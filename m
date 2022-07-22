Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2DD57E249
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiGVN03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiGVN01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:26:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DA85F996;
        Fri, 22 Jul 2022 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658496386; x=1690032386;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=gL17W1lezZEuItWt/uQj/CQrhmFMClKJKozgU/0ZPjI=;
  b=Miq+JNsh6k9szRTBVMfHabRsh2YhK0gIm8JvT+55XOgHqWBQa7DDoYmf
   ifoP2jPqGvXiBplVd8ItNBB36jTjiczh87A/ljNw/kPb1VH/ckNE+3sv1
   3DRT0YQ+HK004wjYr9nemCRAmzgEfOqt3rv+r9AyDyQtxAuB64o9DUejv
   Bnb7Fsedu/pZjYbp9hiP7zuHCcpXr8uzONBAXt3QyaVrL1X3bTrjKRC5B
   rPA7RtYXvATZsKFhPJX63gpqsx0W8pMSFPFKtyqBjQFD7nmLzo2UcbJlM
   UmGXzVp3r7jCOi+oV0BqD4os+MCdsc2Gy5TbgRIBBOUfIKG1x9NFa6fYx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="288482931"
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="288482931"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 06:26:26 -0700
X-IronPort-AV: E=Sophos;i="5.93,185,1654585200"; 
   d="scan'208";a="626560798"
Received: from lfhuarte-mobl1.amr.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.209.148.120])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 06:26:23 -0700
Message-ID: <ab467244dd03b5f94bafe9068b1c02790033c18c.camel@intel.com>
Subject: Re: [PATCH] [v2] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
From:   Kai Huang <kai.huang@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>, dave@sr71.net
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Haitao Huang <haitao.huang@linux.intel.com>, x86@kernel.org,
        linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 23 Jul 2022 01:26:21 +1200
In-Reply-To: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
References: <20220720191347.1343986-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-20 at 12:13 -0700, Dave Hansen wrote:
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1022,9 +1022,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_=
array *array, u32 function)
> =C2=A0		 * userspace.=C2=A0 ATTRIBUTES.XFRM is not adjusted as userspace =
is
> =C2=A0		 * expected to derive it from supported XCR0.
> =C2=A0		 */
> -		entry->eax &=3D SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SGX_ATTR_PROVISIONKEY | SGX_ATTR_EINIT=
TOKENKEY |
> -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SGX_ATTR_KSS;
> +		entry->eax &=3D SGX_ATTR_PRIV_MASK | SGX_ATTR_UNPRIV_MASK;
> =C2=A0		entry->ebx &=3D 0;
> =C2=A0		break;
> =C2=A0	/* Intel PT */
> --
> 2.34.1

Did a quick look at the spec.  It appears ENCLU[EDECCSSA] should be used
together with AEX-notify.  So besides advertising the new
SGX_ATTR_ASYNC_EXIT_NOTIFY bit to the KVM guest, I think we should also
advertise the ENCLU[EDECCSSA] support in guest's CPUID, like below (unteste=
d)?

diff --git a/arch/x86/include/asm/cpufeatures.h
b/arch/x86/include/asm/cpufeatures.h
index 6466a58b9cff..d2ebb38b31e7 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -296,6 +296,7 @@
 #define X86_FEATURE_PER_THREAD_MBA     (11*32+ 7) /* "" Per-thread Memory
Bandwidth Allocation */
 #define X86_FEATURE_SGX1               (11*32+ 8) /* "" Basic SGX */
 #define X86_FEATURE_SGX2               (11*32+ 9) /* "" SGX Enclave Dynami=
c
Memory Management (EDMM) */
+#define X86_FEATURE_SGX_EDECCSSA       (11*32+10) /* "" SGX EDECCSSA user =
leaf
function */
=20
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
 #define X86_FEATURE_AVX_VNNI           (12*32+ 4) /* AVX VNNI instructions=
 */
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index d47222ab8e6e..121456653417 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -612,7 +612,7 @@ void kvm_set_cpu_caps(void)
        );
=20
        kvm_cpu_cap_init_scattered(CPUID_12_EAX,
-               SF(SGX1) | SF(SGX2)
+               SF(SGX1) | SF(SGX2) | SF(SGX_EDECCSSA)
        );
=20
        kvm_cpu_cap_mask(CPUID_8000_0001_ECX,
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index a19d473d0184..4e5b8444f161 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -23,6 +23,7 @@ enum kvm_only_cpuid_leafs {
 /* Intel-defined SGX sub-features, CPUID level 0x12 (EAX). */
 #define KVM_X86_FEATURE_SGX1           KVM_X86_FEATURE(CPUID_12_EAX, 0)
 #define KVM_X86_FEATURE_SGX2           KVM_X86_FEATURE(CPUID_12_EAX, 1)
+#define KVM_X86_FEATURE_SGX_EDECCSSA   KVM_X86_FEATURE(CPUID_12_EAX, 11)
=20
 struct cpuid_reg {
        u32 function;
@@ -78,6 +79,8 @@ static __always_inline u32 __feature_translate(int
x86_feature)
                return KVM_X86_FEATURE_SGX1;
        else if (x86_feature =3D=3D X86_FEATURE_SGX2)
                return KVM_X86_FEATURE_SGX2;
+       else if (x86_feature =3D=3D X86_FEATURE_SGX_EDECCSSA)
+               return KVM_X86_FEATURE_SGX_EDECCSSA;
=20
        return x86_feature;
 }

