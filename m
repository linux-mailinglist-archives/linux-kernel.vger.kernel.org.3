Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39D47570EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbiGLAMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiGLAMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:12:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA34BD3F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657584771; x=1689120771;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=YuH8/YBGwIq8IpsqFu1LOMl4GhE0Yy4f4oxCQEBiApo=;
  b=hynR/5M5i/rpMRUXZykj6J3GcxclwB02gOc6NY2k4LbNrawn+uyujDLJ
   IObFJROqzGGd6i5djKwIiDdKWI5GkB66uiW8L+twUfgnk44L/4Blq+wTH
   aa74Hp0/1Se2I12liMnfJ2Z/swosyr+k46DHSO/tgvm1U+Etd9OQ1hHD4
   FKKrTa18s8BFw/eV9K8W7YczVUl6/s59zWlvb81fQ65ZnHoa2UzyKgi+C
   iiRc2xFnHN0G7r7etbMZVlQDKHqBHW3cmVrlSK9t1p5Y5w53wqym2XrZc
   8XgBHOjP2fBAUj9nmYBCWMMv8dsCsHqwQurAsNCJITQAGHFjG5fZGVA7f
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="282352738"
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="282352738"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:12:51 -0700
X-IronPort-AV: E=Sophos;i="5.92,264,1650956400"; 
   d="scan'208";a="599205589"
Received: from slang2-mobl.gar.corp.intel.com (HELO khuang2-desk.gar.corp.intel.com) ([10.212.98.19])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 17:12:48 -0700
Message-ID: <ba321fad38d5f96a240f1e88a11943cea16bb4dd.camel@intel.com>
Subject: Re: [PATCH v2] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
From:   Kai Huang <kai.huang@intel.com>
To:     Sean Christopherson <seanjc@google.com>,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, kirill.shutemov@linux.intel.com,
        daniel.gutson@eclypsium.com, hughsient@gmail.com,
        alex.bazhaniuk@eclypsium.com
Date:   Tue, 12 Jul 2022 12:12:46 +1200
In-Reply-To: <YsxZKGxVUY61zPEt@google.com>
References: <20220704142250.1512726-1-martin.fernandez@eclypsium.com>
         <8d2a3175be8a3aff1d3fc535dd9ab6217cfe1e66.camel@intel.com>
         <CAKgze5azQG1mnOASbpcrs9jTejdXGkXYmezz9bTKuWQoZp5EFg@mail.gmail.com>
         <YsxZKGxVUY61zPEt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-11 at 17:08 +0000, Sean Christopherson wrote:
> On Tue, Jul 05, 2022, Martin Fernandez wrote:
> > On 7/5/22, Kai Huang <kai.huang@intel.com> wrote:
> > > On Mon, 2022-07-04 at 11:22 -0300, Martin Fernandez wrote:
> > > > Changelog since v1
> > > >=20
> > > > Clear the flag not only for BSP but for every cpu in the system.
>=20
> ...
>=20
> > > > ---
> > > >  arch/x86/kernel/cpu/intel.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/inte=
l.c
> > > > index fd5dead8371c..17f23e23f911 100644
> > > > --- a/arch/x86/kernel/cpu/intel.c
> > > > +++ b/arch/x86/kernel/cpu/intel.c
> > > > @@ -570,6 +570,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
> > > >=20
> > > >  	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
> > > > !TME_ACTIVATE_ENABLED(tme_activate)) {
> > > >  		pr_info_once("x86/tme: not enabled by BIOS\n");
> > > > +		clear_cpu_cap(c, X86_FEATURE_TME);
>=20
> This misses the case where the TME_ACTIVATE_KEYID_BITS() is zero.  AFAICT=
, that's
> allowed, i.e. won't #GP on WRMSR.  TME_ACTIVATE_KEYID_BITS() can't be non=
-zero if
> TME_ACTIVATE_ENABLED() is false, but the reverse is allowed.

But this logic applies to "whether MKTME is enabled",  but not "TME is enab=
led",
right?

If either LOCKED or ENABLED bit isn't set, then TME is not enabled.  My
understanding is this particular patch is trying to fix the issue that TME =
flag
isn't cleared when TME is disabled by BIOS.

>=20
> > > >  		mktme_status =3D MKTME_DISABLED;
> > > >  		return;
> > >=20
> > > This code change itself looks good to me.
> > >=20
> > > But, TME actually supports bypassing TME encryption/decryption by set=
ting 1
> > > to bit 31 to IA32_TME_ACTIVATE MSR.  See 'Table 4-2 IA32_TME_ACTIVATE=
 MSR'
> > > in MKTME spec below:
> > >=20
> > > https://edc.intel.com/content/www/us/en/design/ipla/software-developm=
ent-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-cor=
e-processors-datasheet-volume-1-of-2/002/intel-multi-key-total-memory-encry=
ption/
> > >=20
> > > When bit 31 is set, the TME is bypassed (no encryption/decryption for=
 KeyID 0).
> > >=20
> > > So looks userspace also needs to check this if it wants to truly chec=
k
> > > whether "TME memory encryption" is active.
> > >=20
> > > But perhaps it's arguable whether we can also clear TME flag in this =
case.
> >=20
> > Yep, that's what I thought.
>=20
> IMO, this entire function needs to be reworked to have a cohesive strateg=
y for
> enumerting TME; not just enumerating to userspace, but internal to the ke=
rnel as
> well.
>=20
> E.g. forcing "mktme_status =3D MKTME_DISABLED" on an AP is nonsensical.  =
If an AP's
> basic MKTME enabling doesn't align with the BSP (activate, algorithm, and=
 keyid0
> bypass settings match), then there's no way an AP is going to reach detec=
t_tme().
> Any discrepancy in encryption for keyid0 will cause the AP will read garb=
age on
> wakeup, and barring a miracle, will triple fault and never call in.
>=20
> Conversely, if basic enabling matches but something else mismatches, e.g.=
 an AP
