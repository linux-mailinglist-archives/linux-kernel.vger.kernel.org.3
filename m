Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D2C4B17BF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 22:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344734AbiBJVkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 16:40:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344720AbiBJVke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 16:40:34 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA2B2707
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:34 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id 4so7441696oil.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 13:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gfak+qx3drveGV1Pvkzt57Jl+W0jEgrAmoVtloDMaBw=;
        b=b5WIG4HsEF5Iod1jlBRBnYuxQFaXxoMA8iP1rJdZ9dXaGNSGjPXSPmZnGU7z+N98i3
         PFUIm+xNgTyD24P1KmltetZbCHaWJt9LqJEf5KV+Rq949EsJphUQp5Q+jf2tZt7Qy7c2
         Zt9J61HUTUscpV0smpFM2mhfbNXsZxcRZ828cU4AB7GvTUvUHmVhPml1mkHo4ptzYRRB
         o2+8U3fQcZMV6Mjj4RR8QjhftLH50cjfmPJgOWDqPVNlM1Ri2IQ6mTlaEx+U0p0RgBOn
         UlGy3tsfSb1cSMykpj9Vgdw6vDPziX7U52avE88Xpuwl3zSPHr9RwkywA8TqDnBQxfFl
         PYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gfak+qx3drveGV1Pvkzt57Jl+W0jEgrAmoVtloDMaBw=;
        b=JuveBRbbt8NOoI0DsnMS5XwUSq/NQs/IjSv6WnjeZhKlbkptUdoLfRHBO0EfRk0Eo4
         fVdHPU1IaQ2+JbXP3b+y5kBvOITlbUX1iMj/odcN6u+E8Tw7j2/2kTEZa+FSmqwnhfek
         rmstka1iRbuAYQ1/dC7n74oLGX4QFGGLik/8095zJB1WfuUGpZhkGhT+7O2oARK/xctV
         qs/0PCWculVMmAP+66Z6vwlqNe58+CinjTv2MwidYDihvJP/1bYJlFeGdJo5GuP8yiNd
         bl4kgFFEW53lTKFRzf0T0eqM1QOs663GIhAVg32KHAYM/du9ptH0gyLRP+9DpPFEbaMa
         IVFw==
X-Gm-Message-State: AOAM5317h5KRhXJR/UwwhA7MojaFwcwjORxmQhzSRgq2sPgFPxmBWAa6
        nBs2rRalOCOAjTw+ryOiNc3hIJhGlaWxegk8
X-Google-Smtp-Source: ABdhPJykAnYvG8sqBibAI7XjH1k9J0mAOKTMUjlZygKx4hyhEIURQ1Wi20CpxOC5ed/s+MjwLZlz4g==
X-Received: by 2002:a05:6808:229f:: with SMTP id bo31mr1819283oib.107.1644529233614;
        Thu, 10 Feb 2022 13:40:33 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id u5sm8700000ooo.46.2022.02.10.13.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 13:40:33 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tsukasa OI <research_trasio@irq.a4lg.com>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 3/6] RISC-V: Extract multi-letter extension names from "riscv,isa"
Date:   Thu, 10 Feb 2022 13:40:15 -0800
Message-Id: <20220210214018.55739-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210214018.55739-1-atishp@rivosinc.com>
References: <20220210214018.55739-1-atishp@rivosinc.com>
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

Signed-off-by: Tsukasa OI <research_trasio@irq.a4lg.com>
[Improved commit text and comments]
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 41 +++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index e19ae4391a9b..e9e3b0693d16 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -102,6 +102,7 @@ void __init riscv_fill_hwcap(void)
 #endif
 		for (; *isa; ++isa) {
 			const char *ext = isa++;
+			const char *ext_end = isa;
 			bool ext_long, ext_err = false;
 
 			switch (*ext) {
@@ -119,19 +120,39 @@ void __init riscv_fill_hwcap(void)
 				ext_long = true;
 				/* Multi-letter extension must be delimited */
 				for (; *isa && *isa != '_'; ++isa)
-					if (!islower(*isa) && !isdigit(*isa))
+					if (unlikely(!islower(*isa)
+						     && !isdigit(*isa)))
 						ext_err = true;
-				/* ... but must be ignored. */
+				 /* Parse backwards */
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
 				ext_long = false;
-				if (!islower(*ext)) {
+				if (unlikely(!islower(*ext))) {
 					ext_err = true;
 					break;
 				}
 				/* Find next extension */
 				if (!isdigit(*isa))
 					break;
+				/* Skip the minor version */
 				while (isdigit(*++isa))
 					;
 				if (*isa != 'p')
@@ -140,20 +161,20 @@ void __init riscv_fill_hwcap(void)
 					--isa;
 					break;
 				}
+				/* Skip the major version */
 				while (isdigit(*++isa))
 					;
 				break;
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

