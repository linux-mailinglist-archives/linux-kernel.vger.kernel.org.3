Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766AE4CCB59
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiCDBeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiCDBd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:33:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A2CC8F91;
        Thu,  3 Mar 2022 17:33:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 96931CE2847;
        Fri,  4 Mar 2022 01:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D25C004E1;
        Fri,  4 Mar 2022 01:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646357588;
        bh=nGe3jryB3rTORQsc41kPbM4YtWTR3W7aJ8j9zSH1rLk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ohZhG/QNzyeh8WONTYPwGwZLtYBuZh0N6Sp6SZ+jcJdkFqmJDld+j0dYero1OxcyL
         jG423u8RElthurPOxf2bmC3GS508Z20W9fHqA4TNC+rRO6PCKeEfrmHHiWOBF9Xivv
         ecIkz1zCMCog9eTuNMedqTH39prW5rn0vKtN1b4HgCWNnbj0ZovVzT1XyDflVVnHxP
         0laSptah2m45t9M2JfY2KMAah6r2Y+36hKPV/FwoxV14q10e4hQQG7iYuMIOlZnhI4
         C1SXftIiJixp+3kdera++cUj5//9pSl4PAOuCRgytVSm+kNjsy6T2EDStvX3fGCuO3
         Vsa1isYQKzlfw==
Date:   Fri, 4 Mar 2022 03:32:28 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/sgx: Do not limit EAUG'd pages by pre-initialization
 policy
Message-ID: <YiFsLLEfZgsavKWD@iki.fi>
References: <20220304011636.327511-1-jarkko@kernel.org>
 <YiFqj/Y+Nor/TJND@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiFqj/Y+Nor/TJND@iki.fi>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 03:25:38AM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 04, 2022 at 03:16:35AM +0200, Jarkko Sakkinen wrote:
> > Pre-initialization policy is meant for EADD'd pages because they are
> > part of the enclave identity. It's a good practice to not let touch the
> > permissions after initialization, and does provide guarantees to e.g.
> > LSM's about the enclave.
> > 
> > For EAUG'd pages it should be sufficient to let mmap(), mprotect() and
> > SGX opcodes to control the permissions. Thus effectively disable
> > pre-initialization policy by setting vm_max_prot_bit and
> > vm_run_prot_bits to RWX.
> > 
> > Cc: Reinette Chatre <reinette.chatre@intel.com>
> > Cc: Nathaniel McCallum <nathaniel@profian.com>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/sgx/encl.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> > index 5fe7189eac9d..17feb6fa5578 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -200,13 +200,7 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
> >  	encl_page->desc = addr;
> >  	encl_page->encl = encl;
> >  
> > -	/*
> > -	 * Adding a regular page that is architecturally allowed to only
> > -	 * be created with RW permissions.
> > -	 * TBD: Interface with user space policy to support max permissions
> > -	 * of RWX.
> > -	 */
> > -	prot = PROT_READ | PROT_WRITE;
> > +	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
> >  	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> >  	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
> >  
> > -- 
> > 2.35.1
> > 
> 
> This does not break any existing ABI and at least makes the current
> patch set usable.

Also it would be a sane limitation to deny EMODPR and EMODT completely for
EADD'd pages.

Then, you can discard vm_run_prot_bits. It's not needed for anything
anymore.

This should make implementation considerably less obfuscated.

BR, Jarkko
