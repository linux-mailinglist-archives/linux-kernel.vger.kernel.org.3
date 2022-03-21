Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50EA4E341A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbiCUXOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiCUXMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:12:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CE43A999B
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 15:59:46 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647903553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO4RKzBldiOAEmJiMx6aLhvZMlZcwhA9ygIVn0/s/6U=;
        b=q3mJoo5ZuVD9zYf9Am9/ptnPyfpKmmm64dWqVRlQl6cqkWpUCCM21vU1tnN8qVNwItjH0V
        61r/WVxbjIYSGabq+7Z8ONAoM/OtFDoP0auZUnlwO05B9iELp2wOIxcoCqgGEUyvya8FFF
        uX/SPYY/TkPopgaUWepZBjcpZxtktwTOKVSzsw6iFglDz7wwTrfdL6stM5Hs3FuPYIXtuj
        6uEnllhyJJsA6U558260Gslj/WyPEsywd42ChO9qG7nZnmpeE9wKz0LG6zoSKAsYtGt1VW
        +SxZkP53RnYS6HvfD0cwJaIxoRkwzlyJKVoFHMi/FfADrc64pFkAB2VDOtKxFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647903553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GO4RKzBldiOAEmJiMx6aLhvZMlZcwhA9ygIVn0/s/6U=;
        b=fwMnUpsZjdgqJKw+Ax8eJawy5A70hRdp+mZfIL2cQXgF/SAIHubRvQIKRPYpcxNf7Gg24d
        bupB6o4Y7AfIt0DA==
To:     Andy Lutomirski <luto@kernel.org>, Bharata B Rao <bharata@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-mm@kvack.org, the arch/x86 maintainers <x86@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, shuah@kernel.org,
        Oleg Nesterov <oleg@redhat.com>, ananth.narayan@amd.com
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
In-Reply-To: <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <6a5076ad-405e-4e5e-af55-fe2a6b01467d@www.fastmail.com>
Date:   Mon, 21 Mar 2022 23:59:12 +0100
Message-ID: <87fsnac3pb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21 2022 at 15:29, Andy Lutomirski wrote:
> On Thu, Mar 10, 2022, at 3:15 AM, Bharata B Rao wrote:
>> This patchset makes use of Upper Address Ignore (UAI) feature available
>> on upcoming AMD processors to provide user address tagging support for x86/AMD.
>>
>> UAI allows software to store a tag in the upper 7 bits of a logical
>> address [63:57]. When enabled, the processor will suppress the
>> traditional canonical address checks on the addresses. More information
>> about UAI can be found in section 5.10 of 'AMD64 Architecture
>> Programmer's Manual, Vol 2: System Programming' which is available from
>>
>> https://bugzilla.kernel.org/attachment.cgi?id=300549
>
> I hate to be a pain, but I'm really not convinced that this feature is
> suitable for Linux.  There are a few reasons:

Abusing bit 63 is not suitable for any OS in my opinion.

> Right now, the concept that the high bit of an address determines
> whether it's a user or a kernel address is fairly fundamental to the
> x86_64 (and x86_32!) code.  It may not be strictly necessary to
> preserve this, but violating it would require substantial thought.
> With UAI enabled, kernel and user addresses are, functionally,
> interleaved.  This makes things like access_ok checks, and more
> generally anything that operates on a range of addresses, behave
> potentially quite differently.  A lot of auditing of existing code
> would be needed to make it safe.

Which might be finished ten years from now....

Seriously there is no justification for the bit 63 abuse. This has been
pointed out by various people to AMD before this saw the public. Other
vendors seem to have gotten the memo.

The proper solution here is to issue an erratum and fix this nonsense in
microcode for the already taped out silicon and get rid of it in the
design of future ones completely. Anything else is just wishful
thinking.

Thanks,

        tglx
