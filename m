Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326C54B6493
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbiBOHmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiBOHmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:42:23 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E7EA1BEA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 23:42:12 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JyY2T6GXfz9sSK;
        Tue, 15 Feb 2022 08:42:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UC-mDuC_Qmm5; Tue, 15 Feb 2022 08:42:09 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JyY2T5Y92z9sS2;
        Tue, 15 Feb 2022 08:42:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AF3CD8B775;
        Tue, 15 Feb 2022 08:42:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 2ZI1g5NAe4zL; Tue, 15 Feb 2022 08:42:09 +0100 (CET)
Received: from [192.168.6.174] (unknown [192.168.6.174])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E35A8B763;
        Tue, 15 Feb 2022 08:42:09 +0100 (CET)
Message-ID: <1cf5c948-351c-d5ac-cba3-6ebd322fac77@csgroup.eu>
Date:   Tue, 15 Feb 2022 08:42:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6] mm: Uninline copy_overflow()
Content-Language: fr-FR
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     David Laight <David.Laight@ACULAB.COM>,
        'Anshuman Khandual' <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <e1723b9cfa924bcefcd41f69d0025b38e4c9364e.1644819985.git.christophe.leroy@csgroup.eu>
 <50eed483-9f0a-7aee-1bfd-e89106a80424@arm.com>
 <1157d90c7335458cab4ef471c63a1d52@AcuMS.aculab.com>
 <3b8270fa-b89b-30c6-c1b8-285645215276@csgroup.eu>
 <f487114af1444881b495e0002de491b2@AcuMS.aculab.com>
 <ae9c5df2-0096-fec6-4416-cbbcc99f33ce@csgroup.eu>
 <05aa3859a0a24a0bb5e3c0affe1eb8b2@AcuMS.aculab.com>
 <3fb6ecb8-5c40-7ff4-4a55-7ea5ffad9962@csgroup.eu>
In-Reply-To: <3fb6ecb8-5c40-7ff4-4a55-7ea5ffad9962@csgroup.eu>
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



Le 14/02/2022 à 16:31, Christophe Leroy a écrit :
> 
> 
> Le 14/02/2022 à 16:10, David Laight a écrit :
>> From: Christophe Leroy
>>> Sent: 14 February 2022 14:58
>> ...
>>>> I make that 3 extra instructions.
>>>> Two are needed to load the format string.
>>>> Not sure why the third gets added.
>>>
>>> Third instruction is 'twui', to 'trap' and get the warning oops.
>>
>> I wondered what that did :-)
>> Although you really want the -- cut here -- to contain the pr_warn().
>> Doesn't WARN() do that for you?
> 
> I remember some discussion about that in the past. Will dig into it 
> tomorrow.
> 
>>
>> I was looking at that last week because the 'scheduling while atomic'
>> trace is "BUG: xxxx" but doesn't have the '--- cut here --" marker.
>>

So I looked at it. Both WARN_ON() and WARN() properly display the cut 
here line:

WARN(1, "Testing whether cut here is there");

	[   35.051548] ------------[ cut here ]------------
	[   35.051611] Testing whether cut here is there
	[   35.051665] WARNING: CPU: 0 PID: 358 at 
arch/powerpc/kernel/setup-common.c:330 show_cpuinfo+0x234/0x30c


WARN_ON(1);

	[   35.058987] ------------[ cut here ]------------
	[   35.059033] WARNING: CPU: 0 PID: 358 at 
arch/powerpc/kernel/setup-common.c:331 show_cpuinfo+0x2b0/0x30c


So yes WARN() prints the "cut here", but what the 'twui' provides you is 
everything else, the dump of all registers, call trace, instruction 
dump, etc ...

The 'twui' is after the call to __warn_printk() so everything is after 
the 'cut here'.

Then I'm not sure I understood your question.

The 'scheduling while atomic' is not generated by a WARN() but by a 
printk in function __schedule_bug() hence the absence of '--- cut here ---'

Thanks
Christophe
