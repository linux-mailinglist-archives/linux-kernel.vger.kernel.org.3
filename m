Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF394F6D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 23:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbiDFVvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 17:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbiDFVvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 17:51:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 262008BE20
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 14:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649281252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HYliOFP5D5aEhYg/JNms+LtE3G2AOKbcjH7HxyHb8vw=;
        b=dYWr3V0/ImRW8fUQa2rxvy/atfliw5zGCuc8lxlRiCVXGIWhk1o7Itg+FiFqwpZx0iQ4PP
        W2JnoX0Uw2ggpiKTsMFFVTr54rH8XpPmIk3j+l5TVgJQir+OOGloUAfny/Bu2EJ4ifqk5K
        k+sbhl1Q4ylHPiO0jyJcfJpZ2w2nhzU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-tyvoNc6iPM27azh2PPaxTQ-1; Wed, 06 Apr 2022 17:40:51 -0400
X-MC-Unique: tyvoNc6iPM27azh2PPaxTQ-1
Received: by mail-wm1-f72.google.com with SMTP id v62-20020a1cac41000000b0038cfe6edf3fso3534343wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 14:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HYliOFP5D5aEhYg/JNms+LtE3G2AOKbcjH7HxyHb8vw=;
        b=o+MgPw/BtCYNNzf22gZnYKxIrayRt/E7q+jhq4Bzoc3SO14PqTiVUzgJ/nNza2diT1
         NqzKLFyUXiTOVDWyjX88F48rqXVi+hvB7pfto/BUcwrRlbya4b5lmK3BDtFwM4bFnjix
         57iJn3v4Q9R6ywOVLH1TAXnra05CMiwK63bM/vXT/e2OsrSU1NbUF/4t4DHbD2kYUOsn
         FWSsg5TjevdfTBK+UpwrrOEEDXH8Ov2t9ZXNabyZPTl4X2aWHEFbyCJ9JUE77CA74DaV
         4/RJp/IXvQd4L6Y/yuqPEWjTnUhy0GwLmTMRTl5I+cTUwIPySMAlMcBJnMfm3M6kk801
         oYbQ==
X-Gm-Message-State: AOAM533uKOu2qP7jP8gxXmw2hy6zf2OTGUUV673WpH9KjGytfl98bODf
        zrb6Mbho8oMu2JTTYZiGROTQ9IgyGg+27jmUOgtnaRjOR/rmmaDGSSsfcMtCrCC/mA6cNuswXrk
        j4HPaf5i2XNpmJ930n/jUGsLX+0a8bkqq6QqWQt8PrP1qmu4JicD9dcP70I1/ZqKMgtmHM3uCaC
        U=
X-Received: by 2002:a7b:c111:0:b0:38e:7077:e650 with SMTP id w17-20020a7bc111000000b0038e7077e650mr9147339wmi.114.1649281250433;
        Wed, 06 Apr 2022 14:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6hhwgShELHlodQTRxrKt29AWUJxRNlWgookBuUhICSyykfZrbEYfYfVmqPCNphwSJ5AP/dw==
X-Received: by 2002:a7b:c111:0:b0:38e:7077:e650 with SMTP id w17-20020a7bc111000000b0038e7077e650mr9147307wmi.114.1649281250073;
        Wed, 06 Apr 2022 14:40:50 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm5876020wms.15.2022.04.06.14.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 14:40:49 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, linux-fbdev@vger.kernel.org
Subject: [RESEND RFC PATCH 0/5] Fix some race conditions that exists between fbmem and sysfb
Date:   Wed,  6 Apr 2022 23:39:14 +0200
Message-Id: <20220406213919.600294-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ resend since dri-devel wasn't Cc'ed on all patches, sorry for the noise ]

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

This series attempt to fix it more properly and reverted the mentioned
hack. This will also unblock a pending patch to not make num_registered_fb
visible to drivers anymore, since that's really internal to fbdev core.

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

I'm sending as an RFC since there are many changes to the locking scheme
and that is always tricky to get right. Please let me know what you think.

Best regards,
Javier


Daniel Vetter (1):
  Revert "fbdev: Prevent probing generic drivers if a FB is already
    registered"

Javier Martinez Canillas (4):
  firmware: sysfb: Make sysfb_create_simplefb() return a pdev pointer
  firmware: sysfb: Add helpers to unregister a pdev and disable
    registration
  fbdev: Restart conflicting fb removal loop when unregistering devices
  fbdev: Fix some race conditions between fbmem and sysfb

 drivers/firmware/sysfb.c          | 51 ++++++++++++++++++++++++++-----
 drivers/firmware/sysfb_simplefb.c | 24 +++++++++------
 drivers/video/fbdev/core/fbmem.c  | 38 ++++++++++++++++++-----
 drivers/video/fbdev/efifb.c       | 11 -------
 drivers/video/fbdev/simplefb.c    | 11 -------
 include/linux/fb.h                |  1 -
 include/linux/sysfb.h             | 29 +++++++++++++++---
 7 files changed, 112 insertions(+), 53 deletions(-)

-- 
2.35.1

