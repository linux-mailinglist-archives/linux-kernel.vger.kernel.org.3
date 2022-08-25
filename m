Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA835A0DEA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 12:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiHYKb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 06:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbiHYKbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 06:31:25 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D8B80B4E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 03:31:21 -0700 (PDT)
Received: from zn.tnic (p200300ea971b98f5329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:98f5:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 09D131EC0657;
        Thu, 25 Aug 2022 12:31:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1661423476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=zK9NbDDerkx+CYip96QcRVUldGtE2iU26G30xCp9mcs=;
        b=CQvToHdRh10wL0hNduhRHenIAoBSCFKnudfnEHA7E496ePGgQTBicqQpC4b7DYdm0t9dve
        rs0QKTGLlkgbz/oLxD0um5n6blHxFIND65bz8sT5S+mpVP9lwY85movY9jI+knWEQAtrgS
        N1Z9T8z6WgoJvzYa6LjJLY6GCpGLqxQ=
Date:   Thu, 25 Aug 2022 12:31:11 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 02/10] x86/mtrr: remove unused cyrix_set_all() function
Message-ID: <YwdPb4pWqppgzIpm@zn.tnic>
References: <20220820092533.29420-1-jgross@suse.com>
 <20220820092533.29420-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220820092533.29420-3-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 11:25:25AM +0200, Juergen Gross wrote:
> The Cyrix cpu specific MTRR function cyrix_set_all() will never be
> called, as the struct mtrr_ops set_all() callback will only be called
> in the use_intel() case, which would require the use_intel_if member
> of struct mtrr_ops to be set, which isn't the case for Cyrix.

Doing some git archeology:

So the commit which added mtrr_aps_delayed_init is

  d0af9eed5aa9 ("x86, pat/mtrr: Rendezvous all the cpus for MTRR/PAT init")

from 2009.

The IPI callback before it, looked like this:

static void ipi_handler(void *info)
{
#ifdef CONFIG_SMP
	struct set_mtrr_data *data = info;
	unsigned long flags;

	local_irq_save(flags);

	atomic_dec(&data->count);
	while (!atomic_read(&data->gate))
		cpu_relax();

	/*  The master has cleared me to execute  */
	if (data->smp_reg != ~0U) {
		mtrr_if->set(data->smp_reg, data->smp_base,
			     data->smp_size, data->smp_type);
	} else {
		mtrr_if->set_all();
		^^^^^^^^^

and that else branch would call ->set_all() on Cyrix too.

Suresh's patch changed it to do:

-	} else {
+	} else if (mtrr_aps_delayed_init) {
+		/*
+		 * Initialize the MTRRs inaddition to the synchronisation.
+		 */
 		mtrr_if->set_all();

BUT below in the set_mtrr() call, it did:

        /*
         * HACK!
         * We use this same function to initialize the mtrrs on boot.
         * The state of the boot cpu's mtrrs has been saved, and we want
         * to replicate across all the APs.
         * If we're doing that @reg is set to something special...
         */
        if (reg != ~0U)
                mtrr_if->set(reg, base, size, type);
        else if (!mtrr_aps_delayed_init)
                mtrr_if->set_all();
		^^^

and that would be the Cyrix case.

But then

  192d8857427d ("x86, mtrr: use stop_machine APIs for doing MTRR rendezvous")

came and "cleaned" all up by removing the "HACK" and doing ->set_all()
only in the rendezvous handler:

+       } else if (mtrr_aps_delayed_init || !cpu_online(smp_processor_id())) {
                mtrr_if->set_all();
        }

Which begs the question: why doesn't the second part of the else test
match on Cyrix? The "|| !cpu_online(smp_processor_id())" case.

If only we had a Cyrix machine somewhere...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
