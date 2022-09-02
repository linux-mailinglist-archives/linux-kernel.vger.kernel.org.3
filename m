Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD315AB6C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 18:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbiIBQoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 12:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiIBQo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 12:44:27 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE92F826E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 09:44:26 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-11eab59db71so5980976fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jlxUk3azGy/EzfPrVt/ZaELMrYWactKPSNiRuIa74ck=;
        b=Xp4Qc4d3GxGOeTK6v7NtSdUReBaopEPOMaWHpXj/uzu9JQK/jpmpI3SJeoYxsGYKsp
         qy95k4AD+TVU2j0IUxwCtaykKPkBI3nXvOv+IOBCmx++fiU2GgNyufogGlww0mlyuIqh
         x2Z0L/jqra5Cs/BXT0bLYZMl+OsHGN0wy7mGdbiGmiwR1XCiVUzVb5YoIMA0EmjwZlS4
         Ug9hIJegIX20zNzYRiVRKMNbiIR8cQ7qDxFOjxRKLOhxdYkYThpi8F1r0bMV1MRjPWgw
         eQKTT8XmSupthtYOcAu3hXQt/0IFIrzZ79q2GrBWiaWsTQbwk2d/o3yuIdstpIGiQuZ3
         d19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jlxUk3azGy/EzfPrVt/ZaELMrYWactKPSNiRuIa74ck=;
        b=t7gBjTk/wW+aO7R2MYDXhd7VJvDTdv0i9GNavdxPYGPKt4VrCb+IkVr4GWnjLj2V4n
         jdr/0ixLdkHe2tYFEkG6a/4rOpW37Wrm6cBOzQNsJ+xmq7peXMbge9ohoXwArUvNC1ZA
         VZ4PqDDn6RIFGZn4gF0lzYKjXnMOtIrahbnhP0CtfSlw0lpfboTpV3QEpcHokgKpEEjq
         3uJrp+rY3LltkuqWUHvAeAcFKpWBMSV3QavhF+kTthZX+xHHQTb98O5yRKSx3hfTtbFR
         xqwdRproBXujP6qXT6iIGTWJwkCj/6eeRiSsvxFoZh442COXTDXX0viRzvWJuFXYtLGa
         eANQ==
X-Gm-Message-State: ACgBeo34bHNGwS4Mml2SGaQck4olFQp351S0aH8l7r0mPe3+yowOU20K
        w9EIhmCkiB8UQLH1J8Fw5sA=
X-Google-Smtp-Source: AA6agR4AkPjdTiVT1q1D8S+9i814inn8vtV7CADNh/TTbo4jKHbm/tpSC2wT76G9/4UJNSH3Wr7gLA==
X-Received: by 2002:a05:6808:124f:b0:345:775b:d5bf with SMTP id o15-20020a056808124f00b00345775bd5bfmr2238049oiv.217.1662137065376;
        Fri, 02 Sep 2022 09:44:25 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id y12-20020a4a980c000000b0044afd53b102sm811860ooi.36.2022.09.02.09.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 09:44:25 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH RFC] x86/apic: skip cpu slot reservation logic on boot in case of NR_CPUS == 1
Date:   Fri,  2 Sep 2022 09:42:11 -0700
Message-Id: <20220902164211.1425982-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

generic_processor_info() ensures that there's always a room for boot-cpu
in phys_cpu_present_map. This logic is unneeded when there's a single CPU
in the system, and it makes smatch warning when aliasing nr_cpu_ids to
NR_CPUS in this patch:

https://www.spinics.net/lists/kernel/msg4493525.html

smatch warnings:
arch/x86/kernel/apic/apic.c:2437 generic_processor_info() warn: always true condition '(num_processors >= (1) - 1) =>
+(0-u32max >= 0)'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
This is RFC because I'm not sure that this is not a false positive from
smatch. If NR_CPUS is 1, and the condition is always true, it's simply
optimized out by a compiler, and nothing wrong happens, except maybe a
couple of checks on boot.

 arch/x86/kernel/apic/apic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 6d303d1d276c..6a43faaea5ac 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -2430,6 +2430,7 @@ int generic_processor_info(int apicid, int version)
 		return -ENODEV;
 	}
 
+#if NR_CPUS > 1
 	/*
 	 * If boot cpu has not been detected yet, then only allow upto
 	 * nr_cpu_ids - 1 processors and keep one slot free for boot cpu
@@ -2445,6 +2446,7 @@ int generic_processor_info(int apicid, int version)
 		disabled_cpus++;
 		return -ENODEV;
 	}
+#endif
 
 	if (num_processors >= nr_cpu_ids) {
 		int thiscpu = max + disabled_cpus;
-- 
2.34.1

