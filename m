Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088DF48F6A3
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 13:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbiAOMAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 07:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiAOMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 07:00:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C45C061574;
        Sat, 15 Jan 2022 04:00:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FDCE60AFD;
        Sat, 15 Jan 2022 12:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74173C36AE3;
        Sat, 15 Jan 2022 12:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642248008;
        bh=r9mCVdEqRE76DIUgmvsuL5KxAftGQ+FEDrAOiIvvDhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9QCfFfjVVTaSZC0/ue3HBhFBkOfX8cBP5b7/iHL3HQxb+yq6McvxairD+ZF2f0kq
         oUcvcX3kO6F5IVZlXr20FD51piIXZWNtpfp9mdpfb4SiKMydTYvHyDP5GY5Z64ys6h
         WBClygFuRSPGrNBxWv5QgyGND8Lhk6tcItII+ggBVRzpuxBWlzO5bZuo8Lw/xDrNUh
         kUYQnRRjFJ/q/OlI5T3kDhyLYr6YG8JruFqwvvdsXWpauPCl2zgprsIuHsrNORdkVc
         PjDdhxEaRx5APminK2r8GR4zWcuOFtOhi9GSQqMWjczXYBQhmuh1OZyHAwSRyF66js
         8xX1j/8OA/nyw==
Date:   Sat, 15 Jan 2022 13:59:55 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Nathaniel McCallum <nathaniel@profian.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <YeK3O5Inu53bwltX@iki.fi>
References: <CAHAy0tRi2q+wG+yBttq0FYeK-5wUAoK_=ZCtWsfQf0m8oPc1-w@mail.gmail.com>
 <168fb2c9-de3f-384a-bb17-ab84db2cf533@intel.com>
 <YeHwzwnfsUcxiNbw@iki.fi>
 <b0e5c1fc-aa6d-4e26-c18b-d93d93c2131a@intel.com>
 <YeIEKayEUidj0Dlb@iki.fi>
 <6e1cb295-b86e-ae09-2cf0-cfefd1a10e65@intel.com>
 <YeIU6e6wetrifn+b@iki.fi>
 <e2d675f7-319b-4816-ad5e-4154cbf69f2b@intel.com>
 <YeIgzLzPu0U8s0sh@iki.fi>
 <YeK2hFcy72tYL61S@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeK2hFcy72tYL61S@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 01:56:55PM +0200, Jarkko Sakkinen wrote:
> On Sat, Jan 15, 2022 at 03:18:04AM +0200, Jarkko Sakkinen wrote:
> > On Fri, Jan 14, 2022 at 04:41:59PM -0800, Reinette Chatre wrote:
> > > Hi Jarkko,
> > > 
> > > On 1/14/2022 4:27 PM, Jarkko Sakkinen wrote:
> > > > On Fri, Jan 14, 2022 at 04:01:33PM -0800, Reinette Chatre wrote:
> > > >> Hi Jarkko,
> > > >>
> > > >> On 1/14/2022 3:15 PM, Jarkko Sakkinen wrote:
> > > >>> On Fri, Jan 14, 2022 at 03:05:21PM -0800, Reinette Chatre wrote:
> > > >>>> Hi Jarkko,
> > > >>>
> > > >>> How enclave can check a page range that EPCM has the expected permissions?
> > > >>
> > > >> Only way to change EPCM permissions from outside enclave is to run ENCLS[EMODPR]
> > > >> that needs to be accepted from within the enclave via ENCLU[EACCEPT]. At that
> > > >> time the enclave provides the expected permissions and that will fail
> > > >> if there is a mismatch with the EPCM permissions (SGX_PAGE_ATTRIBUTES_MISMATCH).
> > > > 
> > > > This is a very valid point but that does make the introspection possible
> > > > only at the time of EACCEPT.
> > > > 
> > > > It does not give tools for enclave to make sure that EMODPR-ETRACK dance
> > > > was ever exercised.
> > > 
> > > Could you please elaborate? EACCEPT is available to the enclave as a tool
> > > and it would fail if ETRACK was not completed (error SGX_NOT_TRACKED).
> > > 
> > > Here is the relevant snippet from the SDM from the section where it
> > > describes EACCEPT:
> > > 
> > > IF (Tracking not correct)
> > >     THEN
> > >         RFLAGS.ZF := 1;
> > >         RAX := SGX_NOT_TRACKED;
> > >         GOTO DONE;
> > > FI;
> > > 
> > > Reinette
> > 
> > Yes, if enclave calls EACCEPT it does the necessary introspection and makes
> > sure that ETRACK is completed. I have trouble understanding how enclave
> > makes sure that EACCEPT was called.
> 
> I'm not concerned of anything going wrong once EMODPR has been started.
> 
> The problem nails down to that the whole EMODPR process is spawned by
> the entity that is not trusted so maybe that should further broke down
> to three roles:
> 
> 1. Build process B
> 2. Runner process R.
> 3. Enclave E.
> 
> And to the costraint that we trust B *more* than R. Once B has done all the
> needed EMODPR calls it would send the file descriptor to R. Even if R would
> have full access to /dev/sgx_enclave, it would not matter, since B has done
> EMODPR-EACCEPT dance with E.
> 
> So what you can achieve with EMODPR is not protection against mistrusted
> *OS*. There's absolutely no chance you could use it for that purpose
> because mistrusted OS controls the whole process.
> 
> EMODPR is to help to protect enclave against mistrusted *process*, i.e.
> in the above scenario R.

My suggestion for this is that let's make EMODPR either opt-in or opt-out
with flags parameter, I don't care which way around. That way you can pick
between performance or extra layer of hardening if you care about the above
scenario.

/Jarkko
