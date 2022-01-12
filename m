Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB5848CF65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 00:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235830AbiALXue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 18:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbiALXtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 18:49:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9899CC03327A;
        Wed, 12 Jan 2022 15:49:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C2FE61B76;
        Wed, 12 Jan 2022 23:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF912C36AEC;
        Wed, 12 Jan 2022 23:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642031341;
        bh=Z7mt3+G/fwnHyZZJZ0z9JnL903ZKyuvNqQOlWYiLwB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TprkK78zLj7tO9uxmpbvT8O9oAnEwnw2nfNmXkW3gJj2oBE0uE/ykBoDstVTstc29
         e+FsSYQB94sqiOwXeLbxF3yDeUvZaza5gMozgovMYC+IWUc2qTyhhcC7ThzPdc9uOM
         Qj3SAuBJr5EsY09qc5hHT4YouRiDdgZkOuXQQxcFXi1dGv1QipjnexVmqMAsWSSLO3
         sHVXGouPveTUvjpgufryF2jN7ja72hvaUfysdsITd7ZmNg3eoEhiVHYRn9xYMmaqbb
         QTyzqZzlEFkqQ7KmMV3WSczwgMyk8WkSK/72pKYI17+WKDdtHa7GK+XkAB024CAS6B
         61Y5SsMrwsWfQ==
Date:   Thu, 13 Jan 2022 01:48:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Haitao Huang <haitao.huang@linux.intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Andy Lutomirski <luto@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, seanjc@google.com,
        kai.huang@intel.com, cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/25] x86/sgx: Introduce runtime protection bits
Message-ID: <Yd9o4BJWNtK5AxoB@iki.fi>
References: <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net>
 <YdmxpTVM1JG8nxQ3@iki.fi>
 <YdmzDy1BOHgh8CII@iki.fi>
 <Ydm6RiIwuh3IspRI@iki.fi>
 <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net>
 <YdzjEzjF0YKn+pZ6@iki.fi>
 <YdzjrIxrVfgrlzWH@iki.fi>
 <YdzldMXO2LrssnER@iki.fi>
 <YdzoQJknQK5r6xLK@iki.fi>
 <op.1ftbip0cwjvjmi@hhuan26-mobl1.mshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <op.1ftbip0cwjvjmi@hhuan26-mobl1.mshome.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 09:48:15PM -0600, Haitao Huang wrote:
