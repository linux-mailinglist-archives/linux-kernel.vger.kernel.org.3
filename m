Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C64597645
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 21:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiHQTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 15:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241362AbiHQTJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0512233361
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660763354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=gd3covl43eagT0xH9juakpHOWjtQjx5gc3TXfzwf7g8=;
        b=ZlJQwir73gg/tR9D0yb2xPJz5kqwtn9UNwSDa9EPCifog0neN44THTdv76RptAuQfRd2kM
        F3Hh9WjtfvwN2R6KdHyS5plrOTCmax1sJbCeOwdylMuytgJ4NYEHbyd21FX8hGR0HB64Wq
        djTqD2yjTdzgAk3qr0FRD+FrOUqE9mU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-Cv8fZk0nPyCWE6HyAn9A5A-1; Wed, 17 Aug 2022 15:09:11 -0400
X-MC-Unique: Cv8fZk0nPyCWE6HyAn9A5A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6CBB85A584;
        Wed, 17 Aug 2022 19:09:10 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F3271121315;
        Wed, 17 Aug 2022 19:09:10 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A0C10416D5DE; Wed, 17 Aug 2022 16:08:54 -0300 (-03)
Message-ID: <20220817190136.096849758@redhat.com>
User-Agent: quilt/0.66
Date:   Wed, 17 Aug 2022 16:01:36 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     atomlin@redhat.com, frederic@kernel.org
Cc:     cl@linux.com, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, pauld@redhat.com, neelx@redhat.com,
        oleksandr@natalenko.name, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v7 0/3] tick/sched: Ensure quiet_vmstat() is called when the idle tick was stopped too
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains enhancements on top of Aaron's -v6 of the series
(see the changelog below).

It fixes the following problems two problems:

1) A customer provided some evidence which indicates that the idle tick was
stopped; albeit, CPU-specific vmstat counters still remained populated.
Thus one can only assume quiet_vmstat() was not invoked on return to the
idle loop.

If I understand correctly, I suspect this divergence might erroneously
prevent a reclaim attempt by kswapd. If the number of zone specific free
pages are below their per-cpu drift value then
zone_page_state_snapshot() is used to compute a more accurate view of
the aforementioned statistic.  Thus any task blocked on the NUMA node
specific pfmemalloc_wait queue will be unable to make significant
progress via direct reclaim unless it is killed after being woken up by
kswapd (see throttle_direct_reclaim()).

2) With a SCHED_FIFO task that busy loops on a given CPU, 
and kworker for that CPU at SCHED_OTHER priority, queuing
work to sync per-vmstats will either cause that work
to never execute, or stalld boosts kworker priority which 
causes a latency violation.


Follows the v6 cover letter, with updated changelog. The numbers, for
the test program attached at the end of this cover letter, executed
inside a KVM VM, are:

                                Vanilla                 Patch

cycles per idle loop            151858                  153258  (+1.0%)

cycles per syscall              8461                    8690    (+2.6%)

--------


I have incorporated an idea from Marcelo's patch [1] where a CPU-specific
variable is used to indicate if a vmstat differential/or imbalance is
present for a given CPU. So, at the appropriate time, vmstat processing can
be initiated. The hope is that this particular approach is "cheaper" when
compared to need_update() - used currently; in the context of nohz_full and
the scheduling-clock tick being stopped, we would now with this patch,
check if a CPU-specific vmstat imbalance is present before exiting
user-mode (see tick_nohz_user_enter_prepare()).

This trivial test program [2] was used to determine the somewhat impact
under vanilla and with the proposed changes; mlock(2) and munlock(2) was
used solely to modify vmstat item 'NR_MLOCK'. The following is an average
count of CPU-cycles across the aforementioned system calls and the idle
loop, respectively. I believe these results are negligible:

	  Modified		   |  		Vanilla
                                   |
  cycles per syscall: 7399         | 	cycles per syscall: 4150
  cycles per idle loop: 141048     |	cycles per idle loop: 144730
                                   |


Any feedback would be appreciated. Thanks.

