Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8936F4E69A1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353226AbiCXUIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbiCXUIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:08:44 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F285B245C;
        Thu, 24 Mar 2022 13:07:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 381DA14CD;
        Thu, 24 Mar 2022 21:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1648152429;
        bh=0eOQsHYDIIbVZCbf67FHyRGuPJuqHwQLe+/L63VKp0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PtRlmWJgOon/0zxahejq/GCd1M8wZ9DD2K2XAn07nlV2JUnwbIiIDZMYSQu3QWbNs
         +jlqXrgN1XWNC/ApUkTqz3aS8tzV70gR5n8wKxPy/C8h78S/dDAcanz3bziHWiUd1v
         VnhMaUIoYhXL/4nPMjOvwempy9FkUlBmc9q4qkh0=
Date:   Thu, 24 Mar 2022 22:07:07 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Hangyu Hua <hbh25y@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: uvc_v4l2: fix possible memory leak in
 uvc_ioctl_ctrl_map
Message-ID: <YjzPa0iJ4OuCZ8q0@pendragon.ideasonboard.com>
References: <20220324081718.41091-1-hbh25y@gmail.com>
 <CANiDSCvqQqOZ=uigeSz7ihe-y5XDLCRYD9+ZRULDE21td5rvEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANiDSCvqQqOZ=uigeSz7ihe-y5XDLCRYD9+ZRULDE21td5rvEQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 06:17:18PM +0100, Ricardo Ribalda wrote:
> Isnt it a dupe of:
> https://patchwork.linuxtv.org/project/linux-media/patch/20211008120914.69175-1-ribalda@chromium.org/
> ?

It is. I'll review that one.

> On Thu, 24 Mar 2022 at 18:13, Hangyu Hua <hbh25y@gmail.com> wrote:
> >
> > map->name needs to be freed when uvc_ioctl_ctrl_map fails.
> >
> > Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
> > ---
> >  drivers/media/usb/uvc/uvc_v4l2.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_v4l2.c b/drivers/media/usb/uvc/uvc_v4l2.c
> > index 711556d13d03..e46a2f3b06cb 100644
> > --- a/drivers/media/usb/uvc/uvc_v4l2.c
> > +++ b/drivers/media/usb/uvc/uvc_v4l2.c
> > @@ -93,6 +93,7 @@ static int uvc_ioctl_ctrl_map(struct uvc_video_chain *chain,
> >
> >         kfree(map->menu_info);
> >  free_map:
> > +       kfree(map->name);
> >         kfree(map);
> >
> >         return ret;

-- 
Regards,

Laurent Pinchart
