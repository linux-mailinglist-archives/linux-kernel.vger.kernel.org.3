Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E45994A32DA
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353578AbiA3A3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:29:33 -0500
Received: from mail.loongson.cn ([114.242.206.163]:38050 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1346516AbiA3A3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:29:30 -0500
Received: from [192.168.68.105] (unknown [111.18.94.40])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx3+LT2_VhH5IFAA--.18933S3;
        Sun, 30 Jan 2022 08:29:09 +0800 (CST)
Message-ID: <0e700c2c-8523-ebc3-f006-e463f1fb7d0f@loongson.cn>
Date:   Sun, 30 Jan 2022 08:29:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 4/5] sched: unset panic_on_warn before calling panic()
Content-Language: en-US
To:     Marco Elver <elver@google.com>
Cc:     Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1643370145-26831-1-git-send-email-yangtiezhu@loongson.cn>
 <1643370145-26831-5-git-send-email-yangtiezhu@loongson.cn>
 <CANpmjNPYYAy2jy_U_c7QjTsco6f1Hk2q=HP34di4YRMgdKsa+g@mail.gmail.com>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
In-Reply-To: <CANpmjNPYYAy2jy_U_c7QjTsco6f1Hk2q=HP34di4YRMgdKsa+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dx3+LT2_VhH5IFAA--.18933S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXF13Zr1xZFyftFWDGF43trb_yoWrCFyfpr
        n8KFZ2yr4kK34rXFZ7Xw4qyryYyws8Za4xGa4xJr4rt3Z8GF15JrWIkFy3tr1Ygw17Za4Y
        vw1jqry3Ca1kJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
        c7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAI
        cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa
        73UjIFyTuYvjxUqEoXUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/28/22 19:52, Marco Elver wrote:
> On Fri, 28 Jan 2022 at 12:42, Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> As done in the full WARN() handler, panic_on_warn needs to be cleared
>> before calling panic() to avoid recursive panics.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>   kernel/sched/core.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 848eaa0..f5b0886 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -5524,8 +5524,17 @@ static noinline void __schedule_bug(struct task_struct *prev)
>>                  pr_err("Preemption disabled at:");
>>                  print_ip_sym(KERN_ERR, preempt_disable_ip);
>>          }
>> -       if (panic_on_warn)
>> +
>> +       if (panic_on_warn) {
>> +               /*
>> +                * This thread may hit another WARN() in the panic path.
>> +                * Resetting this prevents additional WARN() from panicking the
>> +                * system on this thread.  Other threads are blocked by the
>> +                * panic_mutex in panic().
>> +                */
>> +               panic_on_warn = 0;
>>                  panic("scheduling while atomic\n");
> 
> I agree this is worth fixing.
> 
> But: Why can't the "panic_on_warn = 0" just be moved inside panic(),
> instead of copy-pasting this all over the place?

OK, it looks better.

Let me wait for some days, if no more comments, I will send v2
to move "panic_on_warn = 0" inside panic() and remove it from
the other places, like this:

diff --git a/kernel/panic.c b/kernel/panic.c
index 55b50e052ec3..95ba825522dd 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -185,6 +185,16 @@ void panic(const char *fmt, ...)
         int old_cpu, this_cpu;
         bool _crash_kexec_post_notifiers = crash_kexec_post_notifiers;

+       if (panic_on_warn) {
+               /*
+                * This thread may hit another WARN() in the panic path.
+                * Resetting this prevents additional WARN() from 
panicking the
+                * system on this thread.  Other threads are blocked by the
+                * panic_mutex in panic().
+                */
+               panic_on_warn = 0;
+       }
+
         /*
          * Disable local interrupts. This will prevent panic_smp_self_stop
          * from deadlocking the first cpu that invokes the panic, since
@@ -576,16 +586,8 @@ void __warn(const char *file, int line, void 
*caller, unsigned taint,
         if (regs)
                 show_regs(regs);

-       if (panic_on_warn) {
-               /*
-                * This thread may hit another WARN() in the panic path.
-                * Resetting this prevents additional WARN() from 
panicking the
-                * system on this thread.  Other threads are blocked by the
-                * panic_mutex in panic().
-                */
-               panic_on_warn = 0;
+       if (panic_on_warn)
                 panic("panic_on_warn set ...\n");
-       }

         if (!regs)
                 dump_stack();
diff --git a/lib/ubsan.c b/lib/ubsan.c
index bdc380ff5d5c..36bd75e33426 100644
--- a/lib/ubsan.c
+++ b/lib/ubsan.c
@@ -154,16 +154,8 @@ static void ubsan_epilogue(void)

         current->in_ubsan--;

-       if (panic_on_warn) {
-               /*
-                * This thread may hit another WARN() in the panic path.
-                * Resetting this prevents additional WARN() from 
panicking the
-                * system on this thread.  Other threads are blocked by the
-                * panic_mutex in panic().
-                */
-               panic_on_warn = 0;
+       if (panic_on_warn)
                 panic("panic_on_warn set ...\n");
-       }
  }

  void __ubsan_handle_divrem_overflow(void *_data, void *lhs, void *rhs)
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 3ad9624dcc56..f14146563d41 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -117,16 +117,8 @@ static void end_report(unsigned long *flags, 
unsigned long addr)
 
pr_err("==================================================================\n");
         add_taint(TAINT_BAD_PAGE, LOCKDEP_NOW_UNRELIABLE);
         spin_unlock_irqrestore(&report_lock, *flags);
-       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, 
&kasan_flags)) {
-               /*
-                * This thread may hit another WARN() in the panic path.
-                * Resetting this prevents additional WARN() from 
panicking the
-                * system on this thread.  Other threads are blocked by the
-                * panic_mutex in panic().
-                */
-               panic_on_warn = 0;
+       if (panic_on_warn && !test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
                 panic("panic_on_warn set ...\n");
-       }
         if (kasan_arg_fault == KASAN_ARG_FAULT_PANIC)
                 panic("kasan.fault=panic set ...\n");
         kasan_enable_current();

Thanks,
Tiezhu

> 
> I may be missing something obvious why this hasn't been done before...
> 
> Thanks,
> -- Marco

