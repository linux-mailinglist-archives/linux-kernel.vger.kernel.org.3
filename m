Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF931592E00
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiHOLRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiHOLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:17:07 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3BE1402F
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 04:17:03 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 767FB426F5;
        Mon, 15 Aug 2022 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1660562221; bh=/rdttBzwCELw49SiLgxYAxi8Kf7NXa7Ve6ox6bsE0NE=;
        h=Date:To:Cc:From:Subject;
        b=EqiuiHIOBks3OZJxtXBMlEwy5EIcTInGH5wZMBnWV5HSZ/S8sRGFCFUmGFbZtBHwd
         eGUYDK6f3UDCyYyKa1zOZOQylfwozz63iNsci5aHZ3lulb71jsYIKkfTCz1LeM03bW
         A7vv4xLjNE4tGO+j8o9B5WLi+cYJ1YVevf1yeJSgcn80fPYm2FOSPxs4qXtrTPP/6p
         xSIrk9jT++Lq8aWql3lYqeyZCk2HV6EamL1KRfHxi0VmMvAn+CEEgRmsSc1t93nUEL
         m9CRISGdwK82KVCyOZ9K8rK+EkLoh5bK3nXioKuF/VDNBbEXr9Mrq4qBjVORzhkbR5
         ToNHyPTJKx9/w==
Message-ID: <6c089268-4f2c-9fdf-7bcb-107b611fbc21@marcan.st>
Date:   Mon, 15 Aug 2022 20:16:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: es-ES
To:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>, jirislaby@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Asahi Linux <asahi@lists.linux.dev>,
        Oliver Neukum <oneukum@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Hector Martin <marcan@marcan.st>
Subject: Debugging a TTY race condition on M1 (memory ordering dragons)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to debug a TTY layer race on Apple M1 machines, and I'm deep
enough into the rabbit hole that I could use some suggestions/help
figuring out how to continue approaching this.

The issue is that when the cdc-acm driver pushes some data into the TTY
in quick succession (two USB packets), with an active userspace reader,
sometimes the second packet ends up in limbo and never gets delivered to
the ldisc (until more data arrives). This quickly reproduces (within a
second or two) by running this [1] script on an M1 Pro or M1 Max with
another M1 machine connected running the m1n1 proxy, using the Asahi
Linux kernels we ship to end users right now. It does not reproduce with
a random monolithic test kernel I have, so clearly there is some
difference there, but I haven't tried to bisect that yet.

This is already having gone through blaming my m1n1 code, our dwc3
driver, my AIC IRQ controller code, the CDC-ACM driver, etc, but I'll
skip those parts. The rabbit hole goes deeper.

Code context:

static inline void tty_flip_buffer_commit(struct tty_buffer *tail)
{
	smp_store_release(&tail->commit, tail->used);
}

void tty_flip_buffer_push(struct tty_port *port)
{
	struct tty_bufhead *buf = &port->buf;

	tty_flip_buffer_commit(buf->tail);
	queue_work(system_unbound_wq, &buf->work);

}

/* This is the work function */
static void flush_to_ldisc(struct work_struct *work)
{
[...]
	while (1) {
		[...]
		count = smp_load_acquire(&head->commit) - head->read;
		if (!count) {
			if (next == NULL)
				break;
			[...]
		}
		// do stuff with the buffer
		[...]
	}
[...]
}

Commit is accessed with acquire/release ops, which compile down to LDAR
and STLR.

With the test case, two packets end up getting pushed to the TTY: 1024
bytes and 186 bytes (total 1210). What I observe is that sometimes,
after commit is set to 1210, queue_work() returns false (indicating that
work is already queued and hasn't begun executing yet), yet the last
work function execution only sees commit==1024. When this happens,
flush_to_ldisc and queue_work were both executing within a microsecond
or two of each other:

[    5.408251] queue_work() ret false (commit=1210)
[    5.410367] flush_to_ldisc() commit=1210
644
[    5.410984] flush_to_ldisc() commit=1024
[    5.411570] flush_to_ldisc() commit=1210
645
[    5.412202] flush_to_ldisc() commit=1024
[    5.412785] flush_to_ldisc() commit=1210
646
[    5.413630] flush_to_ldisc() commit=1024
[    5.413631] queue_work() ret false (commit=1210)
<hang because userspace never gets the data>

The queue_work() documentation says:

> Memory-ordering properties: If it returns true, guarantees that all
> stores preceding the call to queue_work() in the program order will
> be visible from the CPU which will execute work by the time such work
> executes

That would seem to imply that if it returns false, there are no memory
ordering guarantees. If that were the case, the TTY layer's usage of
queue_work() would be buggy. However, that would also make the memory
ordering guarantees essentially useless, since you *need* to know that
if the work is already queued and hasn't started running yet, it will
see all writes you've made until the call (otherwise you'd have to add
manual barriers before queue_work(), which defeats the purpose of
ordering guarantees in the normal case). So, I posit that the
documentation is incomplete and queue_work() does indeed provide such
guarantees.

