Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6735597006
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbiHQNfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 09:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiHQNfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 09:35:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DB7284
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 06:35:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1422161376
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 13:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E65C433C1;
        Wed, 17 Aug 2022 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660743346;
        bh=b2x1y+2NqUSkUdGYmTo5Uu+gl3Ph0WtveAb242glO4U=;
        h=Date:From:To:Cc:Subject:From;
        b=Ugr5fzFgwbZoWPo2jnOgoln/YQG1jK+JkILXQ1Tf31omgJNpyTtMLRwuoHbksqK8L
         fq74NyihJKSkoRUElxe7Y6nTqdGGs1dx8AuGNgwRqqoGHal0Dok76TF4jCKtdNxbzE
         UsRTDfXWkIKFavydVw7TAUv/dLPVdA3jOco/WUlscPJ+O1heJpI/0qwUEiK4QvTUyo
         clrJk6q78q5advxxEskDJSDZsEC8EzyFlXvLjcLQIayoKqqkNzl1li1N4ffkqLgMiA
         tnolKpi9q4R/jYqQ69V12mpEhTe8xKac8j4ydvkt/4YYiNNYihIO0eB48FTPGxvUQT
         ghTc6NM3cLOkA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2EE864035A; Wed, 17 Aug 2022 10:35:43 -0300 (-03)
