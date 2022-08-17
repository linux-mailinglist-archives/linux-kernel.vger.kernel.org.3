Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460855973BD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbiHQQJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:09:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbiHQQIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:08:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24B49F76C
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:08:29 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98b0329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98b0:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A7BA1EC01B7;
        Wed, 17 Aug 2022 18:08:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1660752504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wxHwgaQYszXgOk2yCZLgI7etmYPcha6b1/7gPCoB2pw=;
        b=Ada/DEb5Q69qYOz7e8f5v9+SMfGYiMY8eTop2+PP/7r+hT/IwelYV9pqJHG0/g1ZJ6dF28
        b0tvQp2IR/8hyNpaU2UKt+wD1tmkdD/xv1MJmhVeVaUJTt6p1BwX0u10xNqWNofygOilf7
        DO7V153szMP0h5FRK7HJQV0eG8yRc9k=
Date:   Wed, 17 Aug 2022 18:08:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 1/2] x86/sev: Put PSC struct on the stack in prep for
 unaccepted memory support
Message-ID: <Yv0ScwQ0LGkPM+VV@zn.tnic>
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1660579062.git.thomas.lendacky@amd.com>
 <9017076fe1050b8a38d5ee8447b827a5c41c4e72.1660579062.git.thomas.lendacky@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9017076fe1050b8a38d5ee8447b827a5c41c4e72.1660579062.git.thomas.lendacky@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 10:57:42AM -0500, Tom Lendacky wrote:
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index c05f0124c410..40268ce97aad 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -66,6 +66,17 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
>   */
>  static struct ghcb *boot_ghcb __section(".data");
>  
> +/*
> + * A flag used by set_pages_state() that indicates when the per-CPU GHCB has
> + * been created and registered and thus can be used instead of using the MSR
> + * protocol. The set_pages_state() function eventually invokes vmgexit_psc(),
> + * which only works with a per-CPU GHCB.
> + *
> + * For APs, the per-CPU GHCB is created before they are started and registered
> + * upon startup, so this flag can be used globally for the BSP and APs.
> + */

Ok, better, thanks!

> +static bool ghcb_percpu_ready __section(".data");

However, it reads really weird if you have "percpu" in the name of a
variable which is not per CPU...

Let's just call it "ghcbs_initialized" and be done with it.

And I still hate the whole thing ofc.

Do this ontop (and I knew we had a flags thing already):

(And yes, __read_mostly is in the .data section too).

---
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 40268ce97aad..5b3afbf26349 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -66,17 +66,6 @@ static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
  */
 static struct ghcb *boot_ghcb __section(".data");
 
-/*
- * A flag used by set_pages_state() that indicates when the per-CPU GHCB has
- * been created and registered and thus can be used instead of using the MSR
- * protocol. The set_pages_state() function eventually invokes vmgexit_psc(),
- * which only works with a per-CPU GHCB.
- *
- * For APs, the per-CPU GHCB is created before they are started and registered
- * upon startup, so this flag can be used globally for the BSP and APs.
- */
-static bool ghcb_percpu_ready __section(".data");
-
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
@@ -128,7 +117,18 @@ static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 
 struct sev_config {
 	__u64 debug		: 1,
-	      __reserved	: 63;
+
+	      /*
+	       * A flag used by set_pages_state() that indicates when the per-CPU GHCB has
+	       * been created and registered and thus can be used instead of using the MSR
+	       * protocol. The set_pages_state() function eventually invokes vmgexit_psc(),
+	       * which only works with a per-CPU GHCB.
+	       *
+	       * For APs, the per-CPU GHCB is created before they are started and registered
+	       * upon startup, so this flag can be used globally for the BSP and APs.
+	       */
+	      ghcbs_initialized : 1,
+	      __reserved	: 62;
 };
 
 static struct sev_config sev_cfg __read_mostly;
@@ -762,7 +762,7 @@ static int vmgexit_psc(struct snp_psc_desc *desc)
 	unsigned long flags;
 	struct ghcb *ghcb;
 
-	WARN_ON_ONCE(!ghcb_percpu_ready);
+	WARN_ON_ONCE(!sev_cfg.ghcbs_initialized);
 
 	/*
 	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
@@ -887,7 +887,7 @@ static void set_pages_state(unsigned long vaddr, unsigned int npages, int op)
 	 * Use the MSR protocol when the per-CPU GHCBs are not yet registered,
 	 * since vmgexit_psc() uses the per-CPU GHCB.
 	 */
-	if (!ghcb_percpu_ready)
+	if (!sev_cfg.ghcbs_initialized)
 		return early_set_pages_state(__pa(vaddr), npages, op);
 
 	vaddr = vaddr & PAGE_MASK;
@@ -1268,7 +1268,7 @@ void setup_ghcb(void)
 		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 			snp_register_per_cpu_ghcb();
 
-		ghcb_percpu_ready = true;
+		sev_cfg.ghcbs_initialized = true;
 
 		return;
 	}

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