Behind the scenes, the work pending flag is atomically set with
test_and_set_bit() by queue_work_on(). That compiles down to my old
friend LDSETAL, which I already showed [2] does not provide the
guarantees test_and_set_bit() claims to have (== full memory barrier).
However, I can't get that litmus test to fail on real hardware, so that
may be a red herring as far as this bug goes.

On the other end of things, we have this lovely comment:

static void set_work_pool_and_clear_pending(struct work_struct *work,
                                            int pool_id)
{
    /*
     * The following wmb is paired with the implied mb in
     * test_and_set_bit(PENDING) and ensures all updates to @work made
     * here are visible to and precede any updates by the next PENDING
     * owner.
     */
    smp_wmb();
    /* note: this is an atomic_long_set */
    set_work_data(work, (unsigned long)pool_id << WORK_OFFQ_POOL_SHIFT, 0);
    /*
     * The following mb guarantees that previous clear of a PENDING bit
     * will not be reordered with any speculative LOADS or STORES from
     * work->current_func, which is executed afterwards.  This possible
     * reordering can lead to a missed execution on attempt to queue
     * the same @work.  E.g. consider this case:
     *
     *   CPU#0                         CPU#1
     *   ----------------------------  --------------------------------
     *
     * 1  STORE event_indicated
     * 2  queue_work_on() {
     * 3    test_and_set_bit(PENDING)
     * 4 }                             set_..._and_clear_pending() {
     * 5                                 set_work_data() # clear bit
     * 6                                 smp_mb()
     * 7                               work->current_func() {
     * 8                      LOAD event_indicated
     *                   }
     *
     * Without an explicit full barrier speculative LOAD on line 8 can
     * be executed before CPU#0 does STORE on line 1.  If that happens,
     * CPU#0 observes the PENDING bit is still set and new execution of
     * a @work is not queued in a hope, that CPU#1 will eventually
     * finish the queued @work.  Meanwhile CPU#1 does not see
     * event_indicated is set, because speculative LOAD was executed
     * before actual STORE.
     */
    smp_mb();
}

That would indeed agree with the idea that queue_work() does offer
guarantees in the ret==false case. And yet, it doesn't work.

Effectively we have the sequence:

CPU#1:
  STLR A
  LDSETAL B

CPU#2:
  DMB ISHST
  STR B
  LDAR A

I tried writing a litmus test for this, but I wasn't able to make it
fail on neither herd7 nor real hardware. And yet I can trivially
reproduce the problem in vivo with the TTY layer. Perhaps there are
other preconditions to this particular sequence failing on real hardware
(related to caches, speculation, etc)...

I did stumble upon something a bit odd with the LSE atomic/STR pairing.
I also couldn't get a litmus to fail this in neither sim nor hardware,
so I probably just missed something about the memory model, but:
according to the ARM, the load/store halves of an atomic op are
Atomic-ordered-before among themselves, and the write is
Atomic-ordered-before a subsequent read with acquire semantics. However,
there is no mention of non-atomic writes. So, by my reading, this is
possible:

(flag is 1)
LDSETAL LOAD 1
STR 0
LDSETAL STORE 1

Which would leave you with LDSETAL claiming the old/new values are both
1, while the store completed and vanished. This seems pretty insane, and
would mean atomic_long_set() isn't actually atomic wrt other atomic ops,
but I couldn't figure out what forbids it, at least in the textual
description of the memory model. If this is indeed not forbidden, then
this could happen:

LDSETAL Read-Acquire (1)
  STR pending=0
  LDAR commit=old
STLR commit=new // can move below read-acquire
LDSETAL Write-Release (1)
(Returned 1, so work is not requeued)

But as I said, I couldn't prove that this is possible with herd7 or litmus7.

On the "trying random things" front, this fixes the bug:

	tty_flip_buffer_commit(buf->tail);
	smp_mb();
	queue_work(system_unbound_wq, &buf->work);

But this does not:

	tty_flip_buffer_commit(buf->tail);
	smp_wmb();
	queue_work(system_unbound_wq, &buf->work);

Which does kind of point towards the "load side moving up" theory.

Any ideas? Am I onto something with the STR/LDSETAL thing? Memory model
confusion? CPU bug? Did I miss an obvious bug? :)

[1]

from m1n1.setup import *

i = 0
while True:
    a = iface.readmem(0x900000000, 1170)
    print(i)
    i += 1

[2]
https://lore.kernel.org/all/90ea3e27-b2ef-41ac-75c7-5f0686603b2a@marcan.st/

Interestingly, the litmus test in that link started passing with
aarch64-v07 recently, even though that claimed to be a relaxation of the
memory model. I started that discussion at herd/herdtools7#418.

- Hector
