Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89D452C648
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 00:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiERW34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 18:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbiERW3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 18:29:51 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABF521AA8E;
        Wed, 18 May 2022 15:29:49 -0700 (PDT)
Received: from zn.tnic (p200300ea97465796329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5796:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4664F1EC059D;
        Thu, 19 May 2022 00:29:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652912984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QjF5eTDoB3JolDO0/nH9Uu4VezYQC3KLhczT7BAIp2U=;
        b=LUpbe4iWJGrAj2Grqmcgd+MzINRnJji79ToAO9tkTB8dabEPlZu7c3RwX4655+LAIhS9gW
        7ldc8NlFZ6t8N7TOplWRMkGOW7RfLkcChvRXXR2TKfFRTDb3KJjqzeDmc2omY+WUrPN/Is
        8s6fiaMWtDTVFzl2wlicYYUbT+/FETE=
Date:   Thu, 19 May 2022 00:29:39 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
Subject: Re: linux-next: Tree for May 18
 (arch/x86/kernel/cpu/microcode/intel.o)
Message-ID: <YoVzUxSwhoim9TOX@zn.tnic>
References: <20220518202934.730a8aba@canb.auug.org.au>
 <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
 <YoVlwN/IeVXoMaq1@zn.tnic>
 <df5ed1d0-6304-89b8-ad68-0cf6a59d8614@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df5ed1d0-6304-89b8-ad68-0cf6a59d8614@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 02:54:45PM -0700, Randy Dunlap wrote:
> 
> 
> On 5/18/22 14:34, Borislav Petkov wrote:
> > On Wed, May 18, 2022 at 02:05:28PM -0700, Randy Dunlap wrote:
> >> on x86_64:
> >>
> >> CONFIG_PROCESSOR_SELECT=y
> >> # CONFIG_CPU_SUP_INTEL is not set   <<<<<
> >> CONFIG_CPU_SUP_AMD=y
> >> # CONFIG_CPU_SUP_HYGON is not set
> >> CONFIG_CPU_SUP_CENTAUR=y
> >> CONFIG_CPU_SUP_ZHAOXIN=y
> >>
> >> CONFIG_MICROCODE=y
> >> CONFIG_MICROCODE_INTEL=y   <<<<<
> >> CONFIG_MICROCODE_AMD=y
> > 
> > Hmm:
> > 
> > $ grep -E "(PROCESSOR_SELECT|CPU_SUP|MICROCODE)" .config
> > CONFIG_PROCESSOR_SELECT=y
> > # CONFIG_CPU_SUP_INTEL is not set
> > CONFIG_CPU_SUP_AMD=y
> > # CONFIG_CPU_SUP_HYGON is not set
> > CONFIG_CPU_SUP_CENTAUR=y
> > CONFIG_CPU_SUP_ZHAOXIN=y
> > CONFIG_MICROCODE=y
> > CONFIG_MICROCODE_INTEL=y
> > CONFIG_MICROCODE_AMD=y
> > CONFIG_MICROCODE_OLD_INTERFACE=y
> > 
> > that builds fine here on tip/master. Or is it linux-next specific? I'd
> > hope not.
> > 
> > Can you send me your whole .config pls and how exactly you reproduce it,
> > i.e., on which tree?
> 
> This is linux-next-20220518. config file is attached.

Ah, got it, that's the IFS thing which uses microcode loader functions.

I think this below but will do more poking tomorrow on a fresh head.

Thx.

---
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 60e9be91250e..ba1e509d11bb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1321,7 +1321,6 @@ config X86_REBOOTFIXUPS
 config MICROCODE
 	bool "CPU microcode loading support"
 	default y
-	depends on CPU_SUP_AMD || CPU_SUP_INTEL
 	help
 	  If you say Y here, you will be able to update the microcode on
 	  Intel and AMD processors. The Intel support is for the IA32 family,
@@ -1341,7 +1340,7 @@ config MICROCODE
 
 config MICROCODE_INTEL
 	bool "Intel microcode loading support"
-	depends on MICROCODE
+	depends on CPU_SUP_INTEL && MICROCODE
 	default MICROCODE
 	help
 	  This options enables microcode patch loading support for Intel
@@ -1353,7 +1352,7 @@ config MICROCODE_INTEL
 
 config MICROCODE_AMD
 	bool "AMD microcode loading support"
-	depends on MICROCODE
+	depends on CPU_SUP_AMD && MICROCODE
 	help
 	  If you select this option, microcode patch loading support for AMD
 	  processors will be enabled.
diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
index d84491cfb0db..aaaa5503951d 100644
--- a/drivers/platform/x86/intel/ifs/Kconfig
+++ b/drivers/platform/x86/intel/ifs/Kconfig
@@ -1,6 +1,6 @@
 config INTEL_IFS
 	tristate "Intel In Field Scan"
-	depends on X86 && 64BIT && SMP
+	depends on CPU_SUP_INTEL && 64BIT && SMP
 	select INTEL_IFS_DEVICE
 	help
 	  Enable support for the In Field Scan capability in select


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
