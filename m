Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1D7508208
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354438AbiDTH1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359766AbiDTH1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7DBF3B572
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650439461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=70+NNt2xtRmHQqLOMHsElopnyuSB4rdpz+fN4EuTmaU=;
        b=hC7KtBwqKEusVwUJWnZwYZJDR2nt/cdp1YQf2DLXWlCpjZMqud57HfrUxy8aHospkWAQpa
        7DBhxHwb7s3B+hDu54kTTD3yaqLxr+1OeVLfD5AGvNivLV+txTLg8sayBX+XMQxRjKySiq
        HWni8nGz3hDRWp5lkLxnrojl277q37E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-Ii8a3Q7pNf2ojSwbuwiOww-1; Wed, 20 Apr 2022 03:24:20 -0400
X-MC-Unique: Ii8a3Q7pNf2ojSwbuwiOww-1
Received: by mail-wr1-f70.google.com with SMTP id s13-20020adfa28d000000b00205e049cff2so109770wra.17
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:24:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=70+NNt2xtRmHQqLOMHsElopnyuSB4rdpz+fN4EuTmaU=;
        b=B4zAlzYo27fJ9knQKWqTCZs+WjH2DYtM8Kd63e2BlBTSxEs6HNbaPTQyxAF7n5JSUW
         MjmXwzVqEkKxtg6rpUbmad2e/soaGIvLLCFsSXITXyr+/o0Vgnd62oRlAjEvEZrZXMpm
         f/oIkHn55TWbFhFvmXHxLWiR/jTaHJ05oDfVwxP9urHEwNtEM1cjrCu9UiGgpBAabs9w
         HaKw42NlcRsHuUCVfkYsG1FGFPLnA8ME7AdFzc7faR+YB1KhCqJtSkVz8hFmFHulIRwc
         EbuhhSVMPuaCSxZsR7Dokm40Wx1CClsxyPV5e4mNod8mygohOrHEdHL8vCu9zg04/3w3
         mYzA==
X-Gm-Message-State: AOAM531EF4QHfDOj2BGzW+jGGYKAVx88Y2cKVlG/e4viS+EUEhReV+tf
        6Swd4+HGpMQASs9b/DzQ4+rNPW7oObMd2fcDbW2+EJi49tjt4xS/+/zhM2S24hCnnCK/SPCsiCR
        sYT7EM8DMo9B0gmyp65aMrcqPPnvLqpqf4MOpJ/gIAgJ0WCrvsNvsCjNtfaD48FIwZESCQw9a3K
        Y=
X-Received: by 2002:adf:e5d2:0:b0:207:9be3:c080 with SMTP id a18-20020adfe5d2000000b002079be3c080mr14296722wrn.519.1650439458992;
        Wed, 20 Apr 2022 00:24:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnCOhTmNd8q/c576iu7dDGltRjR3ltNWqTw2/47SyRKDaivg8p55/9kL/BCNiJ6SF0CgqILw==
X-Received: by 2002:adf:e5d2:0:b0:207:9be3:c080 with SMTP id a18-20020adfe5d2000000b002079be3c080mr14296698wrn.519.1650439458646;
        Wed, 20 Apr 2022 00:24:18 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m7-20020adfe0c7000000b002060e7bbe49sm17026889wri.45.2022.04.20.00.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 00:24:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: [PATCH v3] drm/doc: Add sections about tiny drivers and external refs to intro page
Date:   Wed, 20 Apr 2022 09:24:11 +0200
Message-Id: <20220420072411.15104-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Learning about the DRM subsystem could be quite overwhelming for newcomers
but there are lots of useful talks, slides and articles available that can
help to understand the needed concepts and ease the learning curve.

There are also simple DRM drivers that can be used as example about how a
DRM driver should look like.

Add sections to the introduction page, that contains references to these.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
---

Changes in v3:
- Fix typos and grammar errors that found when re-reading the changes.

Changes in v2:
- Remove paragraph that gave wrong impression that DRM is complex (Pekka Paalanen).
- Add Thomas Zimmermann's and Pekka Paalanen's Acked-by tags.
- Replace "Learning material" title with "External References" (Thomas Zimmermann).
- Add a section about tiny DRM drivers being a good first example (Daniel Vetter).
- Add some more external references that I found interesting since v1 was posted.

 Documentation/gpu/introduction.rst | 60 ++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/gpu/introduction.rst b/Documentation/gpu/introduction.rst