> was configured with fewer keys, then forcing "mktme_status =3D MKTME_DISA=
BLED" may
> be misleading as MKTME may be fully enabled and in use for keyid0, it jus=
t won't
> be used for keyid!=3D0.  But that's a moot point because as is, the kerne=
l _never_
> uses keyid!=3D0.
>=20
> And this code is also bogus.  Just because the kernel doesn't know the en=
cryption
> algorithm doesn't magically turn off encryption for keyid0.  Again, mktme=
_status
> confuses "memory is encrypted" with "MKTME is theoretically usable for ke=
yid!=3D0".
>=20
> 	tme_crypto_algs =3D TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
> 	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
> 		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n"=
,
> 				tme_crypto_algs);
> 		mktme_status =3D MKTME_DISABLED;
> 	}
>=20
> The mktme_status variable seems completely pointless.  It's not used anyw=
here
> except to detect that CPU0 vs. APs.

I think your above saying makes sense, but this is a different topic and sh=
ould
be in a separate patch IMHO.

This patch basically tries to fix the issue that TME flag isn't cleared whe=
n TME
is disabled by BIOS.  And fir this purpose, the code change in this patch l=
ooks
reasonable to me.  Unless I am mistaken, detect_tme() will be called for al=
l
cpus if TME is supported in CPUID but isn't enabled by BIOS (either LOCKED =
or
ENABLED bit isn't set).

>=20
>=20
> Something like this seems like a sane approach.
>=20
> ---
>=20
> #define MSR_IA32_TME_ACTIVATE		0x982
>=20
> /* Helpers to access TME_ACTIVATE MSR */
> #define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
> #define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
>=20
> #define TME_ACTIVATE_KEYID0_BYPASS(x)	(x & BIT(31))
>=20
> #define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
> #define TME_ACTIVATE_POLICY_AES_XTS_128	0
>=20
> #define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */
>=20
> #define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
> #define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
>=20
> static int tme_keyid_bits_cpu0 =3D -1;
> static u64 tme_activate_cpu0;
>=20
> static void detect_tme(struct cpuinfo_x86 *c)
> {
> 	u64 tme_activate, tme_policy, tme_crypto_algs;
>=20
> 	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
>=20
> 	if (tme_keyid_bits_cpu0 >=3D 0) {
> 		/* Broken BIOS? */
> 		if (tme_activate !=3D tme_activate_cpu0)
> 			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");
>=20
> 		/*
> 		 * Proceed, stolen keyid bits still needed to be excluded from
> 		 * x86_phys_bits.  The divergence is all but guaranteed to be
> 		 * benign, else this CPU would have died during bringup.
> 		 */
> 		goto adjust_phys_bits;
> 	}
>=20
> 	tme_activate_cpu0 =3D tme_activate;
>=20
> 	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
> 	    !TME_ACTIVATE_ENABLED(tme_activate))
> 		tme_keyid_bits_cpu0 =3D 0;
> 	else
> 		tme_keyid_bits_cpu0 =3D TME_ACTIVATE_KEYID_BITS(tme_activate);
>=20
> 	if (!tme_keyid_bits_cpu0) {
> 		pr_info("x86/tme: not enabled by BIOS\n");
> 		setup_clear_cpu_cap(X86_FEATURE_TME);
> 		return;
> 	}
>=20
> 	pr_info("x86/tme: enabled by BIOS\n");
>=20
> 	if (TME_ACTIVATE_KEYID0_BYPASS(tme_activate)) {
> 		pr_info("x86/tme: KeyID=3D0 encryption bypass enabled\n");
>=20
> 		/*
> 		 * Clear the feature flag, memory for keyid0 isn't encrypted so
> 		 * for all intents and purposes MKTME is unused.
> 		 */
> 		setup_clear_cpu_cap(X86_FEATURE_TME);
> 		goto adjust_phys_bits;
> 	}
>=20
> 	tme_policy =3D TME_ACTIVATE_POLICY(tme_activate);
> 	if (tme_policy !=3D TME_ACTIVATE_POLICY_AES_XTS_128)
> 		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);
>=20
> 	tme_crypto_algs =3D TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
> 	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128))
> 		pr_warn("x86/mktme: Unknown encryption algorithm is active: %#llx\n",
> 			tme_crypto_algs);
>=20
> adjust_phys_bits:
> 	/*
> 	 * KeyID bits effectively lower the number of physical address bits.
> 	 * Update cpuinfo_x86::x86_phys_bits accordingly.  Always use CPU0's
> 	 * info for the adjustment.  If CPU0 steals more bits, then aligning
> 	 * with CPU0 gives the highest chance of survival.  If CPU0 steals
> 	 * fewer bits, adjusting this CPU's x86_phys_bits won't retroactively
> 	 * fix all the calculations done using CPU0's information
> 	 */
> 	c->x86_phys_bits -=3D tme_keyid_bits_cpu0;
> }

