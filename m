Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABD2474CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 22:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbhLNVAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 16:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbhLNVAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 16:00:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCA3C061574;
        Tue, 14 Dec 2021 13:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=02vHHiKz0gT5jyRJmlmc/3dByU2JhzQMiKH2ELlSE50=; b=MyP+dV0kBQGp26VdnA1YyssEtT
        zXH1KQmM6Ki+ffqbOhL5XZA4qBND4++sGgq00SEyxTxV0GmJDOvZKdjawkanhCRNZkX5Y0p4LgT8r
        D9qRNVc3o110ds3GIljIdxpEGPxczxnOKElc1Z/nCuFj8ExYduRc0GgFTCWmjj4jIRnpEmg1nq1wv
        SM9CnqNe08EBJjuwyTETVYdoPil5VNUz7/QQxn44FLCkXoSfI1g6YIzVpZuQw6adzo7uU+21zlnDo
        HuzQPtlElaDW9/hRGa9IiD6Mh67hh3A42RGxhC1UlYYspJrdWxt/CUnwS1zd8OYbn+3hrxL6G+aP0
        oxAxacvA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxEuH-00E4cB-7j; Tue, 14 Dec 2021 21:00:18 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0BA11984C61; Tue, 14 Dec 2021 22:00:17 +0100 (CET)
Date:   Tue, 14 Dec 2021 22:00:16 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, pjt@google.com,
        posk@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca, posk@posk.io
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
Message-ID: <20211214210016.GD16608@worktop.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214204445.665580974@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 09:44:45PM +0100, Peter Zijlstra wrote:
> I'll post my test-hack as a reply, but basically it does co-operative and
> preemptive UP-like user scheduling.

It's pretty rough, but seems to work. Defaults to co-operative and
switches to preemptive when ran with an (any!) argument.

---
// gcc -Itools/include/ -o umcg umcg.c -lpthread

#define _GNU_SOURCE
#include <unistd.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>

#ifndef __NR_umcg_ctl
#define __NR_umcg_ctl  450
#define __NR_umcg_wait 451
#define __NR_umcg_kick 452
#endif

#include <linux/list.h>
#include "include/uapi/linux/umcg.h"

/* syscall wrappers */

static inline int
sys_umcg_ctl(u32 flags, struct umcg_task *self, clockid_t which_clock)
{
	return syscall(__NR_umcg_ctl, flags, self, which_clock);
}

static inline int
sys_umcg_wait(u32 flags, u64 timo)
{
	return syscall(__NR_umcg_wait, flags, timo);
}

static inline int
sys_umcg_kick(u32 flags, pid_t tid)
{
	return syscall(__NR_umcg_kick, flags, tid);
}

/* the 'foo' scheduler */

struct foo_task {
	struct umcg_task	task;
	struct list_head	node;
	pid_t			tid;
};

struct foo_server {
	struct umcg_task	task;
	struct list_head	node;
	pid_t			tid;
	struct foo_task		*cur;
};

void foo_add(struct foo_server *server, struct umcg_task *t)
{
	struct foo_task *foo = container_of(t, struct foo_task, task);

	t->runnable_workers_ptr = 0ULL;
	list_add_tail(&foo->node, &server->node);
}

struct foo_task *foo_pick_next(struct foo_server *server)
{
	struct foo_task *first = NULL;

	if (list_empty(&server->node))
		return first;

	first = list_first_entry(&server->node, struct foo_task, node);
	list_del(&first->node);
	return first;
}

#define NSEC_PER_SEC 1000000000ULL

u64 foo_time(void)
{
	struct timespec ts;
	clock_gettime(CLOCK_MONOTONIC, &ts);
	return (unsigned long long)ts.tv_sec * NSEC_PER_SEC + ts.tv_nsec;
}

void foo_yield(struct umcg_task *self)
{
	self->state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;
	sys_umcg_wait(0, 0);
}

#define TICK_NSEC NSEC_PER_SEC

volatile bool foo_preemptible = false;

/* our workers */

/* always running worker */
void *worker_fn0(void *arg)
{
	struct foo_server *server = arg;
	struct foo_task task = { };
	unsigned long i;
	int ret;

	task.tid = gettid();
	task.task.server_tid = server->tid;
	task.task.state = UMCG_TASK_BLOCKED;

	printf("A == %d\n", gettid());

	ret = sys_umcg_ctl(UMCG_CTL_REGISTER|UMCG_CTL_WORKER, &task.task, CLOCK_MONOTONIC);
	if (ret) {
		perror("umcg_ctl(A): ");
		exit(-1);
	}

	for (;;) {
		int x = i++;

		if (!(x % 1000000)) {
			putchar('.');
			fflush(stdout);
		}

		/* co-operative or preemptible */
		if (!foo_preemptible && !(x % 10000000))
			foo_yield(&task.task);
	}

	return NULL;
}

/* event driven worker */
void *worker_fn1(void *arg)
{
	struct foo_server *server = arg;
	struct foo_task task = { };
	int ret;

	task.tid = gettid();
	task.task.server_tid = server->tid;
	task.task.state = UMCG_TASK_BLOCKED;

	printf("B == %d\n", gettid());

	ret = sys_umcg_ctl(UMCG_CTL_REGISTER|UMCG_CTL_WORKER, &task.task, CLOCK_MONOTONIC);
	if (ret) {
		perror("umcg_ctl(B): ");
		exit(-1);
	}

	for (;;) {
		printf("B\n");
		fflush(stdout);

		sleep(2);
	}

	return NULL;
}

