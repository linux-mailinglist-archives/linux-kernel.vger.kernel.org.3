Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8337A5708AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiGKRJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 13:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiGKRJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 13:09:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07EDB87C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:09:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id e16so5282540pfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 10:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O+c4eS2Wz0xOsNrvUWfPx5RqPnJlgL0GzUaZVBfbEOY=;
        b=oXG6TMI+mspLdUjU5KzrCW2UeS90aUF9+euG0J7yYpxsfVaAjaBamCa91I86piok4a
         +wygfiApuqDh2L4zrfsev6peIpHaucwBY5YJD/amTshdDcafwlLuoiE9IBoyh39vw2Dw
         Trr96zm3ZKH4z1i6Q2Z2WYSM/X3qWG3qBeIq6w9kS6ebJLofLmFYXLcWy/YIT/68uU9I
         b+Zsy4RRi7cle1o+2Xae+YSjvP/LG5Co2eX3vr6dLCKvd7ARoafb4ddZljvPP/mv9d1u
         riVaaJsacU78Qr4eue9LoszE8VgzPqZMzxosEPRa38zuc2OCA1k01Vshi/Uw6UjnINHt
         ieXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O+c4eS2Wz0xOsNrvUWfPx5RqPnJlgL0GzUaZVBfbEOY=;
        b=GpOy0qgDv3U+CXAJRHCQeQpADczwHtwD4Ltbcci8yz2S2DIz4tILW9p5ZHh6pEMvOF
         M7DuCK2PLGuDxU1y79/zoZVlRUSABIX1seKkdiIX01XHZTG5hRV0vf+d6bdNmFtIXxeY
         GVFg00fM0UvAYOeJndQ2LjQ3VXzSlId+UAtnV70oPj1JQaFNgDpPURy4IeA0HEk2ztND
         I90sJFLSV7GgzFGef00FgL9BzOM0aqZV87T0xpdAPc9mabdFx14x+tFJ9K7R7hzwSnyX
         Fe7ujlIxqZW1iCD5tc29hJgbaQUL7sDShlbxYoohstTc0jryDg+C5vZ9HJAHxdtEOtN/
         RbLg==
X-Gm-Message-State: AJIora8rzoG0ybO+VXGlDXdoX8pxE+CvIsuL/tfBLp+OFqKJprpSndVB
        C42PL/KeOenNdxr6A8GBjN2XNA==
X-Google-Smtp-Source: AGRyM1tPVb2b4hh+Adr1CNzCQezGCd6/3eMvBzEbVsi6z5OusgNU4bsr1WwWbM8SX/dXLaR2t4l+hQ==
X-Received: by 2002:a05:6a00:1911:b0:525:9ffe:cffc with SMTP id y17-20020a056a00191100b005259ffecffcmr19029527pfi.54.1657559340988;
        Mon, 11 Jul 2022 10:09:00 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id im22-20020a170902bb1600b0016c37fe48casm4156792plb.193.2022.07.11.10.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 10:09:00 -0700 (PDT)
Date:   Mon, 11 Jul 2022 17:08:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        mingo@redhat.com, tglx@linutronix.de,
        kirill.shutemov@linux.intel.com, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com
Subject: Re: [PATCH v2] x86/cpuinfo: Clear X86_FEATURE_TME if TME/MKTME is
 disabled by BIOS
Message-ID: <YsxZKGxVUY61zPEt@google.com>
References: <20220704142250.1512726-1-martin.fernandez@eclypsium.com>
 <8d2a3175be8a3aff1d3fc535dd9ab6217cfe1e66.camel@intel.com>
 <CAKgze5azQG1mnOASbpcrs9jTejdXGkXYmezz9bTKuWQoZp5EFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgze5azQG1mnOASbpcrs9jTejdXGkXYmezz9bTKuWQoZp5EFg@mail.gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022, Martin Fernandez wrote:
> On 7/5/22, Kai Huang <kai.huang@intel.com> wrote:
> > On Mon, 2022-07-04 at 11:22 -0300, Martin Fernandez wrote:
> >> Changelog since v1
> >>
> >> Clear the flag not only for BSP but for every cpu in the system.

...