Date:   Wed, 17 Aug 2022 10:35:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>, Ben Gardon <bgardon@google.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        =?iso-8859-1?Q?Jo=E3o?= Martins <joao.m.martins@oracle.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        Pierre Morel <pmorel@linux.ibm.com>, Tao Xu <tao3.xu@intel.com>
Subject: [PATCH FYI 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <YvzuryClcn/vA0Gn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick the changes in:

  8a061562e2f2b32b ("RISC-V: KVM: Add extensible CSR emulation framework")
  f5ecfee944934757 ("KVM: s390: resetting the Topology-Change-Report")
  450a563924ae9437 ("KVM: stats: Fix value for KVM_STATS_UNIT_MAX for boolean stats")
  1b870fa5573e260b ("kvm: stats: tell userspace which values are boolean")
  db1c875e0539518e ("KVM: s390: add KVM_S390_ZPCI_OP to manage guest zPCI devices")
  94dfc73e7cf4a31d ("treewide: uapi: Replace zero-length arrays with flexible-array members")
  084cc29f8bbb034c ("KVM: x86/MMU: Allow NX huge pages to be disabled on a per-vm basis")
  2f4073e08f4cc5a4 ("KVM: VMX: Enable Notify VM exit")
  ed2351174e38ad4f ("KVM: x86: Extend KVM_{G,S}ET_VCPU_EVENTS to support pending triple fault")
  e9bf3acb23f0a6e1 ("KVM: s390: Add KVM_CAP_S390_PROTECTED_DUMP")
  8aba09588d2af37c ("KVM: s390: Add CPU dump functionality")
  0460eb35b443f73f ("KVM: s390: Add configuration dump functionality")
  fe9a93e07ba4f29d ("KVM: s390: pv: Add query dump information")
  35d02493dba1ae63 ("KVM: s390: pv: Add query interface")
  c24a950ec7d60c4d ("KVM, SEV: Add KVM_EXIT_SHUTDOWN metadata for SEV-ES")
  ffbb61d09fc56c85 ("KVM: x86: Accept KVM_[GS]ET_TSC_KHZ as a VM ioctl.")
  661a20fab7d156cf ("KVM: x86/xen: Advertise and document KVM_XEN_HVM_CONFIG_EVTCHN_SEND")
  fde0451be8fb3208 ("KVM: x86/xen: Support per-vCPU event channel upcall via local APIC")
  28d1629f751c4a5f ("KVM: x86/xen: Kernel acceleration for XENVER_version")
  536395260582be74 ("KVM: x86/xen: handle PV timers oneshot mode")
  942c2490c23f2800 ("KVM: x86/xen: Add KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID")
  2fd6df2f2b47d430 ("KVM: x86/xen: intercept EVTCHNOP_send from guests")
  35025735a79eaa89 ("KVM: x86/xen: Support direct injection of event channel events")

That just rebuilds perf, as these patches add just an ioctl that is S390
specific and may clash with other arches, so are so far being excluded
in the harvester script:

  $ tools/perf/trace/beauty/kvm_ioctl.sh > before
  $ cp include/uapi/linux/kvm.h tools/include/uapi/linux/kvm.h
  $ tools/perf/trace/beauty/kvm_ioctl.sh > after
  $ diff -u before after
  $ grep 390 tools/perf/trace/beauty/kvm_ioctl.sh
  	egrep -v " ((ARM|PPC|S390)_|[GS]ET_(DEBUGREGS|PIT2|XSAVE|TSC_KHZ)|CREATE_SPAPR_TCE_64)" | \
  $

This is also by now used by tools/testing/selftests/kvm/, a simple test
build succeeded.

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Anup Patel <anup@brainfault.org>
Cc: Ben Gardon <bgardon@google.com>
Cc: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: Janosch Frank <frankja@linux.ibm.com>
Cc: João Martins <joao.m.martins@oracle.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Oliver Upton <oupton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Gonda <pgonda@google.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>
Cc: Tao Xu <tao3.xu@intel.com>
Link: http://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 108 +++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index cb6e3846d27b9a14..eed0315a77a6db67 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -270,6 +270,8 @@ struct kvm_xen_exit {
 #define KVM_EXIT_X86_BUS_LOCK     33
 #define KVM_EXIT_XEN              34
 #define KVM_EXIT_RISCV_SBI        35
+#define KVM_EXIT_RISCV_CSR        36
+#define KVM_EXIT_NOTIFY           37
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -496,6 +498,18 @@ struct kvm_run {
 			unsigned long args[6];
 			unsigned long ret[2];
 		} riscv_sbi;
+		/* KVM_EXIT_RISCV_CSR */
+		struct {
+			unsigned long csr_num;
+			unsigned long new_value;
+			unsigned long write_mask;
+			unsigned long ret_value;
+		} riscv_csr;
+		/* KVM_EXIT_NOTIFY */
+		struct {
+#define KVM_NOTIFY_CONTEXT_INVALID	(1 << 0)
+			__u32 flags;
+		} notify;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -1157,6 +1171,12 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_VM_TSC_CONTROL 214
 #define KVM_CAP_SYSTEM_EVENT_DATA 215
 #define KVM_CAP_ARM_SYSTEM_SUSPEND 216
+#define KVM_CAP_S390_PROTECTED_DUMP 217
+#define KVM_CAP_X86_TRIPLE_FAULT_EVENT 218
+#define KVM_CAP_X86_NOTIFY_VMEXIT 219
+#define KVM_CAP_VM_DISABLE_NX_HUGE_PAGES 220
+#define KVM_CAP_S390_ZPCI_OP 221
+#define KVM_CAP_S390_CPU_TOPOLOGY 222
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1660,6 +1680,55 @@ struct kvm_s390_pv_unp {
 	__u64 tweak;
 };
 
+enum pv_cmd_dmp_id {
+	KVM_PV_DUMP_INIT,
+	KVM_PV_DUMP_CONFIG_STOR_STATE,
+	KVM_PV_DUMP_COMPLETE,
+	KVM_PV_DUMP_CPU,
+};
+
+struct kvm_s390_pv_dmp {
+	__u64 subcmd;
+	__u64 buff_addr;
+	__u64 buff_len;
+	__u64 gaddr;		/* For dump storage state */
+	__u64 reserved[4];
+};
+
+enum pv_cmd_info_id {
+	KVM_PV_INFO_VM,
+	KVM_PV_INFO_DUMP,
+};
+
+struct kvm_s390_pv_info_dump {
+	__u64 dump_cpu_buffer_len;
+	__u64 dump_config_mem_buffer_per_1m;
+	__u64 dump_config_finalize_len;
+};
+
+struct kvm_s390_pv_info_vm {
+	__u64 inst_calls_list[4];
+	__u64 max_cpus;
+	__u64 max_guests;
+	__u64 max_guest_addr;
+	__u64 feature_indication;
+};
+
+struct kvm_s390_pv_info_header {
+	__u32 id;
+	__u32 len_max;
+	__u32 len_written;
+	__u32 reserved;
+};
+
+struct kvm_s390_pv_info {
+	struct kvm_s390_pv_info_header header;
+	union {
+		struct kvm_s390_pv_info_dump dump;
+		struct kvm_s390_pv_info_vm vm;
+	};
+};
+
 enum pv_cmd_id {
 	KVM_PV_ENABLE,
 	KVM_PV_DISABLE,
@@ -1668,6 +1737,8 @@ enum pv_cmd_id {
 	KVM_PV_VERIFY,
 	KVM_PV_PREP_RESET,
 	KVM_PV_UNSHARE_ALL,
+	KVM_PV_INFO,
+	KVM_PV_DUMP,
 };
 
 struct kvm_pv_cmd {
@@ -2119,4 +2190,41 @@ struct kvm_stats_desc {
 /* Available with KVM_CAP_XSAVE2 */
 #define KVM_GET_XSAVE2		  _IOR(KVMIO,  0xcf, struct kvm_xsave)
 
+/* Available with KVM_CAP_S390_PROTECTED_DUMP */
+#define KVM_S390_PV_CPU_COMMAND	_IOWR(KVMIO, 0xd0, struct kvm_pv_cmd)
+
+/* Available with KVM_CAP_X86_NOTIFY_VMEXIT */
+#define KVM_X86_NOTIFY_VMEXIT_ENABLED		(1ULL << 0)
+#define KVM_X86_NOTIFY_VMEXIT_USER		(1ULL << 1)
+
+/* Available with KVM_CAP_S390_ZPCI_OP */
+#define KVM_S390_ZPCI_OP         _IOW(KVMIO,  0xd1, struct kvm_s390_zpci_op)
+
+struct kvm_s390_zpci_op {
+	/* in */
+	__u32 fh;               /* target device */
+	__u8  op;               /* operation to perform */
+	__u8  pad[3];
+	union {
+		/* for KVM_S390_ZPCIOP_REG_AEN */
+		struct {
+			__u64 ibv;      /* Guest addr of interrupt bit vector */
+			__u64 sb;       /* Guest addr of summary bit */
+			__u32 flags;
+			__u32 noi;      /* Number of interrupts */
+			__u8 isc;       /* Guest interrupt subclass */
+			__u8 sbo;       /* Offset of guest summary bit vector */
+			__u16 pad;
+		} reg_aen;
+		__u64 reserved[8];
+	} u;
+};
+
+/* types for kvm_s390_zpci_op->op */
+#define KVM_S390_ZPCIOP_REG_AEN                0
+#define KVM_S390_ZPCIOP_DEREG_AEN      1
+
+/* flags for kvm_s390_zpci_op->u.reg_aen.flags */
+#define KVM_S390_ZPCIOP_REGAEN_HOST    (1 << 0)
+
 #endif /* __LINUX_KVM_H */
-- 
2.37.1

