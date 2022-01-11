Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A4748A56B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 03:03:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346497AbiAKCDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 21:03:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344038AbiAKCDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 21:03:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E7C06173F;
        Mon, 10 Jan 2022 18:03:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A233DB817D4;
        Tue, 11 Jan 2022 02:03:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3D9C36AED;
        Tue, 11 Jan 2022 02:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641866623;
        bh=iSNnRoY7nMyLZFrXV6bBdZlhZllDqxUvkMd8dsuascU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F2lOGZtN9JkjhJ0Xx0WYo2HbL4qyk/aLbEWpj9ogZTIWZ6jbsIEj8dy5qjM7OYDbi
         xP/BIJwI0cBakC6T9xgmiteqJ7WXJNJJiQ4ijGE+G3y7B5hR27IN2N9AzVYhVPhZPX
         FBEtqjrOB+UUb93cc3bHpX7xvejehisRaaMNWt2UOE67sKfy5kITkYRC1Gv7E8MYpU
         ILZOn7I6/P7osPOS8KI3mIQsqMpNEHFgJqnFlvJytteZ6sr+d1aXvZp7PU5uEM7g3J
         g3NmtzfY2xOSaoPcBtvVy/MfHoCsCo53UvTNnRDf/MWDvI9FyXZnFHaLC/Q4u+XM/0
         hzMgbJpn9hTkQ==
Date:   Tue, 11 Jan 2022 04:03:32 +0200
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
Message-ID: <YdzldMXO2LrssnER@iki.fi>
References: <YcsklLw1uFyppSji@iki.fi>
 <573e0836-6ac2-30a4-0c21-d4763707ac96@intel.com>
 <YdgvFTIRboHwTgRT@iki.fi>
 <op.1fmvdehpwjvjmi@hhuan26-mobl1.mshome.net>
 <YdmxpTVM1JG8nxQ3@iki.fi>
 <YdmzDy1BOHgh8CII@iki.fi>
 <Ydm6RiIwuh3IspRI@iki.fi>
 <op.1fsvkfiwwjvjmi@hhuan26-mobl1.mshome.net>
 <YdzjEzjF0YKn+pZ6@iki.fi>
 <YdzjrIxrVfgrlzWH@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdzjrIxrVfgrlzWH@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 03:55:59AM +0200, Jarkko Sakkinen wrote:
> On Tue, Jan 11, 2022 at 03:53:26AM +0200, Jarkko Sakkinen wrote:
> > On Mon, Jan 10, 2022 at 04:05:21PM -0600, Haitao Huang wrote:
> > > On Sat, 08 Jan 2022 10:22:30 -0600, Jarkko Sakkinen <jarkko@kernel.org>
> > > wrote:
> > > 
> > > > On Sat, Jan 08, 2022 at 05:51:46PM +0200, Jarkko Sakkinen wrote:
> > > > > On Sat, Jan 08, 2022 at 05:45:44PM +0200, Jarkko Sakkinen wrote:
> > > > > > On Fri, Jan 07, 2022 at 10:14:29AM -0600, Haitao Huang wrote:
> > > > > > > > > > OK, so the question is: do we need both or would a
> > > > > mechanism just
> > > > > > > > > to extend
> > > > > > > > > > permissions be sufficient?
> > > > > > > > >
> > > > > > > > > I do believe that we need both in order to support pages
> > > > > having only
> > > > > > > > > the permissions required to support their intended use
> > > > > during the
> > > > > > > > > time the
> > > > > > > > > particular access is required. While technically it is
> > > > > possible to grant
> > > > > > > > > pages all permissions they may need during their lifetime it
> > > > > is safer to
> > > > > > > > > remove permissions when no longer required.
> > > > > > > >
> > > > > > > > So if we imagine a run-time: how EMODPR would be useful, and
> > > > > how using it
> > > > > > > > would make things safer?
> > > > > > > >
> > > > > > > In scenarios of JIT compilers, once code is generated into RW pages,
> > > > > > > modifying both PTE and EPCM permissions to RX would be a good
> > > > > defensive
> > > > > > > measure. In that case, EMODPR is useful.
> > > > > >
> > > > > > What is the exact threat we are talking about?
> > > > > 
> > > > > To add: it should be *significantly* critical thread, given that not
> > > > > supporting only EAUG would leave us only one complex call pattern with
> > > > > EACCEPT involvement.
> > > > > 
> > > > > I'd even go to suggest to leave EMODPR out of the patch set, and
> > > > > introduce
> > > > > it when there is PoC code for any of the existing run-time that
> > > > > demonstrates the demand for it. Right now this way too speculative.
> > > > > 
> > > > > Supporting EMODPE is IMHO by factors more critical.
> > > > 
> > > > At least it does not protected against enclave code because an enclave
> > > > can
> > > > always choose not to EACCEPT any of the EMODPR requests. I'm not only
> > > > confused here about the actual threat but also the potential adversary
> > > > and
> > > > target.
> > > > 
> > > I'm not sure I follow your thoughts here. The sequence should be for enclave
> > > to request  EMODPR in the first place through runtime to kernel, then to
> > > verify with EACCEPT that the OS indeed has done EMODPR.
> > > If enclave does not verify with EACCEPT, then its own code has
> > > vulnerability. But this does not justify OS not providing the mechanism to
> > > request EMODPR.
> > 
> > The question is really simple: what is the threat scenario? In order to use
> > the word "vulnerability", you would need one.
> > 
> > Given the complexity of the whole dance with EMODPR it is mandatory to have
> > one, in order to ack it to the mainline.
> > 
> > > Similar to how we don't want have RWX code pages for normal Linux
> > > application, when an enclave loads code pages (either directly or JIT
> > > compiled from high level code ) into EAUG'd page (which has RW), we do not
> > > want leave pages to be RWX for code to be executable, hence the need of
> > > EMODPR request OS to reduce the permissions to RX once the code is ready to
> > > execute.
> > 
> > You cannot compare *enforced* permissions outside the enclave, and claim that
> > they would be equivalent to the permissions of the already sandboxed code
> > inside the enclave, with permissions that are not enforced but are based
> > on good will of the enclave code.
> 
> To add, you can already do "EMODPR" by simply adjusting VMA permissions to be
> more restrictive. How this would be worse than this collaboration based 
> thing?

... or you could even make soft version of EMODPR without using that opcode
by writing an ioctl to update our xarray to allow lower permissions. That
ties the hands of the process who is doing the mmap() already. 

/Jarkko
