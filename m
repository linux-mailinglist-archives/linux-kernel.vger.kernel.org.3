Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4970053422A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 19:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245665AbiEYR1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbiEYR1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 13:27:36 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0E630F5D
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 10:27:34 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L7dLF0RBbz9t7f;
        Wed, 25 May 2022 19:27:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tczjtePghe9T; Wed, 25 May 2022 19:27:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L7dLD6TFDz9sRq;
        Wed, 25 May 2022 19:27:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A495E8B778;
        Wed, 25 May 2022 19:27:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id wTlNO94Eyj_i; Wed, 25 May 2022 19:27:32 +0200 (CEST)
Received: from [192.168.203.180] (unknown [192.168.203.180])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BEA848B763;
        Wed, 25 May 2022 19:27:31 +0200 (CEST)
Message-ID: <f1decbb7-b441-a241-469a-4ba118e08212@csgroup.eu>
Date:   Wed, 25 May 2022 19:27:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [RFC PATCH 4/4] objtool/powerpc: Add --mcount specific
 implementation
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Sathvika Vasireddy <sv@linux.vnet.ibm.com>
Cc:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "aik@ozlabs.ru" <aik@ozlabs.ru>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>,
        "naveen.n.rao@linux.vnet.ibm.com" <naveen.n.rao@linux.vnet.ibm.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <20220523175548.922671-1-sv@linux.ibm.com>
 <20220523175548.922671-5-sv@linux.ibm.com>
 <6be5c941-07b0-64d5-7f36-fe5770fb5244@csgroup.eu>
 <59170f18-1356-1140-70e3-30cb627f00bc@linux.vnet.ibm.com>
 <578ec055-0d63-e579-0caa-ad57846b8995@csgroup.eu>
In-Reply-To: <578ec055-0d63-e579-0caa-ad57846b8995@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 24/05/2022 à 15:33, Christophe Leroy a écrit :
> 
> 
> Le 24/05/2022 à 13:00, Sathvika Vasireddy a écrit :
>>>
>>>> +{
>>>> +    switch (elf->ehdr.e_machine) {
>>>> +    case EM_X86_64:
>>>> +            return R_X86_64_64;
>>>> +    case EM_PPC64:
>>>> +            return R_PPC64_ADDR64;
>>>> +    default:
>>>> +            WARN("unknown machine...");
>>>> +            exit(-1);
>>>> +    }
>>>> +}
>>> Wouldn't it be better to make that function arch specific ?
>>
>> This is so that we can support cross architecture builds.
>>
> 
> 
> I'm not sure I follow you here.
> 
> This is only based on the target, it doesn't depend on the build host so
> I can't the link with cross arch builds.
> 
> The same as you have arch_decode_instruction(), you could have
> arch_elf_reloc_type_long()
> It would make sense indeed, because there is no point in supporting X86
> relocation when you don't support X86 instruction decoding.
> 

Could simply be some macro defined in 
tools/objtool/arch/powerpc/include/arch/elf.h and 
tools/objtool/arch/x86/include/arch/elf.h

The x86 version would be:

#define R_ADDR(elf) R_X86_64_64

And the powerpc version would be:

#define R_ADDR(elf) (elf->ehdr.e_machine == EM_PPC64 ? R_PPC64_ADDR64 : 
R_PPC_ADDR32)

Christophe
