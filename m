Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258EF4C0352
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235650AbiBVUtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235606AbiBVUsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:48:54 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D233AA2F2C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:28 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id a6so15938848oid.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c80lDSr4/XrHo4HXuUiUdwW2N5759X0Jr8s3r01G4uw=;
        b=qi2CLkoTpNf+/7KRpxJWRKKedV3ySUp6Hi5CiH/Rl69V/1ZYKrlbplu5LuSaHdhRIr
         U3qvvNSC3b8wbwX2/jLQsKii0fmBsrukVOjWCg8MHzVUm8SSVTFJXjwemeX/p3d7bn6Q
         +m87Kf9FB60c/CB+MHLc7aTiHvLqierIr4BTAMkPS7FbbukSEVFc7B/wbjSfrQvOn2Jk
         E8yxCnUIUCRB+eJ5tkE7gfAvVChYIkBzF1uoQFj7V7qm3IKD0Nr14+iqzwFSYX/sG6p8
         N4+OOxN8twd0yzhKVeF35CuuEGVtvYulguhNHU0z+MdnBFRUedC9fBtzQri9+gdN6jNK
         01IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c80lDSr4/XrHo4HXuUiUdwW2N5759X0Jr8s3r01G4uw=;
        b=3cwrRyKIH/huRtEWLKjHhCMDFDloxA9zFuD2/VFgo6B3Ia/zog7NijOpI0zpLTYUr6
         otTDldltn/HaER1MdCGmmygn5T+ELrbp7HIg5cBlmw+loArcJb4vbyo3zQ4mnjrbe1qs
         WuufYnZ40weyOSjBriAJC+kGkAUJ0KaEYr+NFkpMuQUO8KA6tcNbeIZFD21OIcnY9aXG
         gG2q5fsKh+pxweW5JW3oygd4uvyTgpWVYbkBOq6XHdlfmoZq2VYkrM09uNzfdup/qODa
         GC9jnpQLDTQBFx7/aZCV7YJrc0YyXwjf9OHWmtq0iH7XVlJ4iaTnkcdJWr35w1n91PWh
         vzEQ==
X-Gm-Message-State: AOAM530qBH0tIpJF5wQpaFkda+qFcTD6mkuxad/jpivwxkH4n8hZlm3C
        akk1LJHSyyGG4TILBB7s7DsAfuSZo/xdwA==
X-Google-Smtp-Source: ABdhPJz2U8KLjdjNRUB//gea/ufjet3hLSc2A6nlzGRCQGTmGSKt0aTPN50GrrZNsqro3BBTDjNyuQ==
X-Received: by 2002:a05:6808:2106:b0:2d5:3244:ca43 with SMTP id r6-20020a056808210600b002d53244ca43mr2968470oiw.263.1645562907949;
        Tue, 22 Feb 2022 12:48:27 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id o14sm16508197oaq.37.2022.02.22.12.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:48:27 -0800 (PST)
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
Subject: [PATCH v5 3/6] RISC-V: Extract multi-letter extension names from "riscv, isa"
Date:   Tue, 22 Feb 2022 12:48:08 -0800
Message-Id: <20220222204811.2281949-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222204811.2281949-1-atishp@rivosinc.com>
References: <20220222204811.2281949-1-atishp@rivosinc.com>
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
index 72c5f6ef56b5..b0df7eff47f7 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -124,8 +124,28 @@ void __init riscv_fill_hwcap(void)
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
@@ -151,14 +171,13 @@ void __init riscv_fill_hwcap(void)
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

