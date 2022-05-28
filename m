Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F74D536B94
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 10:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348632AbiE1IOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 04:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347542AbiE1IOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 04:14:11 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D57DF53;
        Sat, 28 May 2022 01:14:06 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id z11so6514881pjc.3;
        Sat, 28 May 2022 01:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZYHdokksnG9Y0QPms6w4hrVQLSzn/79oRxG8uAaCyWA=;
        b=n4KyaUDNiRgLAnB6fAuw9YONU7eZLpumh8ntdlUumo28paSx7jQf7ZL2xBqIfVGneX
         eRbSH5g5CV03RFtJGNPP0NPpYixt619Zp/XlAPVf75bqqkpIcmrh+OspL3LbxmFJid3Z
         FHLuTUhZlwU2c4euDn/A5LXKyyPCtD1reFCBasCC4UnQNOLjO66cED98AZ3+oQXQQ+9E
         QKeQcVf7pAYS0flG9Q7MTSfKpCeFaEzdWpnFQkXLYdFKRbaAfd3RAGxiu0V52Sv21VjL
         RtzyeQQkXv8BO1PRYiVRDViMiPcTWyozS3mLQ0KmuNfg6oZqA2wCCLzyR/LGYKRT80DW
         0kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZYHdokksnG9Y0QPms6w4hrVQLSzn/79oRxG8uAaCyWA=;
        b=KqkmesPnC8szGN/E8M56bZoN/QodJI5O8vN3tKkfFi2PWmWdTg9zOCIm12AAhn5zJs
         95iN12BJon9fHvwL/1dbgI/NwFq98DbzwbPsK7X6J7LBgBjrsIvL1DgIDM89zXXKPWY9
         DW2oHB5fP7rXgH015Cl6wE/ZJWmUki/9l5roT+svjPPH3P2AY95tzUi3bDwrPUON/qAc
         EPawaD+Y39Y3UUE0v6x4jcMk2sHDz+YyqGebnbrEt+Z+EGc+fMxTkEN0fLC0FYtKHSp1
         grgUdGOhMtRhqz9m7/tqGGRO2DP/nhrc8XHrfs5wmo9QFDctlO75krbE5u9qYMkkDOHc
         rs7Q==
X-Gm-Message-State: AOAM5335GiaFpWJMsw1O+yHG6P6z0hPki6WBGGtlC1V9NiLIySA3fdhL
        PAq9xkScFPACAyqi3GR1WG2mXfnknTkCJA==
X-Google-Smtp-Source: ABdhPJz3V7NRvrZwYZSzP4M47joqmutX5DfncFJvGOCQkJYhAybWJg3Z9vX6P/U4/nZwfw4GfpLF5A==
X-Received: by 2002:a17:90a:e7cb:b0:1df:8481:9469 with SMTP id kb11-20020a17090ae7cb00b001df84819469mr12401528pjb.195.1653725646153;
        Sat, 28 May 2022 01:14:06 -0700 (PDT)
Received: from localhost.localdomain ([140.116.104.153])
        by smtp.gmail.com with ESMTPSA id i12-20020a17090ad34c00b001e0c5da6a51sm2774347pjx.50.2022.05.28.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 01:14:05 -0700 (PDT)
From:   Yu-Jen Chang <arthurchang09@gmail.com>
To:     ak@linux.intel.com, jdike@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        linux-um@lists.infradead.org, jserv@ccns.ncku.edu.tw,
        Yu-Jen Chang <arthurchang09@gmail.com>
Subject: [PATCH 2/2] x86/um: Use x86_64-optimized memchr
Date:   Sat, 28 May 2022 16:12:36 +0800
Message-Id: <20220528081236.3020-3-arthurchang09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220528081236.3020-1-arthurchang09@gmail.com>
References: <20220528081236.3020-1-arthurchang09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add x86_64-optimized memchr, which is 4x faster
than the original implementation, into um.

Signed-off-by: Yu-Jen Chang <arthurchang09@gmail.com>
Signed-off-by: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
---
 arch/x86/um/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index ba5789c35..52b7c21ca 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -28,7 +28,7 @@ else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
+subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../lib/string_64.o ../entry/thunk_64.o
 
 endif
 
-- 
2.25.1

