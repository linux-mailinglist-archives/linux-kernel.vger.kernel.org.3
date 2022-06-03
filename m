Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A757F53D255
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 21:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349181AbiFCTXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 15:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiFCTXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 15:23:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35391BC9E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 12:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4FF061A41
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 19:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7412FC385A9;
        Fri,  3 Jun 2022 19:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654284191;
        bh=r3tew3GTl/lQ9L5T8wfQzn0KZpDqmzXFfoPYfH2kGxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BHsXI7s781eox2M+352pAf+14G2qTBSWAu9cp0UyLoHHhwlkTx5krjgwnyYp+NNfU
         0T9hrmg5fjBcjqF2+HWBGBrBdwwT1JzxvMVrOYD0NyrLPbYS5xK4xUmKRQ043jeGo/
         /GlNVFyLUz0xTdWqWEqXSyCy4PDKg7aNmrUI3gKHU9L+KiEpaP6Pirtl9zWNMrm6Mj
         5s/g2IwwFvZThw09RgQw6k3Q0jmmM/JsAs0PWT3R/OF+DUzDcvkeAd2hghnxtdPhLC
         NfvvkaPj8jOp0yh7YAM42mQNjPxGtlLrEsDthPrjYoeujBjbPqtensQsk+kbKp2Lku
         CNVrPL4KAZJUw==
Date:   Fri, 3 Jun 2022 13:23:07 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        caroline.subramoney@microsoft.com, riwurd@microsoft.com,
        nathan.obr@microsoft.com
Subject: Re: [PATCH v2 2/2] nvme: handle persistent internal error AER from
 NVMe controller
Message-ID: <Yppfm5n41NEcrRlU@kbusch-mbp.dhcp.thefacebook.com>
References: <1654278961-81423-1-git-send-email-mikelley@microsoft.com>
 <1654278961-81423-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1654278961-81423-2-git-send-email-mikelley@microsoft.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 10:56:01AM -0700, Michael Kelley wrote:

This series looks good to me. Just one concern below that may amount to
nothing.

> +static void nvme_handle_aer_persistent_error(struct nvme_ctrl *ctrl)
> +{
> +	u32 csts;
> +
> +	trace_nvme_async_event(ctrl, NVME_AER_ERROR);
> +
> +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts) != 0 ||

The reg_read32() is non-blocking for pcie, so this is safe to call from that
driver's irq handler. The other transports block on register reads, though, so
they can't call this from an atomic context. The TCP context looks safe, but
I'm not sure about RDMA or FC.

> +	    nvme_should_reset(ctrl, csts)) {
> +		dev_warn(ctrl->device, "resetting controller due to AER\n");
> +		nvme_reset_ctrl(ctrl);
> +	}
> +}
> +
>  void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  		volatile union nvme_result *res)
>  {
>  	u32 result = le32_to_cpu(res->u32);
>  	u32 aer_type = result & 0x07;
> +	u32 aer_subtype = (result & 0xff00) >> 8;

Since the above mask + shift is duplicated with nvme_handle_aen_notice(), an
inline helper function seems reasonable.
