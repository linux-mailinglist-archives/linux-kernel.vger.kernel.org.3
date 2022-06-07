Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1505954175A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378140AbiFGVBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357503AbiFGT4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 734F3AFAF3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654626227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hkQx7yHQRkPbdTnula/SBJrpw+Sj9SwG2uOeS/prAHE=;
        b=izZTe1Fp4YmJ7E3RaPDO1sf4aWRCK+AvPMYFC8pTWmTTI7jdWtZh/5FzT4mVb+LHbO2RB0
        vbbcyT5WQ1NlFizQQeKRPzr8G3Zp0j7wbAkyvIRHwV9aK3khzKzDcko4NjIHdjJNFBmuO9
        aN6gabt+Xd7gtGMcSyGAZqCHiWPfihg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-cy2Cv-xeNCWwY6_gqga4bQ-1; Tue, 07 Jun 2022 14:23:46 -0400
X-MC-Unique: cy2Cv-xeNCWwY6_gqga4bQ-1
Received: by mail-wm1-f69.google.com with SMTP id be12-20020a05600c1e8c00b0039c506b52a4so1920226wmb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 11:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hkQx7yHQRkPbdTnula/SBJrpw+Sj9SwG2uOeS/prAHE=;
        b=XMIpe06scuTuBPnjwUaaqKIhjGVgV2JR5q2IGdL6YtqviBVgD7rlD3Q3StHp4QOuMd
         X68lIxeVIQT/2oFr36EOCxGupBw3ZaFR0xg6VLTWAcgvxG7MagKzDFl0W0gDDd6h6Ktg
         f8C/gZjelFydl7s6mjRVodhfz4o1vlq5W9bDUMx5N49olnJ6aNTJzgRDgED4zBX5tRMs
         69GuA9P6Etmuw0D5smXWm6ZfqYFcuKAPWiCQa4JQ5679xtlw1fXeTlp4baQE2Vs0fBjO
         10ZLO2Lq+MLMKztpQorlhZe9X3VpJ4pHx3wA8VB93qvuKeaCHsxxyM937HZKfbXr8ing
         1ViQ==
X-Gm-Message-State: AOAM531qdWJBeQ9SOvreuKlIDFM6HyT0N8dZTgftun2aTMdlYu6wTDUo
        SM0Xio7S0x5dVD03OA+UO+r76aK/DhCloEQKYrunyero3VdkIvytt0qWpGp7uxfNy4xY90qgm1U
        9pQX9LUWAs+7VJnIykSDAh0Freq+Hge/SfOgs2ahWinROU2iYE8DifiX1uhrDKIq8XYrODY4Y67
        g=
X-Received: by 2002:a05:6000:18aa:b0:210:eef2:1137 with SMTP id b10-20020a05600018aa00b00210eef21137mr29273105wri.134.1654626224761;
        Tue, 07 Jun 2022 11:23:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxN4w6wiLjoJYUQMubo1fIcQNXev6xL+517nU/KlMZgD8bGIW170MGyDzMCn47TwhWHZ6WTgQ==
X-Received: by 2002:a05:6000:18aa:b0:210:eef2:1137 with SMTP id b10-20020a05600018aa00b00210eef21137mr29273059wri.134.1654626224460;
        Tue, 07 Jun 2022 11:23:44 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b003942a244f51sm28267502wmq.42.2022.06.07.11.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 11:23:44 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laszlo Ersek <lersek@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>, kvm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
        Peter Jones <pjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: [PATCH v6 0/5] Fix some races between sysfb device registration and drivers probe
Date:   Tue,  7 Jun 2022 20:23:33 +0200
Message-Id: <20220607182338.344270-1-javierm@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

A symptom of this issue, was worked around with the commit fb561bf9abde
("fbdev: Prevent probing generic drivers if a FB is already registered")
but that's really a hack and should be reverted instead.

This series attempt to fix it more correctly and revert the mentioned hack.
That will also allow to make the num_registered_fb variable not visible to
drivers anymore, since that's internal to fbdev core.

Pach 1 is just a simple cleanup in preparation for later patches.

Patch 2 add a sysfb_disable() helper to allow disabling sysfb and unregister
devices registered by sysfb.

Patch 3 fixes the race that exists between sysfb devices registration and
fbdev framebuffer devices registration, by disabling the sysfb when a DRM
or fbdev driver requests to remove conflicting framebuffers.

Patch 4 is the revert patch that was posted by Daniel before but dropped
from his set and finally patch 5 is the one that makes num_registered_fb
private to fbmem.c, to not allow drivers to use it anymore.

The patches were tested on a rpi4 with the vc4, simpledrm and simplefb
drivers, using different combinations of built-in and as a module.

Best regards,
Javier

Changes in v6:
- Drop sysfb_try_unregister() helper since is no longer needed.
- Move the sysfb_disable() before the remove conflicting framebuffers
  loop (Daniel Vetter).
- Drop patch "fbdev: Make sysfb to unregister its own registered devices"
  since was no longer needed.

Changes in v5:
- Move the sysfb_disable() call at conflicting framebuffers again to
  avoid the need of a DRIVER_FIRMWARE capability flag.
- Add Daniel Vetter's Reviewed-by tag again since reverted to the old
  patch that he already reviewed in v2.
- Drop patches that added a DRM_FIRMWARE capability and use them
  since the case those prevented could be ignored (Daniel Vetter).

Changes in v4:
- Make sysfb_disable() to also attempt to unregister a device.
- Add patch to make registered_fb[] private.
- Add patches that introduce the DRM_FIRMWARE capability and usage.

Changes in v3:
- Add Thomas Zimmermann's Reviewed-by tag to patch #1.
- Call sysfb_disable() when a DRM dev and a fbdev are registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
- Call sysfb_disable() when a fbdev framebuffer is registered rather
  than when conflicting framebuffers are removed (Thomas Zimmermann).
- Drop Daniel Vetter's Reviewed-by tag since patch changed a lot.
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
- Drop RFC prefix since patches were already reviewed by Daniel Vetter.
- Add Daniel Reviewed-by tags to the patches.

Daniel Vetter (2):
  Revert "fbdev: Prevent probing generic drivers if a FB is already
    registered"
  fbdev: Make registered_fb[] private to fbmem.c

Javier Martinez Canillas (3):
  firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
  firmware: sysfb: Add sysfb_disable() helper function
  fbdev: Disable sysfb device registration when removing conflicting FBs

 .../driver-api/firmware/other_interfaces.rst  |  6 ++
 drivers/firmware/sysfb.c                      | 58 ++++++++++++++++---
 drivers/firmware/sysfb_simplefb.c             | 16 ++---
 drivers/video/fbdev/core/fbmem.c              | 20 ++++++-
 drivers/video/fbdev/efifb.c                   | 11 ----
 drivers/video/fbdev/simplefb.c                | 11 ----
 include/linux/fb.h                            |  7 +--
 include/linux/sysfb.h                         | 23 ++++++--
 8 files changed, 103 insertions(+), 49 deletions(-)

-- 
2.36.1

