Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7DD5A99D4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbiIAONR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbiIAONP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:13:15 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214765553
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:13:12 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id s22so10815202qkj.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=APMqnyoY0nzwphEpGCTZBJOoOWiMPGTG1aZK6bI1QcI=;
        b=qkCFrjsmebyb54+NCL6rtevKjwdPTqM4Sj1iaN8gRR5Gzi03K+hGmPt8ObbrmOhiH8
         hwBuVfdGIwOmBHcn/p5CIhDJr4QWI+vipz7eYrcFbChvucC0f+h8KBtnl9gE+IRp2yij
         WRtvh0q+Dp8hOOKUy/2h+1z++bCqOscOHKlFeG72N2MzcTAV9a61nZldb1wfAobs8Z+s
         /VxBXpHmM3zi6c2ZkCmx1G3qYAUpjFofiynI3Yo1Z40eDt4ta6YcMk5hxKVgR6lUvHjg
         nZjaK/Z9i3gWwP5nOi0FmhuhH1zRXPu4SGibFwxCIh1hfqjpG5yJVrABvqMHweYtRbmh
         Q9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=APMqnyoY0nzwphEpGCTZBJOoOWiMPGTG1aZK6bI1QcI=;
        b=Ty6Bd+MfVzmXM1DTnYu7L+Foe2nCqZFs3X5sg87DrBDOC4XatVr5tqoCtTvyCtxZqw
         nE3hdyWCANFNsrwc+lFgYpG29cSd3K9yNNy7LDKLkJVF9NkSOMehhiPQX6REVQBaX7Yx
         2SCor0MXTcbdz9TBRRqMZB1bMlXYWPMsZcPhOE1fTld09OMxSrZGQbPApxY15FqnKO5j
         H0WoaxvNCbs0tfSiooO2K+ZOC1SPwJeFqW+vtHD0cZR0UerYguXbQOCTSnTHmR38U/Jk
         fnFg8+/atvwbYYglZF/CshdTOI+m7pMCLYuQqCRRRZBCQ+iIHw79q2nPzObDJn/n9gOP
         qXGQ==
X-Gm-Message-State: ACgBeo309mlhIxhd9HxBeWsv9hDAUNAdmNSf/e56RqZoJDmbNbeah/Ae
        DGoOJudC9TCCayRF+ZJ+P/pDYg3B4ygb+A==
X-Google-Smtp-Source: AA6agR4gg1lLt1Axu2UH/+p5DFKH13Q7nHvZQIAdCtqiVwZwasPpyuzbg9QdUpqJLDxpCqkTEY0ALg==
X-Received: by 2002:a05:620a:4482:b0:6bb:c315:9597 with SMTP id x2-20020a05620a448200b006bbc3159597mr19648718qkp.423.1662041591059;
        Thu, 01 Sep 2022 07:13:11 -0700 (PDT)
Received: from gpee-next.corp.roku ([65.125.88.5])
        by smtp.googlemail.com with ESMTPSA id de21-20020a05620a371500b006b9c9b7db8bsm11815579qkb.82.2022.09.01.07.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 07:13:10 -0700 (PDT)
From:   george pee <georgepee@gmail.com>
Cc:     george pee <georgepee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Report support for optional ARMv8.2 half-precision floating point extension
Date:   Thu,  1 Sep 2022 09:13:05 -0500
Message-Id: <20220901141307.2361752-1-georgepee@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Report as fphp to be consistent with arm64

Signed-off-by: george pee <georgepee@gmail.com>
---
 arch/arm/include/uapi/asm/hwcap.h | 1 +
 arch/arm/kernel/setup.c           | 1 +
 arch/arm/vfp/vfpmodule.c          | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
index 990199d8b7c6..f975845ce5d3 100644
--- a/arch/arm/include/uapi/asm/hwcap.h
+++ b/arch/arm/include/uapi/asm/hwcap.h
@@ -28,6 +28,7 @@
 #define HWCAP_IDIV	(HWCAP_IDIVA | HWCAP_IDIVT)
 #define HWCAP_LPAE	(1 << 20)
 #define HWCAP_EVTSTRM	(1 << 21)
+#define HWCAP_FPHP	(1 << 22)
 
 /*
  * HWCAP2 flags - for elf_hwcap2 (in kernel) and AT_HWCAP2
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1e8a50a97edf..6694ced0552a 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1249,6 +1249,7 @@ static const char *hwcap_str[] = {
 	"vfpd32",
 	"lpae",
 	"evtstrm",
+	"fphp",
 	NULL
 };
 
diff --git a/arch/arm/vfp/vfpmodule.c b/arch/arm/vfp/vfpmodule.c
index 2cb355c1b5b7..cef8c64ce8bd 100644
--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -831,6 +831,8 @@ static int __init vfp_init(void)
 
 			if ((fmrx(MVFR1) & 0xf0000000) == 0x10000000)
 				elf_hwcap |= HWCAP_VFPv4;
+			if ((fmrx(MVFR1) & 0x0f000000) == 0x03000000)
+				elf_hwcap |= HWCAP_FPHP;
 		}
 	/* Extract the architecture version on pre-cpuid scheme */
 	} else {
-- 
2.37.3

