Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A40F514494
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355918AbiD2Iqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355898AbiD2Iqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DABD5F75
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651221790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=O+D/lXpklfq+8wvoJL4WqSLyZYHeykKORq3ghDDfCNk=;
        b=OpjGa+fMoybempB8Z6gDmUOUyhHQhmvPHHqQN4OtYdFjUV6KGfkOOtCfP+LUufEX+JxJNV
        jQiEvyVeHvh+I+DrA9G/BBR8o4KRcpOuQ2ygkWDl7Eh31hhH7LI745PXFU25uWTBsikwP1
        ByGgfFynMB1vs1CwEL8Uqpsbtw/a0eg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-hyXm6fXCOE-ueZEnB81bDA-1; Fri, 29 Apr 2022 04:43:08 -0400
X-MC-Unique: hyXm6fXCOE-ueZEnB81bDA-1
Received: by mail-wm1-f71.google.com with SMTP id c125-20020a1c3583000000b0038e3f6e871aso2700838wma.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 01:43:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O+D/lXpklfq+8wvoJL4WqSLyZYHeykKORq3ghDDfCNk=;
        b=blHOf5ir73PVbiAb+WFUPiNgKUcHrmkvTIztMhdJdFih4lBEju9qe2HwgJaylYzVJz
         dTd4AQJe0vXcqrbrUy+FQBeZcn0znV9g+gCZ5qAGwT/CaPOWqMU7Hp8x5uAfa8+PsfR6
         egitPW/HXr6rCHN1X0uwZnuXQ394wslpTCOIapt9LJt7oWl/cDHxAemGxrtNwgvSvPnu
         t92/4gf7x0e2w5H9ajVZ9TluMmumE2UryZQVuyUbs54L3pJvXka/9Pp8TAF9qQOX6IXn
         5QJ96TPwyAoCGCDyvuvtsH2uWJtBCp5Iwi449gNLK6PLEW7R3os83CEoJJiCrklgkR+H
         /PCg==
X-Gm-Message-State: AOAM532MZ3gEzSQ2pw8WdEo4jNxLQG7H+RKy5va63+bD4harxKNTjng2
        1NMbmJTmRD54CROu6N0Ph4EfjBQMg5cHBbZrbX02+qVokk5T/NAKjFxfdikC1FYhF2+GSqqQz+l
        sfKmuztdvJyfYhJgATQ2uH+IUKge3V2jegk91AV9t/GwS3P77qy44/0QULHOsYrt+m473BvHPID
        s=
X-Received: by 2002:a05:600c:1f0e:b0:392:8b04:9b26 with SMTP id bd14-20020a05600c1f0e00b003928b049b26mr2125594wmb.106.1651221786919;
        Fri, 29 Apr 2022 01:43:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFPu5i9uIaA8HyARC22sqTOXWCEAPFZw0X8BSM+9g/zQpViY352JC38fzukmqcZeLoqR+Pfw==
X-Received: by 2002:a05:600c:1f0e:b0:392:8b04:9b26 with SMTP id bd14-20020a05600c1f0e00b003928b049b26mr2125550wmb.106.1651221786551;
        Fri, 29 Apr 2022 01:43:06 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f7-20020a05600c4e8700b00393f1393abfsm7199256wmq.41.2022.04.29.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 01:43:06 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [RFC PATCH v4 00/11] Fix some race between sysfb device registration and drivers probe
Date:   Fri, 29 Apr 2022 10:42:42 +0200
Message-Id: <20220429084253.1085911-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patches in this series contain mostly changes suggested by Daniel Vetter
Thomas Zimmermann. They aim to fix existing races between the Generic System
Framebuffer (sysfb) infrastructure and the fbdev and DRM device registration.

For example, it is currently possible for sysfb to register a platform
device after a real DRM driver was registered and requested to remove the
conflicting framebuffers. Or is possible for a simple{fb,drm} to match with
a device previously registered by sysfb, even after a real driver is present.

A symptom of this issue, was worked around with by commit fb561bf9abde
("fbdev: Prevent probing generic drivers if a FB is already registered")
but that's really a hack and should be reverted.

This series attempt to fix it more correctly and revert the mentioned hack.
That will also allow to make the num_registered_fb variable not visible to
drivers anymore, since that's internal to fbdev core.

Even though the series is a v4, I've marked it as RFC again since some of
the patches are controversial and the approach will need more discussion.

