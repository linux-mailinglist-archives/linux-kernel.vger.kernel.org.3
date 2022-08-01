Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2843586D2A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiHAOnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:43:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiHAOn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:43:26 -0400
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC03F3E741;
        Mon,  1 Aug 2022 07:42:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9B6D6354FD0;
        Mon,  1 Aug 2022 10:42:46 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QMZj_jTw1QdE; Mon,  1 Aug 2022 10:42:46 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 101353550BA;
        Mon,  1 Aug 2022 10:42:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 101353550BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1659364966;
        bh=Omq/uk2xaYsFc2SnbTFQ8Np0ewayqBDo2ZaBgjfBp6A=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=hQsyBsFhZGR2HBjKVRTylO783wrqVCDAV9vJ7Mo1m/pJGhG8Do1JuWZ3TqmY/e0i+
         l6eNir06gZ/PR5Yj5urlm0h3MINBQvx6Zn7ooholxF+uHk8SHheWKiludVlnigHVPq
         wm9UI2I1iV/mXReFV6tXJTebRtB/Mhsojtj16kXp0nyD0hN8Js2ejNskhWBmkfqcA3
         MfPEWI+73BXqrFMbeKLiKfakkss6oQt3Vw3ZF+sxeQSvbbvMUoLymKxcWIz9ai+hJN
         nX8B0C8zF0PbLMGjiPzddkI/B0sgWtiRcksAm3NLgChoPPc7hcoPpdOssC8+vdUWsO
         0Cz+KHrh2MpOQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qVFcZWVe3CeT; Mon,  1 Aug 2022 10:42:46 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id EC0AC354F2C;
        Mon,  1 Aug 2022 10:42:45 -0400 (EDT)
Date:   Mon, 1 Aug 2022 10:42:45 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Peter Oskolkov <posk@posk.io>
Message-ID: <1656318880.93523.1659364965914.JavaMail.zimbra@efficios.com>
In-Reply-To: <87tu6wm46t.fsf@oldenburg.str.redhat.com>
References: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com> <20220622194617.1155957-2-mathieu.desnoyers@efficios.com> <YufV3PmAOfo1Gt7g@gmail.com> <87tu6wm46t.fsf@oldenburg.str.redhat.com>
Subject: Re: [PATCH 2/2] rseq: Kill process when unknown flags are
 encountered in ABI structures
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4304 (ZimbraWebClient - FF100 (Linux)/8.8.15_GA_4304)
Thread-Topic: rseq: Kill process when unknown flags are encountered in ABI structures
Thread-Index: pv0m3/O0YjWhUVPgCMLJGmsVZ4uj9w==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 1, 2022, at 10:25 AM, Florian Weimer fweimer@redhat.com wrote:

> * Ingo Molnar:
> 
>> * Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>>
>>> rseq_abi()->flags and rseq_abi()->rseq_cs->flags 29 upper bits are
>>> currently unused.
>>> 
>>> The current behavior when those bits are set is to ignore them. This is
>>> not an ideal behavior, because when future features will start using
>>> those flags, if user-space fails to correctly validate that the kernel
>>> indeed supports those flags (e.g. with a new sys_rseq flags bit) before
>>> using them, it may incorrectly assume that the kernel will handle those
>>> flags way when in fact those will be silently ignored on older kernels.
>>> 
>>> Validating that unused flags bits are cleared will allow a smoother
>>> transition when those flags will start to be used by allowing
>>> applications to fail early, and obviously, when they attempt to use the
>>> new flags on an older kernel that does not support them.
>>> 
>>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>> ---
>>>  kernel/rseq.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>> 
>>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>>> index 81d7dc80787b..bda8175f8f99 100644
>>> --- a/kernel/rseq.c
>>> +++ b/kernel/rseq.c
>>> @@ -176,7 +176,7 @@ static int rseq_need_restart(struct task_struct *t, u32
>>> cs_flags)
>>>  	u32 flags, event_mask;
>>>  	int ret;
>>>  
>>> -	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
>>> +	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
>>>  		return -EINVAL;
>>>  
>>>  	/* Get thread flags. */
>>> @@ -184,7 +184,7 @@ static int rseq_need_restart(struct task_struct *t, u32
>>> cs_flags)
>>>  	if (ret)
>>>  		return ret;
>>>  
>>> -	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS))
>>> +	if (WARN_ON_ONCE(flags & RSEQ_CS_NO_RESTART_FLAGS) || flags)
>>>  		return -EINVAL;
>>
>> Just to make it clear: no existing libraries/tooling out there have learned
>> to rely on the old ABI that ignored unset flags, right? Only then is this
>> patch ABI-safe.
> 
> I believe glibc initializes the flag fields to zero before calling the
> rseq system call.  (I don't know if the rseq system call does its own
> initialization; maybe it should if it doesn't do so already.)

Initialization and following updates of rseq_abi()->flags and
rseq_abi()->rseq_cs->flags is done by user-space, so the rseq
system call does not initialize any of those fields.

Indeed glibc initialize the rseq_abi()->flags to 0, and does not
use rseq_abi()->rseq_cs->flags as of now.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
