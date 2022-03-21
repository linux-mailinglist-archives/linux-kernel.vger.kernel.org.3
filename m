Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF64E2EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351564AbiCURDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 13:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351583AbiCURDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 13:03:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71D9132EB7;
        Mon, 21 Mar 2022 10:01:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 536EC61451;
        Mon, 21 Mar 2022 17:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A43BC340E8;
        Mon, 21 Mar 2022 17:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647882101;
        bh=z74tmM91Um9X1h7Fhx54Fbs7WMs3ywKR9k3rFYogmiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4DM2ufydUB+hlToCdfm9R6miNisFSTGqpnrdwux16BgmTvTDhbfRvFmzM5L6vW1v
         ayIg+HMlsnwDpVZxQTp1Hl2/u0BCRxVQF6g+6BdlnqYMpfhg5GHtleX+McUaKIbjaC
         mQrv/1pa8VWuzusofQFkwlRX9tyvINDCzaRiJ5ouiWwH6/osxtCmhdwclNWV3Ypz1d
         uDSngg5GD5fQUJgAGSdxQhsb2AmQokTUSxCyIUWMnFUfigRdEHSV79eNouy/TE/wsp
         /p71KygkDPu0CUEGzDomV89Q+nuLH7PQ7H2yf4hvCBoI+Kib69tr+h2SEioxROAzNm
         DoWkvMr02pTSA==
Date:   Mon, 21 Mar 2022 11:01:39 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 6/9] nvme-apple: Add initial Apple SoC NVMe driver
Message-ID: <Yjivcz4BlCMfJBkM@C02CK6Q3MD6M>
References: <20220321165049.35985-1-sven@svenpeter.dev>
 <20220321165049.35985-7-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321165049.35985-7-sven@svenpeter.dev>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 05:50:46PM +0100, Sven Peter wrote:
> +static bool apple_nvme_poll_cq(struct apple_nvme_queue *q,
> +			       struct io_comp_batch *iob)
> +{
> +	bool found = false;
> +
> +	while (apple_nvme_cqe_pending(q)) {
> +		found = true;
> +
> +		/*
> +		 * load-load control dependency between phase and the rest of
> +		 * the cqe requires a full read memory barrier
> +		 */
> +		dma_rmb();
> +		apple_nvme_handle_cqe(q, iob, q->cq_head);
> +		apple_nvme_update_cq_head(q);
> +	}
> +
> +	if (found)
> +		writel_relaxed(q->cq_head, q->cq_db);

Doesn't a relaxed write mean that a subsequent write can bypass the previous?
If so, that sounds like it can corrupt the cq head.