void *worker_fn2(void *arg)
{
	struct foo_server *server = arg;
	struct foo_task task = { };
	int ret;

	task.tid = gettid();
	task.task.server_tid = server->tid;
	task.task.state = UMCG_TASK_BLOCKED;

	printf("C == %d\n", gettid());

	ret = sys_umcg_ctl(UMCG_CTL_REGISTER|UMCG_CTL_WORKER, &task.task, CLOCK_MONOTONIC);
	if (ret) {
		perror("umcg_ctl(C): ");
		exit(-1);
	}

	for (;;) {
		printf("C\n");
		fflush(stdout);

		sleep(3);
	}

	return NULL;
}

/* the server */

int main(int argc, char **argv)
{
	struct umcg_task *runnable_ptr, *next;
	struct foo_server server = { };
	pthread_t worker[3];
	u64 timeout = 0;
	int ret;

	printf("server == %d\n", gettid());
	fflush(stdout);

	server.tid = gettid();
	INIT_LIST_HEAD(&server.node);
	server.task.server_tid = gettid();
	server.task.state = UMCG_TASK_RUNNING;

	ret = sys_umcg_ctl(UMCG_CTL_REGISTER, &server.task, CLOCK_MONOTONIC);
	if (ret) {
		perror("umcg_ctl: ");
		exit(-1);
	}

	pthread_create(&worker[0], NULL, worker_fn0, &server);
	pthread_create(&worker[1], NULL, worker_fn1, &server);
	pthread_create(&worker[2], NULL, worker_fn2, &server);

	if (argc > 1) {
		foo_preemptible = true;
		/*
		 * setup preemption tick
		 */
		timeout = foo_time() + TICK_NSEC;
	}

	for (;;) {
		/*
		 * Mark the server as runnable first, so we can detect
		 * additions to the runnable list after we read it.
		 */
		server.task.state = UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT;

		/*
		 * comsume the runnable notification list and add
		 * the tasks to our local runqueue.
		 */
		runnable_ptr = (void*)__atomic_exchange_n(&server.task.runnable_workers_ptr,
						   NULL, __ATOMIC_SEQ_CST);
		while (runnable_ptr) {
			next = (void *)runnable_ptr->runnable_workers_ptr;
			foo_add(&server, runnable_ptr);
			runnable_ptr = next;
		}

		/*
		 * If we've got a current running task, the server might have
		 * gotten a 'spurious' wakeup to pick up new runnable tasks.
		 *
		 * In this case, don't pick a new task (possible
		 * wakeup-preemption point, not implemented here).
		 *
		 * Note: even tough this RUNNING test is racy, if it blocks
		 * after we'll get a RUNNABLE notification which will clear our
		 * RUNNABLE state and sys_umcg_wait() will -EAGAIN.
		 */
		if (server.cur && server.cur->task.state == UMCG_TASK_RUNNING) {
			/*
			 * Assert ::next_tid is clear, it should have been
			 * consumed.
			 */
			if (server.task.next_tid) {
				printf("current running, but still have next_tid\n");
				exit(-1);
			}

			putchar('x');
			fflush(stdout);
		} else {
			/*
			 * Pick the next task...
			 */
			server.cur = foo_pick_next(&server);
			server.task.next_tid = server.cur ? server.cur->tid : 0;

			printf("pick: %d\n", server.task.next_tid);
			fflush(stdout);
		}

		/*
		 * And switch...
		 */
		ret = sys_umcg_wait(0, timeout);

		/*
		 * If we did set ::next_tid but it hasn't been consumed by the
		 * syscall due to failure, make sure to put the task back on
		 * the runqueue, lest we leak it.
		 */
		if (server.task.next_tid) {
			foo_add(&server, &server.cur->task);
			server.cur = NULL;
			server.task.next_tid = 0;
		}

		if (!ret)
			continue;

		switch (errno) {
			case EAGAIN:
				/*
				 * Got a wakeup, try again.
				 */
				continue;

			case ETIMEDOUT:
				/*
				 * timeout: drive preemption
				 */
				putchar('t');
				fflush(stdout);

				/*
				 * Next tick..
				 */
				timeout += TICK_NSEC;

				/*
				 * If we have a current, cmpxchg set TF_PREEMPT and on success
				 * send it a signal to kick it into the kernel such that
				 * it might re-report itself runnable.
				 */
				if (server.cur) {
					struct foo_task *t = server.cur;
					u32 val = UMCG_TASK_RUNNING;
					u32 new = UMCG_TASK_RUNNING | UMCG_TF_PREEMPT;

					if (__atomic_compare_exchange_n(&t->task.state, &val, new,
								false, __ATOMIC_SEQ_CST, __ATOMIC_SEQ_CST)) {
						sys_umcg_kick(0, t->tid);
					}
				}
				/*
				 * Either way around, if the cmpxchg
				 * failed the task will have blocked
				 * and we should re-start the loop.
				 */
				continue;

			default:
				printf("errno: %d\n", errno);
				perror("wait:");
				exit(-1);
		}
	}

	return 0;
}

