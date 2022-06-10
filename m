Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4039254609A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 10:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348123AbiFJI5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 04:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344120AbiFJI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 04:57:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B99E38DAC;
        Fri, 10 Jun 2022 01:57:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEF6DB832D3;
        Fri, 10 Jun 2022 08:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245ECC34114;
        Fri, 10 Jun 2022 08:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654851463;
        bh=+DbG4J5RrUMtVEi9AxUcUS78TNMbPCQywLlX1IR8dtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLmej4HjsqWLJJw2NJUAzX7vdlpMknWZ22uQkotWp2YIwCuvzsvZjjwYjV+OWvQSq
         uySBXbIuRhTH0clxGaOFLt0yvqMkswhmUMB8/SGUFZ94gmF1xnHJWbsx5AD4sUR312
         WU6j/ajshavy0UX50BrdEqmsAnTHwvO7WtoIrgIg=
Date:   Fri, 10 Jun 2022 10:57:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix spurious DMA max segment size
 warnings
Message-ID: <YqMHhPXPGkTcXICd@kroah.com>
References: <20220609082246.13182-1-tiwai@suse.de>
 <YqG65hU4SLUrxMI7@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqG65hU4SLUrxMI7@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 09, 2022 at 12:18:30PM +0300, Laurent Pinchart wrote:
> Hi Takashi,
> 
> (CC'ing Greg and the linux-usb mailing list)
> 
> Thank you for the patch.
> 
> On Thu, Jun 09, 2022 at 10:22:46AM +0200, Takashi Iwai wrote:
> > As default, the DMA max segment size is set to 64k, and uvcvideo may
> > overflow that size easily, resulting in a warning like:
> > 
> >   DMA-API: xhci_hcd 0000:00:14.0: mapping sg segment longer than device claims to support [len=98304] [max=65536]
> > 
> > Explicitly set up the DMA max segment size for avoiding spurious kernel
> > warnings.
> > 
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 1b4cc934109e..25aa6e6a6906 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -2160,6 +2160,8 @@ int uvc_video_init(struct uvc_streaming *stream)
> >  	for_each_uvc_urb(uvc_urb, stream)
> >  		INIT_WORK(&uvc_urb->work, uvc_video_copy_data_work);
> >  
> > +	dma_set_max_seg_size(uvc_stream_to_dmadev(stream), UINT_MAX);
> > +
> 
> uvc_stream_to_dmadev() returns the pointer to the HCD's struct device,
> which is shared between all drivers on the bus. Is it really fine for a
> USB device driver to change the maximum segment size of the HCD device
> directly ?

Ick, no!  That feels wrong, it should only change things for that one
specific device, not all devices on that bus.

thanks,

greg k-h
