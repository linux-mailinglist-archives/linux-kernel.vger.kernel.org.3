Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD774E64BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350745AbiCXOLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350739AbiCXOK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:10:56 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C490FED;
        Thu, 24 Mar 2022 07:09:24 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3586D1844;
        Thu, 24 Mar 2022 15:09:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1648130963;
        bh=GbGmvF7eeaO9TAnwm/DxoHYrq1TEVs4ck08bW82PFio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gOqJTdFrVufNVI251wxoxbTNjSaZxGjVAsKHqdcf8+eyU3Cew/Udy6HQknT78Dq2X
         jd8Edq4ve93+1l2dc8oADG+gOQiG1FFytD7FE4MAAyNn2ftN4tc0paMf3G9dZC3Tga
         OckRiwyetcjDF6iKRPAV/JHevoBEgBRWmC5qKJps=
Date:   Thu, 24 Mar 2022 16:09:21 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvc_v4l2: fix possible memory leak in
 uvc_ioctl_ctrl_map
Message-ID: <Yjx7kSoHA64J1VHc@pendragon.ideasonboard.com>
References: <20220324081718.41091-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324081718.41091-1-hbh25y@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hangyu,

Thank you for the patch.

On Thu, Mar 24, 2022 at 04:17:18PM +0800, Hangyu Hua wrote:
> map->name needs to be freed when uvc_ioctl_ctrl_map fails.
> 
> Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> ---
>  drivers/media/usb/uvc/uvc_v4l2.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> index 711556d13d03..e46a2f3b06cb 100644
> --- a/drivers/media/usb/uvc/uvc_v4l2.c
> +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> @@ -93,6 +93,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
>  
>  	kfree(map->menu_info);
>  free_map:
> +	kfree(map->name);

The memory is actually freed in uvc_ctrl_cleanup_mappings() in the
non-error case. I think we could improve this by avoiding the kmemdup()
in this function, and duplicating the name in __uvc_ctrl_add_mapping()
instead. What do you think ?

>  	kfree(map);
>  
>  	return ret;

-- 
Regards,

Laurent Pinchart
