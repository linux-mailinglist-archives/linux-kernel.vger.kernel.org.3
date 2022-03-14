Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26CB4D8E54
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 21:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245108AbiCNUk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 16:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245077AbiCNUkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 16:40:20 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B1D3AA5F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id k125so8460172qkf.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c80lDSr4/XrHo4HXuUiUdwW2N5759X0Jr8s3r01G4uw=;
        b=RSQTwbMTlvf/XdTqYO8yvJZyz1/z+kSqX7ohzLBcVXa38yJV0hhUloVCQYRq6ujmIA
         1cYw+Qz0pz0ig3z21KfyxAF4wuZdIjqUCD1nZNzev4zKBsAc844/u04qkmilCVeIda69
         69+HG1rhQvW+SWGgf9KBGiy+9NU4OlGDr5ehIrJeatZ2TwB4eyZh7WTtKYZ3EM44qWjp
         oiztRuPBGGY2Oyh4IZmc2Q7p993UmfEGaUxuWkpEO4xcn/S+Op9RJnpbv4U1jwb/qrfB
         RbUquhN7Jq2jUlky5oVLorpXAlR1sbmgGdwKhlb/IHjmGYf5JFbdCo224DC5xz2sgncV
         HvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c80lDSr4/XrHo4HXuUiUdwW2N5759X0Jr8s3r01G4uw=;
        b=kRDZwb9U9cD2aRq/8EuFJdfAKMBqZfByAZZaN+Grn6B6BNKEo6NvB6gaxVn06frTlb
         1T63Ex8ClVdsjCynnoVyIptpNWq0yqop2qwbcMCrmvE0bx6yHRVFVqEbcWbAyvZe4Ul9
         phH7IsZjqEKf2lOfG4kVXoAlNouHbiIRi73uXmr0ImOfxqaAeBa1SLki779PCRf39ggI
         325HdxQ2UlqVIUib5VX6ChDL65aJW6ZIROPZiwaeP9OrHL0GRQrwJtN8QzaEyoH9ieLS
         K8uiKcW/FWDnEuGgVPHjOq8ttyaRonWRDYz4xs5z6T0loPIjV67yLgXYDfx/wxp7J57l
         dCTg==
X-Gm-Message-State: AOAM531vXgG977zkGUE2teyH1Y8bokH6iKQmTrKUXUYhlnbAsuDnOIRV
        Y+Qs8WJHUWQw5Wk/owqcGdJwZbVPZkFJeQ==
X-Google-Smtp-Source: ABdhPJyo2wKJnYHR1OhUhhyhMQ4ds5vaGNsAWSD7I6VKTRF9r/58irDDodxIqoeGfB0DsyRbNRTMLQ==
X-Received: by 2002:a05:620a:1a92:b0:67d:b2c2:8311 with SMTP id bl18-20020a05620a1a9200b0067db2c28311mr6926282qkb.594.1647290348212;
        Mon, 14 Mar 2022 13:39:08 -0700 (PDT)
Received: from rivos-atish.ba.rivosinc.com (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm8597023qkb.74.2022.03.14.13.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 13:39:07 -0700 (PDT)
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
Subject: [PATCH v6 3/6] RISC-V: Extract multi-letter extension names from "riscv, isa"
Date:   Mon, 14 Mar 2022 13:38:42 -0700
Message-Id: <20220314203845.832648-4-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220314203845.832648-1-atishp@rivosinc.com>
References: <20220314203845.832648-1-atishp@rivosinc.com>
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

