Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F8A495212
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376930AbiATQJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376886AbiATQJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:09:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9A1C061574;
        Thu, 20 Jan 2022 08:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=n1Q/2ph3XBvxLZMufG8ZSLEJ3l1BBksnAPTycj/jkhE=; b=BESeW3/QkYzgGIFd/2mgD+qt/C
        5NTP+Azsj2HcqVd7L2Rf4GvPewBQVyZYKAbHrfR3r02iuHcbqYr8xvg0sVBel/BK1+aZPvGoZvyRU
        l/3R8xGcjY/M3qoOOLqVa4j0ShNy7/n6niyvYJ/CULvcESc+SCvV4ZREApwSJ0O6dBgilSwyqh2Pa
        aVYxSr7WHBN0Z+obdAdL0ozA0SygDPnUBRqE95jpe2jTl5OHtGZz/MsEq6Q1w+LnTuzMQqPvg6T4n
        6eA00JipEEGN4ENejcuEX9L3UxiyFK85tPEy6THnKjks/jiHM1phFw6UzorCf5wV/5b8FJ0ULz59U
        cj7y2Nrg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAZza-002L84-Cg; Thu, 20 Jan 2022 16:08:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9769300347;
        Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 8B2EC20281C43; Thu, 20 Jan 2022 17:08:51 +0100 (CET)
Message-ID: <20220120155517.066795336@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 20 Jan 2022 16:55:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, x86@kernel.org, peterz@infradead.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca, mark.rutland@arm.com,
        posk@posk.io
Subject: [RFC][PATCH v2 0/5] sched: User Managed Concurrency Groups
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latest version, many changes since last time, still under heavy discussion.

Seems to work with the test-case I have (below), but that still has a few gaps,
coverage wise.

Still haven't done the SMP wakeup thing, finally get the idea with
worker-timeouts but haven't yet implemented that.

Happy hacking..

----

#define _GNU_SOURCE
#include <unistd.h>
#include <sys/types.h>
#include <sys/syscall.h>
#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <signal.h>

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
	int			workers;
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

static volatile bool foo_preemptible = false;

/* our workers */

static volatile bool done = false;

static void umcg_signal(int signr)
{
	done = true;
}

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

	__atomic_add_fetch(&server->workers, 1, __ATOMIC_RELAXED);

	while (!done) {
		int x = i++;

		if (!(x % 1000000)) {
			putchar('.');
			fflush(stdout);
		}

		/* co-operative or preemptible */
		if (!foo_preemptible && !(x % 10000000))
			foo_yield(&task.task);
	}

	printf("A == done\n");

	__atomic_add_fetch(&server->workers, -1, __ATOMIC_RELAXED);

	ret = sys_umcg_ctl(UMCG_CTL_UNREGISTER|UMCG_CTL_WORKER, &task.task, 0);
	if (ret) {
		perror("umcg_ctl(~A): ");
		exit(-1);
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

	__atomic_add_fetch(&server->workers, 1, __ATOMIC_RELAXED);

	while (!done) {
		printf("B\n");
		fflush(stdout);

		sleep(1);
	}

	printf("B == done\n");

	__atomic_add_fetch(&server->workers, -1, __ATOMIC_RELAXED);

	ret = sys_umcg_ctl(UMCG_CTL_UNREGISTER|UMCG_CTL_WORKER, &task.task, 0);
	if (ret) {
		perror("umcg_ctl(~B): ");
		exit(-1);
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

	__atomic_add_fetch(&server->workers, 1, __ATOMIC_RELAXED);

	while (!done) {
		printf("C\n");
		fflush(stdout);

		sleep(2);
	}

	printf("C == done\n");

	__atomic_add_fetch(&server->workers, -1, __ATOMIC_RELAXED);

	ret = sys_umcg_ctl(UMCG_CTL_UNREGISTER|UMCG_CTL_WORKER, &task.task, 0);
	if (ret) {
		perror("umcg_ctl(~C): ");
		exit(-1);
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
	u32 tid;
	int ret;

	struct sigaction sa = {
		.sa_handler = umcg_signal,
	};

	sigaction(SIGINT, &sa, NULL);

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

	while (!(done && !__atomic_load_n(&server.workers, __ATOMIC_RELAXED))) {
		/*
		 * Mark the server as runnable first, so we can detect
		 * additions to the runnable list after we read it.
		 */
		__atomic_store_n(&server.task.state,
				 UMCG_TASK_RUNNABLE | UMCG_TF_COND_WAIT,
				 __ATOMIC_RELAXED);

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

		if (server.cur && server.cur->task.state == UMCG_TASK_RUNNING) {
			/*
			 * Assert ::next_tid still points there and has RUNNING bit on
			 */
			if (server.task.next_tid != (server.cur->tid | UMCG_TID_RUNNING)) {
				printf("current not running: %d %x\n",
				       server.task.next_tid & UMCG_TID_MASK,
				       server.task.next_tid & ~UMCG_TID_MASK);
				exit(-1);
			}

			putchar('x');
		} else {
			tid = 0;
			server.cur = foo_pick_next(&server);
			if (server.cur)
				tid = server.cur->tid;

			__atomic_store_n(&server.task.next_tid, tid, __ATOMIC_RELAXED);

			printf("pick: %d\n", tid);
		}
		fflush(stdout);

		ret = sys_umcg_wait(0, timeout);

		/*
		 * If we set ::next_tid but it hasn't been consumed by the
		 * syscall due to failure, make sure to put the task back on
		 * the queue, lest we leak it.
		 */
		tid = __atomic_load_n(&server.task.next_tid, __ATOMIC_RELAXED);
		if (tid && !(tid & UMCG_TID_RUNNING)) {
			foo_add(&server, &server.cur->task);
			server.cur = NULL;
			putchar('*');
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

	pthread_join(worker[0], NULL);
	pthread_join(worker[1], NULL);
	pthread_join(worker[2], NULL);

	return 0;
}


