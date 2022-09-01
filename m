Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58A35A8BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 05:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiIADDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 23:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiIADDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 23:03:11 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4676EB6D4D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 20:03:09 -0700 (PDT)
Received: from [10.20.42.170] (unknown [10.20.42.170])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxPGvgIBBj0WkOAA--.1930S3;
        Thu, 01 Sep 2022 11:02:57 +0800 (CST)
Message-ID: <eba7bae5-8c9b-0b06-137b-4bcbbd9d8923@loongson.cn>
Date:   Thu, 1 Sep 2022 11:02:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] LoongArch: Add safer signal handler for TLS access
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220831074846.3565542-1-maobibo@loongson.cn>
 <e805e3c4-ea66-a438-9def-bc90bbffa14e@xen0n.name>
From:   maobibo <maobibo@loongson.cn>
In-Reply-To: <e805e3c4-ea66-a438-9def-bc90bbffa14e@xen0n.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxPGvgIBBj0WkOAA--.1930S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCryfGF1xAw4UtrWfCrWktFb_yoWrKF4Upr
        1vyFyUGrWYkr1kJr1Utr1UXryUJr1UJ3WUJryUJa4UAw4UJr1Yqr4UXFyjgF1UJr4kJr1U
        Jr1UJrnrZr47Jr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVAC
        Y4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJV
        W8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG
        8wCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r12
        6r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
        beAp5UUUUU=
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/9/1 10:30, WANG Xuerui 写道:
> On 2022/8/31 15:48, Mao Bibo wrote:
>> LoongArch uses general purpose register R2 as thread pointer(TP)
>> register, signal hanlder also uses TP register to access variables
>> in TLS area, such as errno and variable in TLS.
>>
>> If GPR R2 is modified with wrong value, signal handler still uses
>> the wrong TP register, so signal hanlder is insafe to access TLS
>> variable.
>>
>> This patch adds one arch specific syscall set_thread_area, and
>> restore previoud TP value before signal handler, so that signal
>> handler is safe to access TLS variable.
>>
>> It passes to run with the following test case.
>> =======8<======
>>   #define _GNU_SOURCE
>>   #include <stdio.h>
>>   #include <stdlib.h>
>>   #include <unistd.h>
>>   #include <string.h>
>>   #include <sys/syscall.h>
>>   #include <sys/types.h>
>>   #include <signal.h>
>>   #include <pthread.h>
>>   #include <asm/ucontext.h>
>>   #include <asm/sigcontext.h>
>>
>>   #define ILL_INSN ".word 0x000001f0"
>> static inline long test_sigill(unsigned long fid)
>> {
>>          register long ret __asm__("$r4");
>>          register unsigned long fun __asm__("$r4") = fid;
>>
>>          __asm__ __volatile__("move $r2, $r0 \r\n");
>>          __asm__ __volatile__(
>>                          ILL_INSN
>>                          : "=r" (ret)
>>                          : "r" (fun)
>>                          : "memory"
>>                          );
>>
>>          return ret;
>> }
>>
>> static void set_sigill_handler(void (*fn) (int, siginfo_t *, void *))
>> {
>>          struct sigaction sa;
>>          memset(&sa, 0, sizeof(struct sigaction));
>>
>>          sa.sa_sigaction = fn;
>>          sa.sa_flags = SA_SIGINFO;
>>          sigemptyset(&sa.sa_mask);
>>          if (sigaction(SIGILL, &sa, 0) != 0) {
>>                  perror("sigaction");
>>          }
>> }
>>
>> void catch_sig(int sig, siginfo_t *si, void *vuc)
>> {
>>          struct ucontext *uc = vuc;
>>          register unsigned long tls  __asm__("$r2");
>>
>>          uc->uc_mcontext.sc_pc +=4;
>>          uc->uc_mcontext.sc_regs[2] = tls;
>>          printf("catched signal %d\n", sig);
>> }
>>
>> void *print_message_function( void *ptr )
>> {
>>          char *message;
>>          message = (char *) ptr;
>>          printf("%s \n", message);
>>          test_sigill(1);
>> }
>>
>> void pthread_test(void)
>> {
>>          pthread_t thread1, thread2;
>>          char *message1 = "Thread 1";
>>          char *message2 = "Thread 2";
>>          int  iret1, iret2;
>>
>>          iret1 = pthread_create( &thread1, NULL, print_message_function,
>>                 (void*) message1);
>>          iret2 = pthread_create( &thread2, NULL, print_message_function,
>>                 (void*) message2);
>>          pthread_join( thread1, NULL);
>>          pthread_join( thread2, NULL);
>>          printf("Thread 1 returns: %d\n",iret1);
>>          printf("Thread 2 returns: %d\n",iret2);
>>          exit(0);
>> }
>>
>> void exec_test(void) {
>>          test_sigill(1);
>> }
>>
>> void main() {
>>          register unsigned long tls  __asm__("$r2");
>>          int val;
>>
>>          val = syscall(244, tls);
>>          set_sigill_handler(&catch_sig);
>>          pthread_test();
>>          //exec_test();
>>          return;
>> }
>> =======8<======
> 
> Sorry, but what is the concrete use case you have in mind? arch/riscv for example doesn't have set_thread_area but is apparently doing fine. I haven't studied their code in great detail to find out myself though.

We prepare to add loongarch support to risu project, which injects random instructions in user space. The website is:
   https://git.linaro.org/people/peter.maydell/risu.git

After injected instruction is executed, there will be special illegal instruction where signal handler is used to control to capture the whole registers and continue to run. However if random injected instruction modify TP register, signal handler fails to run.

I double that riscv has the same issue.

regards
bibo,mao

