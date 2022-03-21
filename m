Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5AF4E2235
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbiCUIb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240827AbiCUIby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:31:54 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56774ECFE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:30:27 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KMSVV0FNCz9sSK;
        Mon, 21 Mar 2022 09:30:26 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UkHriV35UGGy; Mon, 21 Mar 2022 09:30:25 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KMSVT6X6Qz9sSD;
        Mon, 21 Mar 2022 09:30:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE1618B766;
        Mon, 21 Mar 2022 09:30:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 289LELinwgzm; Mon, 21 Mar 2022 09:30:25 +0100 (CET)
Received: from [172.25.230.108] (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 83A188B763;
        Mon, 21 Mar 2022 09:30:25 +0100 (CET)
Message-ID: <0a8285c7-67d2-5697-5c41-f6699f9b5599@csgroup.eu>
Date:   Mon, 21 Mar 2022 09:30:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [RFC PATCH 3/3] objtool/mcount: Add powerpc specific functions
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Sathvika Vasireddy <sv@linux.ibm.com>
Cc:     "aik@ozlabs.ru" <aik@ozlabs.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20220318105140.43914-1-sv@linux.ibm.com>
 <20220318105140.43914-4-sv@linux.ibm.com>
 <YjR6kHq4c/rjCTpr@hirez.programming.kicks-ass.net>
 <33447256-81d1-8844-d82f-e8ac94f65fbe@csgroup.eu>
 <87pmmgghvu.fsf@mpe.ellerman.id.au>
 <a688b641-a8ef-8e6b-4f94-da5edd1c6943@csgroup.eu>
In-Reply-To: <a688b641-a8ef-8e6b-4f94-da5edd1c6943@csgroup.eu>
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



Le 21/03/2022 à 08:56, Christophe Leroy a écrit :
> 
> 
> Le 21/03/2022 à 03:27, Michael Ellerman a écrit :
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> Le 18/03/2022 à 13:26, Peter Zijlstra a écrit :
>>>> On Fri, Mar 18, 2022 at 04:21:40PM +0530, Sathvika Vasireddy wrote:
>>>>> This patch adds powerpc specific functions required for
>>>>> 'objtool mcount' to work, and enables mcount for ppc.
>>>>
>>>> I would love to see more objtool enablement for Power :-)
>>>
>>> I have not received this series and I can't see it on powerpc patchwork
>>> either (https://patchwork.ozlabs.org/project/linuxppc-dev/list/)
>>>
>>> Did you send it to linuxppc-dev list ? If not can you resend it there ?
>>
>> It is there, might have been delayed?
>>
>> http://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=291129
>>
>> There are some CI failures.
>>
> 
> On PPC32 I get :
> 
> [    0.000000] ftrace: No functions to be traced?
> 
> Without this series I get:
> 
> [    0.000000] ftrace: allocating 22508 entries in 17 pages
> [    0.000000] ftrace: allocated 17 pages with 2 groups
> 
> 


ppc64_defconfig on QEMU:

[    0.000000][    T0] ftrace: No functions to be traced?

Without your series:

[    0.000000][    T0] ftrace: allocating 38750 entries in 15 pages
[    0.000000][    T0] ftrace: allocated 15 pages with 4 groups
[    0.000000][    T0] trace event string verifier disabled

