Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EFD4F8717
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346862AbiDGScQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiDGScP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:32:15 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA991770BA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:30:11 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KZ90d2yhcz9sRn;
        Thu,  7 Apr 2022 20:30:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YiRAN_PMiJwo; Thu,  7 Apr 2022 20:30:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KZ90d23v1z9sRk;
        Thu,  7 Apr 2022 20:30:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 384238B765;
        Thu,  7 Apr 2022 20:30:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CznV1Ldv3Bfe; Thu,  7 Apr 2022 20:30:09 +0200 (CEST)
Received: from [192.168.202.234] (unknown [192.168.202.234])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5C8908B792;
        Thu,  7 Apr 2022 20:30:07 +0200 (CEST)
Message-ID: <5666917d-81b3-e010-776a-2c2ddccd400e@csgroup.eu>
Date:   Thu, 7 Apr 2022 20:30:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v8 00/14] Convert powerpc to default topdown mmap layout
 (v8)
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "alex@ghiti.fr" <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <cover.1646847561.git.christophe.leroy@csgroup.eu>
 <ddfed61b-e387-4554-eb88-6654b391d1a4@csgroup.eu>
 <877d91m7wd.fsf@mpe.ellerman.id.au>
 <20220310204917.3d42e6cf3088f7cf1c7fe7a6@linux-foundation.org>
 <e61f1ab5-075a-8d68-0315-4d7069be1650@csgroup.eu>
In-Reply-To: <e61f1ab5-075a-8d68-0315-4d7069be1650@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

Le 04/04/2022 à 07:22, Christophe Leroy a écrit :
> Hi Andrew,
> 
> Le 11/03/2022 à 05:49, Andrew Morton a écrit :
>> On Fri, 11 Mar 2022 15:26:42 +1100 Michael Ellerman 
>> <mpe@ellerman.id.au> wrote:
>>
>>>> What will be the merge strategy ? I guess it's a bit late to get it
>>>> through powerpc tree, so I was just wondering whether we could get
>>>> patches 2 to 5 in mm this cycle, and the powerpc ones next cycle ?
>>>
>>> Yeah I didn't pick it up because the mm changes don't have many acks and
>>> I'm always nervous about carrying generic mm changes.
>>>
>>> It would be my preference if Andrew could take 2-5 through mm for v5.18,
>>> but it is quite late, so I'm not sure how he will feel about that.
>>
>> 5.18 isn't a problem.  Perhaps you meant 5.17, which would be real tough.
>>
>> Can we take a look after 5.18-rc1?
> 
> 5.18-rc1 was released last night.
> 
> Can you take patchs 2-5 as they are, or do you prefer I resend them to 
> yourself as a standalone series ?
> 

Are you expecting anything from me ? Do you need a resend of those 4 
patches as a standalone series ?

Thanks
Christiphe
