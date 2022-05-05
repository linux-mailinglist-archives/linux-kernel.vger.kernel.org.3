Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97C951BE0E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357369AbiEELf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355141AbiEELfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:35:20 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.133.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47B5E25C54
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 04:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651750299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=bN3Uh2LhXlJZ1HGDsbuHnMTmS7+4/Zex2TjyKUB51Mw=;
        b=YcDRqyWyCtbpyZrLZRnmxi7eomj1ajrMnXXw3S64gMeEfdUsPMkftHS1gBlpDySmDhSEe+
        TCdT7AIWF5/U1eCszLRoMgs8UlZ4dRT/KicJXkARYx0jf/uw2VViHjT/xxe/3Uyx8k9eP6
        p7DUlwbS2ZFKNIck5ol/og/JhHnwvXc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-0lIDF9mhOEOx5GTV-IQS1A-1; Thu, 05 May 2022 07:31:38 -0400
X-MC-Unique: 0lIDF9mhOEOx5GTV-IQS1A-1
Received: by mail-wm1-f70.google.com with SMTP id c62-20020a1c3541000000b0038ec265155fso4362443wma.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 04:31:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bN3Uh2LhXlJZ1HGDsbuHnMTmS7+4/Zex2TjyKUB51Mw=;
        b=QdHW84TqLyD9AXpQne3kaE3IXNIRlFjS60e11RmoZEUXm+w2n5p0T24uJrf5jkjpGj
         nbba8kpdPSx8pe61s/tfh9Gqug1klJefbMVjJXIX+zsJbaf1sAV88uoHYYtFqdiWnIGp
         r5+Ljw5+zm6I5Zf0ZjkFWM1hKElun++mjz/6RyxDTK+dCMEgIw16A+ZKqMqctw8hawRz
         7YGc9geFTp5rKgaXR/e7nD/F2IsLcIsjYlgg5EFCVT3J0qJvyy/nAVnbuwG55K3rQq08
         3CguXv43+1xvbaJi9p/pkxfptmGTyr8xlp1DAIij2sM2nMdWuAzQh1dUQuEBBTdBXzZe
         EP3w==
X-Gm-Message-State: AOAM531Sp/H2XpGdzI1bctm+46w9nGFt4IgaXWra0QgaySfxKzxmwb9K
        KzICx4qtjmveQuAtCgSprVZQ3+rACUzPIv+IWHdiO2TZGjPFUDFJqWe/AbA6fr3NbkVPgNPIFZQ
        I/RzyX49h8wb1FfNtXzoCUMRq3n8/4KfhPVbq2t7+lGnQHYzvlVALzqRjjysr24hL/0D4YEX4xt
        k=
X-Received: by 2002:a05:600c:1e8a:b0:394:a8:234 with SMTP id be10-20020a05600c1e8a00b0039400a80234mr4310556wmb.117.1651750296664;
        Thu, 05 May 2022 04:31:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYkJhU3npy2RP0EYd+TCS/YRsPqKFjNBTxwh4iOfYuxwgG9V/BfOG8Dx2RoPJjNmCfU8QlfQ==
X-Received: by 2002:a05:600c:1e8a:b0:394:a8:234 with SMTP id be10-20020a05600c1e8a00b0039400a80234mr4310517wmb.117.1651750296280;
        Thu, 05 May 2022 04:31:36 -0700 (PDT)
Received: from minerva.. ([90.167.94.135])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d5181000000b0020c5253d8f5sm995809wrv.65.2022.05.05.04.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 04:31:35 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans de Goede <hdegoede@redhat.com>,
        Helge Deller <deller@gmx.de>, Peter Jones <pjones@redhat.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2 0/4] fbdev: Fix use-after-free caused by wrong fb_info cleanup in drivers
Date:   Thu,  5 May 2022 13:31:23 +0200
Message-Id: <20220505113128.264963-1-javierm@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains patches suggested by Daniel Vetter to fix a use-after-free
error in the fb_release() function, due a fb_info associated with a fbdev being
freed too early while a user-space process still has the fbdev dev node opened.

