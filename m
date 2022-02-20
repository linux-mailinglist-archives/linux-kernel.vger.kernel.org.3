Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3804BCD02
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 08:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240127AbiBTGTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 01:19:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbiBTGTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 01:19:46 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5A0517C7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 22:19:24 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m11so6825118pls.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 22:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxhQxLNvA7mygJSe4CoHbzxz1WYaj+5k5Oout0vgy10=;
        b=ZQR3NDZ+zKn/9Aq7nzyF2Yfqp/AhR/zE7HrjcTKrwZIucPXU6uUZHCZvtvUe2FA3IG
         bBa0T834hqKWtSnQLM4Gk2J04msOE7R2Xw1vsKoOHWup8E7v3lm3iDXTFQufhajLp83W
         QnVBFJ/h1xBgtXZOGWfg1gWA33V+mCTzlEOxt/KGWM+sNdU3qc9Q1ahrZV7GxDl6S4kN
         aFj59jcu/RJ4JhfrxnA86Pb6pz6RHO/H5NufuUHPZvvfY59xT0mJAEx1f2WPNQvu/8Fw
         eZaFvuN8s/UWKg7+3wfzy75nQr5b9IpIiPsdWIzYqdt3oUdOWw9lbrwGmFrTw0OC6xP4
         Z8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AxhQxLNvA7mygJSe4CoHbzxz1WYaj+5k5Oout0vgy10=;
        b=AOiGfDyyO99920StCmkpUZbNm+hii+qwv5E8ugCAxH/I/UQgaMBSdHgh/HTKogwmic
         2SUUP7qleWeQAgm9EvLrvOcOczsG/Nzd0L3AfbYFnaTrLMsKFrSL6XaCg63nzLMjwu6Y
         mvUADjJbnDomaBRUHFmDUcEvz2BG0BkC5V43g+KWxCeCfmop4qIiF1O51tzcSv/LMzBv
         uVdkO1tNYYlTAC38O4ntLG8ocuuC7/7/tsE378NSKMPbpI3FvNa4IbevyafNx2uum9ec
         /cTiXGRd4vdRekg4NcSLR6IztvXNMiwdKtMehFUHq/uSBWll4ETQG7kzsj+mvXn5Qbop
         coGg==
X-Gm-Message-State: AOAM533awMgFt2Xva51xy6EFP3GXjmVdyPqv/mb3VcKbbRGdKzIAeZj+
        y0UHSBxfOitbivx3dBN3pRXuhzuM6DM=
X-Google-Smtp-Source: ABdhPJzpDUYFD9vKBvtQV3C2vOtXz0x2vzXkeykypcsiV+otX0e4rQZ1rMoKrZpPy4gUlzkhhYqBdQ==
X-Received: by 2002:a17:90a:9482:b0:1b9:aaff:7eda with SMTP id s2-20020a17090a948200b001b9aaff7edamr15680863pjo.207.1645337963478;
        Sat, 19 Feb 2022 22:19:23 -0800 (PST)
Received: from barry-desktop.hub ([2407:7000:8942:5500:afc6:e60b:3e3b:52de])
        by smtp.gmail.com with ESMTPSA id 19sm7789060pfz.153.2022.02.19.22.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:19:23 -0800 (PST)
From:   Barry Song <21cnbao@gmail.com>
To:     maz@kernel.org, tglx@linutronix.de, will@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        Barry Song <song.bao.hua@hisilicon.com>
Subject: [PATCH v2] irqchip/gic-v3: use dsb(ishst) to synchronize data to smp before issuing ipi
Date:   Sun, 20 Feb 2022 19:19:10 +1300
Message-Id: <20220220061910.6155-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.30.2
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

From: Barry Song <song.bao.hua@hisilicon.com>

dsb(ishst) should be enough here as we only need to guarantee the
visibility of data to other CPUs in smp inner domain before we
send the ipi.

A micro-benchmark is written to verify the performance impact on
kunpeng920 machine with 2 sockets, each socket has 2 dies, and
each die has 24 CPUs, so totally the system has 2 * 2 * 24 = 96
CPUs. ~2% performance improvement can be seen by this benchmark.

The code of benchmark module:

 #include <linux/module.h>
 #include <linux/timekeeping.h>

 volatile int data0 ____cacheline_aligned;
 volatile int data1 ____cacheline_aligned;
 volatile int data2 ____cacheline_aligned;
 volatile int data3 ____cacheline_aligned;
 volatile int data4 ____cacheline_aligned;
 volatile int data5 ____cacheline_aligned;
 volatile int data6 ____cacheline_aligned;

 static void ipi_latency_func(void *val)
 {
 }

 static int __init ipi_latency_init(void)
 {
 	ktime_t stime, etime, delta;
 	int cpu, i;
 	int start = smp_processor_id();

 	stime = ktime_get();
 	for ( i = 0; i < 1000; i++)
 		for (cpu = 0; cpu < 96; cpu++) {
 			data0 = data1 = data2 = data3 = data4 = data5 = data6 = cpu;
 			smp_call_function_single(cpu, ipi_latency_func, NULL, 1);
 		}
 	etime = ktime_get();

 	delta = ktime_sub(etime, stime);

 	printk("%s ipi from cpu%d to cpu0-95 delta of 1000times:%lld\n",
 			__func__, start, delta);

 	return 0;
 }
 module_init(ipi_latency_init);

 static void ipi_latency_exit(void)
 {
 }
 module_exit(ipi_latency_exit);

 MODULE_DESCRIPTION("IPI benchmark");
 MODULE_LICENSE("GPL");

run the below commands 10 times on both Vanilla and the kernel with this
patch:
 # taskset -c 0 insmod test.ko
 # rmmod test

The result on vanilla:
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126757449
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126784249
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126177703
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:127022281
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126184883
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:127374585
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:125778089
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126974441
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:127357625
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:126228184

The result on the kernel with this patch:
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:124467401
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123474209
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123558497
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122993951
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:122984223
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123323609
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:124507583
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123386963
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123340664
 ipi_latency_init ipi from cpu0 to cpu0-95 delta of 1000times:123285324

Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: add benchmark and benchmark data in commit log

 drivers/irqchip/irq-gic-v3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 5e935d97207d..0efe1a9a9f3b 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1211,7 +1211,7 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 	 * Ensure that stores to Normal memory are visible to the
 	 * other CPUs before issuing the IPI.
 	 */
-	wmb();
+	dsb(ishst);
 
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(cpu_logical_map(cpu));
-- 
2.25.1

