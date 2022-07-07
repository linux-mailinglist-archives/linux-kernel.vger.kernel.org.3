Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF92569BD2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiGGHhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235042AbiGGHgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDF5A326E0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657179370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=saWM6e0JyDJvaXahV2V2qjYz2t3C6FHDQTH/SnTXHP4=;
        b=UHb4hoVvN4CWXOu1WG9/yZh7h5yZQXlreF6CmJwgY/nGQsJ+D+2YCgKtmlmuKWrZ0Mwgpa
        /LdZMDEvBR5hKhgeDy2w+cxd3USlb0D+wfelQprNu3kY0TkqS0PaqbBYCoDusJcP65/51X
        UkFz4fbk+63CfxiK3/+GpW8Kjw0oikE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-paETsosfPHSz2i5WQhzPbQ-1; Thu, 07 Jul 2022 03:36:09 -0400
X-MC-Unique: paETsosfPHSz2i5WQhzPbQ-1
Received: by mail-wm1-f72.google.com with SMTP id t20-20020a1c7714000000b003a032360873so11506297wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 00:36:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=saWM6e0JyDJvaXahV2V2qjYz2t3C6FHDQTH/SnTXHP4=;
        b=4TEM6KUU9V+RrM0XSn41lj1cICKQadVZ56XFVIChas20s5rWbZdyD+B8JE/lApq8Gl
         b9IOX/eOo6cMGnDbvAN3ZQky3wvVT9Hg5Z+MOzMleqF1gQJetQFUQuE8J/zERA37BE+m
         FUhIU+Yk+bTPhU7QvBXvgMuCFvyo5ZCQ8D8BuomB+DuqSAwPXZZugqisTCdO2y+4tfYC
         LUzSum1rfKKaHWkQ8eRScZ9YLFgVdqpemJ8cibtb3f0xdQIOmy7vHkOanvuLb0NFC84W
         nKxHcBald3wLAUW3ycbR93qdh4/9Ta6P0ZBwbO3DcEvSQJ7JUk/e9BxcuTYL1K8lKx9C
         9diw==
X-Gm-Message-State: AJIora9A/doJ6kjQv7+lPBcowhT7nyUY+1x12ldNiusc7MfZIQUXAtd+
        aAked6WsR5GFaUJ4sIadbWdq4+A78C5vu+rG5jmRmV6Uk5vsp8g5+BTkrUD7hNCS3kYvGDI+Lkt
        8Yveg0YwY1wb1ikHIVf4Uv5DA
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr42440881wrr.472.1657179367525;
        Thu, 07 Jul 2022 00:36:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1veceZbRH21fUsnX5CJPHgyNSm2DA1xoK5v3xI4IRUNTkGEIyvFlyIF8/UWpVCYqC2UtKuKaQ==
X-Received: by 2002:adf:fb0e:0:b0:21a:34a2:5ca9 with SMTP id c14-20020adffb0e000000b0021a34a25ca9mr42440823wrr.472.1657179366892;
        Thu, 07 Jul 2022 00:36:06 -0700 (PDT)
Received: from redhat.com ([2.52.154.68])
        by smtp.gmail.com with ESMTPSA id r11-20020adfce8b000000b0021d77625d90sm5440581wrn.79.2022.07.07.00.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:36:06 -0700 (PDT)
Date:   Thu, 7 Jul 2022 03:36:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Guo Zhi <qtxuning1999@sjtu.edu.cn>
Cc:     jasowang@redhat.com, eperezma@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, sgarzare@redhat.com
Subject: Re: [PATCH v2 2/4] virtio_test: move magic number in code as defined
 constant
Message-ID: <20220707033233-mutt-send-email-mst@kernel.org>
References: <20220707024409.1869-1-qtxuning1999@sjtu.edu.cn>
 <20220707024409.1869-3-qtxuning1999@sjtu.edu.cn>
 <20220707010036-mutt-send-email-mst@kernel.org>
 <8c15f97f-df6d-9ec5-b9d3-c42350cde887@sjtu.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c15f97f-df6d-9ec5-b9d3-c42350cde887@sjtu.edu.cn>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2022 at 02:17:19PM +0800, Guo Zhi wrote:
