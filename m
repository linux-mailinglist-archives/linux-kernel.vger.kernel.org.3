Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 756C44F6806
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239573AbiDFR5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239739AbiDFR5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24CCF1945FD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649261205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z2VH15DInn1AZtnEsLb+elNYhtkABvKZLJ4uYvk26l8=;
        b=NETWHqBj1mnVpH0HD56sdhonkILW2aD6WcU7Tp9BR27zjjAn6Ok3Y/hL1iHMiCGcu38pOD
        GwYWSAba8qhWsiZF++n3BEo/fGPvTlHTlu6CHBU4g26oIXn5CXXWPeN4Cl2KBpDgPPXuW3
        8H3izFB/4bXLXWrGPfdRYj0l2nowXFE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-496-qRAtYFn2PtGlfs9P02OHEg-1; Wed, 06 Apr 2022 12:06:44 -0400
X-MC-Unique: qRAtYFn2PtGlfs9P02OHEg-1
Received: by mail-wm1-f71.google.com with SMTP id r19-20020a7bc093000000b0038e706da7c0so1524827wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 09:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z2VH15DInn1AZtnEsLb+elNYhtkABvKZLJ4uYvk26l8=;
        b=z16g673V4cG8xJ99tqCi2s5Qdu50X4N324YBaRE0VJqmHbwK+bTMJpft4OXhJUKTG8
         IsxCe7YUGxaH9OGcOgAEwcO47ExlphGkI1XtaXW85r3PI51rE+BRcmDN5BKQFj3dXUfg
         uKWXMUmzLFkjBjrA2C6MLE/p6kCyC6HDOXdW1wVtjyK7GBXUI8XzHWU8+RtppCM0AsXd
         HwhL6efnhJlMLjZXntfK1hrI1DgryxWMfWrLjecJn1Mu0grbXbMaAVe6+i8cBAcIpDIr
         SypyDSw1bpk9xWGvYt+4a3e2ZAvp51R4m2UHWqEV82+Hrqq9s/wb5sIhv9/jjq2Jtuof
         mIhQ==
X-Gm-Message-State: AOAM531DdiUe3Avmf9toKEIudtM2nAquvA0uKVVzw/HqYyX90JYZAszp
        HMxPM7C3+jw2Aum6pYfpcsdflSUjZLO0SHsG5IOMEf69bkbZdBBm4Rqvtb660xOqIZCBT+HV3Xa
        AyI/TjLG3FLmdUdi5J3Q3JCW7rBrQs7A4uKowdBEQCkvqIwWbtmKSV3mJGXh4FbMpWu54zs2pXU
        Y=
X-Received: by 2002:a05:600c:b55:b0:38e:70e7:511f with SMTP id k21-20020a05600c0b5500b0038e70e7511fmr8332666wmr.178.1649261203293;
        Wed, 06 Apr 2022 09:06:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7yE8td6/fkffNhvrsqmHf15H0cuBaZltuOzDP9IJ5K6fOajl4WM2WGSsI9m1B/7+4GryIGA==
X-Received: by 2002:a05:600c:b55:b0:38e:70e7:511f with SMTP id k21-20020a05600c0b5500b0038e70e7511fmr8332625wmr.178.1649261202834;
        Wed, 06 Apr 2022 09:06:42 -0700 (PDT)
Received: from minerva.home ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm5038899wmc.7.2022.04.06.09.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 09:06:42 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>,
        Miaoqian Lin <linmq006@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [RFC PATCH 0/5] Fix some race conditions that exists between fbmem and sysfb
Date:   Wed,  6 Apr 2022 18:06:27 +0200
Message-Id: <20220406160632.496684-1-javierm@redhat.com>
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
 include/linux/sysfb.h             | 27 +++++++++++++---
 7 files changed, 111 insertions(+), 52 deletions(-)

-- 
2.35.1

