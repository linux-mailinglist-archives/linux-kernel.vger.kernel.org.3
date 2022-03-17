Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3094DC8AC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiCQOYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiCQOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:24:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7D3DDCB;
        Thu, 17 Mar 2022 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=U3YBJWruFs9ahkXSkuJtoG3rsMMVJ7pMrWmhkqc3kms=; b=s+MWaUn4qp3Q0lHwtYNWnMTQfq
        9q7Euphy8neOQ9jGWn432pEdBi+znYgee7nl8kqAaJ+lnlG9Rb3zkZJGu/k3KNZSmx1UvyzmuZJ7C
        gFKS3Dz52B94R8wqAhTA9+JWXyHRf81ngOoAC5w+gYfxHSYz8Fr6bTLvKAIllkUFI2N38AgoayNIU
        ZszwCES5jNkW1yHQmZs0IKg+IyaQlkuHI16YTRh78FbnSF7v6JpLq0rAY/KQO7pouameutdvZyIrJ
        b2md3gbooOYDWmHnhsuULHLUX/jgno0DI2EvQCvDLYSZKPDpLb0Qm+5DQoavi7yKZA5Ugv+ROdjUo
        ha9AwA1Q==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUr21-0072LH-0W; Thu, 17 Mar 2022 14:23:13 +0000
Message-ID: <21c5336c-96e3-fdae-dc52-c1ab2f52df3b@infradead.org>
Date:   Thu, 17 Mar 2022 07:23:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [powerpc] 5.17-rc8-next-20220317 build break kernel/sched/fair.o
Content-Language: en-US
To:     Sachin Sant <sachinp@linux.ibm.com>, linux-next@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>
References: <EF33D230-9A8F-41C5-A38D-95128603224F@linux.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <EF33D230-9A8F-41C5-A38D-95128603224F@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/22 03:35, Sachin Sant wrote:
> Today’s next (5.17.0-rc8-next-20220317) fails to build on powerpc
> with following error:
> 
>   CC      kernel/sched/fair.o
> In file included from ./arch/powerpc/include/generated/asm/rwonce.h:1,
>                  from ./include/linux/compiler.h:248,
>                  from ./include/linux/kernel.h:20,
>                  from ./include/linux/cpumask.h:10,
>                  from ./include/linux/energy_model.h:4,
>                  from kernel/sched/fair.c:23:
> ./include/linux/psi.h: In function 'cgroup_move_task':
> ./include/linux/rcupdate.h:414:36: error: dereferencing pointer to incomplete type 'struct css_set'
>  #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>                                     ^~~~
> ./include/asm-generic/rwonce.h:55:33: note: in definition of macro '__WRITE_ONC'
>   *(volatile typeof(x) *)&(x) = (val);    \
>                                  ^~~
> ./arch/powerpc/include/asm/barrier.h:74:2: note: in expansion of macro 'WRITE_ONCE'
>   WRITE_ONCE(*p, v);      \
>   ^~~~~~~~~~
> ./include/asm-generic/barrier.h:164:55: note: in expansion of macro '__smp_store_release'
>  #define smp_store_release(p, v) do { kcsan_release(); __smp_store_release(p, v); } while (0)
>                                                        ^~~~~~~~~~~~~~~~~~~
> ./include/linux/rcupdate.h:455:3: note: in expansion of macro 'smp_store_releas'
>    smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>    ^~~~~~~~~~~~~~~~~
> ./include/linux/rcupdate.h:455:25: note: in expansion of macro 'RCU_INITIALIZER'
>    smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
>                          ^~~~~~~~~~~~~~~
> ./include/linux/psi.h:58:2: note: in expansion of macro 'rcu_assign_pointer'
>   rcu_assign_pointer(p->cgroups, to);
>   ^~~~~~~~~~~~~~~~~~
> make[2]: *** [scripts/Makefile.build:309: kernel/sched/fair.o] Error 1
> make[1]: *** [scripts/Makefile.build:578: kernel/sched] Error 2
> make: *** [Makefile:1834: kernel] Error 2
> 
> Git bisect points to:
> 
> commit c4ad6fcb67c42d65481c85733c8009c8afdfdf4e (refs/bisect/bad)
>     sched/headers: Reorganize, clean up and optimize kernel/sched/fair.c dependencies
> 
> I have attached .config

Here is a fix for the CONFIG_PSI=n build error:

https://lore.kernel.org/lkml/917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org/

-- 
~Randy
