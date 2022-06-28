Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF155EADA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 19:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiF1RUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 13:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiF1RUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:20:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F378F35DC4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 10:20:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96F83B81F25
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 17:20:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E93F4C3411D;
        Tue, 28 Jun 2022 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656436809;
        bh=IWPu/mbDHuvX3ssxm2ioQx8WcNEoVyZekuDu6HM4RcU=;
        h=Date:From:To:Cc:Subject:From;
        b=o05Z7QiMqh3punNiYgVfjdOsDT2Y5n58GDllURvrXXJPqBHRVw3gCukjlhR7ukZlU
         8odidqymKyq53Fu4mauPwC5VvixSvbsyFHa5srOp6EbhSsVLJUng0rhjPO4L91ei0e
         FUIPc++jiljPezeqPRSx6+ApkafC99qlsdyRCSvZYioiScZT/ZlrbweZ2uLGf3iAaa
         UOVx3fRSGUq26a8s1mA3vTZtvDithjJyP2KniOfWgrhbm/dnJ53s9VvrP4dt4sOORW
         ZLkFtZuw6ZptP4uk9GCFei3Mx5Lb90MLu/n2abcuhwq2k3iKaWilo6JNYF4grWLcKE
         MsRuFzPehGzsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4E7484096F; Tue, 28 Jun 2022 14:20:04 -0300 (-03)
Date:   Tue, 28 Jun 2022 14:20:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Joao Martins <joao.m.martins@oracle.com>,
        Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 FYI] tools headers UAPI: Sync linux/kvm.h with the kernel
 sources
Message-ID: <Yrs4RE+qfgTaWdAt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used not to be copies, with tools/ code using kernel headers
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

  bfbab44568779e16 ("KVM: arm64: Implement PSCI SYSTEM_SUSPEND")
  7b33a09d036ffd9a ("KVM: arm64: Add support for userspace to suspend a vCPU")
  ffbb61d09fc56c85 ("KVM: x86: Accept KVM_[GS]ET_TSC_KHZ as a VM ioctl.")
  661a20fab7d156cf ("KVM: x86/xen: Advertise and document KVM_XEN_HVM_CONFIG_EVTCHN_SEND")
  fde0451be8fb3208 ("KVM: x86/xen: Support per-vCPU event channel upcall via local APIC")
  28d1629f751c4a5f ("KVM: x86/xen: Kernel acceleration for XENVER_version")
  536395260582be74 ("KVM: x86/xen: handle PV timers oneshot mode")
  942c2490c23f2800 ("KVM: x86/xen: Add KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID")
  2fd6df2f2b47d430 ("KVM: x86/xen: intercept EVTCHNOP_send from guests")
  35025735a79eaa89 ("KVM: x86/xen: Support direct injection of event channel events")

That automatically adds support for this new ioctl:

  $ tools/perf/trace/beauty/kvm_ioctl.sh > before
  $ cp include/uapi/linux/kvm.h tools/include/uapi/linux/kvm.h
  $ tools/perf/trace/beauty/kvm_ioctl.sh > after
  $ diff -u before after
  --- before	2022-06-28 12:13:07.281150509 -0300
  +++ after	2022-06-28 12:13:16.423392896 -0300
  @@ -98,6 +98,7 @@
   	[0xcc] = "GET_SREGS2",
   	[0xcd] = "SET_SREGS2",
   	[0xce] = "GET_STATS_FD",
  +	[0xd0] = "XEN_HVM_EVTCHN_SEND",
   	[0xe0] = "CREATE_DEVICE",
   	[0xe1] = "SET_DEVICE_ATTR",
   	[0xe2] = "GET_DEVICE_ATTR",
  $