Patches 1-3 add a new DRIVER_FIRMWARE capability to denote that a DRM driver
uses a firmware provided framebuffer, to mark the emulated fbdev registered
also as a firmware provided framebuffer.

Pach 4 is just a simple cleanup in preparation for later patches.

Patch 5 add a sysfb_disable() and sysfb_try_unregister() helpers to allow
disabling sysfb and attempt to unregister registered devices respectively.

Patch 6 changes how is dealt with conflicting framebuffers unregistering,
rather than having a variable to determine if a lock should be take, it
just drops the lock before unregistering the platform device.

Patch 7 changes the fbdev core to not attempt to unregister devices that
were registered by sysfb, let the same code doing the registration to also
handle the unregistration.

Patch 8 fixes the race that exists between sysfb devices registration and
fbdev framebuffer devices registration.

Patch 9 does the same but to fix the race that exists between sysfb and
the DRM subsystem.

Patch 10 is the revert patch that was posted by Daniel before but dropped
from his set and finally patch 11 is the one that makes num_registered_fb
private to fbmem.c and not allow drivers to use it anymore.

The patches were tested on a rpi4 with the vc4, simpledrm and simplefb
drivers, using different combinations of built-in and as a module. But
being an RFC, I didn't test all possible cases.

Best regards,
Javier

Changes in v4:
- Make sysfb_disable() to also attempt to unregister a device.
- Drop call to sysfb_disable() in fbmem since is done in other places now.
- Add patch to make registered_fb[] private.
- Add patches that introduce the DRM_FIRMWARE capability and usage.

Changes in v3:
- Add Thomas Zimmermann's Reviewed-by tag to patch #1.
- Call sysfb_disable() when a fbdev framebuffer is registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
- Drop Daniel Vetter's Reviewed-by tag since patch changed a lot.
- Call sysfb_disable() when a DRM device is registered rather than
  when conflicting framebuffers are removed (Thomas Zimmermann).
- Rebase on top of latest drm-misc-next branch.

Changes in v2:
- Rebase on top of latest drm-misc-next and fix conflicts (Daniel Vetter).
- Add kernel-doc comments and include in other_interfaces.rst (Daniel Vetter).
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).
- Explain in the commit message that fbmem has to unregister the device
  as fallback if a driver registered the device itself (Daniel Vetter).
- Also explain that fallback in a comment in the code (Daniel Vetter).
- Don't encode in fbmem the assumption that sysfb will always register
  platform devices (Daniel Vetter).
- Add a FIXME comment about drivers registering devices (Daniel Vetter).
- Drop RFC prefix since patches were already reviewed by Daniel Vetter.
- Add Daniel Reviewed-by tags to the patches.

Daniel Vetter (2):
  Revert "fbdev: Prevent probing generic drivers if a FB is already
    registered"
  fbdev: Make registered_fb[] private to fbmem.c

Javier Martinez Canillas (9):
  drm: Add a capability flag for simple framebuffer drivers
  drm/fb-helper: Set FBINFO_MISC_FIRMWARE flag for DRIVER_FIRMWARE fb
  drm/simpledrm: Set the DRM_FIRMWARE capability
  firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
  firmware: sysfb: Add helpers to unregister a pdev and disable
    registration
  fbdev: Restart conflicting fb removal loop when unregistering devices
  fbdev: Make sysfb to unregister its own registered devices
  fbdev: Fix race between sysfb and framebuffer devices registration
  drm: Fix race between sysfb and DRM devices registration

 .../driver-api/firmware/other_interfaces.rst  |  6 ++
 drivers/firmware/sysfb.c                      | 91 +++++++++++++++++--
 drivers/firmware/sysfb_simplefb.c             | 16 ++--
 drivers/gpu/drm/drm_drv.c                     | 12 +++
 drivers/gpu/drm/drm_fb_helper.c               |  4 +
 drivers/gpu/drm/tiny/simpledrm.c              |  2 +-
 drivers/video/fbdev/core/fbmem.c              | 67 +++++++++++---
 drivers/video/fbdev/efifb.c                   | 11 ---
 drivers/video/fbdev/simplefb.c                | 11 ---
 include/drm/drm_drv.h                         |  6 ++
 include/linux/fb.h                            |  8 +-
 include/linux/sysfb.h                         | 29 +++++-
 12 files changed, 201 insertions(+), 62 deletions(-)

-- 
2.35.1