> On Mon, 10 Jan 2022 20:15:28 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> wrote:
> 
> > On Tue, Jan 11, 2022 at 04:03:32AM +0200, Jarkko Sakkinen wrote:
> > > On Tue, Jan 11, 2022 at 03:55:59AM +0200, Jarkko Sakkinen wrote:
> > > > On Tue, Jan 11, 2022 at 03:53:26AM +0200, Jarkko Sakkinen wrote:
> > > > > On Mon, Jan 10, 2022 at 04:05:21PM -0600, Haitao Huang wrote:
> > > > > > On Sat, 08 Jan 2022 10:22:30 -0600, Jarkko Sakkinen
> > > <jarkko@kernel.org>
> > > > > > wrote:
> > > > > >
> > > > > > > On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
> > > > > > > > On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen
> > > wrote:
> > > > > > > > > On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang
> > > wrote:
> > > > > > > > > > > > > OK, so the question is: do we need both or would a
> > > > > > > > mechanism just
> > > > > > > > > > > > to extend
> > > > > > > > > > > > > permissions be sufficient?
> > > > > > > > > > > >
> > > > > > > > > > > > I do believe that we need both in order to support
> > > pages
> > > > > > > > having only
> > > > > > > > > > > > the permissions required to support their intended use
> > > > > > > > during the
> > > > > > > > > > > > time the
> > > > > > > > > > > > particular access is required. While technically it is
> > > > > > > > possible to grant
> > > > > > > > > > > > pages all permissions they may need during their
> > > lifetime it
> > > > > > > > is safer to
> > > > > > > > > > > > remove permissions when no longer required.
> > > > > > > > > > >
> > > > > > > > > > > So if we imagine a run-time: how EMODPR would be
> > > useful, and
> > > > > > > > how using it
> > > > > > > > > > > would make things safer?
> > > > > > > > > > >
> > > > > > > > > > In scenarios of JIT compilers, once code is generated
> > > into RW pages,
> > > > > > > > > > modifying both PTE and EPCM permissions to RX would be
> > > a good
> > > > > > > > defensive
> > > > > > > > > > measure. In that case, EMODPR is useful.
> > > > > > > > >
> > > > > > > > > What is the exact threat we are talking about?
> > > > > > > >
> > > > > > > > To add: it should be *significantly* critical thread,
> > > given that not
> > > > > > > > supporting only EAUG would leave us only one complex call
> > > pattern with
> > > > > > > > EACCEPT involvement.
> > > > > > > >
> > > > > > > > I'd even go to suggest to leave EMODPR out of the patch
> > > set, and
> > > > > > > > introduce
> > > > > > > > it when there is PoC code for any of the existing run-time
> > > that
> > > > > > > > demonstrates the demand for it. Right now this way too
> > > speculative.
> > > > > > > >
> > > > > > > > Supporting EMODPE is IMHO by factors more critical.
> > > > > > >
> > > > > > > At least it does not protected against enclave code because
> > > an enclave
> > > > > > > can
> > > > > > > always choose not to EACCEPT any of the EMODPR requests. I'm
> > > not only
> > > > > > > confused here about the actual threat but also the potential
> > > adversary
> > > > > > > and
> > > > > > > target.
> > > > > > >
> > > > > > I'm not sure I follow your thoughts here. The sequence should
> > > be for enclave
> > > > > > to request  EMODPR in the first place through runtime to
> > > kernel, then to
> > > > > > verify with EACCEPT that the OS indeed has done EMODPR.
> > > > > > If enclave does not verify with EACCEPT, then its own code has
> > > > > > vulnerability. But this does not justify OS not providing the
> > > mechanism to
> > > > > > request EMODPR.
> > > > >
> > > > > The question is really simple: what is the threat scenario? In
> > > order to use
> > > > > the word "vulnerability", you would need one.
> > > > >
> > > > > Given the complexity of the whole dance with EMODPR it is
> > > mandatory to have
> > > > > one, in order to ack it to the mainline.
> > > > >
> > > > > > Similar to how we don't want have RWX code pages for normal Linux
> > > > > > application, when an enclave loads code pages (either directly
> > > or JIT
> > > > > > compiled from high level code ) into EAUG'd page (which has
> > > RW), we do not
> > > > > > want leave pages to be RWX for code to be executable, hence
> > > the need of
> > > > > > EMODPR request OS to reduce the permissions to RX once the
> > > code is ready to
> > > > > > execute.
> > > > >
> > > > > You cannot compare *enforced* permissions outside the enclave,
> > > and claim that
> > > > > they would be equivalent to the permissions of the already
> > > sandboxed code
> > > > > inside the enclave, with permissions that are not enforced but
> > > are based
> > > > > on good will of the enclave code.
> > > >
> > > > To add, you can already do "EMODPR" by simply adjusting VMA
> > > permissions to be
> > > > more restrictive. How this would be worse than this collaboration
> > > based
> > > > thing?
> > > 
> > > ... or you could even make soft version of EMODPR without using that
> > > opcode
> > > by writing an ioctl to update our xarray to allow lower permissions.
> > > That
> > > ties the hands of the process who is doing the mmap() already.
> > 
> > E.g. why not just
> > 
> > #define SGX_IOC_ENCLAVE_RESTRICT_PAGE_PERMISSIONS \
> > 	_IOW(SGX_MAGIC, 0x05, struct sgx_enclave_modify_page_permissions)
> > #define SGX_IOC_ENCLAVE_EXTEND_PAGE_PERMISSIONS \
> > 	_IOW(SGX_MAGIC, 0x06, struct sgx_enclave_modify_page_permissions)
> > 
> > struct sgx_enclave_restrict_page_permissions {
> > 	__u64 src;
> > 	__u64 offset;
> > 	__u64 length;
> > 	__u64 secinfo;
> > 	__u64 count;
> > };
> > struct sgx_enclave_extend_page_permissions {
> > 	__u64 src;
> > 	__u64 offset;
> > 	__u64 length;
> > 	__u64 secinfo;
> > 	__u64 count;
> > };
> > 
> > These would simply update the xarray and nothing else. I'd go with two
> > ioctls (with the necessary checks for secinfo) in order to provide hook
> > up points in the future for LSMs.
> > 
> > This leaves only EAUG and EMODT requiring the EACCEPT handshake.
> > 
> > /Jarkko
> The trusted code base here is the enclave. It can't trust any code outside
> for enforcement. There is also need for TLB shootdown.
> 
> To answer your earlier question about threat, the threat is
> malicious/compromised code inside enclave. Yes, you can say the whole thing
> is sand-boxed, but the runtime inside enclave could load complex upper layer
> code.  Therefore the runtime needs to have a trusted mechanism to ensure
> code pages not writable so that there is less/no chance for compromised
> malicious enclave to modify existing code pages. I still consider it to be
> similar to normal Linux elf-loader/dynamic linker relying on mmap/mprotect
> and trusting OS to enforce permissions, but here the enclave runtime only
> trust the HW provided mechanism: EMODPR to change EPCM records and EACCEPT
> to verify.

So what if:

1. User space does EMODPR ioctl.
2. Enclave does EACCEPT.
3. Enclave does EMODPE.

The problem here is the asymmetry of these operations. If EMODPE also
required EACCEPT from the run-time, EMODPR would also make sense.

Please give a code example on how EMODPR improves trust.

/Jarkko
