Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC824B7BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245072AbiBPA3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 19:29:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244731AbiBPA3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 19:29:38 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53AE2F70F0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:26 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id d7so738298qvk.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 16:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7Lls7PJkZJYc7kZbxcHxB4Pg3B3kBBxHG3i/9qK9T8=;
        b=iVxQeG9XRXiX+NHnAAPdnfqRFudo+DhuKRYlg3KNjR+r63PyTERvyXTSOhQiHUjPal
         yadjBGjUpj+SU5JczUAHkrnSTIw7IND+TXvYERHyHEAItPHKufBA2yq2ylTr6eaZQGwq
         tsHuNeJxApsVwCBvvtWRgYrR9XZqj4fqJeQXkXPKLdWnVEzkad9+676Bf8dy9ySkrc0d
         rqqAlg48l4rGOKse0SeFEFDc4vt7tJZpMId1OD/FFcwtcgIs504aCf0a0cNhPPV/Oc2v
         P+2FAewm5fGeh3l0USDUSU2WJ4p0yiBdT1S/ZcPqqimZaI57ZIXFddkPc1ogAIUl1Qu0
         rsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7Lls7PJkZJYc7kZbxcHxB4Pg3B3kBBxHG3i/9qK9T8=;
        b=ycNIcfVhEVaCwCMZIDRU40LUdavMtQgVyzuRE7f2PKPXu2nWgmx7nYVNdCb4fyeYdc
         lDraqv/8ini1vQHMs5Q2KyqRXklFZrLn1GDRDU/FsY85tGEvsVuK3dlyXUltuZNLvrk4
         lNZ4P+ncfp3wH/G5JDMavO9y6vwaz0WSoIcYcE/ZtOtZ17Mxk6OCFdpIL8HQRthXXHmI
         O+qZoMhDnwFBC1ubF3WgfOlm4WRGULBRbD4E6a0vHVzeNG4GyoaQgp8h3cq3ehlXAIx3
         TUZso5TkPI0EgFftFu1nJgwOVaGM/wmww3YVA3l3cwRmLEEU7v7G7HeztVPYumTU2e+z
         Hnwg==
X-Gm-Message-State: AOAM533V6erUkLakvm0RJpcuTXuCttVHA0PpFvKS1aRJ2ScjpjTtExo0
        f/z8cI7oMG8HQU5HkyURN6Xi1g3E/OJVOP6f
X-Google-Smtp-Source: ABdhPJxGailfSncIp2wrP5MaMjwC6ViL8hwSFjA+/hbO4qkDXM1lwd4PXEQLXo9gcOR7Hb73XLE29g==
X-Received: by 2002:a05:6214:5003:b0:42f:bc42:6ce4 with SMTP id jo3-20020a056214500300b0042fbc426ce4mr344258qvb.63.1644971365295;
        Tue, 15 Feb 2022 16:29:25 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id g21sm20882584qtb.70.2022.02.15.16.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:29:24 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tsukasa OI <research_trasio@irq.a4lg.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 3/6] RISC-V: Extract multi-letter extension names from "riscv, isa"
Date:   Tue, 15 Feb 2022 16:29:08 -0800
Message-Id: <20220216002911.1219593-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220216002911.1219593-1-atishp@rivosinc.com>
References: <20220216002911.1219593-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tsukasa OI <research_trasio@irq.a4lg.com>

Currently, there is no usage for version numbers in extensions as
any ratified non base ISA extension will always at v1.0.

Extract the extension names in place for future parsing.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
[Improved commit text and comments]
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 35 ++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 65664422b04d..cd9eb34f8d11 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -119,8 +119,28 @@ void __init riscv_fill_hwcap(void)
 				ext_long = true;
 				/* Multi-letter extension must be delimited */
 				for (; *isa && *isa != '_'; ++isa)
-					if (!islower(*isa) && !isdigit(*isa))
+					if (unlikely(!islower(*isa)
+						     && !isdigit(*isa)))
 						ext_err = true;
+				/* Parse backwards */
+				ext_end = isa;
+				if (unlikely(ext_err))
+					break;
+				if (!isdigit(ext_end[-1]))
+					break;
+				/* Skip the minor version */
+				while (isdigit(*--ext_end))
+					;
+				if (ext_end[0] != 'p'
+				    || !isdigit(ext_end[-1])) {
+					/* Advance it to offset the pre-decrement */
+					++ext_end;
+					break;
+				}
+				/* Skip the major version */
+				while (isdigit(*--ext_end))
+					;
+				++ext_end;
 				break;
 			default:
 				if (unlikely(!islower(*ext))) {
@@ -146,14 +166,13 @@ void __init riscv_fill_hwcap(void)
 			}
 			if (*isa != '_')
 				--isa;
-			/*
-			 * TODO: Full version-aware handling including
-			 * multi-letter extensions will be added in-future.
-			 */
-			if (ext_err || ext_long)
+
+			if (unlikely(ext_err))
 				continue;
-			this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
-			this_isa |= (1UL << (*ext - 'a'));
+			if (!ext_long) {
+				this_hwcap |= isa2hwcap[(unsigned char)(*ext)];
+				this_isa |= (1UL << (*ext - 'a'));
+			}
 		}
 
 		/*
-- 
2.30.2

