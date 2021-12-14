Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE3F474B6D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 20:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237286AbhLNTB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 14:01:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:51005 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234390AbhLNTB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 14:01:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="263200679"
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="263200679"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 10:32:22 -0800
X-IronPort-AV: E=Sophos;i="5.88,205,1635231600"; 
   d="scan'208";a="661540417"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2021 10:32:18 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id C7C0B20462;
        Tue, 14 Dec 2021 20:32:16 +0200 (EET)
Date:   Tue, 14 Dec 2021 20:32:16 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Jammy Huang <jammy_huang@aspeedtech.com>, hverkuil-cisco@xs4all.nl,
        gregkh@linuxfoundation.org, laurent.pinchart@ideasonboard.com,
        eajames@linux.ibm.com, joel@jms.id.au, andrew@aj.id.au,
        linux-media@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: aspeed: move err-handling together to the
 bottom
Message-ID: <YbjjMDQ+V6ilbQvj@paasikivi.fi.intel.com>
References: <20211206004811.1118-1-jammy_huang@aspeedtech.com>
 <20211214155300.0132946e@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214155300.0132946e@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

On Tue, Dec 14, 2021 at 03:53:00PM +0100, Mauro Carvalho Chehab wrote:
> Em Mon, 6 Dec 2021 08:48:11 +0800
> Jammy Huang <jammy_huang@aspeedtech.com> escreveu:
> 
> > refine aspeed_video_setup_video() flow.
> 
> Why? It makes no difference where the error handling code is. Let's
> keep it as preferred by the driver's author ;-)

Doing error handling can be done in different ways of course, but I think
it's easier to see it's right as it's done by this patch. Of course the
original author's --- like anyone else's --- review wouldn't hurt. But I
see he hasn't reviewed other recent patches to the driver either.

A better description would be nice though, including capital letter
beginning a sentence.

> 
> Regards,
> Mauro
> 
> > 
> > Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> > ---
> > v2:
> >  - remove change-id in comment
> > ---
> >  drivers/media/platform/aspeed-video.c | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> > index fea5e4d0927e..f5c40d6b4ece 100644
> > --- a/drivers/media/platform/aspeed-video.c
> > +++ b/drivers/media/platform/aspeed-video.c
> > @@ -1641,11 +1641,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
> >  
> >  	rc = video->ctrl_handler.error;
> >  	if (rc) {
> > -		v4l2_ctrl_handler_free(&video->ctrl_handler);
> > -		v4l2_device_unregister(v4l2_dev);
> > -
> >  		dev_err(video->dev, "Failed to init controls: %d\n", rc);
> > -		return rc;
> > +		goto err_ctrl_init;
> >  	}
> >  
> >  	v4l2_dev->ctrl_handler = &video->ctrl_handler;
> > @@ -1663,11 +1660,8 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
> >  
> >  	rc = vb2_queue_init(vbq);
> >  	if (rc) {
> > -		v4l2_ctrl_handler_free(&video->ctrl_handler);
> > -		v4l2_device_unregister(v4l2_dev);
> > -
> >  		dev_err(video->dev, "Failed to init vb2 queue\n");
> > -		return rc;
> > +		goto err_vb2_init;
> >  	}
> >  
> >  	vdev->queue = vbq;
> > @@ -1685,15 +1679,19 @@ static int aspeed_video_setup_video(struct aspeed_video *video)
> >  	video_set_drvdata(vdev, video);
> >  	rc = video_register_device(vdev, VFL_TYPE_GRABBER, 0);
> >  	if (rc) {
> > -		vb2_queue_release(vbq);
> > -		v4l2_ctrl_handler_free(&video->ctrl_handler);
> > -		v4l2_device_unregister(v4l2_dev);
> > -
> >  		dev_err(video->dev, "Failed to register video device\n");
> > -		return rc;
> > +		goto err_video_reg;
> >  	}
> >  
> >  	return 0;
> > +
> > +err_video_reg:
> > +	vb2_queue_release(vbq);
> > +err_vb2_init:
> > +err_ctrl_init:
> > +	v4l2_ctrl_handler_free(&video->ctrl_handler);
> > +	v4l2_device_unregister(v4l2_dev);
> > +	return rc;
> >  }
> >  
> >  static int aspeed_video_init(struct aspeed_video *video)
> 
> 
> 
> Thanks,
> Mauro

-- 
Sakari Ailus
