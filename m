Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDD34D6485
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 16:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349127AbiCKP1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 10:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242998AbiCKP1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 10:27:19 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455261BFDF5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 07:26:15 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KFVBs5k0Pz9sSC;
        Fri, 11 Mar 2022 16:26:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qp6YRxrFMoxK; Fri, 11 Mar 2022 16:26:13 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KFVBs4vlZz9sS8;
        Fri, 11 Mar 2022 16:26:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9754A8B78F;
        Fri, 11 Mar 2022 16:26:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WtYrdfl9TIqQ; Fri, 11 Mar 2022 16:26:13 +0100 (CET)
Received: from [192.168.202.87] (unknown [192.168.202.87])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8FD818B763;
        Fri, 11 Mar 2022 16:26:12 +0100 (CET)
Message-ID: <cca14ed0-0fc3-a286-9b06-621cff20a447@csgroup.eu>
Date:   Fri, 11 Mar 2022 16:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] kexec/powerpc: fix exporting memory limit
Content-Language: fr-FR
To:     Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     yadviga@dev.rtsoft.ru, lugovskoy@dev.rtsoft.ru,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Anton Blanchard <anton@samba.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
References: <1394115854-11709-1-git-send-email-nyushchenko@dev.rtsoft.ru>
 <1394153258.21206.1.camel@concordia> <201403070838.07820@blacky.localdomain>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <201403070838.07820@blacky.localdomain>
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



Le 07/03/2014 à 05:38, Nikita Yushchenko a écrit :
>> On Thu, 2014-03-06 at 18:24 +0400, Nikita Yushchenko wrote:
>>> When preparing dump-capturing kernel, kexec userspace tool needs to
>>> know actual amount of memory used by the running kernel. This may
>>> differ from extire available DRAM for a couple of reasons. To address
>>> this issue, kdump kernel support code injects several attributes into
>>> device tree that are later captured by userspace kexec tool via /proc
>>> interface.
>>>
>>> One such attrubute is 'chosen/linux,memory_limit' that is used to pass
>>> memory limit of the running kernel.
>>>
>>> This was initialized using kernel's 'memory_limit' variable, that is
>>> set by early init code based on mem= kernel parameter and other
>>> reasons.
>>>
>>> But there are cases when memory_limit variable does not contain proper
>>> information. One such case is when !CONFIG_HIGHMEM kernel runs on
>>> system with memory large enough not to fit into lowmem.
>>
>> Why doesn't the !CONFIG_HIGHMEM code update memory_limit to reflect
>> reality.
> 
> I guess because memory_limit is used for ... well, memory limit, set by
> mem=. And for the rest memblock is used (and it *is* updated).
> 
> And code elsewhere does use memblock, see e.g. numa_enforce_memory_limit()
> in arch/powerpc/mm/numa.c
> 
> In MMU init (MMU_init() in arch/powerpc/mm/init_32.c -which is the point
> where final memory configuration is set) memblock, not memory_limit, is
> both used and updated.


We still have this patch as "New" in patchwork.

I don't know if it is relevant but directory structure has changed so if 
still needed this patch needs rebase.

Christophe
