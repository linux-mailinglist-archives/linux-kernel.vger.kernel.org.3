Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321A24D03B8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244017AbiCGQKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244003AbiCGQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:10:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DBC38BF4;
        Mon,  7 Mar 2022 08:09:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4718BB8162B;
        Mon,  7 Mar 2022 16:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA31C340E9;
        Mon,  7 Mar 2022 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646669384;
        bh=BxPgcsfYfHGQI3yADGesFM1OfkI+sJTsyJeE5VxFdwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=arP9p8l6BUwf3W9EnSh/5JeRbXUQ3I9EhpcxQ/jZLe5LweoZ1diMz8pngnPVNQwoK
         Z7lXg1MygzTQ5Xoqpyn9XKAkQvUXOvdHfM8XlWNVJYA9iQFi1Uw6oD0VnMjsdFpNTv
         nCcJQaZGGUqeTcP1JDhvY1rpqsa2imr0JnPoR7ycKbTGEChf3eGyPorLjRJAWn9p8V
         QDRkLV79BsY/hczNBYFJbysbcrKxeCQlQrn2eFPDsJ/k1LCY+7bs4xkKgVBtEu9N/8
         GCsPBLygX0y4dlyca81adLYwRCZkcn77tdALSCtXefIIzupKEgxcbWSXJlK25c7oEu
         5TW8slNpsQTcQ==
Date:   Mon, 7 Mar 2022 18:09:03 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Nathaniel McCallum <nathaniel@profian.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/sgx: Enable PROT_EXEC for EAUG'd pages
Message-ID: <YiYuH95wps+yHDk1@iki.fi>
References: <20220307153504.198112-1-jarkko@kernel.org>
 <YiYseF3aKI70x3d8@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiYseF3aKI70x3d8@iki.fi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 06:02:03PM +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 07, 2022 at 05:35:04PM +0200, Jarkko Sakkinen wrote:
> > vm_max_permissions was created to control the pre-initialization content
> > that contributes to MRSIGNATURE. It was never meant to be as a limit to
> > dynamically added pages.
> > 
> > E.g. static content could be used as a hook for LSM's to decide whether
> > certain signature is qualified for EINIT. Dynamic content has nothing to
> > do with that. The current mechanisms only add to the complexity on how
> > to control PTE and EPCM permissions, and do not add anything else than
> > obfuscity to security side of things.
> > 
> > Thus add PROT_EXEC to the permissions assigned by the #PF handler.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  arch/x86/kernel/cpu/sgx/encl.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> > index 79e39bd99c09..0256918b2c2f 100644
> > --- a/arch/x86/kernel/cpu/sgx/encl.c
> > +++ b/arch/x86/kernel/cpu/sgx/encl.c
> > @@ -160,12 +160,11 @@ static vm_fault_t sgx_encl_eaug_page(struct vm_area_struct *vma,
> >  	encl_page->encl = encl;
> >  
> >  	/*
> > -	 * Adding a regular page that is architecturally allowed to only
> > -	 * be created with RW permissions.
> > -	 * TBD: Interface with user space policy to support max permissions
> > -	 * of RWX.
> > +	 * Dynamic pages do not contribute to MRSIGNATURE, i.e. they are
> > +	 * controlled only by PTE and EPCM permissions. Thus, the no limit
> > +	 * is set here.
> >  	 */
> > -	prot = PROT_READ | PROT_WRITE;
> > +	prot = PROT_READ | PROT_WRITE | PROT_EXEC;
> >  	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
> >  	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;
> >  
> > -- 
> > 2.35.1
> > 
> 
> This is really a show stopper. I think here's a logical mistake on for what
> purpose vm_max_prot_bits are used for. They are meant for the static and
> also signed content of the enclave.
> 
> These changes in the patch set that are related to vm_max_prot_bits only
> messes up what already exists, and make incredibly hard to implement
> anything decent on top of SGX2 features.

I.e. once signed content has passed EINIT ioctl, and whatever checks
there are now or in future (e.g. LSM hooks), the system has accepted
the enclave behaviour, and it includes also the use of EACCEPT opcode.

It's the exec or no-exec decision point. The thing that these patches
do is making an obfuscated mess of all this. When EINIT has passed,
it has been decided that the enclave can do its workload. Let's not
throw stick in front of it, and make everyones life misserable.

BR, Jarkko
