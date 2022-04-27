Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6067C511D21
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbiD0Pcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239885AbiD0Pcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:32:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E905545034F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:29:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id k23so4164099ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3cBviZz3q70FXsDK6Pj1JdnEGmCPg6mI5zD0RZKDTEY=;
        b=WLWwH3ssCLmcWNZ33bt9H7KImp7hphdU2v9gSO8zxLJhUMGhXT4QeWvm/Q7TnpXJrM
         cMk8EhpN8CCSdeZYX2qyprbRN0OAYoTZ12K6aFpYBW1cCNwEAHj2sgr/eAM2tTXnJyvj
         iLGa8jWGrTTQFLSeWJo5MGHC5fPZO2iMU8W8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=3cBviZz3q70FXsDK6Pj1JdnEGmCPg6mI5zD0RZKDTEY=;
        b=iUwHpt4hdiQFgDuk4/Bct5doVLXw6DfN1mffhMCXp+2hXVnFPiTI/4iLSTm71CwOTk
         CgUdAe2kR1/WNIWIJqh2ykCbRBqPx+WS1MrbvK10nkaacKCPgON/iCQZxpjCXUUUpiAN
         gWa7BBJ/jafMkiZ7hL7pQaJICkvZJXFmVoonsMz7g1S2e/i2edI7pJlhiItRAr5kotfM
         MgNbpD73vgGsTn4OPNzYQTirH7yjXP+jn4I8WuH/UyvyxmXEudAVAZDwBmgnc1N2enjE
         Gg2tvLcN8TFf1CmzHl6owrp+1I6wK7T9+w5ZNiXqLNc6+XD7uxjdvT1T7lv61mV4sMRy
         1wdQ==
X-Gm-Message-State: AOAM533vByKZeJZvVnmBk89QMJPmkNFzPQhQeRX9MAKQW+8QloLJH+72
        s4p796PHFdmLSi6KQCYXFnxK3g==
X-Google-Smtp-Source: ABdhPJxXXY4DNiqJmyyWuTbHk9BD3Ld/bvNZHbHUZ0P3YcRixcsu/nk/7xBwqKh+V7a1bfsISAFw/A==
X-Received: by 2002:a17:907:86a3:b0:6ec:aaa:7f82 with SMTP id qa35-20020a17090786a300b006ec0aaa7f82mr27262059ejc.651.1651073358267;
        Wed, 27 Apr 2022 08:29:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id gk20-20020a17090790d400b006f3a85db71csm3241190ejb.49.2022.04.27.08.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 08:29:17 -0700 (PDT)
Date:   Wed, 27 Apr 2022 17:29:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] drm/doc: Add sections about tiny drivers and external
 refs to intro page
Message-ID: <YmlhS3m6se0sqhnn@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org
References: <20220420072411.15104-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220420072411.15104-1-javierm@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 09:24:11AM +0200, Javier Martinez Canillas wrote:
> Learning about the DRM subsystem could be quite overwhelming for newcomers
> but there are lots of useful talks, slides and articles available that can
> help to understand the needed concepts and ease the learning curve.
> 
> There are also simple DRM drivers that can be used as example about how a
> DRM driver should look like.
> 
> Add sections to the introduction page, that contains references to these.
> 
> Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

Maybe needs more acks to land?

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Would be good we can hand out links to pretty htmldocs instead of lore
links to this patch, the latter is rather hard on the eyes :-)

Cheers, Daniel

