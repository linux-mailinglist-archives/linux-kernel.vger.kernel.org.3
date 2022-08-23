Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F82759EB0E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbiHWSbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232260AbiHWSaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:30:52 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5434F8266;
        Tue, 23 Aug 2022 09:50:57 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4MBwGR6krQz9sZY;
        Tue, 23 Aug 2022 18:50:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3SSRsUXke2io; Tue, 23 Aug 2022 18:50:55 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4MBwGR6058z9sXB;
        Tue, 23 Aug 2022 18:50:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD5C48B77A;
        Tue, 23 Aug 2022 18:50:55 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gyojHjs122t5; Tue, 23 Aug 2022 18:50:55 +0200 (CEST)
Received: from [192.168.232.51] (po17370.idsi0.si.c-s.fr [192.168.232.51])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 48F258B763;
        Tue, 23 Aug 2022 18:50:55 +0200 (CEST)
Message-ID: <3756ad84-a5b0-b404-7962-86f77d6f38b3@csgroup.eu>
Date:   Tue, 23 Aug 2022 18:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH linux-next] powerpc: disable sanitizer in
 irq_soft_mask_set
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Zhouyi Zhou <zhouzhouyi@gmail.com>, npiggin@gmail.com,
        atrajeev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, lance@osuosl.org, paulmck@kernel.org,
        rcu@vger.kernel.org
References: <20220821010030.97539-1-zhouzhouyi@gmail.com>
 <87edx7l5px.fsf@mpe.ellerman.id.au>
 <0d7b55bc-4dd2-7de1-8ca5-353b1a044caf@csgroup.eu>
In-Reply-To: <0d7b55bc-4dd2-7de1-8ca5-353b1a044caf@csgroup.eu>
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



Le 23/08/2022 à 10:47, Christophe Leroy a écrit :
> 
> 
> Le 23/08/2022 à 10:33, Michael Ellerman a écrit :
>> Zhouyi Zhou <zhouzhouyi@gmail.com> writes:
>>
>> My worry is that this will force irq_soft_mask_set() out of line, which
>> we would rather avoid. It's meant to be a fast path.
>>
>> In fact with this applied I see nearly 300 out-of-line copies of the
>> function when building a defconfig, and ~1700 calls to it.
>>
>> Normally it is inlined at every call site.
>>
>>
>> So I think I'm inclined to revert ef5b570d3700 ("powerpc/irq: Don't open
>> code irq_soft_mask helpers").
> 
> Could you revert it only partially ? In extenso, revert the 
> READ/WRITE_ONCE and bring back the inline asm in irq_soft_mask_return() 
>   and irq_soft_mask_set(), but keep other changes.

I sent a patch doing that.

Christophe
