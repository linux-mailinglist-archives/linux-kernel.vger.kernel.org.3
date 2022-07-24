Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281FD57F26A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 03:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbiGXBCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 21:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238762AbiGXBCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 21:02:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A226A17A82;
        Sat, 23 Jul 2022 18:02:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso7197236pja.4;
        Sat, 23 Jul 2022 18:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnMePAjlxfqugbwA3tp6h6RFCc5B1OEQTh1N6m+wjeE=;
        b=OwoWxf6q/XqRD0WQiN+4+CVfXv4K783W9L7JdqbWGvT9EkFquACP2USzwgr1BBWZcs
         UgFa7nkl5dwNbRGqz0+stQx+lYc/wuvHeQFSqSLwHxd8pYFSbLbfYIUH9vDKO1CR9+FW
         2yvL/KayQ4QKgWJ2HIKDPNL+qTja4CjGdVdCWaOLk7ArHY44EtypiRYybXNwi/Jdr5lq
         S3y39XpJqiS0QSZxK1PSq0YToPR+T28HcNP83uKyGgjrlB5Ez8y8Mk3G+alrWQ43yePF
         6eidm9naEOPDsCmECj5JQW+XhHh+7nf9OCIAZMrQb8rkpUvtyNyO0mk4xO71ZW0oKIgH
         8VjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CnMePAjlxfqugbwA3tp6h6RFCc5B1OEQTh1N6m+wjeE=;
        b=eQ5tUWh+j2yZZhV4l63uEzJ0gUzq7XAb897/aZSNS/8r30yOUPiD5TxnBp0845rASl
         uOOP2qX6ZKQTMgzld2oOfqBqCaqNeDTCFxGQHPuMVhYeo0h6qc/ZZafy3EnTYUVKQSDS
         Gbt5QpBPQuVKJKndjQG/5biQ4f/Kyqiwe0yDUqpmPMSwkUgX+IR1QhZf0giP7hMDQpEL
         ih/F/ANhPSFClrzVLNA3+wMKpkfhmJhPqMaomGxDK6wj2zNLC0643iLm9p+5XGUoZtUf
         TcRPXHd1F6AEEnisy99e7QYs4QWOE7b931OrsE1wtwwuuLXnuhXutov4k+1YwV+h4Ueu
         gsTw==
X-Gm-Message-State: AJIora9hIrFghx3WHHRFqE9IKAL1BYfcDHhq0mWjaei+CtWxHcGuPEdn
        /tiGcTe45qZ8f60VDqFWVHw=
X-Google-Smtp-Source: AGRyM1vzFM2UWLBfSDMyYJQbiiyXGWXRTPwC5zsCa8kurF/e71YFSJZxsOOehXI9DiAtwv2OMMtl4Q==
X-Received: by 2002:a17:90a:bc1:b0:1f2:435f:94bc with SMTP id x1-20020a17090a0bc100b001f2435f94bcmr7431584pjd.5.1658624554996;
        Sat, 23 Jul 2022 18:02:34 -0700 (PDT)
Received: from localhost.localdomain ([194.5.48.112])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090341d100b001677d4a9654sm6286171ple.265.2022.07.23.18.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 18:02:34 -0700 (PDT)
From:   zhouzhouyi@gmail.com
To:     john.ogness@linutronix.de, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        akpm@linux-foundation.org, christophe.leroy@csgroup.eu,
        wangkefeng.wang@huawei.com, npiggin@gmail.com, rppt@kernel.org,
        aneesh.kumar@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, paulmck@kernel.org,
        rcu@vger.kernel.org
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>
Subject: [PATCH linux-next] powerpc: init jump label early in ppc 64
Date:   Sun, 24 Jul 2022 09:02:21 +0800
Message-Id: <20220724010221.17371-1-zhouzhouyi@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhouyi Zhou <zhouzhouyi@gmail.com>

In ppc 64, invoke jump_label_init in setup_feature_keys is too late
because static key will be used in subroutine of early_init_devtree.

So we can invoke jump_label_init earlier in early_setup.
We can not move setup_feature_keys backward because its subroutine
cpu_feature_keys_init depend on data structures initialized in
early_init_devtree.

Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
---
Dear PPC developers

I found this bug when trying to do rcutorture tests in ppc VM of
Open Source Lab of Oregon State University.

qemu-system-ppc64 -nographic -smp cores=8,threads=1 -net none -M pseries -nodefaults -device spapr-vscsi -serial file:/home/ubuntu/linux-next/tools/testing/selftests/rcutorture/res/2022.07.19-01.18.42-torture/results-rcutorture/TREE03/console.log -m 512 -kernel /home/ubuntu/linux-next/tools/testing/selftests/rcutorture/res/2022.07.19-01.18.42-torture/results-rcutorture/TREE03/vmlinux -append "debug_boot_weak_hash panic=-1 console=ttyS0 rcupdate.rcu_cpu_stall_suppress_at_boot=1 torture.disable_onoff_at_boot rcupdate.rcu_task_stall_timeout=30000 rcutorture.onoff_interval=200 rcutorture.onoff_holdoff=30 rcutree.gp_preinit_delay=12 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcutree.kthread_prio=2 threadirqs tree.use_softirq=0 rcutorture.n_barrier_cbs=4 rcutorture.stat_interval=15 rcutorture.shutdown_secs=420 rcutorture.test_no_idle_hz=1 rcutorture.verbose=1"

