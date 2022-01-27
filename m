Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 049FE49E8B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244445AbiA0RSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:18:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47434 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbiA0RSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:18:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A03061AD2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FF7C340E4;
        Thu, 27 Jan 2022 17:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643303881;
        bh=+2Mo0YGB7fDZ+E4s9fMi6i/zLrfypNOu2W4bQGEnMb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q1PSHJVJYIojlDmKCWvadIdxU1iWun6Nyhy69ZCEqwOeTA94lzTsz5GcP61l2dxkD
         WnRB195S+vYNkpVF8jk68Xou14wYXeu/q87q6askaI0O1Du0teofejdrCmoqy8VEyv
         OVCe6Kr4pHscub7+zmacO43nKuY7NbEDv20ckWH6LbSl/nFVSxGs2l2Z+B5Y7XFSzV
         9r1EVeW/ylCxm3/1bbCC6NCXL4N0tBJOVl1GLIcugeaMc/YGLXGK1AdMQj/uHNBwHr
         1l2yekBUY9UUT3clblncc7kGkpGaGF+ZiNx5fA1+jxS8iXbakkpw8vS2G7gxSURDz/
         ekvgezUnSADxQ==
Date:   Thu, 27 Jan 2022 09:17:58 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] nvme: Do not reject dynamic controller cntlid
Message-ID: <20220127171758.GB2266713@dhcp-10-100-145-180.wdc.com>
References: <20220127133648.8201-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127133648.8201-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 02:36:48PM +0100, Daniel Wagner wrote:
> index dd18861f77c0..918abb54771c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2701,7 +2701,7 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
>  		if (nvme_state_terminal(tmp))
>  			continue;
>  
> -		if (tmp->cntlid == ctrl->cntlid) {
> +		if (!nvme_ctrl_dynamic(tmp) && tmp->cntlid == ctrl->cntlid) {
>  			dev_err(ctrl->device,
>  				"Duplicate cntlid %u with %s, subsys %s, rejecting\n",
>  				ctrl->cntlid, dev_name(tmp->device),
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index a162f6c6da6e..ed75245263f5 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -539,6 +539,11 @@ static inline struct request *nvme_cid_to_rq(struct blk_mq_tags *tags,
>  	return blk_mq_tag_to_rq(tags, nvme_tag_from_cid(command_id));
>  }
>  
> +static inline bool nvme_ctrl_dynamic(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->cntlid == 0xffff;
> +}

It's probably safe to assume 0xffff is dynamic, but spec suggests we
check ID_CTRL.FCATT bit 0.
