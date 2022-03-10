Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAD54D40F6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 07:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239692AbiCJGBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 01:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiCJGBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 01:01:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBCD8F637;
        Wed,  9 Mar 2022 22:00:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8780EB8251C;
        Thu, 10 Mar 2022 06:00:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E84C8C340E8;
        Thu, 10 Mar 2022 06:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646892035;
        bh=r5cCxBx7p3YWGZryxH9n4PbKUVpUHmAMBZJNVrUytl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EW98nCiCh80jg8eCpPwOchY6rKiHkkT8EMEGyQkqhOwAT1+Q/CbpAjwr9OKyLEhun
         zHQw/Eqopv2RERq2CYPlEdDion4o6WaRzd9JbM3oH59QsJRDJT4yAkirttiyRNg9XF
         39U+V03uCCv18VZ0FwGnspIVaL5zJ/QHzOWf0t2uM4vNCQVe6TZNRNttSpSocj8Z5s
         lUzdgFr0e+ZEQ1/mFvLUna73833TNcQVquJFRNWGFjqVH8JN37h30oDlDkg6GDo3pV
         afkUj3bJMJz0nmn7g7/ELusgjEALP3lQqf0rnfyp4maALraBbrIeaSOyH8FCJx59ZY
         J0v3L7fymZB7A==
Date:   Thu, 10 Mar 2022 07:59:50 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Haitao Huang <haitao.huang@linux.intel.com>,
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
Message-ID: <YimT1uYC/3EFR1VV@iki.fi>
References: <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi>
 <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com>
 <Yh7Q5fbOtr+6YWaS@iki.fi>
 <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com>
 <op.1igppyk9wjvjmi@hhuan26-mobl1.mshome.net>
 <19155cab-ecff-a8a6-f724-98c4535642ef@intel.com>
 <ce9bd1a9-491a-09e9-1cdc-a55669f8cf28@intel.com>
 <YimQCwmhQkaxMTtn@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YimQCwmhQkaxMTtn@iki.fi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 07:43:42AM +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 03, 2022 at 01:44:14PM -0800, Dave Hansen wrote:
> > On 3/3/22 13:23, Reinette Chatre wrote:
> > > Unfortunately MAP_POPULATE is not supported by SGX VMAs because of their
> > > VM_IO and VM_PFNMAP flags. When VMAs with such flags obtain this capability
> > > then I believe that SGX would benefit.
> > 
> > Some Intel folks asked for this quite a while ago.  I think it's
> > entirely doable: add a new vm_ops->populate() function that will allow
> > ignoring VM_IO|VM_PFNMAP if present.
> > 
> > Or, if nobody wants to waste all of the vm_ops space, just add an
> > arch_vma_populate() or something which can call over into SGX.
> > 
> > I'll happily review the patches if anyone can put such a beast together.
> 
> Everyone would be better off, if EAUG's were done unconditionally for
> mmap() after initialization. Nice property is that this needs no core mm
> changes.
> 
> The resource saving argument is at least a bit weak because you might use
> EMODPR for the address range anyway. So you end up doing things just
> slower. And to have good confidentiality, you actually probably want to
> clear also dynamically added pages with EACCEPTCOPY (and zero page) when
> you take them into use.
> 
> I find it also a bit worrying that enclave has direct access to allocate
> kernel resources and trigger ring-0 opcode. I don't like that part at
> all. syscall/ioctl sets the correct barrier, as the host side should be
> and is the resource manager, not the enclave.

Actually, this should be ABI compatible too. I'd expect all kselftests
continue work as they are.

BR, Jarkko
