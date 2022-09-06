Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49F5AE97B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiIFN0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233384AbiIFN0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:26:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C4474344;
        Tue,  6 Sep 2022 06:26:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0CDAB818B4;
        Tue,  6 Sep 2022 13:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADB8C433D6;
        Tue,  6 Sep 2022 13:26:00 +0000 (UTC)
Message-ID: <082ba39a-aa00-ac49-ac2a-eceac0bca5ff@xs4all.nl>
Date:   Tue, 6 Sep 2022 15:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFT PATCH] media: em28xx: Enable v4l2 file ops at the end of
 em28xx_v4l2_init()
Content-Language: en-US
To:     Soumya Negi <soumya.negi97@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220829132548.23520-1-soumya.negi97@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <20220829132548.23520-1-soumya.negi97@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Soumya,

On 29/08/2022 15:25, Soumya Negi wrote:
> Fix syzbot bug KASAN: use-after-free Read in v4l2_fh_open
> Syzbot link:
> https://syzkaller.appspot.com/bug?id=0e3c97f1c4112e102c9988afd5eff079350eab7f
> Repro: https://syzkaller.appspot.com/text?tag=ReproC&x=12663ebdd00000
> 
> The bug arises because the em28xx driver registers a v4l2 video
> device(struct video_device) with the V4L2 interface in
> em28xx_v4l2_init() but the v4l2 extension initialization eventually
> fails and the video device is unregistered. v4l2_open() in the V4L2
> interface views the device as registered and allows calls to
> em28xx_v4l2_open(). Due to race between video_unregister_device() and
> v4l2_open(), em28xx_v4l2_open() is accessing video device after it has
> been freed(by the release callback) and is passing it on to
> v4l2_fh_open().
> 
> In em28xx_v4l2_init(), temporarily disable v4l2 file operations on
> struct video_device devices(video, vbi, radio) before registering them
> and enable the file ops at the end when v4l2 extension initialization
> succeeds.

That's not the right approach. The problem is the roll-your-own v4l2->ref
refcount. Instead this should use the refcount that is built into struct
v4l2_device.

Specifically v4l2_dev->release should be set to the release function, and
v4l2_device_put(&v4l2->v4l2_dev); should be called in remove() or in the
error path of em28xx_v4l2_init().

Using this the release callback of v4l2_device will be called when the last
open file handle is closed, i.e. it keeps track of the open()s.

The roll-your-own approach in the em28xx driver (written before this v4l2_device
refcounting existed), is not taking that into account, so that causes these
problems.

What is also bad is that em28xx_vb2_setup() is called after the video devices
are registered. That should happen before.

Regards,

	Hans

> 
> Reported-by: syzbot+b2391895514ed9ef4a8e@syzkaller.appspotmail.com
> Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
> ---
>  drivers/media/usb/em28xx/em28xx-video.c | 45 +++++++++++++++++++++----
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
> index 8181c0e6a25b..900a1eacb1c7 100644
> --- a/drivers/media/usb/em28xx/em28xx-video.c
> +++ b/drivers/media/usb/em28xx/em28xx-video.c
> @@ -2320,6 +2320,19 @@ static int em28xx_v4l2_close(struct file *filp)
>  	return 0;
>  }
>  
> +/* Used to temporarily disable file operations on video_device until successful
> + * initialization in em28xx_v4l2_init().
> + */
> +static const struct v4l2_file_operations em28xx_v4l_fops_empty = {
> +	.owner         = THIS_MODULE,
> +	.open          = NULL,
> +	.release       = NULL,
> +	.read          = NULL,
> +	.poll          = NULL,
> +	.mmap          = NULL,
> +	.unlocked_ioctl = NULL,
> +};
> +
>  static const struct v4l2_file_operations em28xx_v4l_fops = {
>  	.owner         = THIS_MODULE,
>  	.open          = em28xx_v4l2_open,
> @@ -2375,12 +2388,22 @@ static const struct v4l2_ioctl_ops video_ioctl_ops = {
>  };
>  
>  static const struct video_device em28xx_video_template = {
> -	.fops		= &em28xx_v4l_fops,
> +	.fops		= &em28xx_v4l_fops_empty,
>  	.ioctl_ops	= &video_ioctl_ops,
>  	.release	= video_device_release_empty,
>  	.tvnorms	= V4L2_STD_ALL,
>  };
>  
> +/* Used to temporarily disable file operations on video_device until successful
> + * initialization in em28xx_v4l2_init().
> + */
> +static const struct v4l2_file_operations radio_fops_empty = {
> +	.owner         = THIS_MODULE,
> +	.open          = NULL,
> +	.release       = NULL,
> +	.unlocked_ioctl = NULL,
> +};
> +
>  static const struct v4l2_file_operations radio_fops = {
>  	.owner         = THIS_MODULE,
>  	.open          = em28xx_v4l2_open,
> @@ -2404,7 +2427,7 @@ static const struct v4l2_ioctl_ops radio_ioctl_ops = {
>  };
>  
>  static struct video_device em28xx_radio_template = {
> -	.fops		= &radio_fops,
> +	.fops		= &radio_fops_empty,
>  	.ioctl_ops	= &radio_ioctl_ops,
>  	.release	= video_device_release_empty,
>  };
> @@ -2833,9 +2856,6 @@ static int em28xx_v4l2_init(struct em28xx *dev)
>  				"can't register radio device\n");
>  			goto unregister_dev;
>  		}
> -		dev_info(&dev->intf->dev,
> -			 "Registered radio device as %s\n",
> -			 video_device_node_name(&v4l2->radio_dev));
>  	}
>  
>  	/* Init entities at the Media Controller */
> @@ -2851,14 +2871,27 @@ static int em28xx_v4l2_init(struct em28xx *dev)
>  	}
>  #endif
>  
> +	/* Enable v4l2 file operations for v4l2 video video_device */
> +	v4l2->vdev.fops = &em28xx_v4l_fops;
>  	dev_info(&dev->intf->dev,
>  		 "V4L2 video device registered as %s\n",
>  		 video_device_node_name(&v4l2->vdev));
>  
> -	if (video_is_registered(&v4l2->vbi_dev))
> +	if (video_is_registered(&v4l2->vbi_dev)) {
> +		/* Enable v4l2 file operations for v4l2 vbi video_device */
> +		v4l2->vbi_dev.fops = &em28xx_v4l_fops;
>  		dev_info(&dev->intf->dev,
>  			 "V4L2 VBI device registered as %s\n",
>  			 video_device_node_name(&v4l2->vbi_dev));
> +	}
> +
> +	if (video_is_registered(&v4l2->radio_dev)) {
> +		/* Enable v4l2 file operations for v4l2 radio video_device */
> +		v4l2->radio_dev.fops = &radio_fops;
> +		dev_info(&dev->intf->dev,
> +			 "Registered radio device as %s\n",
> +			 video_device_node_name(&v4l2->radio_dev));
> +	}
>  
>  	/* Save some power by putting tuner to sleep */
>  	v4l2_device_call_all(&v4l2->v4l2_dev, 0, tuner, standby);

