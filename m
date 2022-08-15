Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F932593032
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 15:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiHONrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHONrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 09:47:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1453F1A383
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 06:47:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A66B860EE9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 13:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E1DC433D6;
        Mon, 15 Aug 2022 13:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660571238;
        bh=0o95ZoWpRqBW2rSC17dLLryvgMyYfOTNout4mhOWKdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Otm+t0Tp6UPqtTkEaf9l2DWnUuoDo1YSKilLO92pD1KUcxl+XJ7q5kBj4N1R6CFWp
         sK2e4GZgbRIZ++IGBv6Wtb+GYs87/8lVzh+acUl+kUHkVaiRusjHZCQt3bOjgDHZlV
         UouxQjBKUXrXTHxZDrcEPwObk1yLiWhKjY8ZO/zLXBGemNB2x8G/RA0SZ9DCwRKSKP
         cKTb377kLXSha7xpTyy77s4RTaAg1UQGVw7Tgh/ejesKCdi+fgtjmcIB7SnOfCuY1T
         C82r8hy01iwJTKimLlZShhOtOvJcpvsTbtiXakYSOM0TwxaYtReb58/sBH4ZAG8oQ0
         +eIkCdrnw+CxA==
Date:   Mon, 15 Aug 2022 14:47:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Asahi Linux <asahi@lists.linux.dev>,
        Oliver Neukum <oneukum@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Debugging a TTY race condition on M1 (memory ordering dragons)
Message-ID: <20220815134711.GA10374@willie-the-truck>
References: <6c089268-4f2c-9fdf-7bcb-107b611fbc21@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c089268-4f2c-9fdf-7bcb-107b611fbc21@marcan.st>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hector,

On Mon, Aug 15, 2022 at 08:16:56PM +0900, Hector Martin wrote:
> I'm trying to debug a TTY layer race on Apple M1 machines, and I'm deep
> enough into the rabbit hole that I could use some suggestions/help
> figuring out how to continue approaching this.

I'm really not familiar with the TTY layer, but here's hoping I can help
a bit on the memory ordering side of things...

> With the test case, two packets end up getting pushed to the TTY: 1024
> bytes and 186 bytes (total 1210). What I observe is that sometimes,
> after commit is set to 1210, queue_work() returns false (indicating that
> work is already queued and hasn't begun executing yet), yet the last
> work function execution only sees commit==1024. When this happens,
> flush_to_ldisc and queue_work were both executing within a microsecond
> or two of each other:
> 
> [    5.408251] queue_work() ret false (commit=1210)
> [    5.410367] flush_to_ldisc() commit=1210
> 644
> [    5.410984] flush_to_ldisc() commit=1024
> [    5.411570] flush_to_ldisc() commit=1210
> 645
> [    5.412202] flush_to_ldisc() commit=1024
> [    5.412785] flush_to_ldisc() commit=1210
> 646
> [    5.413630] flush_to_ldisc() commit=1024
> [    5.413631] queue_work() ret false (commit=1210)
> <hang because userspace never gets the data>
> 
> The queue_work() documentation says:
> 
> > Memory-ordering properties: If it returns true, guarantees that all
> > stores preceding the call to queue_work() in the program order will
> > be visible from the CPU which will execute work by the time such work
> > executes
> 
> That would seem to imply that if it returns false, there are no memory
> ordering guarantees. If that were the case, the TTY layer's usage of
> queue_work() would be buggy. However, that would also make the memory
> ordering guarantees essentially useless, since you *need* to know that
> if the work is already queued and hasn't started running yet, it will
> see all writes you've made until the call (otherwise you'd have to add
> manual barriers before queue_work(), which defeats the purpose of
> ordering guarantees in the normal case). So, I posit that the
> documentation is incomplete and queue_work() does indeed provide such
> guarantees.
> 
> Behind the scenes, the work pending flag is atomically set with
> test_and_set_bit() by queue_work_on(). That compiles down to my old
> friend LDSETAL, which I already showed [2] does not provide the
> guarantees test_and_set_bit() claims to have (== full memory barrier).
> However, I can't get that litmus test to fail on real hardware, so that
> may be a red herring as far as this bug goes.

As I mentioned in the thread you linked to, the architecture was undergoing
review in this area. I should've followed back up, but in the end it was
tightened retrospectively to provide the behaviour you wanted. This was
achieved by augmenting the barrier-ordered-before relation with:

  * RW1 is a memory write effect W1 and is generated by an atomic instruction
    with both Acquire and Release semantics.

You can see this in the latest Arm ARM.

However, test_and_set_bit() is unordered on failure (i.e. when the bit is
unchanged) and uses READ_ONCE() as a quick check before the RmW. See the
"ORDERING" section of Documentation/atomic_bitops.txt.

