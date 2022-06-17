Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8154F86F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382310AbiFQNnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382447AbiFQNne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:43:34 -0400
Received: from outbound-smtp55.blacknight.com (outbound-smtp55.blacknight.com [46.22.136.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0156714D37
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:43:29 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp55.blacknight.com (Postfix) with ESMTPS id 5DE13FAD69
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:43:28 +0100 (IST)
Received: (qmail 25423 invoked from network); 17 Jun 2022 13:43:28 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Jun 2022 13:43:28 -0000
Date:   Fri, 17 Jun 2022 14:43:26 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Waiman Long <longman@redhat.com>
Cc:     Zhenhua Ma <mazhenhua@xiaomi.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Lockups due to "locking/rwsem: Make handoff bit handling more
 consistent"
Message-ID: <20220617134325.GC30825@techsingularity.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hi Waiman,

I've received reports of lockups happening in kernels including
commit d257cc8cb8d5 ("locking/rwsem: Make handoff bit handling more
consistent"). The exact symptoms vary but usually it's either a soft lockup
(older kernel with a backport), the task hanging and never exiting or the
machine becomes generally unresponsive and ssh is broken.  The problem
started in 5.16 and reliably bisected to commit d257cc8cb8d5. Reverting
the patch in 5.16, 5.17 and 5.18 finish the test successfully but I didn't
test a revert on 5.19-rc2 because of other changes layered on top.

The reproducer is simple -- start pairs of CPU hogs pinned to a CPU with
different SCHED_RR priorities that run for a few seconds. It does not
hit every time but usually happens within 10 attempts. On 5.16 at least,
the tasks failed to exit and kept retrying to exit using the following path

[<0>] rwsem_down_write_slowpath+0x2ad/0x580
[<0>] unlink_file_vma+0x2c/0x50
[<0>] free_pgtables+0xbe/0x110
[<0>] exit_mmap+0xc1/0x220
[<0>] mmput+0x52/0x110
[<0>] do_exit+0x2ec/0xb00
[<0>] do_group_exit+0x2d/0x90
[<0>] get_signal+0xb6/0x920
[<0>] arch_do_signal_or_restart+0xba/0x700
[<0>] exit_to_user_mode_prepare+0xb7/0x230
[<0>] irqentry_exit_to_user_mode+0x5/0x20
[<0>] asm_sysvec_apic_timer_interrupt+0x12/0x20
[<0>] preempt_schedule_thunk+0x16/0x18
[<0>] rwsem_down_write_slowpath+0x2ad/0x580
[<0>] unlink_file_vma+0x2c/0x50
[<0>] free_pgtables+0xbe/0x110
[<0>] exit_mmap+0xc1/0x220
[<0>] mmput+0x52/0x110
[<0>] do_exit+0x2ec/0xb00
[<0>] do_group_exit+0x2d/0x90
[<0>] get_signal+0xb6/0x920
[<0>] arch_do_signal_or_restart+0xba/0x700
[<0>] exit_to_user_mode_prepare+0xb7/0x230
[<0>] irqentry_exit_to_user_mode+0x5/0x20
[<0>] asm_sysvec_apic_timer_interrupt+0x12/0x20

The C file and shell script to run it are attached.

-- 
Mel Gorman
SUSE Labs

--lrZ03NoBR/3+SXJZ
Content-Type: text/x-c; charset=iso-8859-15
Content-Disposition: attachment; filename="fsim.c"

#include <unistd.h>
#include <stdlib.h>
#include <signal.h>

void sig_handle(int sig) { exit(0); }

int main(void)
{ unsigned long c; signal(SIGALRM, sig_handle); alarm(10); while (1) c++; }

--lrZ03NoBR/3+SXJZ
Content-Type: application/x-sh
Content-Disposition: attachment; filename="run-fsim.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0Aif [ ! -e fsim ]; then=0A	gcc -o fsim fsim.c=0A	if [ $? -n=
e 0 ]; then=0A		echo Failed to compile fsim=0A		exit -1=0A	fi=0Afi=0A=0AMAX=
_ITERATIONS=3D100=0ACPU_MIN=3D"10 30"=0Afor i in `seq 1 $MAX_ITERATIONS`; d=
o=0A	echo "Start $i/$MAX_ITERATIONS: `date`"=0A	for CPU in `seq $CPU_MIN $C=
PU_MAX`; do=0A		taskset -c $CPU chrt -r 10 ./fsim &>/dev/null &=0A		taskset=
 -c $CPU chrt -r 40 ./fsim &>/dev/null &=0A	done=0A	echo "Wait  $i/$MAX_ITE=
RATIONS: `date`"=0A	wait=0Adone=0A
--lrZ03NoBR/3+SXJZ--
