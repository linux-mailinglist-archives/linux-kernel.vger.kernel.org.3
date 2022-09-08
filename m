Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E71A5B2371
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiIHQRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbiIHQRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:17:17 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53CB76747
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1662653826; bh=ahOA21ACEb2cg2T2lerUldLTXTolLkoN5mANWRtuYI8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XJQuLPQ5RIPqOtFsqdS+VFEqB1aM2vt5shRNOEiipz1q3VwxpSV6kMAu/3wS6Ab88
         MTz/QSJHGkFX5+5m4rJe9Uyw8qvkO57J6L82ADoOQ+K9tGjutpiWLcNDZUV+5ueJdy
         Emi9dqhOZ6Fj2WWKSDqcqK6kcBEqpz77ryVJn+hE=
Received: from [192.168.9.172] (unknown [101.88.26.24])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id EAD11600BD;
        Fri,  9 Sep 2022 00:17:05 +0800 (CST)
Message-ID: <d70a92e6-95db-469b-841c-56f4f3564843@xen0n.name>
Date:   Fri, 9 Sep 2022 00:17:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:106.0) Gecko/20100101
 Thunderbird/106.0a1
Subject: Re: [PATCH v3] LoongArch: Add safer signal handler for TLS access
Content-Language: en-US
To:     Mao Bibo <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220902095958.3875126-1-maobibo@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220902095958.3875126-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/2/22 17:59, Mao Bibo wrote:
> LoongArch uses general purpose register R2 as thread pointer(TP)
> register, signal hanlder also uses TP register to access variables
> in TLS area, such as errno and variable in TLS.
>
> If GPR R2 is modified with wrong value, signal handler still uses
> the wrong TP register, so signal hanlder is insafe to access TLS
> variable.
>
> This patch adds one arch specific syscall set_thread_area, and
> restore previoud TP value before signal handler, so that signal
> handler is safe to access TLS variable.
>
> It passes to run with the following test case.
> =======8<======
>   #define _GNU_SOURCE
>   #include <stdio.h>
>   #include <stdlib.h>
>   #include <unistd.h>
>   #include <string.h>
>   #include <sys/syscall.h>
>   #include <sys/types.h>
>   #include <signal.h>
>   #include <pthread.h>
>   #include <asm/ucontext.h>
>   #include <asm/sigcontext.h>
>
>   #define ILL_INSN ".word 0x000001f0"
> static inline long test_sigill(unsigned long fid)
> {
>          register long ret __asm__("$r4");
>          register unsigned long fun __asm__("$r4") = fid;
>
>          __asm__ __volatile__("move $r2, $r0 \r\n");
>          __asm__ __volatile__(
>                          ILL_INSN
>                          : "=r" (ret)
>                          : "r" (fun)
>                          : "memory"
>                          );
>
>          return ret;
> }
>
> static void set_sigill_handler(void (*fn) (int, siginfo_t *, void *))
> {
>          struct sigaction sa;
>          memset(&sa, 0, sizeof(struct sigaction));
>
>          sa.sa_sigaction = fn;
>          sa.sa_flags = SA_SIGINFO;
>          sigemptyset(&sa.sa_mask);
>          if (sigaction(SIGILL, &sa, 0) != 0) {
>                  perror("sigaction");
>          }
> }
>
> void catch_sig(int sig, siginfo_t *si, void *vuc)
> {
>          struct ucontext *uc = vuc;
>          register unsigned long tls  __asm__("$r2");
>
>          uc->uc_mcontext.sc_pc +=4;
>          uc->uc_mcontext.sc_regs[2] = tls;
>          printf("catched signal %d\n", sig);
> }
>
> void *print_message_function( void *ptr )
> {
>          char *message;
>          message = (char *) ptr;
>          printf("%s \n", message);
>          test_sigill(1);
> }
>
> void pthread_test(void)
> {
>          pthread_t thread1, thread2;
>          char *message1 = "Thread 1";
>          char *message2 = "Thread 2";
>          int  iret1, iret2;
>
>          iret1 = pthread_create( &thread1, NULL, print_message_function,
> 				(void*) message1);
>          iret2 = pthread_create( &thread2, NULL, print_message_function,
> 				(void*) message2);
>          pthread_join( thread1, NULL);
>          pthread_join( thread2, NULL);
>          printf("Thread 1 returns: %d\n",iret1);
>          printf("Thread 2 returns: %d\n",iret2);
>          exit(0);
> }
>
> void exec_test(void) {
>          test_sigill(1);
> }
>
> void main() {
>          register unsigned long tls  __asm__("$r2");
>          int val;
>
>          val = syscall(244, tls);
>          set_sigill_handler(&catch_sig);
>          pthread_test();
>          //exec_test();
>          return;
> }
> =======8<======
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
> v2->v3:
>   - Use current_thread_info rather than task_thread_info(current)
> v1->v2:
>   - Clear TP value in clone function if CLONE_SETTLS is not set
> ---
>   arch/loongarch/include/asm/unistd.h      |  1 +
>   arch/loongarch/include/uapi/asm/unistd.h |  2 ++
>   arch/loongarch/kernel/process.c          | 10 +++++++++-
>   arch/loongarch/kernel/signal.c           |  5 +++++
>   arch/loongarch/kernel/syscall.c          |  9 +++++++++
>   5 files changed, 26 insertions(+), 1 deletion(-)

So here we're trying to accommodate for ABI violations from user-mode 
programs, no matter whether they come from fuzzing, or any other black 
magic; but being user-space, theoretically set_thread_area could also be 
fuzzed, and this "additional" layer of defense then breaks down. And if 
this theoretical case is deemed uninteresting, remember the case you're 
demonstrating is also found by fuzzing and not found in normal working 
user programs, then the whole scenario should be theoretical and 
uninteresting as well...

BTW I've also thrown this problem into a riscv discussion group, and 
they pointed out that e.g. sigaltstack is already available for 
guaranteeing at least some working state when a signal comes. And riscv 
also doesn't have set_thread_area which is most likely why loongarch 
isn't getting one; further, looking at manpages of 
{get,set}_thread_area, it may be the case that both riscv and loongarch 
have the TP in user-visible ISA state, so a syscall is not needed for 
manipulating it anyway. Again it's equally easy to mess the hidden state 
of set_thread_area as $tp itself. Or put it differently, if 
set_thread_area is necessary/good for loongarch, you should probably add 
it to riscv as well -- both will benefit.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

