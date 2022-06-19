Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF3D55090B
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 08:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiFSGzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 02:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiFSGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 02:55:22 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46031B1EF
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jun 2022 23:55:20 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LQk793fp7z9tqD;
        Sun, 19 Jun 2022 08:55:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wCXGlb6dWBvg; Sun, 19 Jun 2022 08:55:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LQk792Yslz9tlb;
        Sun, 19 Jun 2022 08:55:17 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4519E8B766;
        Sun, 19 Jun 2022 08:55:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LZIrJToxkgNZ; Sun, 19 Jun 2022 08:55:17 +0200 (CEST)
Received: from [192.168.232.18] (unknown [192.168.232.18])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DEE728B763;
        Sun, 19 Jun 2022 08:55:16 +0200 (CEST)
Message-ID: <90a002a5-52b0-a028-b729-33a072c077c1@csgroup.eu>
Date:   Sun, 19 Jun 2022 08:55:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] powerpc/prom_init: Add memset as valid external symbol if
 CONFIG_KASAN=y
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Guenter Roeck <linux@roeck-us.net>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        ul Mackerras <paulus@samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Axtens <dja@axtens.net>
References: <20220619035246.2633538-1-linux@roeck-us.net>
 <9b2952c9-d6d7-b4c2-f5d6-cec8722decc8@csgroup.eu>
In-Reply-To: <9b2952c9-d6d7-b4c2-f5d6-cec8722decc8@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 19/06/2022 à 08:45, Christophe Leroy a écrit :
> 
> 
> Le 19/06/2022 à 05:52, Guenter Roeck a écrit :
>> If CONFIG_KASAN=y, powerpc:allmodconfig fails to build with the following
>> error.
>>
>> Error: External symbol 'memset' referenced from prom_init.c
>>
>> The problem was introduced with commit 41b7a347bf14 ("powerpc: Book3S
>> 64-bit outline-only KASAN support"). So far, with CONFIG_KASAN=y, only
>> __memset was accepted as valid external symbol in prom_init_check.sh.
>> Add memset as well to fix the problem.
> 
> No way. It is way too early to use the instrumented version of memset().

See commit 26deb04342e3 ("powerpc: prepare string/mem functions for 
KASAN") for more details

> 
> Did you try with the patch I sent ?
> 
> https://patchwork.ozlabs.org/project/linuxppc-dev/patch/3802811f7cf94f730be44688539c01bba3a3b5c0.1654875808.git.christophe.leroy@csgroup.eu/
> 
> Thanks
> Christophe
> 
>>
>> Fixes: 41b7a347bf14 ("powerpc: Book3S 64-bit outline-only KASAN support")
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Daniel Axtens <dja@axtens.net>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>    arch/powerpc/kernel/prom_init_check.sh | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/prom_init_check.sh b/arch/powerpc/kernel/prom_init_check.sh
>> index b183ab9c5107..787142b5dd26 100644
>> --- a/arch/powerpc/kernel/prom_init_check.sh
>> +++ b/arch/powerpc/kernel/prom_init_check.sh
>> @@ -16,7 +16,7 @@
>>    grep "^CONFIG_KASAN=y$" .config >/dev/null
>>    if [ $? -eq 0 ]
>>    then
>> -	MEM_FUNCS="__memcpy __memset"
>> +	MEM_FUNCS="__memcpy __memset memset"
>>    else
>>    	MEM_FUNCS="memcpy memset"
>>    fi