> ---
> 
> Changes in v3:
> - Fix typos and grammar errors that found when re-reading the changes.
> 
> Changes in v2:
> - Remove paragraph that gave wrong impression that DRM is complex (Pekka Paalanen).
> - Add Thomas Zimmermann's and Pekka Paalanen's Acked-by tags.
> - Replace "Learning material" title with "External References" (Thomas Zimmermann).
> - Add a section about tiny DRM drivers being a good first example (Daniel Vetter).
> - Add some more external references that I found interesting since v1 was posted.
> 
>  Documentation/gpu/introduction.rst | 60 ++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
> 
> diff --git a/Documentation/gpu/introduction.rst b/Documentation/gpu/introduction.rst
> index 25a56e9c0cfd..f05eccd2c07c 100644
> --- a/Documentation/gpu/introduction.rst
> +++ b/Documentation/gpu/introduction.rst
> @@ -112,3 +112,63 @@ Please conduct yourself in a respectful and civilised manner when
>  interacting with community members on mailing lists, IRC, or bug
>  trackers. The community represents the project as a whole, and abusive
>  or bullying behaviour is not tolerated by the project.
> +
> +Simple DRM drivers to use as examples
> +=====================================
> +
> +The DRM subsystem contains a lot of helper functions to ease writing drivers for
> +simple graphic devices. For example, the `drivers/gpu/drm/tiny/` directory has a
> +set of drivers that are simple enough to be implemented in a single source file.
> +
> +These drivers make use of the `struct drm_simple_display_pipe_funcs`, that hides
> +any complexity of the DRM subsystem and just requires drivers to implement a few
> +functions needed to operate the device. This could be used for devices that just
> +need a display pipeline with one full-screen scanout buffer feeding one output.
> +
> +The tiny DRM drivers are good examples to understand how DRM drivers should look
> +like. Since are just a few hundreds lines of code, they are quite easy to read.
> +
> +External References
> +===================
> +
> +Delving into a Linux kernel subsystem for the first time can be an overwhelming
> +experience, one needs to get familiar with all the concepts and learn about the
> +subsystem's internals, among other details.
> +
> +To shallow the learning curve, this section contains a list of presentations
> +and documents that can be used to learn about DRM/KMS and graphics in general.
> +
> +There are different reasons why someone might want to get into DRM: porting an
> +existing fbdev driver, write a DRM driver for a new hardware, fixing bugs that
> +could face when working on the graphics user-space stack, etc. For this reason,
> +the learning material covers many aspects of the Linux graphics stack. From an
> +overview of the kernel and user-space stacks to very specific topics.
> +
> +The list is sorted in reverse chronological order, to keep the most up-to-date
> +material at the top. But all of them contain useful information, and it can be
> +valuable to go through older material to understand the rationale and context
> +in which the changes to the DRM subsystem were made.
> +
> +Conference talks
> +----------------
> +
> +* `An Overview of the Linux and Userspace Graphics Stack <https://www.youtube.com/watch?v=wjAJmqwg47k>`_ - Paul Kocialkowski (2020)
> +* `Getting pixels on screen on Linux: introduction to Kernel Mode Setting <https://www.youtube.com/watch?v=haes4_Xnc5Q>`_ - Simon Ser (2020)
> +* `Everything Great about Upstream Graphics <https://www.youtube.com/watch?v=kVzHOgt6WGE>`_ - Daniel Vetter (2019)
> +* `An introduction to the Linux DRM subsystem <https://www.youtube.com/watch?v=LbDOCJcDRoo>`_ - Maxime Ripard (2017)
> +* `Embrace the Atomic (Display) Age <https://www.youtube.com/watch?v=LjiB_JeDn2M>`_ - Daniel Vetter (2016)
> +* `Anatomy of an Atomic KMS Driver <https://www.youtube.com/watch?v=lihqR9sENpc>`_ - Laurent Pinchart (2015)
> +* `Atomic Modesetting for Drivers <https://www.youtube.com/watch?v=kl9suFgbTc8>`_ - Daniel Vetter (2015)
> +* `Anatomy of an Embedded KMS Driver <https://www.youtube.com/watch?v=Ja8fM7rTae4>`_ - Laurent Pinchart (2013)
> +
> +Slides and articles
> +-------------------
> +
> +* `Understanding the Linux Graphics Stack <https://bootlin.com/doc/training/graphics/graphics-slides.pdf>`_ - Bootlin (2022)
> +* `DRM KMS overview <https://wiki.st.com/stm32mpu/wiki/DRM_KMS_overview>`_ - STMicroelectronics (2021)
> +* `Linux graphic stack <https://studiopixl.com/2017-05-13/linux-graphic-stack-an-overview>`_ - Nathan Gauër (2017)
> +* `Atomic mode setting design overview, part 1 <https://lwn.net/Articles/653071/>`_ - Daniel Vetter (2015)
> +* `Atomic mode setting design overview, part 2 <https://lwn.net/Articles/653466/>`_ - Daniel Vetter (2015)
> +* `The DRM/KMS subsystem from a newbie’s point of view <https://bootlin.com/pub/conferences/2014/elce/brezillon-drm-kms/brezillon-drm-kms.pdf>`_ - Boris Brezillon (2014)
> +* `A brief introduction to the Linux graphics stack <https://blogs.igalia.com/itoral/2014/07/29/a-brief-introduction-to-the-linux-graphics-stack/>`_ - Iago Toral (2014)
> +* `The Linux Graphics Stack <https://blog.mecheye.net/2012/06/the-linux-graphics-stack/>`_ - Jasper St. Pierre (2012)
> -- 
> 2.35.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
