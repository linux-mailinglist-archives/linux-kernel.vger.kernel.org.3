Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641825B11C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 03:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIHBDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 21:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiIHBDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 21:03:32 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7FDC2F82
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 18:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662599011; x=1694135011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=26/imFb4csvZ9bWbHVMwcbyUMlLP50BKdvRpDIg2LU4=;
  b=miNINWJcXH/nJY0k6UV1U8H+rhdalyRtrjIolvWx311ViKur4gVW3Roe
   QfPN5SnafpzVbsAKXuAjH0+lv7KI0AhL0lmBCmPAcGmPQZXuYckmeQayX
   cr3tNJf1W0W5oU3NEnuci8JzYKU+hKbVZXs/hsmZ6oQ9KpODafUkLGEMV
   2ea/gcvOTYrf8j+qYKJO3VXlCxKSehEKz2ZD5j6dMN7LWRv8Sqevg6wcG
   /Sa6T8sszA82a7iR10I6CGo+P4WZM7qMYu3RpRVT2NhVObh/BNfxzZnsr
   X1ihA0Ojz7GhYPKlV9yQBnFyvRb1T6Mv7dU84zgxOB71agIKhz+L22X8V
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="280064706"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="280064706"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 18:03:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="591943895"
Received: from arashsob-mobl.amr.corp.intel.com (HELO desk) ([10.209.110.101])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 18:03:30 -0700
Date:   Wed, 7 Sep 2022 18:03:29 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Andrew Cooper <Andrew.Cooper3@citrix.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Message-ID: <20220908010329.rhetlp6plqlaiegf@desk>
References: <20220906201743.436091-1-hdegoede@redhat.com>
 <YxexAl+i+6MGjf7K@hirez.programming.kicks-ass.net>
 <6ff23930-325b-4207-12fc-4d8fd5bea1ff@redhat.com>
 <Yxe09Bk7tNwa6OsO@hirez.programming.kicks-ass.net>
 <c076b593-815b-f7b2-4eab-9d2087580a71@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c076b593-815b-f7b2-4eab-9d2087580a71@citrix.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:00:08PM +0000, Andrew Cooper wrote:
> On 06/09/2022 22:00, Peter Zijlstra wrote:
> > On Tue, Sep 06, 2022 at 10:56:47PM +0200, Hans de Goede wrote:
> >> Hi,
> >>
> >> On 9/6/22 22:43, Peter Zijlstra wrote:
> >>> On Tue, Sep 06, 2022 at 10:17:43PM +0200, Hans de Goede wrote:
> >>>> On an Intel Atom N2600 (and presumable other Cedar Trail models)
> >>>> MSR_IA32_TSX_CTRL can be read, causing saved_msr.valid to be set for it
> >>>> by msr_build_context().
> >>>>
> >>>> This causes restore_processor_state() to try and restore it, but writing
> >>>> this MSR is not allowed on the Intel Atom N2600 leading to:
> >>> FWIW, virt tends to do this same thing a lot. They'll allow reading
> >>> random MSRs and only fail on write.
> >> Right. So I guess I should send a v2 with an updated commit
> >> message mentioning this ?
> > Nah, just saying this is a somewhat common pattern with MSRs.
> >
> > The best ones are the one where writing the value read is invalid :/ or
> > those who also silently eat a 0 write just for giggles. Luckily that
> > doesn't happen often.
> 
> Several comments.  First of all, MSR_TSX_CTRL is a fully read/write
> MSR.  If virt is doing this wrong, fix the hypervisor.  But this doesn't
> look virt related?
> 
> More importantly, MSR_TSX_CTRL does not plausibly exist on an Atom
> N2600, as it is more than a decade old.
> 
> MSR_TSX_CTRL was retrofitted in microcode to the MDS_NO, TAA-vulnerable
> CPUs which is a very narrow range from about 1 quarter of 2019 which
> includes Cascade Lake, and then included architecturally on subsequent
> parts which support TSX.
> 
> pm_save_spec_msr() is totally broken.  It's poking MSRs blindly without
> checking the enumeration of the capability first.

pm_save_spec_msr() relies on valid-msr-check in build_msr_context(), but
obviously it is not working in this particular case.

Does adding the enumeration check as below looks okay:

(I am not sure if I got the enumeration right for MSR_AMD64_LS_CFG).

---
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index 8cbf623f0ecf..a750c1a1964b 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -76,6 +76,8 @@ static inline void init_ia32_feat_ctl(struct cpuinfo_x86 *c) {}
 
 extern __noendbr void cet_disable(void);
 
+extern bool spec_msr_valid(u32 msr_id);
+
 struct ucode_cpu_info;
 
 int intel_cpu_collect_info(struct ucode_cpu_info *uci);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 3e508f239098..7430a36fd7ae 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1278,6 +1278,26 @@ static bool __init cpu_matches(const struct x86_cpu_id *table, unsigned long whi
 	return m && !!(m->driver_data & which);
 }
 
+bool spec_msr_valid(u32 msr_id)
+{
+	u64 ia32_cap = x86_read_arch_cap_msr();
+
+	switch (msr_id) {
+	case MSR_IA32_SPEC_CTRL:
+		return boot_cpu_has(X86_FEATURE_MSR_SPEC_CTRL);
+	case MSR_IA32_TSX_CTRL:
+		return !!(ia32_cap & ARCH_CAP_TSX_CTRL_MSR);
+	case MSR_TSX_FORCE_ABORT:
+		return boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT);
+	case MSR_IA32_MCU_OPT_CTRL:
+		return boot_cpu_has(X86_FEATURE_SRBDS_CTRL);
+	case MSR_AMD64_LS_CFG:
+		return boot_cpu_has(X86_FEATURE_LS_CFG_SSBD);
+	}
+
+	return false;
+}
+
 u64 x86_read_arch_cap_msr(void)
 {
 	u64 ia32_cap = 0;
diff --git a/arch/x86/power/cpu.c b/arch/x86/power/cpu.c
index bb176c72891c..8db73f7982c7 100644
--- a/arch/x86/power/cpu.c
+++ b/arch/x86/power/cpu.c
@@ -520,8 +520,12 @@ static void pm_save_spec_msr(void)
 		MSR_IA32_MCU_OPT_CTRL,
 		MSR_AMD64_LS_CFG,
 	};
+	int i;
 
-	msr_build_context(spec_msr_id, ARRAY_SIZE(spec_msr_id));
+	for (i=0; i < ARRAY_SIZE(spec_msr_id); i++) {
+		if (spec_msr_valid(spec_msr_id[i]))
+			msr_build_context(&spec_msr_id[i], 1);
+	}
 }
 
 static int pm_check_save_msr(void)
