Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F283E4646C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 06:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346779AbhLAFqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 00:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345818AbhLAFqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:46:15 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C272C061574;
        Tue, 30 Nov 2021 21:42:55 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 85A67A15;
        Wed,  1 Dec 2021 06:42:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1638337373;
        bh=eaC05PztGw/AVSr6nL3R/sT2S2LOyHeq1cvM0nlU+cE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lHfjAuOxWOXhncAiUo3fa6g4iEHbXwrwoFPepzUanZQW+P2nYU5uwbmC6nTGRfQRK
         bxs4kTROT4f4TXyiGRrV7T5G+ZUIi8E17TjpqveGPVdwpwiFRm0RWZArRZ2BqhJ+zO
         qmtNfD66vGuEQZcn1nc+KNrRufMoYC0Q84TN2bFw=
Date:   Wed, 1 Dec 2021 07:42:27 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Avoid invalid memory access
Message-ID: <YacLQ/CNxBaLC+EE@pendragon.ideasonboard.com>
References: <20211201052218.689103-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201052218.689103-1-ribalda@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Wed, Dec 01, 2021 at 06:22:17AM +0100, Ricardo Ribalda wrote:
> If mappings points to an invalid memory, we will be invalid accessing
> it.

I'll reflow the commit message.

> Solve it by initializing the value of the variable mapping and by
> changing the order in the conditional statement (to avoid accessing
> mapping->id if not needed).
> 
> Fix:
> kasan: GPF could be caused by NULL-ptr deref or user memory access
> general protection fault: 0000 [#1] PREEMPT SMP KASAN NOPTI
> 
> Fixes: 6350d6a4ed487 ("media: uvcvideo: Set error_idx during ctrl_commit errors")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 30bfe9069a1f..9a25d6029255 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1638,7 +1638,7 @@ static int uvc_ctrl_find_ctrl_idx(struct uvc_entity *entity,
>  				  struct v4l2_ext_controls *ctrls,
>  				  struct uvc_control *uvc_control)
>  {
> -	struct uvc_control_mapping *mapping;
> +	struct uvc_control_mapping *mapping = NULL;
>  	struct uvc_control *ctrl_found;
>  	unsigned int i;
>  

-- 
Regards,

Laurent Pinchart
