Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595475A53B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 20:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbiH2SEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 14:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiH2SEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 14:04:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAEB99244
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661796283; x=1693332283;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4DoeZRjdq0CCrb2/BxHHyW/sjuta94LmYgd4rr3eFyU=;
  b=Xalw6ky5EdmE4YdiD6iLmEnTK+0eh7A8Ugr/amtl9Xgc6YvHmqHKmQgM
   Z5L/C0LDuyWwmCA1rT3OYF1YyLWE2zIOehKD4W4MvMd9pCBC0QKnJhb//
   8hPMwqqet4fz325imC8UjtOMrz/oumaRXmJ4XkzfxYBogk785oE1xkbCV
   Z90l7//eRSBM1BoaAwiRNoPFl4CeRR5ZH3xV3FRpnn9SEIueeFST68dDE
   h1G/7wWDb3k85wolwxFYqnbK/n2EF5/Q6AaxlWlRdQGpxs6XTitpAu41Z
   qfUkO5acWnUFR5QyVzbtgZnVELkW1WLvZT+G1JxFC+qk7ze7ORgO+D+6z
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="275364188"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="275364188"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:04:42 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="672476974"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 11:04:42 -0700
From:   Ashok Raj <ashok.raj@intel.com>
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     "LKML Mailing List" <linux-kernel@vger.kernel.org>,
        X86-kernel <x86@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        "Ashok Raj" <ashok.raj@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH] x86/microcode/intel: Allow late loading only if a min rev is specified
Date:   Mon, 29 Aug 2022 18:04:36 +0000
Message-Id: <20220829180436.716672-1-ashok.raj@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general users don't have the necessary information to determine
whether a late loading of a new microcode version has removed any feature
(MSR, CPUID etc) between what is currently loaded and this new microcode.
To address this issue, Intel has added a "minimum required version" field to
a previously reserved field in the file header. Microcode updates
should only be applied if the current microcode version is equal
to, or greater than this minimum required version.

Thomas made some suggestions[1] on how meta-data in the microcode file could
provide Linux with information to decide if the new microcode is suitable
candidate for late loading. But even the "simpler" option#1 requires a lot of
metadata and corresponding kernel code to parse it.

The proposal here is an even simpler option. Simply "OS visible features"
such as CPUID and MSRs are the only two examples. The microcode must not
change these OS visible features because they cause problems after late
loading.

Pseudo code for late loading is as follows:

if header.min_required_id == 0
	This is old format microcode, block late loading
else if current_ucode_version < header.min_required_id
	Current version is too old, block late loading of this microcode.
else
	OK to proceed with late loading.

Any microcode that modifies the interface to an OS-visible feature
will set the min_version to itself. This will enforce this microcode is
not suitable for late loading unless the currently loaded revision is greater
or equal to the new microcode affecting the change.

The enforcement is not in hardware and limited to kernel loader enforcing
the requirement. It is not required for early loading of microcode to
enforce this requirement, since the new features are only
evaluated after early loading in the boot process.


Test cases covered:

1. With new kernel, attempting to load an older format microcode with the
   min_rev=0 should be blocked by kernel.

   [  210.541802] Late loading denied: microcode header does not specify a
   required min version.

2. New microcode with a non-zero min_rev in the header, but the specified
   min_rev is greater than what is currently loaded in the CPU should be
   blocked by kernel.

   245.139828] microcode: Late loading denied: Current revision 0x8f685300 is too old to update, must be at 0xaa000050 version or higher. Use early loading instead.

3. New microcode with a min_rev < currently loaded should allow loading the
   microcode

4. Build initrd with microcode that has min_rev=0, or min_rev > currently
   loaded should permit early loading microcode from initrd.

[1] https://lore.kernel.org/linux-kernel/alpine.DEB.2.21.1909062237580.1902@nanos.tec.linutronix.de/


Tested-by: William Xie <william.xie@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
---

Needs:
	https://lore.kernel.org/lkml/20220825075445.28171-1-bp@alien8.de/

v3: https://lore.kernel.org/lkml/20220817051127.3323755-1-ashok.raj@intel.com/
v2: https://lore.kernel.org/lkml/20220816043754.3258815-1-ashok.raj@intel.com/
v1: https://lore.kernel.org/lkml/20220813223825.3164861-1-ashok.raj@intel.com/

v3->v4:
- Drop the multi-step patch, provide that as a separate series later, since
  we want make more changes to mulit-step handling.
- Boris:
  * Rename fw_refresh as late_loading, don't use print_err as indicator
    for late loading
  * Changed commit and warn messages as suggested.
---
 arch/x86/include/asm/microcode.h       |  2 +-
 arch/x86/include/asm/microcode_intel.h |  4 +++-
 arch/x86/kernel/cpu/microcode/amd.c    |  4 ++--
 arch/x86/kernel/cpu/microcode/intel.c  | 31 +++++++++++++++++++++-----
 4 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/microcode.h b/arch/x86/include/asm/microcode.h
