Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7384F4734F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 20:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237274AbhLMT2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 14:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbhLMT2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 14:28:10 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D5CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:28:09 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id l7so25234754lja.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 11:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wuhs1uu3xd+DAtVvYo8LfoJq6FMmwCoLXFe+b3mQ9lk=;
        b=nY0y16AgC9FhPUVjSZBirXeR/6JmySF+N7Y7VNIwzImpGwEqs9HTAgVslXfdAKbw7p
         h5VDPnoBy218LhjZDpzpSrgOGo9Xt4p4YihSMqTQVdP4YrsaWYmoy9hERj1nCuhrU4JO
         vH9NnzJm9SNXhfnTlWVWaMzGS6iAXl82NNy2Mz/5bg95gNmIllIjfB0cWaV/zaDmssUy
         wOaxO1Sd6GAdpR1hgMBCrKl2N7TAIvKmJKr44TNy9YxuSEBHcu7SEYNzlRjaTDiU3Y61
         PZ4lA26NMuPTxG/HJAzM1/oO2Ee2I+FXbotTMIiWRHzj+G9nv1FCirF/4FMqxPXFsRL+
         W9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wuhs1uu3xd+DAtVvYo8LfoJq6FMmwCoLXFe+b3mQ9lk=;
        b=72Yhbr0hXEa/vjYrZTUp/oOh/2XHsu+7TZ6hHnGmVVQD8hg2JUkb/v+S3Sw4x/j9Q5
         gDrSgoydL9CCo5IENmtNC6UHmsNFf1C2l4JQWN54DdOlvXyiuTXlhhoq+sariFFu8pdz
         CehldXnzctBl3fKZ7uzxthDpU87/KQJxFYIuASNQyb1RmlfYyC3C+E0G5vhpCJZEuC3B
         2kaEJBxQumB5YFX3bBQ7l0FCaeeHk2sb89sq8fMRFz1ef/e+Ess/HXlfMXFXOKlDMXsh
         1mWKD2dI1T2Bpk9gXs4to7Fln4qdPL51Pm0uC1yi9/Gjwv5znKh7ogMAMmNz80S3xlAA
         /Kkg==
X-Gm-Message-State: AOAM530xThp05VVn9TjMsw0+YUyyuuhHdjHPAQ8qYm0QOsDvJg6NL95a
        O9WB5B5I97hG2DCjlXr2ZIdb7u5mVVXPV+BJkQAlBg==
X-Google-Smtp-Source: ABdhPJxqWHONSnBCMMMMigrcQTyIdrM1feHJHhhHJ+AuRFOFD/oPpUM/4g0Ux0zeJp2mf9xcOHyDILt1fheukMheXoQ=
X-Received: by 2002:a05:651c:324:: with SMTP id b4mr493697ljp.188.1639423687564;
 Mon, 13 Dec 2021 11:28:07 -0800 (PST)
MIME-Version: 1.0
References: <87tufctk82.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87tufctk82.fsf@oldenburg.str.redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 13 Dec 2021 20:27:41 +0100
Message-ID: <CAG48ez2oNKbSvNavKLEe2iYm1Cj+OaaaF45FA8cqkY+-7DuJTw@mail.gmail.com>
Subject: Re: rseq + membarrier programming model
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-api@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        libc-alpha@sourceware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 7:48 PM Florian Weimer <fweimer@redhat.com> wrote:
> I've been studying Jann Horn's biased locking example:
>
>   Re: [PATCH 0/4 POC] Allow executing code and syscalls in another address space
>   <https://lore.kernel.org/linux-api/CAG48ez02UDn_yeLuLF4c=kX0=h2Qq8Fdb0cer1yN8atbXSNjkQ@mail.gmail.com/>
>
> It uses MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ as part of the biased lock
> revocation.
>
> How does the this code know that the process has called
> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ?  Could it fall back to
> MEMBARRIER_CMD_GLOBAL instead?