> On the other end of things, we have this lovely comment:
> 
> static void set_work_pool_and_clear_pending(struct work_struct *work,
>                                             int pool_id)
> {
>     /*
>      * The following wmb is paired with the implied mb in
>      * test_and_set_bit(PENDING) and ensures all updates to @work made
>      * here are visible to and precede any updates by the next PENDING
>      * owner.
>      */
>     smp_wmb();
>     /* note: this is an atomic_long_set */
>     set_work_data(work, (unsigned long)pool_id << WORK_OFFQ_POOL_SHIFT, 0);
>     /*
>      * The following mb guarantees that previous clear of a PENDING bit
>      * will not be reordered with any speculative LOADS or STORES from
>      * work->current_func, which is executed afterwards.  This possible
>      * reordering can lead to a missed execution on attempt to queue
>      * the same @work.  E.g. consider this case:
>      *
>      *   CPU#0                         CPU#1
>      *   ----------------------------  --------------------------------
>      *
>      * 1  STORE event_indicated
>      * 2  queue_work_on() {
>      * 3    test_and_set_bit(PENDING)
>      * 4 }                             set_..._and_clear_pending() {
>      * 5                                 set_work_data() # clear bit
>      * 6                                 smp_mb()
>      * 7                               work->current_func() {
>      * 8                      LOAD event_indicated
>      *                   }
>      *
>      * Without an explicit full barrier speculative LOAD on line 8 can
>      * be executed before CPU#0 does STORE on line 1.  If that happens,
>      * CPU#0 observes the PENDING bit is still set and new execution of
>      * a @work is not queued in a hope, that CPU#1 will eventually
>      * finish the queued @work.  Meanwhile CPU#1 does not see
>      * event_indicated is set, because speculative LOAD was executed
>      * before actual STORE.
>      */
>     smp_mb();
> }
> 
> That would indeed agree with the idea that queue_work() does offer
> guarantees in the ret==false case. And yet, it doesn't work.
> 
> Effectively we have the sequence:
> 
> CPU#1:
>   STLR A
>   LDSETAL B

I think you're missing the "shortcut" in test_and_set_bit():

        if (READ_ONCE(*p) & mask)
                return 1;

        old = arch_atomic_long_fetch_or(mask, (atomic_long_t *)p);

so if the bit is already set (which I think is the 'ret == false' case)
then you've only got a control dependency here and we elide writing to
B.

> 
> CPU#2:
>   DMB ISHST
>   STR B

Missing DMB ISH here from the smp_mb()?

>   LDAR A
> 
> I tried writing a litmus test for this, but I wasn't able to make it
> fail on neither herd7 nor real hardware. And yet I can trivially
> reproduce the problem in vivo with the TTY layer. Perhaps there are
> other preconditions to this particular sequence failing on real hardware
> (related to caches, speculation, etc)...

Hmm, without the full DMB on CPU2, the store to B and the load-acquire from
A are not ordered so it really should fail.

> I did stumble upon something a bit odd with the LSE atomic/STR pairing.
> I also couldn't get a litmus to fail this in neither sim nor hardware,
> so I probably just missed something about the memory model, but:
> according to the ARM, the load/store halves of an atomic op are
> Atomic-ordered-before among themselves, and the write is
> Atomic-ordered-before a subsequent read with acquire semantics. However,
> there is no mention of non-atomic writes. So, by my reading, this is
> possible:
> 
> (flag is 1)
> LDSETAL LOAD 1
> STR 0
> LDSETAL STORE 1
> 
> Which would leave you with LDSETAL claiming the old/new values are both
> 1, while the store completed and vanished. This seems pretty insane, and
> would mean atomic_long_set() isn't actually atomic wrt other atomic ops,
> but I couldn't figure out what forbids it, at least in the textual
> description of the memory model. If this is indeed not forbidden, then
> this could happen:
> 
> LDSETAL Read-Acquire (1)
>   STR pending=0
>   LDAR commit=old
> STLR commit=new // can move below read-acquire
> LDSETAL Write-Release (1)
> (Returned 1, so work is not requeued)
> 
> But as I said, I couldn't prove that this is possible with herd7 or litmus7.

If that non-atomic store is hitting the same variable, then it cannot land
in the middle of the atomic RmW. The architecture says:

 | The atomic instructions perform atomic read and write operations on a memory
 | location such that the architecture guarantees that no modification of that
 | memory location by another observer can occur between the read and the write
 | defined by that instruction.

and the .cat file used by herd has a separate constraint for this (see the
"empty rmw & (fre; coe) as atomic" line).

> On the "trying random things" front, this fixes the bug:
> 
> 	tty_flip_buffer_commit(buf->tail);
> 	smp_mb();
> 	queue_work(system_unbound_wq, &buf->work);
> 
> But this does not:
> 
> 	tty_flip_buffer_commit(buf->tail);
> 	smp_wmb();
> 	queue_work(system_unbound_wq, &buf->work);
> 
> Which does kind of point towards the "load side moving up" theory.
> 
> Any ideas? Am I onto something with the STR/LDSETAL thing? Memory model
> confusion? CPU bug? Did I miss an obvious bug? :)

There's never anything obvious when you're working with this sort of stuff,
but my suggestion is that we work towards a litmus tests that we both agree
represents the code and then take it from there. At the moment there's an
awful lof of information, but you can see from my comments that I'm not
up to speed with you yet!

Cheers,

Will
