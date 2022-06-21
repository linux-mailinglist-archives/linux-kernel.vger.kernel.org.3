Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24595534CE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 16:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351725AbiFUOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350580AbiFUOre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 10:47:34 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE441CB1E;
        Tue, 21 Jun 2022 07:47:33 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id m14so12744923plg.5;
        Tue, 21 Jun 2022 07:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=liIeHdPGNjU8bYPqknTA8U4F+aVaqOI8sJWxJcW9D0E=;
        b=jpfvcOG0Tp7GekMlmMm5FMSSTBE9ocH6SrPC4j9kGiO76LBt5JG/nTVjjLvk7pIXgc
         5WXjsraLQ6qZBUdZW90eKqnWLH0DyOq67URagf7R1uZaU33630JI+SPZgTBic7z7yE2u
         SrVIPg65RDtHD4LzoyK/tP0bpujacgL/f4cFMM0dpaLFymXjGCZhCXJ8o4YQA+fc6+qm
         Q4INMBDYC/AzC+JsdQcJbxH/eENGtFInkaMvChdDjuHJGx7HnE4MX0Jf3lB19xQVrOEA
         Dwr3eDFH1B6APEFsRSLUWkseuJ/PJqHSVKNtowbGH/G3PamTX1ImRxz3laoV/PxjTNL9
         I/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=liIeHdPGNjU8bYPqknTA8U4F+aVaqOI8sJWxJcW9D0E=;
        b=zmdAptM48BjhAI+nKYYW8wODSvsK1F+VOg2mcvageTlvbtTlW+SAYVrghFqmf9rzZ5
         8XjyJfJAC50gqOlVkXHqYofRoS1sK1dDF981IyTCKidm2rl/+ukfvau3D+0ylQPGchbm
         Z/UoMRrtHW1bpbEiZe9/eBugu3mmwhhUyK/Dgn2r7dOJPvR4nn5SaWh+KKeO2YAGUGUP
         S50n5gmo3mfVxCQ/bsVkyx87MpWppP4RTsK6SOwoVVni15g531zEA4AuwvhyxUGz0Wj8
         Qyb/xSsqWa5xMUHhnxo2ULLyqgbfl5rj3fm7k5v2zMtXFhvU/gAYvztFTNGD19bSvxrF
         GGGQ==
X-Gm-Message-State: AJIora+Ji0qMgn0xAifUxIR7Z/5Jhg7Xz4D0CLSmX7WP4CMZ+9+cXzao
        oe0jObJ1Wp7rRXx2uclu+FM=
X-Google-Smtp-Source: AGRyM1vAMGeDob1urLIoFhqrrm8UjWodEUKRFvrla+pWll4alKdJnlcwu2x3ouxr/ay8BxUppuHvmw==
X-Received: by 2002:a17:90b:180e:b0:1ec:d129:708 with SMTP id lw14-20020a17090b180e00b001ecd1290708mr2436517pjb.235.1655822853166;
        Tue, 21 Jun 2022 07:47:33 -0700 (PDT)
Received: from localhost ([2601:642:4c0a:44a6:9ce0:31c2:d9f5:8b25])
        by smtp.gmail.com with ESMTPSA id j11-20020aa7928b000000b005251ce498cfsm5331270pfa.191.2022.06.21.07.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 07:47:32 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Alexander Lobakin <alobakin@pm.me>,
        Huacai Chen <chenhuacai@kernel.org>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Mao Bibo <maobibo@loongson.cn>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        WANG Xuerui <kernel@xen0n.name>, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH] mips: micro-optimize calculate_cpu_foreign_map()
Date:   Tue, 21 Jun 2022 07:47:29 -0700
Message-Id: <20220621144729.533026-1-yury.norov@gmail.com>
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

The inner loop in calculate_cpu_foreign_map() walks the whole
cpumask to check if we have siblings for a given cpu.

We can just break after a 1st match and avoid useless traversing
the rest of mask.

Loongarch has an identical function, so fix it here as well.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---

It looks like loongarch copied quite a lot from arch/mips/kernel/smp.c.
For loongarch folks: Guys, can you consider moving shared code into a
shared file(s)?

 arch/loongarch/kernel/smp.c | 7 +++----
 arch/mips/kernel/smp.c      | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index b8c53b755a25..c1c91df3c8ac 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -463,17 +463,16 @@ static inline void set_cpu_core_map(int cpu)
  */
 void calculate_cpu_foreign_map(void)
 {
-	int i, k, core_present;
+	int i, k;
 	cpumask_t temp_foreign_map;
 
 	/* Re-calculate the mask */
 	cpumask_clear(&temp_foreign_map);
 	for_each_online_cpu(i) {
-		core_present = 0;
 		for_each_cpu(k, &temp_foreign_map)
 			if (cpus_are_siblings(i, k))
-				core_present = 1;
-		if (!core_present)
+				break;
+		if (k >= nr_cpu_ids)
 			cpumask_set_cpu(i, &temp_foreign_map);
 	}
 
diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 1d93b85271ba..a2ce641f5f18 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -115,17 +115,16 @@ static inline void set_cpu_core_map(int cpu)
  */
 void calculate_cpu_foreign_map(void)
 {
-	int i, k, core_present;
+	int i, k;
 	cpumask_t temp_foreign_map;
 
 	/* Re-calculate the mask */
 	cpumask_clear(&temp_foreign_map);
 	for_each_online_cpu(i) {
-		core_present = 0;
 		for_each_cpu(k, &temp_foreign_map)
 			if (cpus_are_siblings(i, k))
-				core_present = 1;
-		if (!core_present)
+				break;
+		if (k >= nr_cpu_ids)
 			cpumask_set_cpu(i, &temp_foreign_map);
 	}
 
-- 
2.32.0

