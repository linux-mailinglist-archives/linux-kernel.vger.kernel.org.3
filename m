Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3595593ED
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 09:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiFXHGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 03:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiFXHGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 03:06:48 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A546808E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 00:06:47 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LTp855ZHpz9tKq;
        Fri, 24 Jun 2022 09:06:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kD-3xgQ0uNKM; Fri, 24 Jun 2022 09:06:45 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LTp854pJHz9t8B;
        Fri, 24 Jun 2022 09:06:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 959748B78F;
        Fri, 24 Jun 2022 09:06:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id b8XY4EGIdD-e; Fri, 24 Jun 2022 09:06:45 +0200 (CEST)
Received: from [192.168.232.54] (unknown [192.168.232.54])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 277A78B763;
        Fri, 24 Jun 2022 09:06:45 +0200 (CEST)
Message-ID: <5489627e-b8c6-c024-808b-7de0a515882f@csgroup.eu>
Date:   Fri, 24 Jun 2022 09:06:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v1 0/4] Kill the time spent in patch_instruction()
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Michael Ellerman <patch-notifications@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cover.1647962456.git.christophe.leroy@csgroup.eu>
 <165261053687.1047019.4165741740473209888.b4-ty@ellerman.id.au>
 <f1481139-9ed6-3e00-e73e-87d4319c614d@csgroup.eu>
 <874k1opc6l.fsf@mpe.ellerman.id.au>
 <b5fb2df0-911b-ee84-9377-fc426c081adc@csgroup.eu>
In-Reply-To: <b5fb2df0-911b-ee84-9377-fc426c081adc@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael ?

Le 31/05/2022 à 08:24, Christophe Leroy a écrit :
> 
> 
> Le 17/05/2022 à 14:37, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> Le 15/05/2022 à 12:28, Michael Ellerman a écrit :
>>>> On Tue, 22 Mar 2022 16:40:17 +0100, Christophe Leroy wrote:
>>>>> This series reduces by 70% the time required to activate
>>>>> ftrace on an 8xx with CONFIG_STRICT_KERNEL_RWX.
>>>>>
>>>>> Measure is performed in function ftrace_replace_code() using mftb()
>>>>> around the loop.
>>>>>
>>>>> With the series,
>>>>> - Without CONFIG_STRICT_KERNEL_RWX, 416000 TB ticks are measured.
>>>>> - With CONFIG_STRICT_KERNEL_RWX, 546000 TB ticks are measured.
>>>>>
>>>>> [...]
>>>>
>>>> Patches 1, 3 and 4 applied to powerpc/next.
>>>>
>>>> [1/4] powerpc/code-patching: Don't call is_vmalloc_or_module_addr() 
>>>> without CONFIG_MODULES
>>>>         
>>>> https://git.kernel.org/powerpc/c/cb3ac45214c03852430979a43180371a44b74596 
>>>>
>>>> [3/4] powerpc/code-patching: Use jump_label for testing freed initmem
>>>>         
>>>> https://git.kernel.org/powerpc/c/b033767848c4115e486b1a51946de3bee2ac0fa6 
>>>>
>>>> [4/4] powerpc/code-patching: Use jump_label to check if 
>>>> poking_init() is done
>>>>         
>>>> https://git.kernel.org/powerpc/c/1751289268ef959db68b0b6f798d904d6403309a 
>>>>
>>>>
>>>
>>> Patch 2 was the keystone of this series. What happened to it ?
>>
>> It broke on 64-bit. I think I know why but I haven't had time to test
>> it. Will try and get it fixed in the next day or two.
>>
> 
> You didn't find any solution at the end, or didn't have time ?
> 
> What was the problem exactly ? I made a quick try on QEMU and it was 
> working as expected.
> 

Should I make it a ppc32-only change ?