index 7f7800e15ed0..9df733b35912 100644
--- a/arch/x86/include/asm/microcode.h
+++ b/arch/x86/include/asm/microcode.h
@@ -33,7 +33,7 @@ enum ucode_state {
 
 struct microcode_ops {
 	enum ucode_state (*request_microcode_fw) (int cpu, struct device *,
-						  bool refresh_fw);
+						  bool late_loading);
 
 	void (*microcode_fini_cpu) (int cpu);
 
diff --git a/arch/x86/include/asm/microcode_intel.h b/arch/x86/include/asm/microcode_intel.h
index 4c92cea7e4b5..16b8715e0984 100644
--- a/arch/x86/include/asm/microcode_intel.h
+++ b/arch/x86/include/asm/microcode_intel.h
@@ -14,7 +14,9 @@ struct microcode_header_intel {
 	unsigned int            pf;
 	unsigned int            datasize;
 	unsigned int            totalsize;
-	unsigned int            reserved[3];
+	unsigned int            reserved1;
+	unsigned int		min_req_id;
+	unsigned int            reserved3;
 };
 
 struct microcode_intel {
diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 5f38dd75cbc5..c18d3f01a452 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -891,7 +891,7 @@ load_microcode_amd(bool save, u8 family, const u8 *data, size_t size)
  * These might be larger than 2K.
  */
 static enum ucode_state request_microcode_amd(int cpu, struct device *device,
-					      bool refresh_fw)
+					      bool late_loading)
 {
 	char fw_name[36] = "amd-ucode/microcode_amd.bin";
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
@@ -900,7 +900,7 @@ static enum ucode_state request_microcode_amd(int cpu, struct device *device,
 	const struct firmware *fw;
 
 	/* reload ucode container only on the boot cpu */
-	if (!refresh_fw || !bsp)
+	if (!late_loading || !bsp)
 		return UCODE_OK;
 
 	if (c->x86 >= 0x15)
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 1fcbd671f1df..332ba19e0147 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -163,13 +163,14 @@ static void save_microcode_patch(struct ucode_cpu_info *uci, void *data, unsigne
 		intel_ucode_patch = p->data;
 }
 
-static int microcode_sanity_check(void *mc, int print_err)
+static int microcode_sanity_check(void *mc, int print_err, bool late_loading)
 {
 	unsigned long total_size, data_size, ext_table_size;
 	struct microcode_header_intel *mc_header = mc;
 	struct extended_sigtable *ext_header = NULL;
 	u32 sum, orig_sum, ext_sigcount = 0, i;
 	struct extended_signature *ext_sig;
+	struct ucode_cpu_info uci;
 
 	total_size = get_totalsize(mc_header);
 	data_size = get_datasize(mc_header);
@@ -240,6 +241,24 @@ static int microcode_sanity_check(void *mc, int print_err)
 		return -EINVAL;
 	}
 
+
+	/*
+	* Enforce for late-load that min_req_id is specified in the
+	* header. Otherwise its an old format microcode, reject it
+	*/
+	if (late_loading) {
+		if (!mc_header->min_req_id) {
+		       pr_warn("Late loading denied: Microcode header does not specify a required min version\n");
+		       return -EINVAL;
+		}
+		intel_cpu_collect_info(&uci);
+		if (uci.cpu_sig.rev < mc_header->min_req_id) {
+			pr_warn("Late loading denied: Current revision 0x%x too old to update, must be at 0x%x or higher. Use early loading instead\n",
+		       uci.cpu_sig.rev, mc_header->min_req_id);
+		       return -EINVAL;
+		}
+	}
+
 	if (!ext_table_size)
 		return 0;
 
@@ -281,7 +300,7 @@ scan_microcode(void *data, size_t size, struct ucode_cpu_info *uci, bool save)
 		mc_size = get_totalsize(mc_header);
 		if (!mc_size ||
 		    mc_size > size ||
-		    microcode_sanity_check(data, 0) < 0)
+		    microcode_sanity_check(data, 0, false) < 0)
 			break;
 
 		size -= mc_size;
@@ -778,7 +797,7 @@ static enum ucode_state apply_microcode_intel(int cpu)
 	return ret;
 }
 
-static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
+static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter, bool late_loading)
 {
 	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
 	unsigned int curr_mc_size = 0, new_mc_size = 0;
@@ -820,7 +839,7 @@ static enum ucode_state generic_load_microcode(int cpu, struct iov_iter *iter)
 		memcpy(mc, &mc_header, sizeof(mc_header));
 		data = mc + sizeof(mc_header);
 		if (!copy_from_iter_full(data, data_size, iter) ||
-		    microcode_sanity_check(mc, 1) < 0) {
+		    microcode_sanity_check(mc, 1, late_loading) < 0) {
 			break;
 		}
 
@@ -886,7 +905,7 @@ static bool is_blacklisted(unsigned int cpu)
 }
 
 static enum ucode_state request_microcode_fw(int cpu, struct device *device,
-					     bool refresh_fw)
+					     bool late_loading)
 {
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	const struct firmware *firmware;
@@ -909,7 +928,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device,
 	kvec.iov_base = (void *)firmware->data;
 	kvec.iov_len = firmware->size;
 	iov_iter_kvec(&iter, WRITE, &kvec, 1, firmware->size);
-	ret = generic_load_microcode(cpu, &iter);
+	ret = generic_load_microcode(cpu, &iter, late_loading);
 
 	release_firmware(firmware);
 
-- 
2.32.0