index 25a56e9c0cfd..f05eccd2c07c 100644
--- a/Documentation/gpu/introduction.rst
+++ b/Documentation/gpu/introduction.rst
@@ -112,3 +112,63 @@ Please conduct yourself in a respectful and civilised manner when
 interacting with community members on mailing lists, IRC, or bug
 trackers. The community represents the project as a whole, and abusive
 or bullying behaviour is not tolerated by the project.
+
+Simple DRM drivers to use as examples
+=====================================
+
+The DRM subsystem contains a lot of helper functions to ease writing drivers for
+simple graphic devices. For example, the `drivers/gpu/drm/tiny/` directory has a
+set of drivers that are simple enough to be implemented in a single source file.
+
+These drivers make use of the `struct drm_simple_display_pipe_funcs`, that hides
+any complexity of the DRM subsystem and just requires drivers to implement a few
+functions needed to operate the device. This could be used for devices that just
+need a display pipeline with one full-screen scanout buffer feeding one output.
+
+The tiny DRM drivers are good examples to understand how DRM drivers should look
+like. Since are just a few hundreds lines of code, they are quite easy to read.
+
+External References
+===================
+
+Delving into a Linux kernel subsystem for the first time can be an overwhelming
+experience, one needs to get familiar with all the concepts and learn about the
+subsystem's internals, among other details.
+
+To shallow the learning curve, this section contains a list of presentations
+and documents that can be used to learn about DRM/KMS and graphics in general.
+
+There are different reasons why someone might want to get into DRM: porting an
+existing fbdev driver, write a DRM driver for a new hardware, fixing bugs that
+could face when working on the graphics user-space stack, etc. For this reason,
+the learning material covers many aspects of the Linux graphics stack. From an
+overview of the kernel and user-space stacks to very specific topics.
+
+The list is sorted in reverse chronological order, to keep the most up-to-date
+material at the top. But all of them contain useful information, and it can be
+valuable to go through older material to understand the rationale and context
+in which the changes to the DRM subsystem were made.
+
+Conference talks
+----------------
+
+* `An Overview of the Linux and Userspace Graphics Stack <https://www.youtube.com/watch?v=wjAJmqwg47k>`_ - Paul Kocialkowski (2020)
+* `Getting pixels on screen on Linux: introduction to Kernel Mode Setting <https://www.youtube.com/watch?v=haes4_Xnc5Q>`_ - Simon Ser (2020)
+* `Everything Great about Upstream Graphics <https://www.youtube.com/watch?v=kVzHOgt6WGE>`_ - Daniel Vetter (2019)
+* `An introduction to the Linux DRM subsystem <https://www.youtube.com/watch?v=LbDOCJcDRoo>`_ - Maxime Ripard (2017)
+* `Embrace the Atomic (Display) Age <https://www.youtube.com/watch?v=LjiB_JeDn2M>`_ - Daniel Vetter (2016)
+* `Anatomy of an Atomic KMS Driver <https://www.youtube.com/watch?v=lihqR9sENpc>`_ - Laurent Pinchart (2015)
+* `Atomic Modesetting for Drivers <https://www.youtube.com/watch?v=kl9suFgbTc8>`_ - Daniel Vetter (2015)
+* `Anatomy of an Embedded KMS Driver <https://www.youtube.com/watch?v=Ja8fM7rTae4>`_ - Laurent Pinchart (2013)
+
+Slides and articles
+-------------------
+
+* `Understanding the Linux Graphics Stack <https://bootlin.com/doc/training/graphics/graphics-slides.pdf>`_ - Bootlin (2022)
+* `DRM KMS overview <https://wiki.st.com/stm32mpu/wiki/DRM_KMS_overview>`_ - STMicroelectronics (2021)
+* `Linux graphic stack <https://studiopixl.com/2017-05-13/linux-graphic-stack-an-overview>`_ - Nathan Gauër (2017)
+* `Atomic mode setting design overview, part 1 <https://lwn.net/Articles/653071/>`_ - Daniel Vetter (2015)
+* `Atomic mode setting design overview, part 2 <https://lwn.net/Articles/653466/>`_ - Daniel Vetter (2015)
+* `The DRM/KMS subsystem from a newbie’s point of view <https://bootlin.com/pub/conferences/2014/elce/brezillon-drm-kms/brezillon-drm-kms.pdf>`_ - Boris Brezillon (2014)
+* `A brief introduction to the Linux graphics stack <https://blogs.igalia.com/itoral/2014/07/29/a-brief-introduction-to-the-linux-graphics-stack/>`_ - Iago Toral (2014)
+* `The Linux Graphics Stack <https://blog.mecheye.net/2012/06/the-linux-graphics-stack/>`_ - Jasper St. Pierre (2012)
-- 
2.35.1

