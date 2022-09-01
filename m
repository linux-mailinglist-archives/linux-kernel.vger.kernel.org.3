Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9D125A8B73
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbiIACac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbiIACaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:30:22 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2D61F62E
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1661999416; bh=KJnjnuj9UwZ584xvjShdAEAAYkFgZpBSk25gP37xpaU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c17EwY9J77leNbKYcmpkMYnMqZmQJEYMOGp4Sgpkahg6Rf+ZGMYUmInueKbKd926Q
         FYhh5jbxcgQ3qLh1zd+2vwmwVxkDKxtCDygWXyXXJoJE36LhhQv3G1ZLCdp/34MBQv
         lF877lOpugJsurrQHVl5wHY29gSvUnYTjJZ9smqQ=
Received: from [100.100.57.219] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id F30C8600A9;
        Thu,  1 Sep 2022 10:30:15 +0800 (CST)
Message-ID: <e805e3c4-ea66-a438-9def-bc90bbffa14e@xen0n.name>
Date:   Thu, 1 Sep 2022 10:30:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:106.0)
 Gecko/20100101 Thunderbird/106.0a1
Subject: Re: [PATCH v2] LoongArch: Add safer signal handler for TLS access
To:     Mao Bibo <maobibo@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20220831074846.3565542-1-maobibo@loongson.cn>
Content-Language: en-US
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20220831074846.3565542-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/8/31 15:48, Mao Bibo wrote:
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

Sorry, but what is the concrete use case you have in mind? arch/riscv 
for example doesn't have set_thread_area but is apparently doing fine. I 
haven't studied their code in great detail to find out myself though.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/

