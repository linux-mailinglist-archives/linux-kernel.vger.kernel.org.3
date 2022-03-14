Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498224D7977
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235968AbiCNCvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiCNCvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:51:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2A7366A9;
        Sun, 13 Mar 2022 19:49:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 656D060F73;
        Mon, 14 Mar 2022 02:49:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FD3C340E8;
        Mon, 14 Mar 2022 02:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647226194;
        bh=dbiYNCU9zHUF24goSbfL3UhBRIquiNGr7H1wyo9MKdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a8gS5CD1E0e15GzKB5EfpYlVdKyxSbEaAy+8inRwoi/vrQYwfRRh7r2SZ337arDWc
         jBkc83/1SM0gOUvc2VDYWD6xPVofuW2jZXG8yS6/UeeNH1ZVWuWheBEIeGEuqYq4Np
         HnJ0CEAhPIhT0HpNoK0oxu9YorB30rX1eKOTnUxLePQnuXpNXYXwjFoMorFmwhr8EJ
         EYsQXZn8ASLIBIkZc73Ir3eZbOOUTKF2gS9te/VCXG3xRu+KExKuDPSDVKhdRXiqY8
         zUszLLeJTHYL5kUA+afytMeHmg6t5Ev6dnpD1367dIEg7Ot3PZ2IxgMChbTxJMEoJS
         3LNsB0A63lVuA==
Date:   Mon, 14 Mar 2022 04:50:50 +0200
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nathaniel@profian.com
Subject: Re: [PATCH V2 16/32] x86/sgx: Support restricting of enclave page
 permissions
Message-ID: <Yi6tinbF+Y7a66eQ@iki.fi>
References: <cover.1644274683.git.reinette.chatre@intel.com>
 <4ce06608b5351f65f4e6bc6fc87c88a71215a2e7.1644274683.git.reinette.chatre@intel.com>
 <YhLhoMFPyOFZ2fsX@iki.fi>
 <DM8PR11MB55917F499CDF4CC7D426B0A7F63C9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <YimWaAqEnXHbLdjh@iki.fi>
 <op.1itu5vkewjvjmi@hhuan26-mobl1.mshome.net>
 <Yis8LV99mORcLYs6@iki.fi>
 <Yis9rA8uC/0bmWCF@iki.fi>
 <97565fed-dc67-bab1-28d4-c40201c9f055@intel.com>
 <Yi6tPLLt9Q+ailQ3@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yi6tPLLt9Q+ailQ3@iki.fi>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 04:49:37AM +0200, Jarkko Sakkinen wrote:
> On Fri, Mar 11, 2022 at 09:53:29AM -0800, Reinette Chatre wrote:
> 
> > I saw Haitao's note that EMODPE requires "Read access permitted by enclave".
> > This motivates that EMODPR->PROT_NONE should not be allowed since it would
> > not be possible to relax permissions (run EMODPE) after that. Even so, I
> > also found in the SDM that EACCEPT has the note "Read access permitted
> > by enclave". That seems to indicate that EMODPR->PROT_NONE is not practical
> > from that perspective either since the enclave will not be able to
> > EACCEPT the change. Does that match your understanding?
> 
> Yes, PROT_NONE should not be allowed.
> 
> This is however the real problem.
> 
> The current kernel patch set has inconsistent API and EMODPR ioctl is
> simply unacceptable. It  also requires more concurrency management from
> user space run-time, which would be heck a lot easier to do in the kernel.
> 
> If you really want EMODPR as ioctl, then for consistencys sake, then EAUG
> should be too. Like this when things go opposite directions, this patch set
> plain and simply will not work out.
> 
> I would pick EAUG's strategy from these two as it requires half the back
> calls to host from an enclave. I.e. please combine mprotect() and EMODPR,
> either in the #PF handler or as part of mprotect(), which ever suits you
> best.
> 
> I'll try demonstrate this with two examples.
> 
> mmap() could go something like this() (simplified):
> 1. Execution #UD's to SYSCALL.
> 2. Host calls enclave's mmap() handler with mmap() parameters.
> 3. Enclave up-calls host's mmap().
> 4. Loops the range with EACCEPTCOPY.
> 
> mprotect() has to be done like this:
> 1. Execution #UD's to SYSCALL.
> 2. Host calls enclave's mprotect() handler.
> 3. Enclave up-calls host's mprotect().
> 4. Enclave up-calls host's ioctl() to SGX_IOC_ENCLAVE_PERMISSIONS.
> 3. Loops the range with EACCEPT.
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  5. Loops the range with EACCEPT + EMODPE.

> This is just terrible IMHO. I hope these examples bring some insight.

BR, Jarkko
