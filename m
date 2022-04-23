Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B3C50CC5D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 18:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236452AbiDWQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiDWQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 12:43:41 -0400
X-Greylist: delayed 532 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 23 Apr 2022 09:40:42 PDT
Received: from mailout-l3b-97.contactoffice.com (mailout-l3b-97.contactoffice.com [212.3.242.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F913CA5B
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 09:40:42 -0700 (PDT)
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
        by mailout-l3b-97.contactoffice.com (Postfix) with ESMTP id 6A530771
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 18:31:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1650731509;
        s=20210208-e7xh; d=mailfence.com; i=flaskhalsaren@mailfence.com;
        h=Message-ID:Date:MIME-Version:From:Content-Type:Content-Transfer-Encoding;
        l=5571; bh=0R8nPHhTzHrR7qwjgjmoB8zkJbRXGE/jXo1Sg2ABPyk=;
        b=BvIIgwiDKclVZmrrxLP4c4ds5UsOqdKoWV9LkZosXZ2LTj8kL9d2SCpOgjkfMX5c
        RBsuHLwGdqlxjiyeWe5nrvIOQE0xGJOtxNvw+0dhDKawiuE14EKe1M83D/xvSYBz8CI
        CL3IR2WKv9aUE+pHoff2aHtx1t1NncfYxysTwIf7yugaaG1TxHjVEE6rbRUG68657Yj
        pMyRmYJsxainH2Jyj3k+WoFJYx+ZyzfBnIXSZyTYGPG79RffNQz/43KNpPRc4XZPHGj
        tLk3BhHTTEgkKvnq7FGmEKK+PtUA0uxVkWhdb0XOigBwkoW1PAUG8a5F2EV+oG1aggk
        lUE2L+ZwNQ==
Received: by smtp.mailfence.com with ESMTPSA
          for <linux-kernel@vger.kernel.org> ; Sat, 23 Apr 2022 18:31:46 +0200 (CEST)
Message-ID: <a444299d-377b-a175-2d69-5dc068a840e7@mailfence.com>
Date:   Sat, 23 Apr 2022 18:31:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
From:   flaskhalsaren it <flaskhalsaren@mailfence.com>
Subject: Slowing down task using a modified FIFO scheduler
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-ContactOffice-Account: com:351898251
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have been experimenting with the FIFO scheduler and tick rate in order
to reduce execution speed for tasks; I need to run legacy code that runs 
on old
slow hardware at approximately the same speed on new faster hardware while
preserving "realtime-like" properties of the code. The general idea
was to add a delay
during each task, tick to mimic the execution speed of the slower system.

At the end of this mail are my modifications in the kernel, where I for the
FIFO scheduler introduces a delay of 500 microseconds for each scheduling
tick, that is
my intention is to use up about 500 microseconds of the scheduling tick 
for the
task. Assuming a tick length of 1000 microseconds we effectively reduce the
execution speed to about 1 - 500/1000 or about 50%.

I am using kernel version 5.15.7 and Ubuntu 20.04.4

I have made a small test program to verify that my approach works as 
expected
which I run in userspace (delay_test.c):

#include <stdio.h>
#include <unistd.h>
#include <time.h>
#include <sched.h>
#include <stdint.h>
#include <sys/time.h>

static inline void timespec_diff(struct timespec *a, struct timespec *b,
     struct timespec *result) {
     result->tv_sec  = a->tv_sec  - b->tv_sec;
     result->tv_nsec = a->tv_nsec - b->tv_nsec;
     if (result->tv_nsec < 0) {
         --result->tv_sec;
         result->tv_nsec += 1000000000L;
     }
}

void main(int argc, char *args[])
{
   struct sched_param param;
   param.sched_priority = 99;
   sched_setscheduler(0,SCHED_FIFO,&param);
   struct timespec start,now,diff;
   uint64_t  sleep_delay = 100L;
   clock_gettime(CLOCK_MONOTONIC, &start);

   printf("Start is %lu.%lu\n",start.tv_sec,start.tv_nsec);
   for(;;)
   {
     usleep(sleep_delay);
     clock_gettime(CLOCK_MONOTONIC, &now);
     timespec_diff(&now,&start,&diff);
     printf("Time is %lus 
%luns\n",(uint64_t)diff.tv_sec,(uint64_t)diff.tv_nsec);

   }
}


I compile the above program like this (assuming a 2GHz CPU core that is
evacuated and assigned a dedicated Cgroup) $ gcc ....
and create it like this with Cgroup v1
sudo cgcreate -t $USER:$GRP -a $USER:$GRP -g cpuset,memory,freezer:tes
echo "1" | sudo tee /sys/fs/cgroup/cpuset/test/cpuset.cpus > /dev/null
echo "0" | sudo tee /sys/fs/cgroup/cpuset/test/cpuset.mems > /dev/null
echo "1" | sudo tee /sys/fs/cgroup/cpuset/test/cpuset.cpu_exclusive > 
/dev/null

and run it with
sudo cgexec -g memory,freezer,cpuset:test ./a.out

The expected output is something like
Start is 1835.474539419
Time is 0s 200000ns
Time is 0s 300000ns
Time is 0s 500000ns
Time is 0s 1000000ns <-- Here scheduler delay kicks i.
Time is 0s 1100000ns
Time is 0s 1200000ns
...

and so on. Instead, I get this
Start is 1835.474539419
Time is 0s 175382ns
Time is 0s 283956ns
Time is 0s 391289ns
Time is 0s 501217ns <-- Around here scheduler delay should have kicked in.
Time is 0s 610443ns <- Instead roughly the same delay is added.
Time is 0s 721963ns
Time is 0s 835387ns
Time is 0s 948290ns
Time is 0s 1061414ns

Things I have tried so far: Turning off SMT, making sure that I am using
CONFIG_HZ_PERIODIC , Isolating tasks using cgroups and isolcpus, making sure
that the system is running at the correct tick rate and changing the 
frequency
in combination with the Governor. Is it something I am missing in regards to
doing this slowdown? Any answers or hints would be appreciated.

My own delay method I have added to the kernel (register_time.c):

static uint64_t rdtsc2(void){
     uint32_t hi, lo;
     __asm__ __volatile__ ("xorl %%eax,%%eax\ncpuid" ::: "%rax",
"%rbx", "%rcx", "%rdx");
     __asm__ __volatile__ ("rdtsc" : "=a"(lo), "=d"(hi));
     return  (((uint64_t)hi)<<32) | ((uint64_t)lo) ; }

uint64_t get_khz(void){
     uint64_t aperf,mperf,khz;
     unsigned long flags;

     local_irq_save(flags);
     rdmsrl(MSR_IA32_APERF,aperf);
     rdmsrl(MSR_IA32_MPERF,mperf);
     local_irq_restore(flags);

     khz = div64_u64((cpu_khz * aperf),mperf);

     return khz;
}

uint64_t nanos_to_ticks(uint64_t nanos){
      return (get_khz() * 1000L * nanos)/NSEC_PER_SEC;
}
  /*
  *Sleeps for the specified amount of ticks.
  * Ticks to sleep can be calculated with nanos_to_tick().
  * Going from ticks to nanoseconds is done using ticks_to_nanos().
  */
uint64_t tick_sleep(uint64_t ticks_to_sleep) {
     uint64_t now;
     uint64_t sleep_until;
     uint64_t delta_ticks;

     preempt_disable();
     now = rdtsc2();
     sleep_until = now + ticks_to_sleep;
     while (now < sleep_until)
     {
         now = rdtsc2();
     }
     delta_ticks = now - sleep_until;
     preempt_enable();
     return delta_ticks;
}

The part where I try to add the delay (rt.c):

static void task_tick_rt(struct rq *rq, struct task_struct *p, int queued) {
   struct sched_rt_entity *rt_se = &p->rt;

   update_curr_rt(rq);
   update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 1);

   watchdog(rq, p);

   /*
    * RR tasks need a special form of timeslice management.
    * FIFO tasks have no timeslices.
    * CONFIG_PWM_FRAMEWORK is used to activate the special FIFO
    */
   #ifdef CONFIG_PWM_FRAMEWORK
   if (p->policy == SCHED_FIFO)
   {
       tick_sleep(nanos_to_ticks(500000));
       return;
   }
   #else
   if (p->policy != SCHED_RR)
   {
       return;
   }
   #endif

   if (--p->rt.time_slice)
       return;

   p->rt.time_slice = sched_rr_timeslice;

   /*
    * Requeue to the end of the queue if we (and all of our ancestors) 
are not
    * the only element on the queue
    */
   for_each_sched_rt_entity(rt_se)
   {
       if (rt_se->run_list.prev != rt_se->run_list.next)
       {
           requeue_task_rt(rq, p, 0);
           resched_curr(rq);
           return;
       }
   }
}


Best Regards
Jacob M