That is caused by a wrong management of the struct fb_info lifetime in drivers,
but the fbdev core can also be made more resilient about it an leak

This can easily be reproduced with the simplefb driver doing the following:

$ cat < /dev/fb0 &
$ echo simple-framebuffer.0 > /sys/bus/platform/drivers/simple-framebuffer/unbind
$ kill %1

[  257.490471] ------------[ cut here ]------------
...
[  257.495125] refcount_t: underflow; use-after-free.
[  257.495222] WARNING: CPU: 0 PID: 975 at lib/refcount.c:28 refcount_warn_saturate+0xf4/0x144
...
[  257.637482] pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  257.644441] pc : refcount_warn_saturate+0xf4/0x144
[  257.649226] lr : refcount_warn_saturate+0xf4/0x144
[  257.654009] sp : ffff80000a06bbf0
[  257.657315] x29: ffff80000a06bbf0 x28: 000000000000000a x27: 000000000000000a
[  257.664448] x26: 0000000000000000 x25: ffff470b88c6a180 x24: 000000000000000a
[  257.671581] x23: ffff470b81706480 x22: ffff470b808c2160 x21: ffff470b8922ba20
[  257.678713] x20: ffff470b891f5810 x19: ffff470b891f5800 x18: ffffffffffffffff
[  257.685846] x17: 3a725f7463656a62 x16: ffffbb18c6465fd4 x15: 0720072007200720
[  257.692978] x14: 0720072d072d072d x13: 0a2e656572662d72 x12: 657466612d657375
[  257.700110] x11: 203b776f6c667265 x10: 646e75203a745f74 x9 : ffffbb18c58f6c90
[  257.707242] x8 : 75203b776f6c6672 x7 : 65646e75203a745f x6 : 0000000000000001
[  257.714373] x5 : ffff470bff8ec418 x4 : 0000000000000000 x3 : 0000000000000027
[  257.721506] x2 : 0000000000000000 x1 : 0000000000000027 x0 : 0000000000000026
[  257.728638] Call trace:
[  257.731075]  refcount_warn_saturate+0xf4/0x144
[  257.735513]  put_fb_info+0x70/0x7c
[  257.738916]  fb_release+0x60/0x74
[  257.742225]  __fput+0x88/0x240
[  257.745276]  ____fput+0x1c/0x30
[  257.748410]  task_work_run+0xc4/0x21c
[  257.752066]  do_exit+0x170/0x370
[  257.755288]  do_group_exit+0x40/0xb4
[  257.758858]  get_signal+0x8e0/0x90c
[  257.762339]  do_signal+0x1a0/0x280
[  257.765733]  do_notify_resume+0xc8/0x390
[  257.769650]  el0_da+0xe8/0xf0
[  257.772613]  el0t_64_sync_handler+0xe8/0x130
[  257.776877]  el0t_64_sync+0x190/0x194
[  257.780534] ---[ end trace 0000000000000000 ]---

Patch #1 adds a WARN_ON() to framebuffer_release() to prevent the use-after-free
to happen.

Patch #2, #3 and #4 fix the simplefb, efifb and vesafb drivers respectively, to
free the resources at the correct place.

Changes in v2:
- Also do the change for vesafb (Thomas Zimmermann).

Daniel Vetter (1):
  fbdev: Prevent possible use-after-free in fb_release()

Javier Martinez Canillas (3):
  fbdev: simplefb: Cleanup fb_info in .fb_destroy rather than .remove
  fbdev: efifb: Cleanup fb_info in .fb_destroy rather than .remove
  fbdev: vesafb: Cleanup fb_info in .fb_destroy rather than .remove

 drivers/video/fbdev/core/fbsysfs.c |  4 ++++
 drivers/video/fbdev/efifb.c        |  9 ++++++++-
 drivers/video/fbdev/simplefb.c     |  8 +++++++-
 drivers/video/fbdev/vesafb.c       | 14 +++++++++++---
 4 files changed, 30 insertions(+), 5 deletions(-)

-- 
2.35.1

