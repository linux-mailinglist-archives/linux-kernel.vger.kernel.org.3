Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D8E4C8C8E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiCAN0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiCAN0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:26:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37FF9D044;
        Tue,  1 Mar 2022 05:26:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8ED796144F;
        Tue,  1 Mar 2022 13:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4705DC340EE;
        Tue,  1 Mar 2022 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646141171;
        bh=q9GySkEXj2qOEws7WQOcFqhKLJ1DJ8LgqDRm04SdGeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPYvYuyueG6EFv2fYzIoq3il0/n2kYnPiWjDUpOFBNjDQrEULzkYVHw1eyjRD2VGv
         rJeF0aqQPQM6AeIBatbJhFQ5vxhYSFPKqUQlEJCvYAv4lLD7TMxD32gi1RUzBLikt0
         NbF4B03o3T8Il98RCGPWG+TeM4yPwRE9uvPwaJVdv8EVcaDO3GgsHrld3/0odUqSx5
         seGKIta13pTceYFRVUsn4gxpO0B6dLdW6ias4B3eN2HywOMApIMIQOKAK3Ozqg2zFk
         EfzDGJbSgVGb1OkOUuWXPJUHik54imQfdglXde2ZN03nr6pbWYcj6z2Xpg0gTS6mXF
         XOl30WceJBOhQ==
Date:   Tue, 1 Mar 2022 14:26:48 +0100
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
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
Message-ID: <Yh4fGORDaJyVrJQW@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <Yhy/GvJegnTqYdq6@iki.fi>
 <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 07:16:22AM -0800, Dave Hansen wrote:
> On 2/28/22 04:24, Jarkko Sakkinen wrote:
> >> Regarding the recent update of splitting the page permissions change
> >> request into two IOCTLS (RELAX and RESTRICT), can we combine them into
> >> one? That is, revert to how it was done in the v1 version?
> > They are logically separate complex functionalities:
> > 
> > 1. "restrict" calls EMODPR and requires EACCEPT
> > 2. "relax" increases permissions up to vetted ("EADD") and could be
> >     combined with EMODPE called inside enclave.
> 
> It would be great to have a _slightly_ better justification than that.
> Existing permission interfaces like chmod or mprotect() don't have this
> asymmetry.
> 
> I think you're saying that the underlying hardware implementation is
> asymmetric, so the interface should be too.  I don't find that argument
> very convincing.  If the hardware interface is arcane and we can make it
> look more sane in the ioctl() layer, we should that, asymmetry or not.

That is my argument, yes.

> If we can't make it any more sane, let's say why the ioctl() must or
> should be asymmetric.

Perhaps underling this asymmetry in kdoc would be enough.

> The SGX2 page permission mechanism is horribly counter intuitive.
> *Everybody* that looks at it thinks that it's wrong.  That means that we
> have a lot of work ahead of us to explain the interfaces that get
> layered on top.

I fully agree on this :-)

With EACCEPTCOPY (kudos to Mark S. for reminding me of this version of
EACCEPT @ chat.enarx.dev) it is possible to make R and RX pages but
obviously new RX pages are now out of the picture:


	/*
	 * Adding a regular page that is architecturally allowed to only
	 * be created with RW permissions.
	 * TBD: Interface with user space policy to support max permissions
	 * of RWX.
	 */
	prot = PROT_READ | PROT_WRITE;
	encl_page->vm_run_prot_bits = calc_vm_prot_bits(prot, 0);
	encl_page->vm_max_prot_bits = encl_page->vm_run_prot_bits;

If that TBD is left out to the final version the page augmentation has a
risk of a API bottleneck, and that risk can realize then also in the page
permission ioctls.

I.e. now any review comment is based on not fully known territory, we have
one known unknown, and some unknown unknowns from unpredictable effect to
future API changes.

BR, Jarkko
