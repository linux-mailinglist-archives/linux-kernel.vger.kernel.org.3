Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE7E4D7975
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiCNCtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiCNCtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:49:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7DE2AE34;
        Sun, 13 Mar 2022 19:48:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04D8560F73;
        Mon, 14 Mar 2022 02:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DBDC340E8;
        Mon, 14 Mar 2022 02:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647226116;
        bh=cdxrnVF+mdB7TRc/m1TVEM0ez+IrY1+UczlFrVPBIDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qO6KL/yWZaUqhz1ePHakl6NGSjBJB1o36h3/ASqNEEgWMl1ppM03Djifu0Ivur3QG
         te5y/GQooC4bdnGdz8z1t8QwwAC0CYXZ/q9tBbuFzzvcW/cSIcrzaouJdGXJbo5NbB
         PSEezrFXa2awV3PKy0s7ptIZ51RnDqKt9iJZUhj5NB/X4BSTHiFE/wkTOKv+rrQati
         wdOeLFthHWLJV7DdaRInORRoEv6hMZKVndUPypm2sUNSWqu+ixdOL37CNOVQwVKJQS
         GMN7IHWDzI1ynPruoe5yknCGz4DggqJjGYN0NWHve/KisEiyi7iWLOUpD6GOuF7gMg
         Za/am1gIceI3g==
Date:   Mon, 14 Mar 2022 04:49:32 +0200
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
Message-ID: <Yi6tPLLt9Q+ailQ3@iki.fi>
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
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 09:53:29AM -0800, Reinette Chatre wrote:

> I saw Haitao's note that EMODPE requires "Read access permitted by enclave".
> This motivates that EMODPR->PROT_NONE should not be allowed since it would
> not be possible to relax permissions (run EMODPE) after that. Even so, I
> also found in the SDM that EACCEPT has the note "Read access permitted
> by enclave". That seems to indicate that EMODPR->PROT_NONE is not practical
> from that perspective either since the enclave will not be able to
> EACCEPT the change. Does that match your understanding?

Yes, PROT_NONE should not be allowed.

This is however the real problem.

The current kernel patch set has inconsistent API and EMODPR ioctl is
simply unacceptable. It  also requires more concurrency management from
user space run-time, which would be heck a lot easier to do in the kernel.

If you really want EMODPR as ioctl, then for consistencys sake, then EAUG
should be too. Like this when things go opposite directions, this patch set
plain and simply will not work out.

I would pick EAUG's strategy from these two as it requires half the back
calls to host from an enclave. I.e. please combine mprotect() and EMODPR,
either in the #PF handler or as part of mprotect(), which ever suits you
best.

I'll try demonstrate this with two examples.

mmap() could go something like this() (simplified):
1. Execution #UD's to SYSCALL.
2. Host calls enclave's mmap() handler with mmap() parameters.
3. Enclave up-calls host's mmap().
4. Loops the range with EACCEPTCOPY.

mprotect() has to be done like this:
1. Execution #UD's to SYSCALL.
2. Host calls enclave's mprotect() handler.
3. Enclave up-calls host's mprotect().
4. Enclave up-calls host's ioctl() to SGX_IOC_ENCLAVE_PERMISSIONS.
3. Loops the range with EACCEPT.

This is just terrible IMHO. I hope these examples bring some insight.

BR, Jarkko