This silences these perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/kvm.h' differs from latest version at 'include/uapi/linux/kvm.h'
  diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Joao Martins <joao.m.martins@oracle.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Oliver Upton <oupton@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/kvm.h | 54 ++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 6a184d260c7f2e17..5088bd9f1922851f 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -444,6 +444,9 @@ struct kvm_run {
 #define KVM_SYSTEM_EVENT_SHUTDOWN       1
 #define KVM_SYSTEM_EVENT_RESET          2
 #define KVM_SYSTEM_EVENT_CRASH          3
+#define KVM_SYSTEM_EVENT_WAKEUP         4
+#define KVM_SYSTEM_EVENT_SUSPEND        5
+#define KVM_SYSTEM_EVENT_SEV_TERM       6
 			__u32 type;
 			__u32 ndata;
 			union {
@@ -646,6 +649,7 @@ struct kvm_vapic_addr {
 #define KVM_MP_STATE_OPERATING         7
 #define KVM_MP_STATE_LOAD              8
 #define KVM_MP_STATE_AP_RESET_HOLD     9
+#define KVM_MP_STATE_SUSPENDED         10
 
 struct kvm_mp_state {
 	__u32 mp_state;
@@ -1150,8 +1154,9 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_S390_MEM_OP_EXTENSION 211
 #define KVM_CAP_PMU_CAPABILITY 212
 #define KVM_CAP_DISABLE_QUIRKS2 213
-/* #define KVM_CAP_VM_TSC_CONTROL 214 */
+#define KVM_CAP_VM_TSC_CONTROL 214
 #define KVM_CAP_SYSTEM_EVENT_DATA 215
+#define KVM_CAP_ARM_SYSTEM_SUSPEND 216
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
@@ -1240,6 +1245,7 @@ struct kvm_x86_mce {
 #define KVM_XEN_HVM_CONFIG_SHARED_INFO		(1 << 2)
 #define KVM_XEN_HVM_CONFIG_RUNSTATE		(1 << 3)
 #define KVM_XEN_HVM_CONFIG_EVTCHN_2LEVEL	(1 << 4)
+#define KVM_XEN_HVM_CONFIG_EVTCHN_SEND		(1 << 5)
 
 struct kvm_xen_hvm_config {
 	__u32 flags;
@@ -1478,7 +1484,8 @@ struct kvm_s390_ucas_mapping {
 #define KVM_SET_PIT2              _IOW(KVMIO,  0xa0, struct kvm_pit_state2)
 /* Available with KVM_CAP_PPC_GET_PVINFO */
 #define KVM_PPC_GET_PVINFO	  _IOW(KVMIO,  0xa1, struct kvm_ppc_pvinfo)
-/* Available with KVM_CAP_TSC_CONTROL */
+/* Available with KVM_CAP_TSC_CONTROL for a vCPU, or with
+*  KVM_CAP_VM_TSC_CONTROL to set defaults for a VM */
 #define KVM_SET_TSC_KHZ           _IO(KVMIO,  0xa2)
 #define KVM_GET_TSC_KHZ           _IO(KVMIO,  0xa3)
 /* Available with KVM_CAP_PCI_2_3 */
@@ -1694,6 +1701,32 @@ struct kvm_xen_hvm_attr {
 		struct {
 			__u64 gfn;
 		} shared_info;
+		struct {
+			__u32 send_port;
+			__u32 type; /* EVTCHNSTAT_ipi / EVTCHNSTAT_interdomain */
+			__u32 flags;
+#define KVM_XEN_EVTCHN_DEASSIGN		(1 << 0)
+#define KVM_XEN_EVTCHN_UPDATE		(1 << 1)
+#define KVM_XEN_EVTCHN_RESET		(1 << 2)
+			/*
+			 * Events sent by the guest are either looped back to
+			 * the guest itself (potentially on a different port#)
+			 * or signalled via an eventfd.
+			 */
+			union {
+				struct {
+					__u32 port;
+					__u32 vcpu;
+					__u32 priority;
+				} port;
+				struct {
+					__u32 port; /* Zero for eventfd */
+					__s32 fd;
+				} eventfd;
+				__u32 padding[4];
+			} deliver;
+		} evtchn;
+		__u32 xen_version;
 		__u64 pad[8];
 	} u;
 };
@@ -1702,11 +1735,17 @@ struct kvm_xen_hvm_attr {
 #define KVM_XEN_ATTR_TYPE_LONG_MODE		0x0
 #define KVM_XEN_ATTR_TYPE_SHARED_INFO		0x1
 #define KVM_XEN_ATTR_TYPE_UPCALL_VECTOR		0x2
+/* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_EVTCHN_SEND */
+#define KVM_XEN_ATTR_TYPE_EVTCHN		0x3
+#define KVM_XEN_ATTR_TYPE_XEN_VERSION		0x4
 
 /* Per-vCPU Xen attributes */
 #define KVM_XEN_VCPU_GET_ATTR	_IOWR(KVMIO, 0xca, struct kvm_xen_vcpu_attr)
 #define KVM_XEN_VCPU_SET_ATTR	_IOW(KVMIO,  0xcb, struct kvm_xen_vcpu_attr)
 
+/* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_EVTCHN_SEND */
+#define KVM_XEN_HVM_EVTCHN_SEND	_IOW(KVMIO,  0xd0, struct kvm_irq_routing_xen_evtchn)
+
 #define KVM_GET_SREGS2             _IOR(KVMIO,  0xcc, struct kvm_sregs2)
 #define KVM_SET_SREGS2             _IOW(KVMIO,  0xcd, struct kvm_sregs2)
 
@@ -1724,6 +1763,13 @@ struct kvm_xen_vcpu_attr {
 			__u64 time_blocked;
 			__u64 time_offline;
 		} runstate;
+		__u32 vcpu_id;
+		struct {
+			__u32 port;
+			__u32 priority;
+			__u64 expires_ns;
+		} timer;
+		__u8 vector;
 	} u;
 };
 
@@ -1734,6 +1780,10 @@ struct kvm_xen_vcpu_attr {
 #define KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_CURRENT	0x3
 #define KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_DATA	0x4
 #define KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST	0x5
+/* Available with KVM_CAP_XEN_HVM / KVM_XEN_HVM_CONFIG_EVTCHN_SEND */
+#define KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID		0x6
+#define KVM_XEN_VCPU_ATTR_TYPE_TIMER		0x7
+#define KVM_XEN_VCPU_ATTR_TYPE_UPCALL_VECTOR	0x8
 
 /* Secure Encrypted Virtualization command */
 enum sev_cmd_id {
-- 
2.36.1

