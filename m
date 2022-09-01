Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501A25AA148
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 23:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235157AbiIAU70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiIAU6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:58:43 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2949A9C1DA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:58:31 -0700 (PDT)
Date:   Thu, 1 Sep 2022 16:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662065909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hkUsmhoc/mtitBsMEKBISOd/1pAkSpFc2P/cfXQtjM=;
        b=GBx/osHm3HGi4Ds4wKNlfh+0rOeAjSc5fMxjCY9+prDg46Our7ah2+T4UCkEyoyjGAR3Ey
        DNyFdaH7yElNXaYOG7p+DGMlnJB29QeQAVtRk4yNGTDim3sXPR4Q5JwB92gpqpAdtQY8uE
        Z2Ok6tGIN+Dib9yzL+1nMDwaoBKyC1E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@suse.de, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, laurent.dufour@fr.ibm.com,
        paulmck@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        kernel-team@android.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND 00/28] per-VMA locks proposal
Message-ID: <20220901205819.emxnnschszqv4ahy@moria.home.lan>
References: <20220901173516.702122-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220901173516.702122-1-surenb@google.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 10:34:48AM -0700, Suren Baghdasaryan wrote:
> Resending to fix the issue with the In-Reply-To tag in the original
> submission at [4].
> 
> This is a proof of concept for per-vma locks idea that was discussed
> during SPF [1] discussion at LSF/MM this year [2], which concluded with
> suggestion that “a reader/writer semaphore could be put into the VMA
> itself; that would have the effect of using the VMA as a sort of range
> lock. There would still be contention at the VMA level, but it would be an
> improvement.” This patchset implements this suggested approach.
> 
> When handling page faults we lookup the VMA that contains the faulting
> page under RCU protection and try to acquire its lock. If that fails we
> fall back to using mmap_lock, similar to how SPF handled this situation.
> 
> One notable way the implementation deviates from the proposal is the way
> VMAs are marked as locked. Because during some of mm updates multiple
> VMAs need to be locked until the end of the update (e.g. vma_merge,
> split_vma, etc). Tracking all the locked VMAs, avoiding recursive locks
> and other complications would make the code more complex. Therefore we
> provide a way to "mark" VMAs as locked and then unmark all locked VMAs
> all at once. This is done using two sequence numbers - one in the
> vm_area_struct and one in the mm_struct. VMA is considered locked when
> these sequence numbers are equal. To mark a VMA as locked we set the
> sequence number in vm_area_struct to be equal to the sequence number
> in mm_struct. To unlock all VMAs we increment mm_struct's seq number.
> This allows for an efficient way to track locked VMAs and to drop the
> locks on all VMAs at the end of the update.

I like it - the sequence numbers are a stroke of genuius. For what it's doing
the patchset seems almost small.

Two complaints so far:
 - I don't like the vma_mark_locked() name. To me it says that the caller
   already took or is taking the lock and this function is just marking that
   we're holding the lock, but it's really taking a different type of lock. But
   this function can block, it really is taking a lock, so it should say that.
   
   This is AFAIK a new concept, not sure I'm going to have anything good either,
   but perhaps vma_lock_multiple()?

 - I don't like the #ifdef and the separate fallback path in the fault handlers.

   Can we make find_and_lock_anon_vma() do the right thing, and not fail unless
   e.g. there isn't a vma at that address? Just have it wait for vm_lock_seq to
   change and then retry if needed.
