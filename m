Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C231F468820
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 23:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbhLDWrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 17:47:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbhLDWrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 17:47:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 511DCC061751;
        Sat,  4 Dec 2021 14:43:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B665660F34;
        Sat,  4 Dec 2021 22:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3CBC341C2;
        Sat,  4 Dec 2021 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638657815;
        bh=Oi2gHDAoxVW5e0bNBs/Os74W+RmXk7U4l0nr6HuqW1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQwSmDVD2C9q6qYOv6A2UJcDmy4M7ZEUXKQTDVDcrVqH0ssR+dkWcr6NqNqiTk9kX
         TGwHCou64e8ANpM5KuZw2jjcYp6r//Pf3LYEzsoQphVMLFkcrImDscUGaT8wef1qqI
         jIV+IpZde8yJ/2rlCnejB5EMBpOYHeGUD4SKxN2/c16woeLEvpXNfhbSfF04wp313x
         A5gVxwNEG29jiYlYtP+xKjmqv2/BZp6Q/gF3rAzhI4AOmVfyUAN8E2LPX2qOIuyfyl
         RoxPlPA3eOtfvcnPZpF2l/CEUUTR2EIz3qtB+M1oAgbKSKkWBHQ3qjm3fD7Mxn+104
         hrv+ZXA5aeOaw==
Date:   Sun, 5 Dec 2021 00:43:31 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/25] x86/sgx: Add pfn_mkwrite() handler for present PTEs
Message-ID: <YavvE+wF5XQNXlFu@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <9edf8cd20628cbf400886d88e359fb24265fdef0.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9edf8cd20628cbf400886d88e359fb24265fdef0.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:23:02AM -0800, Reinette Chatre wrote:
> By default a write page fault on a present PTE inherits the permissions
> of the VMA. Enclave page permissions maintained in the hardware's
> Enclave Page Cache Map (EPCM) may change after a VMA accessing the page
> is created. A VMA's permissions may thus exceed the enclave page
> permissions even though the VMA was originally created not to exceed
> the enclave page permissions. Following the default behavior during
> a page fault on a present PTE while the VMA permissions exceed the
> enclave page permissions would result in the PTE for an enclave page
> to be writable even though the page is not writable according to the
> enclave's permissions.
> 
> Consider the following scenario:
> * An enclave page exists with RW EPCM permissions.
> * A RW VMA maps the range spanning the enclave page.
> * The enclave page's EPCM permissions are changed to read-only.

How could this happen in the existing mainline code?

> * There is no page table entry for the enclave page.
> 
> Q.
>  What will user space observe when an attempt is made to write to the
>  enclave page from within the enclave?
> 
> A.
>  Initially the page table entry is not present so the following is
>  observed:
>  1) Instruction writing to enclave page is run from within the enclave.
>  2) A page fault with second and third bits set (0x6) is encountered
>     and handled by the SGX handler sgx_vma_fault() that installs a
>     read-only page table entry following previous patch that installs
>     page table entry with permissions that VMA and enclave agree on
>     (read-only in this case).
>  3) Instruction writing to enclave page is re-attempted.
>  4) A page fault with first three bits set (0x7) is encountered and
>     transparently (from SGX and user space perspective) handled by the
>     OS with the page table entry made writable because the VMA is
>     writable.
>  5) Instruction writing to enclave page is re-attempted.
>  6) Since the EPCM permissions prevents writing to the page a new page
>     fault is encountered, this time with the SGX flag set in the error
>     code (0x8007). No action is taken by OS for this page fault and
>     execution returns to user space.
>  7) Typically such a fault will be passed on to an application with a
>     signal but if the enclave is entered with the vDSO function provided
>     by the kernel then user space does not receive a signal but instead
>     the vDSO function returns successfully with exception information
>     (vector=14, error code=0x8007, and address) within the exception
>     fields within the vDSO function's struct sgx_enclave_run.
> 
> As can be observed it is not possible for user space to write to an
> enclave page if that page's enclave page permissions do not allow so,
> no matter what the VMA or PTE allows.
> 
> Even so, the OS should not allow writing to a page if that page is not
> writable. Thus the page table entry should accurately reflect the
> enclave page permissions.
> 
> Do not blindly accept VMA permissions on a page fault due to a write
> attempt to a present PTE. Install a pfn_mkwrite() handler that ensures
> that the VMA permissions agree with the enclave permissions in this
> regard.
> 
> Considering the same scenario as above after this change results in
> the following behavior change:
> 
> Q.
>  What will user space observe when an attempt is made to write to the
>  enclave page from within the enclave?
> 
> A.
>  Initially the page table entry is not present so the following is
>  observed:
>  1) Instruction writing to enclave page is run from within the enclave.
>  2) A page fault with second and third bits set (0x6) is encountered
>     and handled by the SGX handler sgx_vma_fault() that installs a
>     read-only page table entry following previous patch that installs
>     page table entry with permissions that VMA and enclave agree on
>     (read-only in this case).
>  3) Instruction writing to enclave page is re-attempted.
>  4) A page fault with first three bits set (0x7) is encountered and
>     passed to the pfn_mkwrite() handler for consideration. The handler
>     determines that the page should not be writable and returns SIGBUS.
>  5) Typically such a fault will be passed on to an application with a
>     signal but if the enclave is entered with the vDSO function provided
>     by the kernel then user space does not receive a signal but instead
>     the vDSO function returns successfully with exception information
>     (vector=14, error code=0x7, and address) within the exception fields
>     within the vDSO function's struct sgx_enclave_run.
> 
> The accurate exception information supports the SGX runtime, which is
> virtually always implemented inside a shared library, by providing
> accurate information in support of its management of the SGX enclave.

This QA-format is not a great idea, as it kind of tells what are the legit
questions to ask. You should describe what the patch does and what are the
legit reasons for doing that. Unfortunately, in the current form it is very
hard to get grip of this patch.

/Jarkko
