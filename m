Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380E146697E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376497AbhLBR7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:59:07 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37350 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhLBR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:59:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 454816275E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 17:55:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26BE5C00446;
        Thu,  2 Dec 2021 17:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638467742;
        bh=sdj0UvhBCfKVf0u/SdHPJuC64O6tsVkXn7OzWimaLzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pVDPKhQjoQ+3xSuzopBIn53m45pKfNejP9gSc4SfM6eooYnBZ8jEKfiLY0BYwqEKw
         vcjqkoIJWFO7H6QFHGLsxqS/q1+aUI4EF//d3PShtRJLVZPqQVTeXkfBOOq4122zpR
         bO+6CyH/61JCPKNbweOuJY/97DFrps1po8tQ4sYG9WZFGjDXf8z0Iotj8o8RYeNJEE
         0EHP0ZCtdFhOpKaezXUOnQoTD2vbAaVYbBKLhDZQALB3s570uT0p8ryFrCYzjikvt8
         POx6Cm/0oqftjQ+evjx7NWUjY0S7OT7SqrydAix/2wegAkvCi4FiG/hf12StDCVGM8
         cwL57tSfmVmyw==
Date:   Thu, 2 Dec 2021 09:55:39 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     caojun <caojun@uniontech.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add Intel 760p/Pro 7600p nvme disk
Message-ID: <20211202175539.GC3836713@dhcp-10-100-145-180.wdc.com>
References: <20211202030230.17507-1-caojun@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202030230.17507-1-caojun@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 11:02:30AM +0800, caojun wrote:
> Signed-off-by: caojun <caojun@uniontech.com>

What is the purpose of this patch? All of this code already exists from
3 years ago.

> ---
>  drivers/nvme/host/core.c | 16 +++++++++-------
>  drivers/nvme/host/nvme.h |  5 +++++
>  drivers/nvme/host/pci.c  |  2 ++
>  3 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e64310f22..8e0dbfb6a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2155,14 +2155,16 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
>  	size_t nqnlen;
>  	int off;
>  
> -	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
> -	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
> -		strncpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
> -		return;
> -	}
> +	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
> +		nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
> +		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
> +			strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
> +			return;
> +		}
>  
> -	if (ctrl->vs >= NVME_VS(1, 2, 1))
> -		dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
> +		if (ctrl->vs >= NVME_VS(1, 2, 1))
> +			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
> +	}
>  
>  	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
>  	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 276975506..5f5a91518 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -90,6 +90,11 @@ enum nvme_quirks {
>  	 * Set MEDIUM priority on SQ creation
>  	 */
>  	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
> +
> +	/*
> +	 * Ignore device provided subnqn.
> +	 */
> +	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
>  };
>  
>  /*
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index d7cf3202c..fcac05528 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2713,6 +2713,8 @@ static const struct pci_device_id nvme_id_table[] = {
>  	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
>  		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
>  				NVME_QUIRK_MEDIUM_PRIO_SQ },
> +	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
> +		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
>  	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
>  		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
>  	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
> -- 
> 2.20.1
> 
> 
> 
> 
