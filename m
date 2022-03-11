Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AD24D6854
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350825AbiCKSNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:13:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiCKSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:13:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6FF1D3DAA;
        Fri, 11 Mar 2022 10:12:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6718561E84;
        Fri, 11 Mar 2022 18:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478CFC340EC;
        Fri, 11 Mar 2022 18:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647022325;
        bh=uYvE7bQA3vVCKRU/cREAI+1LDFVSuyI3rV9XY6TDwYk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EXBUsqoQStTGw+FtuP8pLWZUeAZkBCT85ZilWvbaaqw1nAmSs7q71PHbLdPzfefEd
         162cp/8BaMKh5084i34Out4wfkl3twkNq1kA78HvIHE9OyQEIqXDfWDBMDboimf8g3
         5iCDdpIpzx9Plbf3Fpnou9cajRlkMd6MoOb8PTohiRqhPYUJycWPG5samG+cJZdt88
         q/ZNSh3lm9+Ek/IX0ZLZ84P6QQ1Ha5Fs9l28vT/ki441Oy2b/Y4Km4e4VU8ho1ax/E
         2zOHzrv2dYfhsoMpwkWc55TCurCzUlGGLs8i4CaxsnprJtuvBiyiP9ZjGXtZ9Xh5Py
         bbXGHrcm9zlsw==
Date:   Fri, 11 Mar 2022 20:11:19 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <YiuQx+X9UQ2l22un@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <YimWaAqEnXHbLdjh@iki.fi>
 <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi>
 <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 09:53:29AM -0800, Reinette Chatre wrote:
 
> I do not believe that you encountered the #GP documented above because that
> check is already present in the current implementation of
> SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS:
> 
> sgx_ioc_enclave_restrict_permissions()->sgx_perm_from_user_secinfo():
> 	if ((perm & SGX_SECINFO_W) && !(perm & SGX_SECINFO_R))
> 		return -EINVAL;
> 
> It does return EINVAL which is the catch-all error code used to represent
> invalid input from user space. I am not convinced that EACCES should be used
> instead though, EACCES means "Permission denied", which is not the case here.
> The case here is just an invalid request.
> 
> It currently does not prevent the user from setting PROT_NONE though, which
> EMODPR does seem to allow.
> 
> I saw Haitao's note that EMODPE requires "Read access permitted by enclave".
> This motivates that EMODPR->PROT_NONE should not be allowed since it would
> not be possible to relax permissions (run EMODPE) after that. Even so, I
> also found in the SDM that EACCEPT has the note "Read access permitted
> by enclave". That seems to indicate that EMODPR->PROT_NONE is not practical
> from that perspective either since the enclave will not be able to
> EACCEPT the change. Does that match your understanding?
> 
> I will add the check for R in SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS at least.

Yes, I think we are in the same line with this.

But there is another thing.

As EAUG is taken care by the page handler so should EMODPR. It makes the
developer experience whole a lot easier when you don't have to back call
to host and ask it to execute EMODPR for the range.

It's also a huge incosistency in this patch set that they are handled
differently.

And it creates a concurrency case for user space that is complicated to say
the least, i.e. divided work between host and enclave implementation to
execute EMODPR is a nightmare scenario. On the other hand this is trivial
to sort out in kernel.

So what it means that, in one way or antoher, mprotect() needs to be the
melting point for both. This can be called mandatory requirement, however
this patch set it done, not least because of managing concurrency between
kernel and user space.

You can get that done by these steps:

1. Unmap PTE's in mprotect() flow.
2. In #PF handler, EMODPR with R set.

This clear API for enclave developer because you know in what state pages
are after mprotect(), and what you need to still do to them. Only the
syscall needs to be them performed by the host side.

BR, Jarkko
