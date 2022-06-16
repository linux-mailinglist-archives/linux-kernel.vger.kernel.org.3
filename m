Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1985754D89F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 04:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350634AbiFPCsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 22:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiFPCsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 22:48:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 264AD56F96
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655347697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nm47lN81/en9RFa7PC7KN5HytoLN2v81StHx1wCGkys=;
        b=OL058jx4U8Fj5xDYFf4itSQOYnbfSURaHDWF5EfdIiTH/IHYk2gP6DIuuTiX1iuHOwkSg+
        vRItWb2muYVrjh3r/BjiK4EFIb5+zMJkbfe0GJAtDAzb0RqBbAJ/Jb8r1rUA28OfOWEO59
        hO/tqQF79YlK/RhQ9Vc4TgJmBE5C2KM=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-sQ8b5I9oMiGFOBgmPbkAPg-1; Wed, 15 Jun 2022 22:48:13 -0400
X-MC-Unique: sQ8b5I9oMiGFOBgmPbkAPg-1
Received: by mail-pg1-f198.google.com with SMTP id n6-20020a654886000000b003fda8768883so11205pgs.14
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 19:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nm47lN81/en9RFa7PC7KN5HytoLN2v81StHx1wCGkys=;
        b=Zuw8Kw77mH+ybuwPOF9hFi8k+HkTcg8QeeSmrilG7QPutacgCseHTXuG8DcCXlX1pc
         07CX4UCik6at3U3PRaTGdARh6rOa3mbW1IZPLikI2GznhRb04YNkSigdofw2Odc4mrrS
         Bw0uT8CJb5iPJeB6Io6IRjl5HB0MKEhxq0799mJXvE7TJ7MPMzRn3zuQlshKC9f1FAco
         kJTVJuZdenxeWEpiVOYLqdXVgQ8cM90oKpdXgeaThh5/+pIjAQrBns9OxF7KVKGvVFf0
         MJm22H3coF2pib+Yf+2UpV0MsklJXczMu4m6w+lJJ6xvSKJ9ExrWSufHB4FZq6YyvOa+
         kgWw==
X-Gm-Message-State: AJIora8YKUZ2co4jLC4p1F3xaYyfy2b0m+TkVmnilvIeIxKIXnWiu0ft
        DtKIhqeOFk69m4VGFqrqIXv5+JZjOk0hSLFKNRtANbrWyEYjX8mJWDpdLLGeKL4OCNpPgZCa9A6
        CI/ONxZ7tTWgeG+ejLgmFWdM7
X-Received: by 2002:a17:90b:3845:b0:1e2:e175:be04 with SMTP id nl5-20020a17090b384500b001e2e175be04mr2713657pjb.50.1655347692640;
        Wed, 15 Jun 2022 19:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vNxKCZA5WfH/QsdIwkuqJGtpe52oai0trhWKfXSevkSeFUljebxiedwE3bOi8tGXLV9uMwZA==
X-Received: by 2002:a17:90b:3845:b0:1e2:e175:be04 with SMTP id nl5-20020a17090b384500b001e2e175be04mr2713631pjb.50.1655347692362;
        Wed, 15 Jun 2022 19:48:12 -0700 (PDT)
Received: from localhost.localdomain.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001621ce92196sm354573plw.86.2022.06.15.19.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 19:48:11 -0700 (PDT)
From:   Tao Liu <ltao@redhat.com>
To:     bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tao Liu <ltao@redhat.com>
Subject: [PATCH] kdump: round up the total memory size to 128M for crashkernel reservation
Date:   Thu, 16 Jun 2022 10:48:03 +0800
Message-Id: <20220616024803.5091-1-ltao@redhat.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The total memory size we get in kernel is usually slightly less than 2G
with a 2G memory module machine. The main reason is bios/firmware
reserve some area it will not export all memory as usable to Linux.

2G memory X86 kvm guest test result of the total_mem value:
UEFI boot with ovmf: 0x7ef10000
Legacy boot kvm guest: 0x7ff7cc00
This is also a problem on arm64 UEFI booted system according to my test.

Thus for example crashkernel=1G-2G:128M, if we have a 1G memory
machine, we get total size 1023M from firmware then it will not fall
into 1G-2G thus no memory reserved.  User will never know that, it is
hard to let user to know the exact total value we get in kernel

An option is to use dmi/smbios to get physical memory size, but it's not
reliable as well. According to Prarit hardware vendors sometimes screw
this up. Thus round up total size to 128M to workaround this problem.

This patch is a resend of [1] and rebased onto v5.19-rc2, and the
original credit goes to Dave Young <dyoung@redhat.com>.

[1]: http://lists.infradead.org/pipermail/kexec/2018-April/020568.html

Signed-off-by: Tao Liu <ltao@redhat.com>
---
 kernel/crash_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 71122e01623c..f6c1ffce9d5a 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/utsname.h>
 #include <linux/vmalloc.h>
+#include <linux/sizes.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -43,6 +44,15 @@ static int __init parse_crashkernel_mem(char *cmdline,
 					unsigned long long *crash_base)
 {
 	char *cur = cmdline, *tmp;
+	unsigned long long total_mem = system_ram;
+
+	/*
+	 * Firmware sometimes reserves some memory regions for it's own use.
+	 * so we get less than actual system memory size.
+	 * Workaround this by round up the total size to 128M which is
+	 * enough for most test cases.
+	 */
+	total_mem = roundup(total_mem, SZ_128M);
 
 	/* for each entry of the comma-separated list */
 	do {
@@ -87,13 +97,13 @@ static int __init parse_crashkernel_mem(char *cmdline,
 			return -EINVAL;
 		}
 		cur = tmp;
-		if (size >= system_ram) {
+		if (size >= total_mem) {
 			pr_warn("crashkernel: invalid size\n");
 			return -EINVAL;
 		}
 
 		/* match ? */
-		if (system_ram >= start && system_ram < end) {
+		if (total_mem >= start && total_mem < end) {
 			*crash_size = size;
 			break;
 		}
-- 
2.33.1

