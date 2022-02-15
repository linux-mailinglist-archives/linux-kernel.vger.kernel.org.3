Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8514B66E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbiBOJC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:02:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiBOJCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:02:46 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714E7B54D1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:37 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id a19so17089392qvm.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PZTGGlFqOOOyiaN6gxsek+e4rLg8IgrL4zDsxITUV58=;
        b=gOICOmC4IxU3X4MSsiyEWM8HxOs/j/5mUyNV4SqSm8mbgryc6hcSAyRYKiMAKb21Cw
         CsnNzdrkCsv6rcH/9wILxHZWjwEGCaojBEUp67oc0qGRCrBgdUODQlQ5YjZ0gna9zMWA
         6FfOeIaDQH1mY7dRYm9KK0qBYX9tTq0tVr/UVAWPQMQZaOVjtjcVnTO3blVbEcRMI9iY
         Jakd730gszKr8ibDUuEGKyA0BfHwN4wGL36ZpFRgQvrotS0TQuTUBjuyPerOD0Rnl6Aq
         duWdRplQ8y7EokINuJqpCrO9+RY2eyqxJ287GvW+WylZcV4o/P3bij/VAXexWlkJ2oGY
         aC8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PZTGGlFqOOOyiaN6gxsek+e4rLg8IgrL4zDsxITUV58=;
        b=K5E64jzXrrnM8ONILhjJNz8PDn9fo7Ppq2a66Qvt7Ta0bvqeL/J9nqp1pZ7K2LlPoq
         BBm1z0vJkEJO5jKw2L1x5BNKeOvkl4u3aKrTBsDxRXlK/UEE76PGqd9Jcox32EPHMyuV
         6WW+EAzEFFFX0BVwELGlmY+hvHNU0hpqNpNzTfmV4OIpyQ7eaIZ/kh0Ge5cU8wn/F2XG
         4Ink8tyCwRzwLj88Jz7kc62rHDpzWaFwD7bb+Ycbwj2oXf1oz8BDBlgojH5FlVnRx9EA
         +EF+fHT6GiPxERytgUVVY485lCPT/S5OCowtlBJJP/qSbEVMsFMc0ik9UY6s/nHwjFqM
         dR2A==
X-Gm-Message-State: AOAM532hyJ+9BzsV/2F2HxTFqO2ac939G2xr8NrWH1jnxZWXpEPWQNZp
        tDvj7Qm6RyWcCnLw659dnjT6TEO+ib8sGRqn
X-Google-Smtp-Source: ABdhPJxX2hGcT3+xRwhjlKaaOUOvbc5Anj8eZx1sK0eZAfvIjPN0L0OGcFka5qnrXcEjmuM8VRTJmw==
X-Received: by 2002:ad4:5941:: with SMTP id eo1mr1976230qvb.50.1644915756363;
        Tue, 15 Feb 2022 01:02:36 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id w4sm17711158qko.123.2022.02.15.01.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 01:02:35 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tsukasa OI <research_trasio@irq.a4lg.com>,
        Atish Patra <atishp@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
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
Subject: [PATCH v3 3/6] RISC-V: Extract multi-letter extension names from "riscv, isa"
Date:   Tue, 15 Feb 2022 01:02:08 -0800
Message-Id: <20220215090211.911366-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215090211.911366-1-atishp@rivosinc.com>
References: <20220215090211.911366-1-atishp@rivosinc.com>
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
Tested-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/cpufeature.c | 38 ++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 9d5448542226..cd9eb34f8d11 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -119,9 +119,28 @@ void __init riscv_fill_hwcap(void)
 				ext_long = true;
 				/* Multi-letter extension must be delimited */
 				for (; *isa && *isa != '_'; ++isa)
-					if (!islower(*isa) && !isdigit(*isa))
+					if (unlikely(!islower(*isa)
+						     && !isdigit(*isa)))
 						ext_err = true;
-				/* ... but must be ignored. */
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
@@ -131,6 +150,7 @@ void __init riscv_fill_hwcap(void)
 				/* Find next extension */
 				if (!isdigit(*isa))
 					break;
+				/* Skip the minor version */
 				while (isdigit(*++isa))
 					;
 				if (*isa != 'p')
@@ -139,20 +159,20 @@ void __init riscv_fill_hwcap(void)
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

