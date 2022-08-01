Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80C4586D03
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiHAOj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiHAOj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:39:57 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB233A08;
        Mon,  1 Aug 2022 07:39:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 41022355282;
        Mon,  1 Aug 2022 10:39:54 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qU3Ksj57-Bf5; Mon,  1 Aug 2022 10:39:53 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 84365355281;
        Mon,  1 Aug 2022 10:39:53 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 84365355281
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659364793;
        bh=S6TGQdRaLLzWDqfWZw/iX4zWZbflDaNiquwZgEj1VAU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GEcHO9q5VqIHAvO9M4Ydp4H68nx8WrnKU7NcXWY2D7IPyC0YwoxjOAQ2lgkRGgNzZ
         xtOOS0dDoNecDFEt3sAJl2HOP1/QLkuAUKpunPP7NjbTqa4Y2pVH7fWmGTXX+/83IB
         UjxztRTvu6bSF+Pg0bLf2mJFZ+RDS8N7HxfhjngILB7wnOz//L8fWUiIuP+pQfgQVo
         ebxXkCRVmopyaquWoHbqFAALghaeRLubX5azntPcaXkhAEmgyRgTwqpML6A+9ttaA0
         Dr90DNSqBCm0aWFCmnwD5hMHweDS0t0PDUKreEY9JjqJPUvbCAyNVK4gcjqnFtrFpF
         n9cfH2lJ+M3XQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 28mwD_qkks1k; Mon,  1 Aug 2022 10:39:53 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 72610354FAE;
        Mon,  1 Aug 2022 10:39:53 -0400 (EDT)
Date:   Mon, 1 Aug 2022 10:39:53 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>
Message-ID: <1686554751.93506.1659364793386.JavaMail.zimbra@efficios.com>
In-Reply-To: <YufV3PmAOfo1Gt7g@gmail.com>
References: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com> <20220622194617.1155957-2-mathieu.desnoyers@efficios.com> <YufV3PmAOfo1Gt7g@gmail.com>
Subject: Re: [PATCH 2/2] rseq: Kill process when unknown flags are
 encountered in ABI structures
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Topic: rseq: Kill process when unknown flags are encountered in ABI structures
Thread-Index: Gyv6lAHRYZe8QjWfh6WSrEJ1aTXMvw==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 1, 2022, at 9:32 AM, Ingo Molnar mingo@kernel.org wrote:

> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> rseq_abi()->flags and rseq_abi()->rseq_cs->flags 29 upper bits are
>> currently unused.
>> 
>> The current behavior when those bits are set is to ignore them. This is
>> not an ideal behavior, because when future features will start using
>> those flags, if user-space fails to correctly validate that the kernel
>> indeed supports those flags (e.g. with a new sys_rseq flags bit) before
>> using them, it may incorrectly assume that the kernel will handle those
>> flags way when in fact those will be silently ignored on older kernels.
>> 
>> Validating that unused flags bits are cleared will allow a smoother
>> transition when those flags will start to be used by allowing
>> applications to fail early, and obviously, when they attempt to use the
>> new flags on an older kernel that does not support them.
>> 
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>>  kernel/rseq.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>> index 81d7dc80787b..bda8175f8f99 100644
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -176,7 +176,7 @@ static int rseq_need_restart(struct task_struct *t, u32
>> cs_flags)
>>  	u32 flags, event_mask;
>>  	int ret;
>>  
>> -	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
>> +	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
>>  		return -EINVAL;
>>  
>>  	/* Get thread flags. */
>> @@ -184,7 +184,7 @@ static int rseq_need_restart(struct task_struct *t, u32
>> cs_flags)
>>  	if (ret)
>>  		return ret;
>>  
>> -	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS))
>> +	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
>>  		return -EINVAL;
> 
> Just to make it clear: no existing libraries/tooling out there have learned
> to rely on the old ABI that ignored unset flags, right? Only then is this
> patch ABI-safe.

The projects I know about that use rseq at the moment don't rely on the old ABI
ignoring unset flags:

- glibc initialize the rseq_abi()->flags to 0 and do not use rseq_abi()->rseq_cs->flags yet.
- tcmalloc initialize rseq_abi()->flags and rseq_abi()->rseq_cs->flags to 0.
- librseq (still only a master branch, no officially released public API yet) initialize
  rseq_abi()->flags and rseq_abi()->rseq_cs->cs_flags to 0.
- the Linux kernel selftests initialize rseq_abi()->flags and rseq_abi()->rseq_cs->cs_flags
  to 0.
- AFAIK DynamoRIO does not rely on the kernel ignoring unset flags bits.
- AFAIK CRIU does not rely on the kernel ignoring unset flags bits.

If anyone else rely on rseq ignoring those unset flags, please yell now.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
