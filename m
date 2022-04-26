Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF053510ADE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355219AbiDZVDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349114AbiDZVDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:03:21 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1B5BC11;
        Tue, 26 Apr 2022 14:00:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A794DCE2193;
        Tue, 26 Apr 2022 21:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C432DC385A0;
        Tue, 26 Apr 2022 21:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651006808;
        bh=QxPQiDVyvyboQhb7hQg8egZCDBIE9qPfnk2lOel1mkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHfywpbDKaiIA+fVMnwKtNcMVk1eg8P8ocioCAYf46wZZ6qFH46Nr4JMwaMpjxbhI
         59zSmCUibSb6RUX46rByC1vS5y147UwUI9gtevvehdbPKze2VpZJTnpu1yEunlWzr8
         uMJlquUantp3QdT6iaRubNfhDNaOJgpkdI2DvYEI9B762H8XmbZZPU+kBkiR6Gcg44
         7h/CRMLmpP1EUIzXExSw0A7OB0mggP/e5NMvEp7yGkVIFXtjXX+V5p/B6NLSVam9sk
         gXPzTX+EZ3x3ooShAyIzTqU8Koo5mSbB9su7vgkZL4aT1iWdp5N6k4hmkw0TvI77Np
         iyPC0Regq0J2A==
Date:   Tue, 26 Apr 2022 15:00:04 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Janne Grunau <j@jannau.net>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 6/6] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <YmhdVJgd6DGRHPXd@kbusch-mbp.dhcp.thefacebook.com>
References: <20220426201539.12829-1-sven@svenpeter.dev>
 <20220426201539.12829-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426201539.12829-7-sven@svenpeter.dev>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 10:15:39PM +0200, Sven Peter wrote:
> +static enum blk_eh_timer_return apple_nvme_timeout(struct request *req,
> +						   bool reserved)
> +{
> +	struct apple_nvme_iod *iod = blk_mq_rq_to_pdu(req);
> +	struct apple_nvme_queue *q = iod->q;
> +	struct apple_nvme *anv = queue_to_apple_nvme(q);
> +	unsigned long flags;
> +	u32 csts = readl(anv->mmio_nvme + NVME_REG_CSTS);
> +
> +	if (anv->ctrl.state != NVME_CTRL_LIVE) {
> +		/*
> +		 * From rdma.c:
> +		 * If we are resetting, connecting or deleting we should
> +		 * complete immediately because we may block controller
> +		 * teardown or setup sequence
> +		 * - ctrl disable/shutdown fabrics requests
> +		 * - connect requests
> +		 * - initialization admin requests
> +		 * - I/O requests that entered after unquiescing and
> +		 *   the controller stopped responding
> +		 *
> +		 * All other requests should be cancelled by the error
> +		 * recovery work, so it's fine that we fail it here.
> +		 */
> +		dev_warn(anv->dev,
> +			 "I/O %d(aq:%d) timeout while not in live state\n",
> +			 req->tag, q->is_adminq);
> +		if (blk_mq_request_started(req) &&
> +		    !blk_mq_request_completed(req)) {
> +			nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
> +			blk_mq_complete_request(req);

I think you need a 'nvme_req(req)->flags |= NVME_REQ_CANCELLED' here to get the
expected -EINTR for any admin command timeouts during a reset. Without it, the
resetting task is going to think it got a real response from the controller.

Other than that, this looks good.
