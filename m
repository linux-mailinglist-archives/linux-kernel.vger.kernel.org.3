Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA7F4C7BF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiB1V3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiB1V33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:29:29 -0500
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7C212F16A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:28:49 -0800 (PST)
Received: (wp-smtpd smtp.tlen.pl 37613 invoked from network); 28 Feb 2022 22:28:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=1024a;
          t=1646083727; bh=wOQap3kjDZao23By2HQk+Vp02aERr8ev+5YsvdfIw8Q=;
          h=From:To:Cc:Subject;
          b=agmSIsTUenZsM6HowvVcDC2Lp46N29wbdkkmxxfQT5ueVdtKPo0QwmFXmK4EglvCz
           CPfafTcGRhS42+uWaUFrFa/eCnJgmDxMfVQcx6vPNHWOUaTtya5gkq4W6X+fa+0ooj
           OyVCsGibUrfoWgf25wVEK1ejnMNMuoCr13OhdABY=
Received: from aafa139.neoplus.adsl.tpnet.pl (HELO localhost.localdomain) (mat.jonczyk@o2.pl@[83.4.130.139])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <linux-kernel@vger.kernel.org>; 28 Feb 2022 22:28:46 +0100
From:   =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 01/10] x86/Kconfig: enable X86_X2APIC by default and improve help text
Date:   Mon, 28 Feb 2022 22:28:17 +0100
Message-Id: <20220228212826.27080-2-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228212826.27080-1-mat.jonczyk@o2.pl>
References: <20220228212826.27080-1-mat.jonczyk@o2.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-WP-MailID: 37a90506aca53024aafda06b8c982270
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000001 [AUJy]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As many current platforms (most modern Intel CPUs and QEMU) have x2APIC
present, enable CONFIG_X86_X2APIC by default as it gives performance
and functionality benefits. Additionally, if the BIOS has already
switched APIC to x2APIC mode, but CONFIG_X86_X2APIC is disabled, the
kernel will panic in arch/x86/kernel/apic/apic.c .

Also improve the help text, which was confusing and really did not
describe what the feature is about.

Help text references and discussion:

Both Intel [1] and AMD [3] spell the name as "x2APIC", not "x2apic".

"It allows faster access to the local APIC"
        [2], chapter 2.1, page 15:
        "More efficient MSR interface to access APIC registers."

"x2APIC was introduced in Intel CPUs around 2008":
        I was unable to find specific information which Intel CPUs
        support x2APIC. Wikipedia claims it was "introduced with the
        Nehalem microarchitecture in November 2008", but I was not able
        to confirm this independently. At least some Nehalem CPUs do not
        support x2APIC [1].

        The documentation [2] is dated June 2008. Linux kernel also
        introduced x2APIC support in 2008, so the year seems to be
        right.

"and in AMD EPYC CPUs in 2019":
        [3], page 15:
        "AMD introduced an x2APIC in our EPYC 7002 Series processors for
        the first time."

"It is also frequently emulated in virtual machines, even when the host
CPU does not support it."
        [1]

"If this configuration option is disabled, the kernel will not boot on
some platforms that have x2APIC enabled."
        According to some BIOS documentation [4], the x2APIC may be
        "disabled", "enabled", or "force enabled" on this system.
        I think that "enabled" means "made available to the operating
        system, but not already turned on" and "force enabled" means
        "already switched to x2APIC mode when the OS boots". Only in the
        latter mode a kernel without CONFIG_X86_X2APIC will panic in
        validate_x2apic() in arch/x86/kernel/apic/apic.c .

        QEMU 4.2.1 and my HP laptop (bought in 2019) use the "enabled"
        mode and the kernel does not panic.

[1] "Re: [Qemu-devel] [Question] why x2apic's set by default without host sup"
        https://lists.gnu.org/archive/html/qemu-devel/2013-07/msg03527.html

[2] Intel® 64 Architecture x2APIC Specification,
        ( https://www.naic.edu/~phil/software/intel/318148.pdf )

[3] Workload Tuning Guide for AMD EPYC ™ 7002 Series Processor Based
        Servers Application Note,
        https://developer.amd.com/wp-content/resources/56745_0.80.pdf

[4] UEFI System Utilities and Shell Command Mobile Help for HPE ProLiant
        Gen10, ProLiant Gen10 Plus Servers and HPE Synergy:
        Enabling or disabling Processor x2APIC Support
        https://techlibrary.hpe.com/docs/iss/proliant-gen10-uefi/s_enable_disable_x2APIC_support.html

Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Yinghai Lu <yinghai@kernel.org>
---
 arch/x86/Kconfig | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..64d760a2b81a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -437,15 +437,27 @@ config X86_FEATURE_NAMES
 	  If in doubt, say Y.
 
 config X86_X2APIC
-	bool "Support x2apic"
+	bool "Support CPUs with x2APIC interrupt controllers"
 	depends on X86_LOCAL_APIC && X86_64 && (IRQ_REMAP || HYPERVISOR_GUEST)
+	default y
 	help
-	  This enables x2apic support on CPUs that have this feature.
+	  x2APIC is an interrupt controller architecture, a component of which
+	  (the local APIC) is present in the CPU. It allows faster access to
+	  the local APIC and supports a larger number of CPUs in the system
+	  then the predecessors.
 
-	  This allows 32-bit apic IDs (so it can support very large systems),
-	  and accesses the local apic via MSRs not via mmio.
+	  x2APIC was introduced in Intel CPUs around 2008 and in AMD EPYC CPUs
+	  in 2019, but it can be disabled by the BIOS. It is also frequently
+	  emulated in virtual machines, even when the host CPU does not support
+	  it. Support in the CPU be checked by executing
+		cat /proc/cpuinfo | grep x2apic
 
-	  If you don't know what to do here, say N.
+	  If this configuration option is disabled, the kernel will not boot on
+	  some platforms that have x2APIC enabled.
+
+	  Say N if you know that your platform does not have x2APIC.
+
+	  Otherwise, say Y.
 
 config X86_MPPARSE
 	bool "Enable MPS table" if ACPI
-- 
2.25.1

