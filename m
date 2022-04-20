Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697EB508428
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376978AbiDTI4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376971AbiDTI4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E68C93B2AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650444797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E0YhsAgzYjv+lmX1BaJJCZkRLt/I7LvOa39GZEIhqUY=;
        b=HShUpXSy9Lmk1ayjyUlaNjqpc2vWg2GlC5BuVu64pUDSLC8mhECPb88WTTou7nDobOonvT
        WVhUUlOEj0WOjhRGspLKLNxL1P+gPExHjpwxkFpnuY1UE3q6GT2iOXmcDSJQCLXZBODOsF
        yKhG3BRBlsjgisBwY2CvFp1uoue4Y/E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-BGY-yOY4Nn6sqiSL8uNMuA-1; Wed, 20 Apr 2022 04:53:15 -0400
X-MC-Unique: BGY-yOY4Nn6sqiSL8uNMuA-1
Received: by mail-wm1-f70.google.com with SMTP id n37-20020a05600c502500b0038fdc1394c6so633469wmr.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 01:53:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=E0YhsAgzYjv+lmX1BaJJCZkRLt/I7LvOa39GZEIhqUY=;
        b=fBTqGGWq3aG5zFVPOVg6DkJpW3GDJkIgsRdDiMPo3Ojb1MF9QEp3MzPlcXWBGp9/16
         WvyfPYHZvp48JS9n6cvwiclB56OWZe5CZH17nYZUD+MlUaYJmFAYy5zH84RqgzFLmSe3
         wt2p0AVm0VODm7D7YGXVT/D/NsrIwFjeerTOTS4ExrCFWEO343MklZc3L/XqfuzxqTu1
         2HUCJYZZD+MdwX+36aXeaO940yDrRqW6iNcSFr2ivTCVu194tNXSGQUAdkYmPMwhFrJw
         Nqm++FKcrbuYFr5Gx7L+HN6Ia8/SIA8xuzkOQUnoRS974WySoqHZeRWyPJGC2QxSAHWP
         ihnw==
X-Gm-Message-State: AOAM533eXQhsU9lZjMlkO8dYia7mgyjLhg7jcdlfp7edgAaWsR6jp5+O
        TTTwYXn2lYTol48kKvYMZ3Ps5T7aiU80ET7C9HOtmRJmycYnl65/dEtxd/4OH3XcoytfBCGYDG8
        sm5C2r2D2mY2MQWirgfIneNG15eiFrp20HoSahC1/cmgkcodfi3nBDd9quPnxA9Op4Wk/A4ww1Z
        Q=
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr2496912wmb.157.1650444794433;
        Wed, 20 Apr 2022 01:53:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxheIU3MZtHSmbm2S30h9XB//sGVs+fBzUrdX6TE0Ye/x/JWHfdB5GuD6LrNgo08kTzLr689Q==
X-Received: by 2002:a1c:f018:0:b0:37b:c13c:3128 with SMTP id a24-20020a1cf018000000b0037bc13c3128mr2496874wmb.157.1650444794081;
        Wed, 20 Apr 2022 01:53:14 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b0020aac00f862sm1895343wry.98.2022.04.20.01.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 01:53:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Yizhuo Zhai <yzhai003@ucr.edu>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        linux-doc@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v3 0/5] Fix some race conditions that exists between fbmem and sysfb
Date:   Wed, 20 Apr 2022 10:52:58 +0200
Message-Id: <20220420085303.100654-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The patches in this series are mostly changes suggested by Daniel Vetter
to fix some race conditions that exists between the fbdev core (fbmem)
and sysfb with regard to device registration and removal.

For example, it is currently possible for sysfb to register a platform
device after a real DRM driver was registered and requested to remove the
conflicting framebuffers.

A symptom of this issue, was worked around with by commit fb561bf9abde
("fbdev: Prevent probing generic drivers if a FB is already registered")
but that's really a hack and should be reverted.

This series attempt to fix it more properly and revert the mentioned hack.
That will also unblock a pending patch to not make the num_registered_fb
variable visible to drivers anymore, since that's internal to fbdev core.

Patch #1 is just a trivial preparatory change.

Patch #2 add sysfb_disable() and sysfb_try_unregister() helpers for fbmem
to use them.

Patch #3 changes how is dealt with conflicting framebuffers unregistering,
rather than having a variable to determine if a lock should be take, it
just drops the lock before unregistering the platform device.

Patch #4 fixes the mentioned race conditions and finally patch #5 is the
revert patch that was posted by Daniel before but he dropped from his set.

The patches were tested on a rpi4 using different video configurations:
(simpledrm -> vc4 both builtin, only vc4 builtin, only simpledrm builtin
and simpledrm builtin with vc4 built as a module).

Best regards,
Javier

Changes in v3:
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

Daniel Vetter (1):
  Revert "fbdev: Prevent probing generic drivers if a FB is already
    registered"

Javier Martinez Canillas (4):
  firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
  firmware: sysfb: Add helpers to unregister a pdev and disable
    registration
  fbdev: Restart conflicting fb removal loop when unregistering devices
  fbdev: Fix some race conditions between fbmem and sysfb

 .../driver-api/firmware/other_interfaces.rst  |  6 ++
 drivers/firmware/sysfb.c                      | 77 +++++++++++++++++--
 drivers/firmware/sysfb_simplefb.c             | 16 ++--
 drivers/video/fbdev/core/fbmem.c              | 62 ++++++++++++---
 drivers/video/fbdev/efifb.c                   | 11 ---
 drivers/video/fbdev/simplefb.c                | 11 ---
 include/linux/fb.h                            |  1 -
 include/linux/sysfb.h                         | 29 +++++--
 8 files changed, 158 insertions(+), 55 deletions(-)

-- 
2.35.1