Changes since v6 [6]:
 - sync vmstats independently of whether vmstat_update work is queued or not
 - clean vmstat_dirty before differential sync loop
 - cancel pending work if tick stopped
 - do not queue work to remote CPU if tick stopped

Changes since v5 [3]:

 - Introduced __tick_nohz_user_enter_prepare()
 - Switched to EXPORT_SYMBOL_GPL()

Changes since v4 [4]:

 - Moved vmstat_dirty specific changes into a separate patch
   (Marcelo Tosatti)

Changes since v3 [5]:

 - Used EXPORT_SYMBOL() on tick_nohz_user_enter_prepare()
 - Replaced need_update()
 - Introduced CPU-specific variable namely vmstat_dirty
   and mark_vmstat_dirty()

[1]: https://lore.kernel.org/lkml/20220204173554.763888172@fedora.localdomain/
[2]: https://pastebin.com/8AtzSAuK
[3]: https://lore.kernel.org/lkml/20220801234258.134609-1-atomlin@redhat.com/
[4]: https://lore.kernel.org/lkml/20220621172207.1501641-1-atomlin@redhat.com/
[5]: https://lore.kernel.org/lkml/20220422193647.3808657-1-atomlin@redhat.com/
[6]: https://lore.kernel.org/linux-mm/20220808194820.676246-1-atomlin@redhat.com/

 include/linux/tick.h     |    5 +++--
 kernel/time/tick-sched.c |   19 ++++++++++++++++++-
 mm/vmstat.c              |   74 ++++++++++++++++++++++++++++++++++++--------------------------------------
 3 files changed, 57 insertions(+), 41 deletions(-)

--- test-vmstat-overhead.c ---

#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
#include <string.h>

typedef unsigned long long cycles_t;
typedef unsigned long long usecs_t;
typedef unsigned long long u64;

#ifdef __x86_64__
#define DECLARE_ARGS(val, low, high)    unsigned long low, high
#define EAX_EDX_VAL(val, low, high)     ((low) | ((u64)(high) << 32))
#define EAX_EDX_ARGS(val, low, high)    "a" (low), "d" (high)
#define EAX_EDX_RET(val, low, high)     "=a" (low), "=d" (high)
#else
#define DECLARE_ARGS(val, low, high)    unsigned long long val
#define EAX_EDX_VAL(val, low, high)     (val)
#define EAX_EDX_ARGS(val, low, high)    "A" (val)
#define EAX_EDX_RET(val, low, high)     "=A" (val)
#endif

static inline unsigned long long __rdtscll(void)
{
        DECLARE_ARGS(val, low, high);

        asm volatile("cpuid; rdtsc" : EAX_EDX_RET(val, low, high));

        return EAX_EDX_VAL(val, low, high);
}

#define rdtscll(val) do { (val) = __rdtscll(); } while (0)

#define NRSYSCALLS 30000
#define NRSLEEPS   100000

void main(int argc, char *argv[])
{
	unsigned long a, b, cycles;
	int i, syscall = 0;
	void *page = malloc(4096);

	if (mlock(page, 4096))
		perror("mlock");
	if (munlock(page, 4096))
		perror("munlock");

	if (argc != 2) {
		printf("usage: %s {idle,syscall}\n", argv[0]);
		exit(1);
	}

        rdtscll(a);

	if (strncmp("idle", argv[1], 4) == 0)
		syscall = 0;
	else if (strncmp("syscall", argv[1], 7) == 0)
		syscall = 1;
	else {
		printf("usage: %s {idle,syscall}\n", argv[0]);
		exit(1);
	}
	
	if (syscall == 1) {
        	for (i = 0; i < NRSYSCALLS; i++) {
			if (mlock(page, 4096))
				perror("mlock");
			if (munlock(page, 4096))
				perror("munlock");
		}
	} else {
        	for (i = 0; i < NRSLEEPS; i++)
		 	usleep(10);
	}

        rdtscll(b);

        cycles = b - a;

	if (syscall == 1)
        	printf("cycles per syscall: %d\n", (b-a)/(NRSYSCALLS*2));
	else
		printf("cycles per idle loop: %d\n", (b-a)/NRSLEEPS);
}