> >> ---
> >>  arch/x86/kernel/cpu/intel.c | 1 +
> >>  1 file changed, 1 insertion(+)
> >>
> >> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> >> index fd5dead8371c..17f23e23f911 100644
> >> --- a/arch/x86/kernel/cpu/intel.c
> >> +++ b/arch/x86/kernel/cpu/intel.c
> >> @@ -570,6 +570,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
> >>
> >>  	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
> >> !TME_ACTIVATE_ENABLED(tme_activate)) {
> >>  		pr_info_once("x86/tme: not enabled by BIOS\n");
> >> +		clear_cpu_cap(c, X86_FEATURE_TME);

This misses the case where the TME_ACTIVATE_KEYID_BITS() is zero.  AFAICT, that's
allowed, i.e. won't #GP on WRMSR.  TME_ACTIVATE_KEYID_BITS() can't be non-zero if
TME_ACTIVATE_ENABLED() is false, but the reverse is allowed.

> >>  		mktme_status = MKTME_DISABLED;
> >>  		return;
> >
> > This code change itself looks good to me.
> >
> > But, TME actually supports bypassing TME encryption/decryption by setting 1
> > to bit 31 to IA32_TME_ACTIVATE MSR.  See 'Table 4-2 IA32_TME_ACTIVATE MSR'
> > in MKTME spec below:
> >
> > https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/002/intel-multi-key-total-memory-encryption/
> >
> > When bit 31 is set, the TME is bypassed (no encryption/decryption for KeyID 0).
> >
> > So looks userspace also needs to check this if it wants to truly check
> > whether "TME memory encryption" is active.
> >
> > But perhaps it's arguable whether we can also clear TME flag in this case.
> 
> Yep, that's what I thought.

IMO, this entire function needs to be reworked to have a cohesive strategy for
enumerting TME; not just enumerating to userspace, but internal to the kernel as
well.

E.g. forcing "mktme_status = MKTME_DISABLED" on an AP is nonsensical.  If an AP's
basic MKTME enabling doesn't align with the BSP (activate, algorithm, and keyid0
bypass settings match), then there's no way an AP is going to reach detect_tme().
Any discrepancy in encryption for keyid0 will cause the AP will read garbage on
wakeup, and barring a miracle, will triple fault and never call in.

Conversely, if basic enabling matches but something else mismatches, e.g. an AP
was configured with fewer keys, then forcing "mktme_status = MKTME_DISABLED" may
be misleading as MKTME may be fully enabled and in use for keyid0, it just won't
be used for keyid!=0.  But that's a moot point because as is, the kernel _never_
uses keyid!=0.

And this code is also bogus.  Just because the kernel doesn't know the encryption
algorithm doesn't magically turn off encryption for keyid0.  Again, mktme_status
confuses "memory is encrypted" with "MKTME is theoretically usable for keyid!=0".

	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128)) {
		pr_err("x86/mktme: No known encryption algorithm is supported: %#llx\n",
				tme_crypto_algs);
		mktme_status = MKTME_DISABLED;
	}

The mktme_status variable seems completely pointless.  It's not used anywhere
except to detect that CPU0 vs. APs.


Something like this seems like a sane approach.

---

#define MSR_IA32_TME_ACTIVATE		0x982

/* Helpers to access TME_ACTIVATE MSR */
#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)

#define TME_ACTIVATE_KEYID0_BYPASS(x)	(x & BIT(31))

#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	/* Bits 7:4 */
#define TME_ACTIVATE_POLICY_AES_XTS_128	0

#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/* Bits 35:32 */

#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1

static int tme_keyid_bits_cpu0 = -1;
static u64 tme_activate_cpu0;

static void detect_tme(struct cpuinfo_x86 *c)
{
	u64 tme_activate, tme_policy, tme_crypto_algs;

	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);

	if (tme_keyid_bits_cpu0 >= 0) {
		/* Broken BIOS? */
		if (tme_activate != tme_activate_cpu0)
			pr_err_once("x86/tme: configuration is inconsistent between CPUs\n");

		/*
		 * Proceed, stolen keyid bits still needed to be excluded from
		 * x86_phys_bits.  The divergence is all but guaranteed to be
		 * benign, else this CPU would have died during bringup.
		 */
		goto adjust_phys_bits;
	}

	tme_activate_cpu0 = tme_activate;

	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
	    !TME_ACTIVATE_ENABLED(tme_activate))
		tme_keyid_bits_cpu0 = 0;
	else
		tme_keyid_bits_cpu0 = TME_ACTIVATE_KEYID_BITS(tme_activate);

	if (!tme_keyid_bits_cpu0) {
		pr_info("x86/tme: not enabled by BIOS\n");
		setup_clear_cpu_cap(X86_FEATURE_TME);
		return;
	}

	pr_info("x86/tme: enabled by BIOS\n");

	if (TME_ACTIVATE_KEYID0_BYPASS(tme_activate)) {
		pr_info("x86/tme: KeyID=0 encryption bypass enabled\n");

		/*
		 * Clear the feature flag, memory for keyid0 isn't encrypted so
		 * for all intents and purposes MKTME is unused.
		 */
		setup_clear_cpu_cap(X86_FEATURE_TME);
		goto adjust_phys_bits;
	}

	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
		pr_warn("x86/tme: Unknown policy is active: %#llx\n", tme_policy);

	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128))
		pr_warn("x86/mktme: Unknown encryption algorithm is active: %#llx\n",
			tme_crypto_algs);

adjust_phys_bits:
	/*
	 * KeyID bits effectively lower the number of physical address bits.
	 * Update cpuinfo_x86::x86_phys_bits accordingly.  Always use CPU0's
	 * info for the adjustment.  If CPU0 steals more bits, then aligning
	 * with CPU0 gives the highest chance of survival.  If CPU0 steals
	 * fewer bits, adjusting this CPU's x86_phys_bits won't retroactively
	 * fix all the calculations done using CPU0's information
	 */
	c->x86_phys_bits -= tme_keyid_bits_cpu0;
}
