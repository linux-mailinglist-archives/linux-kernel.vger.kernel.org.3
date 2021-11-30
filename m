Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2531E463A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbhK3Pwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:52:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240309AbhK3PvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:51:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A347FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 07:48:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EB60ECE1A48
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:47:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACCE6C53FC7;
        Tue, 30 Nov 2021 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638287277;
        bh=ht1w0Zxz/2n1bifQGvJqnd2/yqA1jDA28G0XH75K4fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cxyq76XGheE0psrKTWB/ikTksRmK2Ysik36of6t7Wtq8yMabfKT4tj3cKULpXU6cg
         FCiUrCm+Od2E1G71M+X8wnb+Kc3INGhzCQX9rpO7oXH/IJGcv8goXBWLTxEz8/kqm+
         mxmExAQ4kXuIlUEVZ5hPafxzTqn05fMffocZULgnBuTx6h8cd21A9k6Fhowtf/HTEQ
         Sc2vcc1FtrfrtSCZ6LjMvORgA6NFUJfBvxGzckTdkz5ifN2rqOPlT7CWCUsnVjVqX2
         4e1ZaNLEanWh7P2fhT6gUYFrujGwvf5IrbysNqgbxiJWso68tAaPerZ69T7aEqIu/p
         xzHUj+p0yBEMQ==
Date:   Tue, 30 Nov 2021 07:47:54 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver: nvme: fix missing error code
Message-ID: <20211130154754.GA3627665@dhcp-10-100-145-180.wdc.com>
References: <20211130135015.1818325-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130135015.1818325-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 09:50:14PM +0800, Dongliang Mu wrote:
> Smatch reports:
> 
> drivers/nvme/host/multipath.c:865
> nvme_mpath_init_identify() warn: missing error code 'error'
> 
> In one error handling path of nvme_mpath_init_identify(Line 865), error
> is not initialized as an errno.
> 
> Fix this by assigning error to -EINVAL.

Nak, the code is correct as-is. Returning a negetive error will abort
the initialization process. We don't need ANA support in order to manage
this controller, so failing a controller for an optional condition
isn't helpful.

The other parts of this function returning negetive errors should be
fixed to return 0, though.
 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/nvme/host/multipath.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 7f2071f2460c..2cbeb6d6b064 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -862,6 +862,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>  			"ANA log page size (%zd) larger than MDTS (%zd).\n",
>  			ana_log_size, max_transfer_size);
>  		dev_err(ctrl->device, "disabling ANA support.\n");
> +		error = -EINVAL;
>  		goto out_uninit;
>  	}
>  	if (ana_log_size > ctrl->ana_log_size) {
> -- 
> 2.25.1
> 
