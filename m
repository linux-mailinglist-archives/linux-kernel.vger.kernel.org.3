Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F354CE7E6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 01:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiCFARD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 19:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiCFARC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 19:17:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8EE36B6B;
        Sat,  5 Mar 2022 16:16:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE95960EC8;
        Sun,  6 Mar 2022 00:16:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF420C004E1;
        Sun,  6 Mar 2022 00:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646525771;
        bh=fRzblLoTU0IIepSzyJUSFHl7AXMCwFYni+g4JkSYhbg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QXV9fKVCKfPzG9vF33d7AEPx1yP3YesqHNp08TJJc2sL8HfLEXA/XzmXHNh+A+sLB
         gwuoW6jbm1JS+gms6qn2NrNlXfKZl0MAS1fEtV2fZW6Wlrhe0nf6itzIud25uuxnKJ
         CCA1n/BCF4a+e7+JoFap54ZyxIrCxCCg1DXcSYjaLKLKvRTG7RqF/wYQ5N2xZrbkaG
         jAyhus3BL7L7QynDTZ2uxFs7Y5/8sLjMtOX3GTUr/4v2VaWUhl1phIpM/Yg7B9+a+Z
         axIMqCx6vpEIOK3PcFQmIk3LQUPPbl30kzigbwpc+VnhEdl1LTl6+IVvQpm+rBbzwZ
         pobOlAh8xYGrQ==
Date:   Sun, 6 Mar 2022 02:15:29 +0200
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
Message-ID: <YiP9IWzE3NfmzhB3@iki.fi>
References: <f6a256a6-a7d7-a8e7-c9a8-e232203c63af@intel.com>
 <Yh4fGORDaJyVrJQW@iki.fi>
 <Yh4i4hVcnfZ8QDAl@iki.fi>
 <2d2d3471-78ce-9faa-daf6-138078f5ffaa@intel.com>
 <Yh7Q5fbOtr+6YWaS@iki.fi>
 <6f65287a-f69c-971e-be2c-929e327e7ff9@intel.com>
 <op.1igppyk9wjvjmi@hhuan26-mobl1.mshome.net>
 <19155cab-ecff-a8a6-f724-98c4535642ef@intel.com>
 <ce9bd1a9-491a-09e9-1cdc-a55669f8cf28@intel.com>
 <YiLWvNxI/v43h+VQ@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiLWvNxI/v43h+VQ@iki.fi>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 05, 2022 at 05:19:24AM +0200, Jarkko Sakkinen wrote:
> Sorry, I missed this.
> 
> On Thu, Mar 03, 2022 at 01:44:14PM -0800, Dave Hansen wrote:
> > On 3/3/22 13:23, Reinette Chatre wrote:
> > > Unfortunately MAP_POPULATE is not supported by SGX VMAs because of their
> > > VM_IO and VM_PFNMAP flags. When VMAs with such flags obtain this capability
> > > then I believe that SGX would benefit.
> > 
> > Some Intel folks asked for this quite a while ago.  I think it's
> > entirely doable: add a new vm_ops->populate() function that will allow
> > ignoring VM_IO|VM_PFNMAP if present.
> 
> I'm sorry what I don't understand what you mean by ignoring here,
> i.e. cannot fully comprehend the last sentece.
> 
> And would the vm_ops->populate() be called right after the existing ones
> involved with the VMA creation process?
> 
> > Or, if nobody wants to waste all of the vm_ops space, just add an
> > arch_vma_populate() or something which can call over into SGX.
> > 
> > I'll happily review the patches if anyone can put such a beast together.
> 
> I'll start with vm_ops->populate() and check the feedback first for
> that.

I would instead extend populate() in file_operations into:

int (*populate)(struct file *, struct vm_area_struct *, bool populate);

This does not add to memory consumption.

BR, Jarkko
