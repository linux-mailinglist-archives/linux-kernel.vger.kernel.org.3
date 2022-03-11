Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42A4D5C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 08:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347058AbiCKHYT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 02:24:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235117AbiCKHYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 02:24:16 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27826A66C6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:23:14 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id lj8-20020a17090b344800b001bfaa46bca3so7249915pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 23:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=2UiXXrEjdOpBieCoiCd3aIQdcB5Bw07/UD0oa+EI5Cs=;
        b=VGw2sJf7ZC5hIzk26XFnKPx84Hs7TL3fu43vK4vihxZ1OU6Ow8coT6SRzjKUqCLP3W
         PuReiL/3OaezeQYUIpCI4Vj0eb8gMnOf7OTcHr0lHQN5iI+t73DSIB3Y/i2zNeFILLBu
         WJix6q602iGFXeE54Ld7N85ac2s73RMCN+j3lWM9mlszRqX0x0uqDfXS2nOxaaKrwf6r
         xys/HsaSzzU9fHfhithhTXUhcwj+Z8lWSuP7uzhW+SbhJMejhkEN0XFKkx/4sVXp6+d9
         FOg5V/ZYfyGc9WwJ+Oh7qpuuVT4uptvUmZ33JokW370SW4qsxGLI5l184okvrha56Rce
         D48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2UiXXrEjdOpBieCoiCd3aIQdcB5Bw07/UD0oa+EI5Cs=;
        b=W1SrvZHTE3h1AlqQL0ZgMkkApD9eTZtyKu+0fdiBjG25WCoDrtUNcslUJlLZhjMjko
         MC066nVXNxbtBvT//i6qEm/BXo0PGeny8WTDOI2AjCDUpGnL0B39m/FmENMo7faFnJLX
         84USU8QrMBejZO28x8LJZgIRGe/biW4eKtU6mnoTW1A7NxZCKe9zzytve83uKy11AVgc
         RPhfeP6qWcdrdxJlGvr6au8wsxvAG9dQPACkHPyT81T9z6jIurd6JYYsKsrxY8kzB7Og
         8/YJpX3gAqrRQX9xybgh9j304z7pbc7sVNCp7BoRrQY6dOCUxR3J2lSxFir2v14ZunO6
         aArA==
X-Gm-Message-State: AOAM5315WCGhyudaiFS4ywAqdkDVbmyxA2AjGgKbpe4eZXtU/+nq6/Qu
        hxN7UoJrYyob9KN5+lr2cw==
X-Google-Smtp-Source: ABdhPJwK5t4CfKDqHjqDyY3n+hI+DNnXEM4ILZ3cGz9W2U5alypJtzbJ+Q0FEvrFPgMYq4olE7DrRA==
X-Received: by 2002:a17:902:b204:b0:14d:a8c8:af37 with SMTP id t4-20020a170902b20400b0014da8c8af37mr9119476plr.108.1646983393619;
        Thu, 10 Mar 2022 23:23:13 -0800 (PST)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id w23-20020a627b17000000b004f6cf170070sm8967270pfc.186.2022.03.10.23.23.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Mar 2022 23:23:13 -0800 (PST)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] drm: drm_bufs: Error out if 'dev->agp' is a null pointer
Date:   Fri, 11 Mar 2022 07:23:02 +0000
Message-Id: <1646983382-30036-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user program can control the 'drm_buf_desc::flags' via ioctl system
call and enter the function drm_legacy_addbufs_agp(). If the driver
doesn't initialize the agp resources, the driver will cause a null
pointer dereference.

The following log reveals it:
    general protection fault, probably for non-canonical address
    0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN PTI
    KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
    Call Trace:
     <TASK>
     drm_ioctl_kernel+0x342/0x450 drivers/gpu/drm/drm_ioctl.c:785
     drm_ioctl+0x592/0x940 drivers/gpu/drm/drm_ioctl.c:885
     vfs_ioctl fs/ioctl.c:51 [inline]
     __do_sys_ioctl fs/ioctl.c:874 [inline]
     __se_sys_ioctl+0xaa/0xf0 fs/ioctl.c:860
     do_syscall_x64 arch/x86/entry/common.c:50 [inline]
     do_syscall_64+0x43/0x90 arch/x86/entry/common.c:80
     entry_SYSCALL_64_after_hwframe+0x44/0xae

Fix this bug by adding a check.

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/gpu/drm/drm_bufs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index fcca21e8efac..4fe2363b1e34 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -734,7 +734,7 @@ int drm_legacy_addbufs_agp(struct drm_device *dev,
 	int i, valid;
 	struct drm_buf **temp_buflist;
 
-	if (!dma)
+	if (!dma || !dev->agp)
 		return -EINVAL;
 
 	count = request->count;
-- 
2.25.1

