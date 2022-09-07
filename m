Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE075B0954
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 17:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiIGP6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 11:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIGP56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 11:57:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E2096759
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 08:57:56 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id k17so9014624wmr.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 08:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=YZgl4dnyb1fLqxxsB9m/gywD8hhxQB+iJpjv0XCZv3k=;
        b=GHe3D3Fp1nzIGOlU+T0DPDqLoSiCtfNeLjow+OU3RCeYo0rrXU6AYGzmrteJzcfcNG
         8IbMElUTZXc2/PPrkqNI1/3ET176TWgAMpXMBRwhofqF5wuxi44uSz4Pp8VacNyzE1Ab
         jiznOSBzjdfth/+WCwRYbB8eoH4gd2fbkTVYzjo9gkeM5Pw9DgpmWaGb6eF1c47efhvk
         Fs0lJRpZ6qpONA2aMe3Q9yxrkMoovTS3V8JKf7cIOubX1n674+iJiBajE/4HWG1lWSEM
         UECU+4FjzxKyclniILVYmv6cIk4Ts7PJahJjj3Awc1h4PfAjCyJgoQKQGvpgb6tLvi5l
         wl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=YZgl4dnyb1fLqxxsB9m/gywD8hhxQB+iJpjv0XCZv3k=;
        b=bb1V6Wo8HNfDdA2cEVxShIFsHpTNYBDofuilyRYILizWOrxOTs0zVpE4aXrJQ5zPzz
         D8Ghlsxdb/dAJnOwlj7YyYVY8DLLfU/VUXdpZsrj4/IcsOnsPv/Dele6RoFYTQfdm1fY
         dVadBbzq5uLCwFQPIZISB35P4898g1WNuFCHy0fRb6o20XmnXhVKKv61XEW+y61QM2yU
         MAlFSm1SoT6ywTXTAZa+Wc7XmQnPgehDBT8lKLKSzKqGJ8znHRM9fSTBMSdSEvldBBfq
         8oqGAAA1+Cbw7HvgcHLGNzAliLB1jUHTne7BnLEKsUikRjBB29MddfxxRWNYztCxh7Lb
         VykQ==
X-Gm-Message-State: ACgBeo0aAuaadK07AhfntdDZ9ee6ZQTIdMV7aolb7kX2r5HJpO+D0Wcc
        JfotCa+g0r7w4m1n/D4KqzapNQ==
X-Google-Smtp-Source: AA6agR4I8nNkgxUAOZJ4jnslbwda1RWWniDCV+FvB/sanLgip20cgQpB04iheQ4BPw6iEeYpLC2TZQ==
X-Received: by 2002:a1c:7414:0:b0:3a5:fd9e:e629 with SMTP id p20-20020a1c7414000000b003a5fd9ee629mr17428341wmc.194.1662566274794;
        Wed, 07 Sep 2022 08:57:54 -0700 (PDT)
Received: from localhost ([95.148.15.66])
        by smtp.gmail.com with ESMTPSA id d11-20020adfe84b000000b0021f131de6aesm17867390wrn.34.2022.09.07.08.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:57:54 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     ast@kernel.org
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhoufeng.zf@bytedance.com,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org
Subject: [PATCH v2] bpf: Simplify code by using for_each_cpu_wrap()
Date:   Wed,  7 Sep 2022 16:57:46 +0100
Message-Id: <20220907155746.1750329-1-punit.agrawal@bytedance.com>
X-Mailer: git-send-email 2.35.1
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

In the percpu freelist code, it is a common pattern to iterate over
the possible CPUs mask starting with the current CPU. The pattern is
implemented using a hand rolled while loop with the loop variable
increment being open-coded.

Simplify the code by using for_each_cpu_wrap() helper to iterate over
the possible cpus starting with the current CPU. As a result, some of
the special-casing in the loop also gets simplified.

No functional change intended.

Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
---
v1 -> v2:
* Fixed the incorrect transformation changing semantics of __pcpu_freelist_push_nmi()

