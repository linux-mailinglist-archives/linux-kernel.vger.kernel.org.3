Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD5F048FE7A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 19:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiAPSey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 13:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiAPSex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 13:34:53 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFA1C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 10:34:53 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id z25-20020a0568301db900b005946f536d85so8110467oti.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 10:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8tWFetS/0R91mAOw4wQiTZSwlHSR50XGbCjUlKQuD+A=;
        b=u8KBF5jOEy3icvGHKQWWiLkKz/Omz5FsxL3Tj2/2r/KZawCZE7/h1xBEvdLLeaLD33
         Ou3IYHX5Qs1oX+UPaTT8NQS1IHKhGNG76vMYsFyprbEHyEI9f+NM7EjbISDYGiwCi3jU
         Bcolm/cBefYRlXyvHzoBml89qqkAs7K0jQQclrYwh0VTiZYbJrbAckn4UcgI8GVQKSMG
         cOV+174xzmM8qwARphD7bcdJrGYPFh/O/lCkHlEZ+vdWsyTmqaC5+k5CBHH7YsTjo3/X
         4hwNpWXIgzy/E8wmglzZXJDMmNmMtr4vG7XGt3++tf/nprdV2Ro/loDBXH1sUxOvONUF
         3tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8tWFetS/0R91mAOw4wQiTZSwlHSR50XGbCjUlKQuD+A=;
        b=mw6Hkh0AHk4OmxbaOSiBkMWubR2C6kduw/oBN+96++EyZGjqEHZq0bVFiaAkzWgS9F
         NiPAs2zHbNGCdEkNdgFeCge2YAVmNWvSGhkugQ5tKs1LzFZFgkVqFXRcFvHGHYWemDCI
         zBFFExnouZkDBASxa53fn/kVpb7aTIuKub2OC14z/qH0lZfJa5idgUs/E6Y88PzKVZdC
         K8gPXfNdV83YUHqwdAlDG9JQugfEt1RV3UVnr3XN1jaFZ8mQ6IZlp/uuRXDxIfM7Y139
         8hDG3KxTIqlyaP5UpV+crd6cynJCcMscWWATD9JYEeMpzLnQLqD8k78Sjns2kCPDIeWq
         EibQ==
X-Gm-Message-State: AOAM533nsvD0mhQDWwT41AGIW9EJVttEfDNCVVD/jETyFMY2ldc/hQNx
        0vohzZ+a8XTQ79gq6aXjL9UOM2RFdTLNCQ==
X-Google-Smtp-Source: ABdhPJyc1L+aLyOyLgGrMm2krIG1Asfl7+3mKuAkHXVV5LH4erGZSK1ycu3RtzB/2XhF4MTSrObAHg==
X-Received: by 2002:a9d:294a:: with SMTP id d68mr13692860otb.301.1642358092223;
        Sun, 16 Jan 2022 10:34:52 -0800 (PST)
Received: from [192.168.86.178] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id 184sm5399896oih.58.2022.01.16.10.34.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 10:34:51 -0800 (PST)
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Rob Landley <rob@landley.net>
Subject: [PATCH] Wire up CONFIG_DEVTMPFS_MOUNT to initramfs.
Message-ID: <d53f041a-83f7-57f7-28ae-eb7b23034f83@landley.net>
Date:   Sun, 16 Jan 2022 12:36:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Landley <rob@landley.net>

The kernel has had CONFIG_DEVTMPFS_MOUNT for years, but it only applied to
fallback ROOT= not initramfs/initmpfs. As long as the config option exists, it
might as well work.

I use this for board bringup: populating a chdir and calling cpio as a normal
user often leaves /dev empty (because mknod requires root access), meaning no
/dev/console for init/main.c to open, meaning init runs without
stdin/stdout/stderr and has to mount devtmpfs and redirect the filehandles blind
with no error output if something goes wrong.

Signed-off-by: Rob Landley <rob@landley.net>
---
Previously: https://lkml.org/lkml/2017/9/13/651

 init/main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index bb984ed79de0..288c73db57f4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1612,7 +1612,6 @@ static noinline void __init kernel_init_freeable(void)
 	kunit_run_all_tests();

 	wait_for_initramfs();
-	console_on_rootfs();

 	/*
 	 * check if there is an early userspace init.  If yes, let it do all
@@ -1621,7 +1620,11 @@ static noinline void __init kernel_init_freeable(void)
 	if (init_eaccess(ramdisk_execute_command) != 0) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
+	} else if (IS_ENABLED(CONFIG_DEVTMPFS_MOUNT)) {
+		sys_mkdir("/dev", 0755);
+		devtmpfs_mount();
 	}
+	console_on_rootfs();

 	/*
 	 * Ok, we have completed the initial bootup, and
