Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D574C4D40FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239665AbiCJGMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238151AbiCJGMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:12:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CCB6C1ED;
        Wed,  9 Mar 2022 22:11:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E16106191C;
        Thu, 10 Mar 2022 06:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5DCC340E8;
        Thu, 10 Mar 2022 06:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646892693;
        bh=+NRsmFooFziApBCrU39ZrDWDpT82NCDcWI2bwFAfxLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lvOi1HG4F/nEVju0MUqWvgfXpukS80FBaYaZEuuwUboWQ2H8kjjD8VNNF/HXjPLJX
         nu4PsCTIXrQt0A/OBIs7033cPFN0Fc9f8pLWotjPiynqVHgs50DLrCd/gz3qz3eEgB
         PEXte7CnSpNLcrCz9Uvv9uReARgruJhMRRzSbtfDk7LoyxUUz2mtji0HsEgz97zl5j
         kfb/d1gI/yxFqeiwJLsEFhCkfGe66lF0JaBbvpzzviBbughdUoBmK4UJB3KRBSQiRK
         IYcoGSm8R5mmijav0DMrhVx064bWob7MRyOakzUqcavS3H2gCKrGMHKnmq3C6YdxT0
         +aCb6LCq6SocA==
Date:   Thu, 10 Mar 2022 08:10:48 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>
Cc:     "Chatre, Reinette" <reinette.chatre@intel.com>,
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
Message-ID: <YimWaAqEnXHbLdjh@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 07:21:50PM +0000, Dhanraj, Vijay wrote:
> Hi All,
> 
> Regarding the recent update of splitting the page permissions change
> request into two IOCTLS (RELAX and RESTRICT), can we combine them into
> one? That is, revert to how it was done in the v1 version?
> 
> Why? Currently in Gramine (a library OS for unmodified applications,
> https://gramineproject.io/) with the new proposed change, one needs to
> store the page permission for each page or range of pages. And for every
> request of `mmap` or `mprotect`, Gramine would have to do a lookup of the
> page permissions for the request range and then call the respective IOCTL
> either RESTRICT or RELAX. This seems a little overwhelming.
> 
> Request: Instead, can we do `MODPE`,  call `RESTRICT` IOCTL, and then do
> an `EACCEPT` irrespective of RELAX or RESTRICT page permission request?
> With this approach, we can avoid storing  page permissions and simplify
> the implementation.
> 
> I understand RESTRICT IOCTL would do a `MODPR` and trigger `ETRACK` flows
> to do TLB shootdowns which might not be needed for RELAX IOCTL but I am
> not sure what will be the performance impact. Is there any data point to
> see the performance impact?
> 
> Thanks,
> -Vijay

This should get better in the next versuin. "relax" is gone. And for
dynamic EAUG'd pages only VMA and EPCM permissions matter, i.e.
internal vm_max_prot_bits is set to RWX.

I patched the existing series eno

For Enarx I'm using the following patterns.

Shim mmap() handler:
1. Ask host for mmap() syscall.
2. Construct secinfo matching the protection bits.
3. For each page in the address range: EACCEPTCOPY with a
   zero page.
    
Shim mprotect() handler:
1. Ask host for mprotect() syscall.
2. For each page in the address range: EACCEPT with PROT_NONE
   secinfo and EMODPE with the secinfo having the prot bits.
    
Backend mprotect() handler:
1. Invoke ENCLAVE_RESTRICT_PERMISSIONS ioctl for the address
   range with PROT_NONE.
2. Invoke real mprotect() syscall.

Not super-complicated.

That is the safest way to changes permissions i.e. use EMODPR only to reset
the permissions, and EMODPE as EMODP. Then the page is always either
inaccessible completely or with the correct permissions.

Any other ways to use EMODPR are a bit questionable. That's why I tend to
think that it would be better to kernel provide only limited version of it
to reset the permissions. Most of the other use will be most likely
mis-use. IMHO there is only one legit pattern to use it, i.e. "least
racy" pattern.

I would replace SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS with
SGX_IOC_ENCLAVE_RESET_PERMISSIONS that resets pages to PROT_NONE or embed
this straight into mprotect().

BR, Jarkko
