Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6EA49DC6F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237722AbiA0IV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237715AbiA0IVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:21:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643271683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=aqucoy4XGsTZkTOddjEsvTdomJ0r/Uc6V8VLwfxZoJ8=;
        b=c+uh61BODsQ/p/pdA64Fw1+vJy/pstC/iTG5/45KysS+sf+JOoChAj0ilz/vfLtgSDBLcG
        ueIAyib5cmBqn6XU9IlQMjoFvelrBQkjp1L171zzW0E6A6Rs447AwWcvw4YYeZr6/w7sqT
        3zNfaQU9y8gpFDQws9TblSu8DF6mH+o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-0U8HPSftPd2k8sUMWmjNCg-1; Thu, 27 Jan 2022 03:21:21 -0500
X-MC-Unique: 0U8HPSftPd2k8sUMWmjNCg-1
Received: by mail-wm1-f72.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso1137847wmb.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aqucoy4XGsTZkTOddjEsvTdomJ0r/Uc6V8VLwfxZoJ8=;
        b=6crspRAvME2/26MF1MIBFpuek7lQFzmqDmohyxvbXZHEaOzSs0Qz0nCWUPkMNnIyFR
         20PJOF/5ivp/9iW4nIe1bRG6FXbzTZd+BLqTbyjoR3Rcq5zedhd9bZs2fI1m7TUu71KT
         FwPXHI6aJWJWfXycJUvlP/zaK4fPkjbCG32EEYR1+RUucLQjEG8ABZ+jJj5AlwYfxkCh
         LgTznvBV+bNtDEuTsCzyvl06XkVRC/F8on3RB1JrqV5FvbR5VjqZcmQ2vdD47NMH/V95
         8hCB9suUORoXvSz9/VKi8IHXE0eL3sdvwo8k4vh9Y27flISxeLTIGrGvYlR4EQsmTqRP
         K5gQ==
X-Gm-Message-State: AOAM531XCnuLFWBLPUMk06u1LnIBuANMO2qVvhGvaVOddyJY6G6b77zu
        E9j2rEsLhQEhkEchMOrTa810HHc1aPiTdVHOgC4dMsKWmyttxXuHwfuhSbT32FwnapKyvVKp3lY
        R4GaIrdSME7+9WdLn2oVhyElcqWnDtNuKBXoiTjIuso5CTjIFlmC80+JlqgvoeUH9BMEcImIfkQ
        w=
X-Received: by 2002:a05:6000:15c5:: with SMTP id y5mr2159697wry.656.1643271679994;
        Thu, 27 Jan 2022 00:21:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxJ/ZlKYqVE0iVqFH4AaZjGEnemdYNWmvhTud3sB/CSRe+UTC4Mv6f2ZPwV9RWl4nRIixdB4w==
X-Received: by 2002:a05:6000:15c5:: with SMTP id y5mr2159669wry.656.1643271679638;
        Thu, 27 Jan 2022 00:21:19 -0800 (PST)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h20sm7466wmq.8.2022.01.27.00.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 00:21:19 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pekka Paalanen <pekka.paalanen@collabora.co.uk>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org
Subject: [PATCH] drm/doc: Add section in the introduction page about learning material
Date:   Thu, 27 Jan 2022 09:20:58 +0100
Message-Id: <20220127082058.434421-1-javierm@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Linux DRM subsystem supports complex graphics devices and it could be
quite overwhelming for newcomers to learn about the subsystem's internals.

There are lots of useful talks, slides and articles available that can be
used to get familiar with the needed concepts and ease the learning curve.

Add a section to the intro that contains these DRM introductory materials.

Suggested-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 Documentation/gpu/introduction.rst | 36 ++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/gpu/introduction.rst b/Documentation/gpu/introduction.rst
index 25a56e9c0cfd..35986784f916 100644
--- a/Documentation/gpu/introduction.rst
+++ b/Documentation/gpu/introduction.rst
@@ -112,3 +112,39 @@ Please conduct yourself in a respectful and civilised manner when
 interacting with community members on mailing lists, IRC, or bug
 trackers. The community represents the project as a whole, and abusive
 or bullying behaviour is not tolerated by the project.
+
+Learning material
+=================
+
+Since the Linux DRM layer supports complex graphics devices, it can be quite
+overwhelming for newcomers to get familiar with all the needed concepts and
+learn the subsystem's internals.
+
+To shallow the learning curve, this section contains a list of presentations
+and documents that can be used to learn about DRM/KMS and graphics in general.
+
+The list is sorted in reverse chronological order, to keep the most up-to-date
+material at the top. But all of them contain useful information, and it can be
+valuable to go through older material to understand the rationale and context
+in which the recent changes to the DRM subsystem were made.
+
+Talks
+-----
+
+* `An Overview of the Linux and Userspace Graphics Stack <https://www.youtube.com/watch?v=wjAJmqwg47k>`_ - Paul Kocialkowski (2020)
+* `Getting pixels on screen on Linux: introduction to Kernel Mode Setting <https://www.youtube.com/watch?v=haes4_Xnc5Q>`_ - Simon Ser (2020)
+* `An introduction to the Linux DRM subsystem <https://www.youtube.com/watch?v=LbDOCJcDRoo>`_ - Maxime Ripard (2017)
+* `Embrace the Atomic (Display) Age <https://www.youtube.com/watch?v=LjiB_JeDn2M>`_ - Daniel Vetter (2016)
+* `Anatomy of an Atomic KMS Driver <https://www.youtube.com/watch?v=lihqR9sENpc>`_ - Laurent Pinchart (2015)
+* `Atomic Modesetting for Drivers <https://www.youtube.com/watch?v=kl9suFgbTc8>`_ - Daniel Vetter (2015)
+* `Anatomy of an Embedded KMS Driver <https://www.youtube.com/watch?v=Ja8fM7rTae4>`_ - Laurent Pinchart (2013
+
+Slides and articles
+-------------------
+
+* `Understanding the Linux Graphics Stack <https://bootlin.com/doc/training/graphics/graphics-slides.pdf>`_ - Bootlin (2022)
+* `DRM KMS overview <https://wiki.st.com/stm32mpu/wiki/DRM_KMS_overview>`_ - STMicroelectronics (2021)
+* `Linux graphic stack <https://studiopixl.com/2017-05-13/linux-graphic-stack-an-overview>`_ - Nathan Gauër (2017)
+* `The DRM/KMS subsystem from a newbie’s point of view <https://bootlin.com/pub/conferences/2014/elce/brezillon-drm-kms/brezillon-drm-kms.pdf>`_ - Boris Brezillon (2014)
+* `A brief introduction to the Linux graphics stack <https://blogs.igalia.com/itoral/2014/07/29/a-brief-introduction-to-the-linux-graphics-stack/>`_ - Iago Toral (2014)
+* `The Linux Graphics Stack <https://blog.mecheye.net/2012/06/the-linux-graphics-stack/>`_ - Jasper St. Pierre (2012)
-- 
2.34.1

