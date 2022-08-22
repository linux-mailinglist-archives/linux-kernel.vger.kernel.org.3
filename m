Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1434E59B783
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 04:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbiHVCRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 22:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiHVCQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 22:16:44 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937F122B34
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:16:43 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id u22so8652404plq.12
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 19:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=PHnhWNxyM6E9IxuW9zPMNCsqVfB66utEZnswI2QVnUY=;
        b=moyaT8LSzbsNueFItnBmXfweqqJW9rd5NwnfMitdVq1qYPLzlWYAklL72LaXB9oDvS
         JpCgS1YpoIHyPnh0KSuubJSnDsEtvOt1uncB6yxmaK8MQOhSUye5ULeoyFZ8gLHcgLtm
         CZha7A0JSZxdrdNhCQIMcHj8tXNLhk7KWvT6y/0bqmWktx98ivUpz7ndxNdcnYsvd4Gv
         djm4Wghi5lRR/MwRT4vwVy70tUYaHEdli5D2yg/fRmtSZ4BS+A33PfPf0bFw2aQWfAY8
         ieb8o1pFrhi9TXDdC7A1CU5ozlkzki6nUWCPZilyRhE0maI0dWIklZ1jVX0QH4g3WCqd
         nXxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=PHnhWNxyM6E9IxuW9zPMNCsqVfB66utEZnswI2QVnUY=;
        b=jhl2tQ5whCyjlssfauajxzmwSbQ94GcGetZL4l2ZnSstahovw6SdiOVDkwtGTO4hIx
         Z7eacy927u0EpsfDQCo7y7+kli/I//p+p+XTL4pKeDtSO15rHdc1QlvcxqjlL4Uj8qKo
         MVybAMa2jPDTnJuFmcTt/lEOcJN3qYoCEHzFGCDtQRQpVOGlsxNoPzvphZ9D0hFbaYFb
         lN2/+0Qa5eK3JaoJaeOzjB0snwN1NtHPiJDEC+6NyIWM0xLEQrQcHT2G8c7DQfYZM9TN
         9tlO8/WL9JSwJ6+ucR3AEYNvALBo86Llvl4YlJvz/4iol3vD4wCdzY5YBpUZNV8cvHxS
         Ck4Q==
X-Gm-Message-State: ACgBeo0oiZyXEti1ELq6yGcm54dbTtZSY/R1IPxHJKvwWrgavnedHbEm
        kYzhwrG0+RKA3sttJ33XNA==
X-Google-Smtp-Source: AA6agR57jl9X7wl2LO5S9m+7exo7QRftfzMvBzue936dsrZ1sTIFM7iDKbI/NpJ/4k6h+XhaKlz7WA==
X-Received: by 2002:a17:90a:c402:b0:1f8:c335:d4d7 with SMTP id i2-20020a17090ac40200b001f8c335d4d7mr26607609pjt.242.1661134602655;
        Sun, 21 Aug 2022 19:16:42 -0700 (PDT)
Received: from piliu.users.ipa.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id k3-20020aa79723000000b005321340753fsm7312139pfg.103.2022.08.21.19.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:16:42 -0700 (PDT)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Phil Auld <pauld@redhat.com>, Rob Herring <robh@kernel.org>,
        Ben Dooks <ben-linux@fluff.org>
Subject: [RFC 10/10] arm64: smp: Make __cpu_disable() parallel
Date:   Mon, 22 Aug 2022 10:15:20 +0800
Message-Id: <20220822021520.6996-11-kernelfans@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220822021520.6996-1-kernelfans@gmail.com>
References: <20220822021520.6996-1-kernelfans@gmail.com>
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

On a dying cpu, take_cpu_down()->__cpu_disable(), which means if the
teardown path supports parallel, __cpu_disable() confront the parallel,
which may ruin cpu_online_mask etc if no extra lock provides the
protection.

At present, the cpumask is protected by cpu_add_remove_lock, that lock
is quite above __cpu_disable(). In order to protect __cpu_disable() from
parrallel in kexec quick reboot path, introducing a local lock
cpumap_lock.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Ben Dooks <ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 arch/arm64/kernel/smp.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ffc5d76cf695..fee8879048b0 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -287,6 +287,28 @@ static int op_cpu_disable(unsigned int cpu)
 	return 0;
 }
 
+static DEFINE_SPINLOCK(cpumap_lock);
+
+static void __cpu_clear_maps(unsigned int cpu)
+{
+	/*
+	 * In the case of kexec rebooting, the cpu_add_remove_lock mutex can not protect
+	 */
+	if (kexec_in_progress)
+		spin_lock(&cpumap_lock);
+	remove_cpu_topology(cpu);
+	numa_remove_cpu(cpu);
+
+	/*
+	 * Take this CPU offline.  Once we clear this, we can't return,
+	 * and we must not schedule until we're ready to give up the cpu.
+	 */
+	set_cpu_online(cpu, false);
+	if (kexec_in_progress)
+		spin_unlock(&cpumap_lock);
+
+}
+
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
@@ -299,14 +321,7 @@ int __cpu_disable(void)
 	if (ret)
 		return ret;
 
-	remove_cpu_topology(cpu);
-	numa_remove_cpu(cpu);
-
-	/*
-	 * Take this CPU offline.  Once we clear this, we can't return,
-	 * and we must not schedule until we're ready to give up the cpu.
-	 */
-	set_cpu_online(cpu, false);
+	__cpu_clear_maps(cpu);
 	ipi_teardown(cpu);
 
 	/*
-- 
2.31.1

