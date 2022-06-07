Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533D053FB6C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241193AbiFGKgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbiFGKf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:35:56 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABC8EC3E5
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:35:43 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3541567373; Tue,  7 Jun 2022 12:35:39 +0200 (CEST)
Date:   Tue, 7 Jun 2022 12:35:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        caroline.subramoney@microsoft.com, riwurd@microsoft.com,
        nathan.obr@microsoft.com
Subject: Re: [PATCH v3 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Message-ID: <20220607103538.GA25071@lst.de>
References: <1654560915-22449-1-git-send-email-mikelley@microsoft.com> <1654560915-22449-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654560915-22449-2-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2022 at 05:15:15PM -0700, Michael Kelley wrote:
> +static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
> +{
> +	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
> +
> +	/*
> +	 * We can't read the CSTS here because we're in an atomic context on
> +	 * some transports and the read may require submitting a request to the
> +	 * to the controller and getting a response. Such a sequence isn't
> +	 * likely to be successful anyway if the controller is reporting a
> +	 * persistent internal error. So assume CSTS.CFS is set.
> +	 */
> +	if (nvme_should_reset(ctrl, NVME_CSTS_CFS)) {
> +		dev_warn(ctrl->device, "resetting controller due to AER\n");
> +		nvme_reset_ctrl(ctrl);

I don't think we even need the nvme_should_reset check now.

nvme_reset_ctrl first calls nvme_change_ctrl_state, which only allows
the transition to the RESETTING state if it previously was NEW or LIVE,
so we are already covered.  The only downside would be an extra kernel
message if we already were in another state.