Previous version -
v1: https://lore.kernel.org/all/20220817130807.68279-1-punit.agrawal@bytedance.com/

 kernel/bpf/percpu_freelist.c | 48 ++++++++++++------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
index 00b874c8e889..b6e7f5c5b9ab 100644
--- a/kernel/bpf/percpu_freelist.c
+++ b/kernel/bpf/percpu_freelist.c
@@ -58,23 +58,21 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
 {
 	int cpu, orig_cpu;
 
-	orig_cpu = cpu = raw_smp_processor_id();
+	orig_cpu = raw_smp_processor_id();
 	while (1) {
-		struct pcpu_freelist_head *head;
+		for_each_cpu_wrap(cpu, cpu_possible_mask, orig_cpu) {
+			struct pcpu_freelist_head *head;
 
-		head = per_cpu_ptr(s->freelist, cpu);
-		if (raw_spin_trylock(&head->lock)) {
-			pcpu_freelist_push_node(head, node);
-			raw_spin_unlock(&head->lock);
-			return;
+			head = per_cpu_ptr(s->freelist, cpu);
+			if (raw_spin_trylock(&head->lock)) {
+				pcpu_freelist_push_node(head, node);
+				raw_spin_unlock(&head->lock);
+				return;
+			}
 		}
-		cpu = cpumask_next(cpu, cpu_possible_mask);
-		if (cpu >= nr_cpu_ids)
-			cpu = 0;
 
 		/* cannot lock any per cpu lock, try extralist */
-		if (cpu == orig_cpu &&
-		    pcpu_freelist_try_push_extra(s, node))
+		if (pcpu_freelist_try_push_extra(s, node))
 			return;
 	}
 }
@@ -125,13 +123,12 @@ static struct pcpu_freelist_node *___pcpu_freelist_pop(struct pcpu_freelist *s)
 {
 	struct pcpu_freelist_head *head;
 	struct pcpu_freelist_node *node;
-	int orig_cpu, cpu;
+	int cpu;
 
-	orig_cpu = cpu = raw_smp_processor_id();
-	while (1) {
+	for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
 		head = per_cpu_ptr(s->freelist, cpu);
 		if (!READ_ONCE(head->first))
-			goto next_cpu;
+			continue;
 		raw_spin_lock(&head->lock);
 		node = head->first;
 		if (node) {
@@ -140,12 +137,6 @@ static struct pcpu_freelist_node *___pcpu_freelist_pop(struct pcpu_freelist *s)
 			return node;
 		}
 		raw_spin_unlock(&head->lock);
-next_cpu:
-		cpu = cpumask_next(cpu, cpu_possible_mask);
-		if (cpu >= nr_cpu_ids)
-			cpu = 0;
-		if (cpu == orig_cpu)
-			break;
 	}
 
 	/* per cpu lists are all empty, try extralist */
@@ -164,13 +155,12 @@ ___pcpu_freelist_pop_nmi(struct pcpu_freelist *s)
 {
 	struct pcpu_freelist_head *head;
 	struct pcpu_freelist_node *node;
-	int orig_cpu, cpu;
+	int cpu;
 
-	orig_cpu = cpu = raw_smp_processor_id();
-	while (1) {
+	for_each_cpu_wrap(cpu, cpu_possible_mask, raw_smp_processor_id()) {
 		head = per_cpu_ptr(s->freelist, cpu);
 		if (!READ_ONCE(head->first))
-			goto next_cpu;
+			continue;
 		if (raw_spin_trylock(&head->lock)) {
 			node = head->first;
 			if (node) {
@@ -180,12 +170,6 @@ ___pcpu_freelist_pop_nmi(struct pcpu_freelist *s)
 			}
 			raw_spin_unlock(&head->lock);
 		}
-next_cpu:
-		cpu = cpumask_next(cpu, cpu_possible_mask);
-		if (cpu >= nr_cpu_ids)
-			cpu = 0;
-		if (cpu == orig_cpu)
-			break;
 	}
 
 	/* cannot pop from per cpu lists, try extralist */
-- 
2.35.1

