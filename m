Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E95A185E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243124AbiHYSIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243068AbiHYSIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:08:10 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8375BD155;
        Thu, 25 Aug 2022 11:08:07 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id n124so13293594oih.7;
        Thu, 25 Aug 2022 11:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc;
        bh=Sk5vHqzSrLz4606TEoT4An8u20ArqzK6P+IPHBOiaUg=;
        b=3hvd5mNGRnTsOkuURBNohxzi0TLNbotn2dkawwm95LM0K6TIXns+r1Ig4q3dO+ZnSV
         UNmtVXhtaq2QTxTK7y8dRNBRmVn4Hx9Qm1x5TAmbzi6s9yh2q0ygL20PRETC+Ftu7ssP
         pEnfCsqGxZKXIIzryx2GImN+YGe5cVZOFmiKGJCSHXhLvL01VRW3g6EBcEGmpzqIBIiq
         5LmuP8ihovi+xGVukxMVhoAkgNZDXX7bBk7vTt9NQFzt05/tzaIUSfjqgS2BrNJ2BRmh
         4/jdVjNh/GgSWJlk8ExhCYlQRd/pirwRxQIV5/ZYoAMMpwzGS+xmZ/8hzlj4zebQqb41
         RbDg==
X-Gm-Message-State: ACgBeo38beyketC/ULtCiLCxhMQviBQBuL1TE0z3wYWxK9dwQQ6Xb2Gd
        nrdqaM7UnQqaVxpQ6GacMKBby8+6rg==
X-Google-Smtp-Source: AA6agR6tmX6O0OQeg40/a66cayp7ZWrOxCAZYXQEEjFQWCLZQTwLxAFer43d7O2YrUBoOEJPMNoEYQ==
X-Received: by 2002:a05:6808:1281:b0:344:d85a:9f38 with SMTP id a1-20020a056808128100b00344d85a9f38mr82124oiw.207.1661450887187;
        Thu, 25 Aug 2022 11:08:07 -0700 (PDT)
Received: from [127.0.1.1] (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t26-20020a0568080b3a00b003434b221a17sm5000231oij.52.2022.08.25.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 11:08:06 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 25 Aug 2022 13:08:00 -0500
Subject: [PATCH RFC v1 1/3] perf: arm_spe: Support new SPEv1.2/v8.7 'not taken' event
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220825-arm-spe-v8-7-v1-1-c75b8d92e692@kernel.org>
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
In-Reply-To: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
X-Mailer: b4 0.10.0-dev
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm SPEv1.2 (Armv8.7/v9.2) adds a new event, 'not taken', in bit 6 of
the PMSEVFR_EL1 register. Update arm_spe_pmsevfr_res0() to support the
additional event.

Signed-off-by: Rob Herring <robh@kernel.org>

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 7c71358d44c4..57904c11aece 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -312,6 +312,8 @@
 	 BIT_ULL(6) | BIT_ULL(4) | BIT_ULL(2) | BIT_ULL(0))
 #define SYS_PMSEVFR_EL1_RES0_8_3	\
 	(SYS_PMSEVFR_EL1_RES0_8_2 & ~(BIT_ULL(18) | BIT_ULL(17) | BIT_ULL(11)))
+#define SYS_PMSEVFR_EL1_RES0_8_7	\
+	(SYS_PMSEVFR_EL1_RES0_8_3 & ~BIT_ULL(6))
 
 #define SYS_PMSLATFR_EL1		sys_reg(3, 0, 9, 9, 6)
 #define SYS_PMSLATFR_EL1_MINLAT_SHIFT	0
@@ -847,6 +849,7 @@
 
 #define ID_AA64DFR0_PMSVER_8_2		0x1
 #define ID_AA64DFR0_PMSVER_8_3		0x2
+#define ID_AA64DFR0_PMSVER_8_7		0x3
 
 #define ID_DFR0_PERFMON_SHIFT		24
 
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index b65a7d9640e1..a75b03b5c8f9 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -677,9 +677,11 @@ static u64 arm_spe_pmsevfr_res0(u16 pmsver)
 	case ID_AA64DFR0_PMSVER_8_2:
 		return SYS_PMSEVFR_EL1_RES0_8_2;
 	case ID_AA64DFR0_PMSVER_8_3:
+		return SYS_PMSEVFR_EL1_RES0_8_3;
+	case ID_AA64DFR0_PMSVER_8_7:
 	/* Return the highest version we support in default */
 	default:
-		return SYS_PMSEVFR_EL1_RES0_8_3;
+		return SYS_PMSEVFR_EL1_RES0_8_7;
 	}
 }
 

-- 
b4 0.10.0-dev