> On 2022/7/7 13:09, Michael S. Tsirkin wrote:
> > On Thu, Jul 07, 2022 at 10:44:07AM +0800, Guo Zhi wrote:
> > > We should avoid using magic numbers directly.
> > Not necessarily. For repeated values - I guess.
> > But this kind of thing:
> > 
> > 	#define BUF_SIZE 1024
> > 	int buf_size = BUF_SIZE;
> > 
> > brings no benefit IMHO.
> > 
> > And this has cost - values are now removed from code.
> 
> Firstly, as a test, user will have to change the config to test virtio and
> vhost frequently. If these magic number are put together like these, change
> will be more easier.

If tweaking these is useful for users we should add a command line flags
as opposed to asking users to tweak code.

> Secondly, many configs will be repeated, such as MAX_SG_FRAGS, even if some
> varibale only appear once, subsequent upgrade of virtio_test will use these
> variable in other place. For example, in this series of patch, patch 4/4
> will use RINGSIZE to set INDIRECTS_BUF_SIZE.
> 
> > > Signed-off-by: Guo Zhi <qtxuning1999@sjtu.edu.cn>

Isn't there some way to use the size we get as 1st parameter of kmalloc?

> > > ---
> > >   tools/virtio/virtio_test.c | 18 +++++++++++-------
> > >   1 file changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
> > > index 95f78b311..1ecd64271 100644
> > > --- a/tools/virtio/virtio_test.c
> > > +++ b/tools/virtio/virtio_test.c
> > > @@ -20,7 +20,10 @@
> > >   #include "../../drivers/vhost/test.h"
> > >   #define RANDOM_BATCH -1
> > > -
> > > +#define ALIGN 4096
> > > +#define RINGSIZE   256
> > > +#define TEST_BUF_NUM 0x100000
> > > +#define BUF_SIZE   1024
> > >   /* Unused */
> > >   void *__kmalloc_fake, *__kfree_ignore_start, *__kfree_ignore_end;
> > > @@ -100,8 +103,8 @@ static void vq_reset(struct vq_info *info, int num, struct virtio_device *vdev)
> > >   	if (info->vq)
> > >   		vring_del_virtqueue(info->vq);
> > > -	memset(info->ring, 0, vring_size(num, 4096));
> > > -	vring_init(&info->vring, num, info->ring, 4096);
> > > +	memset(info->ring, 0, vring_size(num, ALIGN));
> > > +	vring_init(&info->vring, num, info->ring, ALIGN);
> > >   	info->vq = __vring_new_virtqueue(info->idx, info->vring, vdev, true,
> > >   					 false, vq_notify, vq_callback, "test");
> > >   	assert(info->vq);
> > > @@ -115,7 +118,7 @@ static void vq_info_add(struct vdev_info *dev, int num)
> > >   	info->idx = dev->nvqs;
> > >   	info->kick = eventfd(0, EFD_NONBLOCK);
> > >   	info->call = eventfd(0, EFD_NONBLOCK);
> > > -	r = posix_memalign(&info->ring, 4096, vring_size(num, 4096));
> > > +	r = posix_memalign(&info->ring, PAGE_SIZE, vring_size(num, ALIGN));
> > >   	assert(r >= 0);
> > >   	vq_reset(info, num, &dev->vdev);
> > >   	vhost_vq_setup(dev, info);
> > This is actually doing more than what commit log says.
> > 
> > > @@ -131,7 +134,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
> > >   	dev->vdev.features = features;
> > >   	INIT_LIST_HEAD(&dev->vdev.vqs);
> > >   	spin_lock_init(&dev->vdev.vqs_list_lock);
> > > -	dev->buf_size = 1024;
> > > +	dev->buf_size = BUF_SIZE;
> > > 
> > > 
> > > This seems to have zero added value.
> > > 
> Since the reason above and other magic number have been set as a defined
> constant, change here for simplicity and consistency.
> > >   	dev->buf = malloc(dev->buf_size);
> > >   	assert(dev->buf);
> > >           dev->control = open("/dev/vhost-test", O_RDWR);
> > > @@ -396,7 +399,8 @@ int main(int argc, char **argv)
> > >   done:
> > >   	vdev_info_init(&dev, features);
> > > -	vq_info_add(&dev, 256);
> > > -	run_test(&dev, &dev.vqs[0], delayed, batch, reset, 0x100000);
> > > +	vq_info_add(&dev, RINGSIZE);
> > > +
> > > +	run_test(&dev, &dev.vqs[0], delayed, batch, reset, TEST_BUF_NUM);
> > >   	return 0;
> > 
> > This replacement does not buy us anything either.
> RINGSIZE will be used in other place in subsequent modification.
> > 
> > >   }
> > > -- 
> > > 2.17.1
> 

