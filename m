Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1A54AA87
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354369AbiFNH0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 03:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351788AbiFNH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 03:26:09 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4DB3DA77
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 00:26:07 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LMg320zS8z9tBr;
        Tue, 14 Jun 2022 09:26:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tydUD9wXKsef; Tue, 14 Jun 2022 09:26:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LMg32020vz9tBX;
        Tue, 14 Jun 2022 09:26:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E1A868B766;
        Tue, 14 Jun 2022 09:26:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Co_muVH59YpW; Tue, 14 Jun 2022 09:26:05 +0200 (CEST)
Received: from [192.168.204.246] (unknown [192.168.204.246])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 735208B763;
        Tue, 14 Jun 2022 09:26:05 +0200 (CEST)
Message-ID: <c76598b5-2d60-ea22-d590-4cc6998a8830@csgroup.eu>
Date:   Tue, 14 Jun 2022 09:26:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIDIvMl0gdWlvOnBvd2VycGM6bXBjODV4?=
 =?UTF-8?Q?x=3a_l2-cache-sram_uio_driver_implementation?=
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Wenhu Wang <wenhu.wang@hotmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220609102855.272270-1-wenhu.wang@hotmail.com>
 <SG2PR01MB295139AA7360917B2C4846E19FA79@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
 <YqHy1uXwCLlJmftr@kroah.com>
 <SG2PR01MB2951EA9ED70E5F766DD26A069FAA9@SG2PR01MB2951.apcprd01.prod.exchangelabs.com>
 <efebcb50-0481-622a-894c-7000999aacc6@csgroup.eu>
In-Reply-To: <efebcb50-0481-622a-894c-7000999aacc6@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 14/06/2022 à 09:18, Christophe Leroy a écrit :
> 
> 
> Le 14/06/2022 à 08:09, Wenhu Wang a écrit :
>>>> +static const struct vm_operations_struct uio_cache_sram_vm_ops = {
>>>> +#ifdef CONFIG_HAVE_IOREMAP_PROT
>>>
>>> Same here.
>>>
>>
>> I tried to eliminate it in mainline
>> See: [PATCH v2] mm: eliminate ifdef of HAVE_IOREMAP_PROT in .c files
>> https://lkml.org/lkml/2022/6/10/695
>>
> 
> I looked at that patch.
> 
> I don't think you can just drop the #ifdef in function 
> __access_remote_vm() in mm/memory.c
> 
> You have to replace it with something like:
> 
>      if (!IS_ENABLED(CONFIG_HAVE_IOREMAP_PROT))
>          break;
> 


Another thing in that patch:

By making generic_access_phys() a static inline, it means that everytime 
you refer to the address of that function in a vm_operations_struct 
struct, the compiler has to provide an outlined instance of the 
function. It means you'll likely have several instances of a 
generic_access_phys().

What you could do instead is to add the following at the start of 
generic_access_phys() in mm/memory.c :

	if (!IS_ENABLED(CONFIG_HAVE_IOREMAP_PROT))
		return 0;
