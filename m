Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDBF4D3DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 00:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiCIXhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 18:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbiCIXhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 18:37:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E666325587;
        Wed,  9 Mar 2022 15:36:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70FD060B13;
        Wed,  9 Mar 2022 23:36:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DAD4C340EE;
        Wed,  9 Mar 2022 23:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646868994;
        bh=PbkHs7QNANWxCf+qyn+VFMD/SOYwgb0ES8M8oJRM2bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qXT3wKHjZ1nmlXuRsrYx7mY0Fj/jboB8x6LPKa16yvBd8twrk0QpZ+Ildtk2S73ii
         Mo1bNDlpXaUrzaWJqlJDccTunlIHqHm6iLvtsjxajH4MWoJXtTWycHonzJqUx3aFrg
         JhzQnsTzycxj1Q067jWamilo8dP1cZwEAKg6rHXHZgpbaxK0qnWqypXLHjbk705qpF
         aCjn1Gr7+6WYlzV6fnDaV+jGIvznr0cmZI24Zmyvi6PnWKY1IviNsmrqRg0PkNO1te
         ky9wY98FxtQf27DPeh4L/N8t37qZwZfnb90/fpZFMoHEsG6GnIVkj09e9I6m5rxQ0+
         p4RdRCRVVDc7w==
Date:   Thu, 10 Mar 2022 01:35:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-sgx@vger.kernel.org,
        Nathaniel McCallum <nathaniel@profian.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2.1 14/30] x86/sgx: Support restricting of enclave
 page permissions
Message-ID: <Yik51tjxXcqamBrO@iki.fi>
References: <20220304093524.397485-1-jarkko@kernel.org>
 <20220304093524.397485-14-jarkko@kernel.org>
 <YihqwiU3Dr5mvMQx@iki.fi>
 <Yih00gFMaJhLIgxa@iki.fi>
 <5e89a3be-0760-b1b4-7693-2f3d9ac5066b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e89a3be-0760-b1b4-7693-2f3d9ac5066b@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 08:59:42AM -0800, Reinette Chatre wrote:
> Hi Jarkko,
> 
> On 3/9/2022 1:35 AM, Jarkko Sakkinen wrote:
> > On Wed, Mar 09, 2022 at 10:52:22AM +0200, Jarkko Sakkinen wrote:
> >> On Fri, Mar 04, 2022 at 11:35:08AM +0200, Jarkko Sakkinen wrote:
> >>> +#define SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS \
> >>> +	_IOWR(SGX_MAGIC, 0x05, struct sgx_enclave_restrict_perm)
> >>
> >> What if this was replaced with just SGX_IOC_ENCLAVE_RESET_PAGES, which
> >> would simply do EMODPR with PROT_NONE? The main ingredient of EMODPR is to
> >> flush out the TLB's, and move a page to pending state, which cannot be done
> >> from inside the enclave.
> 
> I see the main ingredient as running EMODPR to restrict the EPCM permissions. If
> the user wants to use SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS just to flush TLB it is
> already possible since attempting to use EMODPR to relax permissions does not
> change any permissions (although it still sets EPCM.PR) but yet will still
> flush the TLB.

It's not just to flush the TLB. It also resets permissions to zero from
which it is easy to set the exact permissions with EMODPE.

> Even so, you have a very good point that removing SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> removes the ability for users to flush the TLB after an EMODPE. If there are
> thus PTEs present at the time the user runs EMODPE the pages would not be
> accessible with the new permissions.
> 
> Repurposing SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS with PROT_NONE to accomplish
> this is not efficient because:
> - For the OS to flush the TLB the enclave pages need not be in the EPC but
>   in order to run EMODPR the enclave page needs to be in the EPC. In an 
>   oversubscribed environment running EMODPR unnecessarily can thus introduce
>   a significant delay. Please see the performance comparison I did in
>   https://lore.kernel.org/linux-sgx/77e81306-6b03-4b09-2df2-48e09e2e79d5@intel.com/
>   The test shows that running EMODPR unnecessarily can be orders of magnitude slower.
> - Running EMODPR on an enclave page sets the EPCM.PR bin in the enclave page
>   that needs to be cleared with an EACCEPT from within the enclave.
>   If the user just wants to reset the TLB after running EMODPE then it should
>   not be necessary to run EACCEPT again to reset EPCM.PR.
> 
> Resetting the TLB is exactly what SGX_IOC_ENCLAVE_RELAX_PERMISSIONS did in an 
> efficient way - it is quick (no need to load pages into EPC) and it does not
> require EACCEPT to clear EPCM.PR. 
> 
> It looks like we need SGX_IOC_ENCLAVE_RELAX_PERMISSIONS back. We could
> rename it to SGX_IOC_ENCLAVE_RESET_PAGES if you prefer.

Please do not add it. We do not have any use for it. It's not only used
to flush TLB's so it would not do any good. I just use it with fixed
PROT_NONE permissions.

> >> It's there because of microarchitecture constraints, and less so to work as
> >> a reasonable permission control mechanism (actually it does terrible job on
> >> that side and only confuses).
> >>
> >> Once you have this magic TLB reset button in place you can just do one
> >> EACCEPT and EMODPE inside the enclave and you're done.
> >>
> >> This is also kind of atomic in the sense that EACCEPT free's a page with no
> >> rights so no misuse can happend before EMODPE has tuned EPCM.
> > 
> > I wonder if this type of pattern could be made work out for Graphene:
> > 
> > 1. SGX_IOC_ENCLAVE_RESET_PAGES
> > 2. EACCEPT + EMODPE
> > 
> > This kind of delivers EMODP that everyone has been looking for.
> 
> EACCEPT will result in page table entries created for the enclave page. EMODPE
> will be able to relax the permissions but TLB flush would be required to
> access the page with the new permissions. SGX_IOC_ENCLAVE_RELAX_PERMISSIONS
> (renamed to SGX_IOC_ENCLAVE_RESET_PAGES?) that does just a TLB flush is
> required to be after EMODPE.

For EMODPE TLB flush is not required. I even verified this from Mark
Shanahan. And since access rights are zero, the page cannot be
deferenced by threads before EMODPE.


BR, Jarkko
