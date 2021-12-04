Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B38468832
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 00:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhLDXQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 18:16:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:36894 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbhLDXQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 18:16:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 144A760F28;
        Sat,  4 Dec 2021 23:13:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5C2C341C0;
        Sat,  4 Dec 2021 23:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638659585;
        bh=xuirBdsXzzPtl9EEh0mQgSHxLbk3dDXitBScKP/mMpU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vC/n3iNDGrP+fDH4qvZ6VWYkyRUPPLPDP3IT5hep3e4Ri7L8A9Ydk5wsQzFNQ7CK/
         AvxeyyDY16/1AcDpVUrze6Qdlwf8BPIS5U9p0LMghycRgoNYPE/O+RGXLK/gAh4mE7
         /3PPM6/0XaMQsrnEKaCboaqIwlgO3S0lw5r4ewAnIfGxiw0Ealzksoz6ZVIUi+FL7F
         kHlG0RnQCQBi/uExRyZn6mLeMvZ7NPdVN9CqcjwXI+19ypyPr8hE/P8u1+i8dsqTCR
         iJVQrjuQMWb1xoLPXxQ5L4GDXYNCDFVKCGnsuoOU3D1io9Zh2ZUxiCAlklo26UvqCr
         j8b8YtiMY+DkQ==
Date:   Sun, 5 Dec 2021 01:13:01 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/25] x86/sgx: Support adding of pages to initialized
 enclave
Message-ID: <Yav1/ZRX68cECD7a@iki.fi>
References: <cover.1638381245.git.reinette.chatre@intel.com>
 <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab661a845d242cb10a90ade997f8ebda33cc7c9.1638381245.git.reinette.chatre@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"to initialize" -> "to an initialized"

On Wed, Dec 01, 2021 at 11:23:11AM -0800, Reinette Chatre wrote:
> With SGX1 an enclave needs to be created with its maximum memory demands
> allocated. Pages cannot be added to an enclave after it is initialized.
> SGX2 introduces a new function, ENCLS[EAUG], that can be used to add
> pages to an initialized enclave. With SGX2 the enclave still needs to
> set aside address space for its maximum memory demands during enclave
> creation, but all pages need not be added before enclave initialization.
> Pages can be added during enclave runtime.
> 
> Add support for dynamically adding pages to an initialized enclave,
> architecturally limited to RW permission. Add pages via the page fault
> handler at the time an enclave address without a backing enclave page
> is accessed, potentially directly reclaiming pages if no free pages
> are available.
> 
> The enclave is still required to run ENCLU[EACCEPT] on the page before
> it can be used. A useful flow is for the enclave to run ENCLU[EACCEPT]
> on an uninitialized address. This will trigger the page fault handler
> that will add the enclave page and return execution to the enclave to
> repeat the ENCLU[EACCEPT] instruction, this time successful.
> 
> If the enclave accesses an uninitialized address in another way, for
> example by expanding the enclave stack to a page that has not yet been
> added, then the page fault handler would add the page on the first
> write but upon returning to the enclave the instruction that triggered
> the page fault would be repeated and since ENCLU[EACCEPT] was not run
> yet it would trigger a second page fault, this time with the SGX flag
> set in the page fault error code. This can only be recovered by entering
> the enclave again and directly running the ENCLU[EACCEPT] instruction on
> the now initialized address.
> 
> Accessing an uninitialized address from outside the enclave also triggers
> this flow but the page will remain in PENDING state until accepted from
> within the enclave.

What does it mean being in PENDING state, and more imporantly, what is
PENDING state? What does a memory access within enclave cause when it
touch a page within this state?

I see a lot of text in the commit message but zero mentions about EPCM
expect this one sudden mention about PENDING field without attaching
it to anything concrete.

/Jarkko

