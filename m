Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB40B505D55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 19:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346895AbiDRRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 13:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346835AbiDRRPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 13:15:11 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12B320F7F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id n11-20020a17090a73cb00b001d1d3a7116bso341831pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 10:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lh5wkQZbkXRgnC4EjKjmQBHmFIjrKbl6A7v1jfavo8o=;
        b=is/oplsxgXfd3Ca6GkmGp/PT4EJfLLlwOkdjXIO+h+IRZ/KytNrxvBQ7S7U93JQFP4
         h0EIGyI3NDzkkojrNsgnru7Wp36kdWkr3t++Lq0G7KWoA2HaQ8azVDY+JmWVcD3TSeuD
         hCBDHEkv0HsJPCSP7iEz1QT1xMIlq8fpqZ1Tw6W2kiPa/7IE8koX4YVjJ7ObKjiZvwiq
         boJAkxtbq681aAKCnvFCbm4tr0IrYJAsYzZlVobT77ozxlsIanEvkV0tDo0OswmqmYNi
         BoOnWh25d4UF2lJ4TRaGMnEf2xZ1pS5y8TRzDsYh0bOcbdFxnIs064KyEXpt1agvzoVw
         XDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lh5wkQZbkXRgnC4EjKjmQBHmFIjrKbl6A7v1jfavo8o=;
        b=Uw4oj5xBMtQEwnBI0vD15rBZGYRj5ptTJ8mOsn5M8/k2SVHF5eJsFUS8RitArc3FY9
         uphFHJbl9nyKL0KhKl8SCFkDAvbW2Z3cisi4CahXltxUV2gQ7oASgLOID5lCijUYVrYS
         hr2YHbhUS06JXg36q+qpzA++tsHov3w19MIek7xy4MYblFdYCACGJzbUBnnIi3W7c6IC
         v8bd6KsVl590SnfR0kS51gKuuHX4nXT7YBgU9ASBbGklgBX4rjJIf18Efo0KB3PE7095
         2dmqRx0+8xQGUprzeoeodiVV2yQgLsJmEp3cFhfCiI5EEmqKZ6Hjb8URMtT5yNmEphJ/
         RXXg==
X-Gm-Message-State: AOAM530oGTLa1Twv+JsHIoMsWOylFmXt8O0vCKTPvsyP6S9uRXVkyAHg
        0lymlIpamT9FJRvJY8nfbmw=
X-Google-Smtp-Source: ABdhPJzGYxA05zBkmyGOb7yOlqsx0I2fv8L9tibsLM/3cNljPB8O80/1ZQdTEI1c4YF4iR6ksa/r3g==
X-Received: by 2002:a17:90a:d584:b0:1bc:e520:91f2 with SMTP id v4-20020a17090ad58400b001bce52091f2mr19800353pju.192.1650301951534;
        Mon, 18 Apr 2022 10:12:31 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:3f09:380c:8f11:5a8a])
        by smtp.gmail.com with ESMTPSA id e16-20020a63ee10000000b0039d1c7e80bcsm13637138pgi.75.2022.04.18.10.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:12:30 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 5/5] xtensa: enable HAVE_VIRT_CPU_ACCOUNTING_GEN
Date:   Mon, 18 Apr 2022 10:12:05 -0700
Message-Id: <20220418171205.2413168-6-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
References: <20220418171205.2413168-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no direct cputime_t manipulation in the xtensa arch code, so
generic virt CPU accounting may be enabled.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 Documentation/features/time/virt-cpuacct/arch-support.txt | 2 +-
 arch/xtensa/Kconfig                                       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/features/time/virt-cpuacct/arch-support.txt b/Documentation/features/time/virt-cpuacct/arch-support.txt
index 5163a60a1c1e..c905aa3c1d81 100644
--- a/Documentation/features/time/virt-cpuacct/arch-support.txt
+++ b/Documentation/features/time/virt-cpuacct/arch-support.txt
@@ -27,5 +27,5 @@
     |       sparc: |  ok  |
     |          um: | TODO |
     |         x86: |  ok  |
-    |      xtensa: | TODO |
+    |      xtensa: |  ok  |
     -----------------------
diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index 6134808a633d..797355c142b3 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -43,6 +43,7 @@ config XTENSA
 	select HAVE_PERF_EVENTS
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_DOMAIN
 	select MODULES_USE_ELF_RELA
 	select PERF_USE_VMALLOC
-- 
2.30.2