AFAIK no - MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ specifically
forces targeted processes to go through an RSEQ preemption. That only
happens when this special membarrier command is used and when an
actual task switch happens; other membarrier flavors don't guarantee
that.


Also, MEMBARRIER_CMD_GLOBAL can take really long in terms of wall
clock time - it's basically just synchronize_rcu(), and as the
documentation at
https://www.kernel.org/doc/html/latest/RCU/Design/Requirements/Requirements.html
says:

"The synchronize_rcu() grace-period-wait primitive is optimized for
throughput. It may therefore incur several milliseconds of latency in
addition to the duration of the longest RCU read-side critical
section."


You can see that synchronize_rcu() indeed takes quite long in terms of
wall clock time (but not in terms of CPU time - as the documentation
says, it's optimized for throughput in a parallel context) with a
simple test program:

jannh@laptop:~/test/rcu$ cat rcu_membarrier.c
#define _GNU_SOURCE
#include <stdio.h>
#include <linux/membarrier.h>
#include <sys/syscall.h>
#include <unistd.h>
#include <time.h>
#include <err.h>

int main(void) {
  for (int i=0; i<20; i++) {
    struct timespec ts1;
    if (clock_gettime(CLOCK_MONOTONIC, &ts1))
      err(1, "time");

    if (syscall(__NR_membarrier, MEMBARRIER_CMD_GLOBAL, 0, 0))
      err(1, "membarrier");

    struct timespec ts2;
    if (clock_gettime(CLOCK_MONOTONIC, &ts2))
      err(1, "time");

    unsigned long delta_ns = (ts2.tv_nsec - ts1.tv_nsec) +
(1000UL*1000*1000) * (ts2.tv_sec - ts1.tv_sec);
    printf("MEMBARRIER_CMD_GLOBAL took %lu nanoseconds\n", delta_ns);
  }
}
jannh@laptop:~/test/rcu$ gcc -o rcu_membarrier rcu_membarrier.c -Wall
jannh@laptop:~/test/rcu$ time ./rcu_membarrier
MEMBARRIER_CMD_GLOBAL took 17155142 nanoseconds
MEMBARRIER_CMD_GLOBAL took 19207001 nanoseconds
MEMBARRIER_CMD_GLOBAL took 16087350 nanoseconds
MEMBARRIER_CMD_GLOBAL took 15963711 nanoseconds
MEMBARRIER_CMD_GLOBAL took 16336149 nanoseconds
MEMBARRIER_CMD_GLOBAL took 15931331 nanoseconds
MEMBARRIER_CMD_GLOBAL took 16020315 nanoseconds
MEMBARRIER_CMD_GLOBAL took 15873814 nanoseconds
MEMBARRIER_CMD_GLOBAL took 15945667 nanoseconds
MEMBARRIER_CMD_GLOBAL took 23815452 nanoseconds
MEMBARRIER_CMD_GLOBAL took 23626444 nanoseconds
MEMBARRIER_CMD_GLOBAL took 19911435 nanoseconds
MEMBARRIER_CMD_GLOBAL took 23967343 nanoseconds
MEMBARRIER_CMD_GLOBAL took 15943147 nanoseconds
MEMBARRIER_CMD_GLOBAL took 23914809 nanoseconds
MEMBARRIER_CMD_GLOBAL took 32498986 nanoseconds
MEMBARRIER_CMD_GLOBAL took 19450932 nanoseconds
MEMBARRIER_CMD_GLOBAL took 16281308 nanoseconds
MEMBARRIER_CMD_GLOBAL took 24045168 nanoseconds
MEMBARRIER_CMD_GLOBAL took 15406698 nanoseconds

real 0m0.458s
user 0m0.058s
sys 0m0.031s
jannh@laptop:~/test/rcu$

Every invocation of MEMBARRIER_CMD_GLOBAL on my laptop took >10 ms.