console.log report following WARN:
[    0.000000][    T0] static_key_enable_cpuslocked(): static key '0xc000000002953260' used before call to jump_label_init()^M
[    0.000000][    T0] WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:166 static_key_enable_cpuslocked+0xfc/0x120^M
[    0.000000][    T0] Modules linked in:^M
[    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Not tainted 5.19.0-rc5-next-20220708-dirty #131^M
[    0.000000][    T0] NIP:  c00000000038068c LR: c000000000380688 CTR: c000000000186ac0^M
[    0.000000][    T0] REGS: c000000002867930 TRAP: 0700   Not tainted  (5.19.0-rc5-next-20220708-dirty)^M
[    0.000000][    T0] MSR:  8000000000022003 <SF,FP,RI,LE>  CR: 24282224  XER: 20040000^M
[    0.000000][    T0] CFAR: 0000000000000730 IRQMASK: 1 ^M
[    0.000000][    T0] GPR00: c000000000380688 c000000002867bd0 c000000002868d00 0000000000000065 ^M
[    0.000000][    T0] GPR04: 0000000000000001 0000000000000000 0000000000000080 000000000000000d ^M
[    0.000000][    T0] GPR08: 0000000000000000 0000000000000000 c0000000027fd000 000000000000000f ^M
[    0.000000][    T0] GPR12: c000000000186ac0 c000000002082280 0000000000000003 000000000000000d ^M
[    0.000000][    T0] GPR16: 0000000002cc00d0 0000000000000000 c000000002082280 0000000000000001 ^M
[    0.000000][    T0] GPR20: c000000002080942 0000000000000000 0000000000000000 0000000000000000 ^M
[    0.000000][    T0] GPR24: 0000000000000000 c0000000010d6168 0000000000000000 c0000000020034c8 ^M
[    0.000000][    T0] GPR28: 0000002800000000 0000000000000000 c000000002080942 c000000002953260 ^M
[    0.000000][    T0] NIP [c00000000038068c] static_key_enable_cpuslocked+0xfc/0x120^M
[    0.000000][    T0] LR [c000000000380688] static_key_enable_cpuslocked+0xf8/0x120^M
[    0.000000][    T0] Call Trace:^M
[    0.000000][    T0] [c000000002867bd0] [c000000000380688] static_key_enable_cpuslocked+0xf8/0x120 (unreliable)^M
[    0.000000][    T0] [c000000002867c40] [c000000000380810] static_key_enable+0x30/0x50^M
[    0.000000][    T0] [c000000002867c70] [c000000002030314] setup_forced_irqthreads+0x28/0x40^M
[    0.000000][    T0] [c000000002867c90] [c000000002003568] do_early_param+0xa0/0x108^M
[    0.000000][    T0] [c000000002867d10] [c000000000175340] parse_args+0x290/0x4e0^M
[    0.000000][    T0] [c000000002867e10] [c000000002003c74] parse_early_options+0x48/0x5c^M
[    0.000000][    T0] [c000000002867e30] [c000000002003ce0] parse_early_param+0x58/0x84^M
[    0.000000][    T0] [c000000002867e60] [c000000002009878] early_init_devtree+0xd4/0x518^M
[    0.000000][    T0] [c000000002867f10] [c00000000200aee0] early_setup+0xb4/0x214^M

After this fix, the WARN does not show again.

Kind Regards
Zhouyi
--
 arch/powerpc/kernel/setup_64.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2b2d0b0fbb30..bf2fb76221da 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -365,6 +365,9 @@ void __init early_setup(unsigned long dt_ptr)
 
 	udbg_printf(" -> %s(), dt_ptr: 0x%lx\n", __func__, dt_ptr);
 
+	/* Initialise jump label because subsequent calls need it */
+	jump_label_init();
+
 	/*
 	 * Do early initialization using the flattened device
 	 * tree, such as retrieving the physical memory map or
@@ -394,8 +397,15 @@ void __init early_setup(unsigned long dt_ptr)
 
 	/* Apply all the dynamic patching */
 	apply_feature_fixups();
-	setup_feature_keys();
+
+	/*
+	 * All the cpu/mmu_has_feature() checks take on their correct polarity
+	 * based on the current set of CPU/MMU features. These should be done
+	 * only after early_init_devtree.
+	 */
+	cpu_feature_keys_init();
+	mmu_feature_keys_init();
+
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu();
-- 
2.25.1

