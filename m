Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380B8572CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbiGMFJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbiGMFJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:09:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284701BEB8;
        Tue, 12 Jul 2022 22:09:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LjQdQ48fVz4ySW;
        Wed, 13 Jul 2022 15:08:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657688941;
        bh=7wafbD99SC49dp1tbcYE9gdUF4LGwL1TUylf/cbUe5Y=;
        h=Date:From:To:Cc:Subject:From;
        b=j4BGTBbJF2A5rGOLx/MhCetAPEpbXbPYdcuK7kYG44Gf8v1IRi0lhaZaH2fjl1Z+S
         O7PRP5nXgFBMSn/7q+woCOp05R+v07pYvS6tshf9aidrXd84hjC0BztujBgKsjPseU
         elJFsx64QTR9IDD3lD4gbtQL8W1d9syn5L+tWCkB5q9vTacPxBlH4BbLVz0/xFWU9j
         IZdrTpI+YrzYExD4Z2ov3Dtng/6i+39u9mWPcOVpvjafSinWFPeh15KHQNi3sLhQH6
         /DuUpiPpFde/ZgCT8E1wAhq0AwGnlROOq1AC+zmU7Yi4beFnm8RTANMXnnIHiWnc/F
         lnDWgz96ZTiqA==
Date:   Wed, 13 Jul 2022 15:08:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@suse.de>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the tip tree with Linus' tree
Message-ID: <20220713150854.68b2d129@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/QhB/TRw04=mUBB+mpVADc9k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/QhB/TRw04=mUBB+mpVADc9k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  drivers/idle/intel_idle.c

between commit:

  bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")

from Linus' tree and commit:

  f08ef9057b7b ("intel_idle: Add a new flag to initialize the AMX state")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/idle/intel_idle.c
index f5c6802aa6c3,8a19ba1c2c1b..000000000000
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@@ -53,9 -52,9 +53,10 @@@
  #include <linux/moduleparam.h>
  #include <asm/cpu_device_id.h>
  #include <asm/intel-family.h>
 +#include <asm/nospec-branch.h>
  #include <asm/mwait.h>
  #include <asm/msr.h>
+ #include <asm/fpu/api.h>
 =20
  #define INTEL_IDLE_VERSION "0.5.1"
 =20
@@@ -107,12 -106,11 +108,17 @@@ static unsigned int mwait_substates __i
   */
  #define CPUIDLE_FLAG_ALWAYS_ENABLE	BIT(15)
 =20
 +/*
 + * Disable IBRS across idle (when KERNEL_IBRS), is exclusive vs IRQ_ENABLE
 + * above.
 + */
 +#define CPUIDLE_FLAG_IBRS		BIT(16)
 +
+ /*
+  * Initialize large xstate for the C6-state entrance.
+  */
 -#define CPUIDLE_FLAG_INIT_XSTATE	BIT(16)
++#define CPUIDLE_FLAG_INIT_XSTATE	BIT(17)
+=20
  /*
   * MWAIT takes an 8-bit "hint" in EAX "suggesting"
   * the C-state (top nibble) and sub-state (bottom nibble)
@@@ -167,24 -165,13 +173,31 @@@ static __cpuidle int intel_idle_irq(str
  	return ret;
  }
 =20
 +static __cpuidle int intel_idle_ibrs(struct cpuidle_device *dev,
 +				     struct cpuidle_driver *drv, int index)
 +{
 +	bool smt_active =3D sched_smt_active();
 +	u64 spec_ctrl =3D spec_ctrl_current();
 +	int ret;
 +
 +	if (smt_active)
 +		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
 +
 +	ret =3D __intel_idle(dev, drv, index);
 +
 +	if (smt_active)
 +		wrmsrl(MSR_IA32_SPEC_CTRL, spec_ctrl);
 +
 +	return ret;
 +}
 +
+ static __cpuidle int intel_idle_xstate(struct cpuidle_device *dev,
+ 				       struct cpuidle_driver *drv, int index)
+ {
+ 	fpu_idle_fpregs();
+ 	return __intel_idle(dev, drv, index);
+ }
+=20
  /**
   * intel_idle_s2idle - Ask the processor to enter the given idle state.
   * @dev: cpuidle device of the target CPU.
@@@ -1845,12 -1837,9 +1863,15 @@@ static void __init intel_idle_init_csta
  		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENABLE)
  			drv->states[drv->state_count].enter =3D intel_idle_irq;
 =20
 +		if (cpu_feature_enabled(X86_FEATURE_KERNEL_IBRS) &&
 +		    cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IBRS) {
 +			WARN_ON_ONCE(cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_IRQ_ENAB=
LE);
 +			drv->states[drv->state_count].enter =3D intel_idle_ibrs;
 +		}
 +
+ 		if (cpuidle_state_table[cstate].flags & CPUIDLE_FLAG_INIT_XSTATE)
+ 			drv->states[drv->state_count].enter =3D intel_idle_xstate;
+=20
  		if ((disabled_states_mask & BIT(drv->state_count)) ||
  		    ((icpu->use_acpi || force_use_acpi) &&
  		     intel_idle_off_by_default(mwait_hint) &&

--Sig_/QhB/TRw04=mUBB+mpVADc9k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLOU2YACgkQAVBC80lX
0Gz3ogf/dmDcNe9VPVIt6JfW5yeP/EkTLiNsV7n0qg51eoNpdjn0WilPFHPyGaDW
w4ftD4miWaeWZJsC2G+YS88xd9GHz31UKuYv72O5MZh/MKAS6LL8w4dvflb5kT9x
lJ5mBR7Sh7HF7lbuLuQoMZx/WBWoCXSNmPu3LMKzco9GT+BKEzVoGDibMatINgpH
tsmt8EpWnNLrfaASrT/ewUzZa+0NmBZHFTn51AM76DwrEGF0bjP8sZs08HAG4FTY
BknJrmRGXoC2QEtGd7l0MTY6y6vfB94/nLymc+cM0qWK9YMeCHdi2u4oCzZb11GK
HaI0Blp7E3cCCzoav354dcgdXG7S7Q==
=gtmK
-----END PGP SIGNATURE-----

--Sig_/QhB/TRw04=mUBB+mpVADc9k--
