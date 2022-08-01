Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E2D586CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbiHAOZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiHAOZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B998A45B
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659363928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8SWhnvugOGDjKjvgWCUF/erAdE9TR/aKwqvfm/BKepE=;
        b=Fs6fcNPSo+N+RUvXSoOtmcvNh1UIwTq/eBpyMfP+B7A98x6SV0uhtn8mn7V4/SCPibLJAA
        +kOnt6DZ05mo6M0WIfGTotXLsGLKNC5hn2vbBPkvIkCh8Bgb22VON63GSAjGvyV47hiBVS
        0qrpnVE66uC7nr9XGE2+JPQjpZrSB4U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-117-qFY0QgG5N4m_0qyjuUxHnw-1; Mon, 01 Aug 2022 10:25:19 -0400
X-MC-Unique: qFY0QgG5N4m_0qyjuUxHnw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1BF638035AB;
        Mon,  1 Aug 2022 14:25:18 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B055E90A04;
        Mon,  1 Aug 2022 14:25:16 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Peter Oskolkov <posk@posk.io>
Subject: Re: [PATCH 2/2] rseq: Kill process when unknown flags are
 encountered in ABI structures
References: <20220622194617.1155957-1-mathieu.desnoyers@efficios.com>
        <20220622194617.1155957-2-mathieu.desnoyers@efficios.com>
        <YufV3PmAOfo1Gt7g@gmail.com>
Date:   Mon, 01 Aug 2022 16:25:14 +0200
In-Reply-To: <YufV3PmAOfo1Gt7g@gmail.com> (Ingo Molnar's message of "Mon, 1
        Aug 2022 15:32:12 +0200")
Message-ID: <87tu6wm46t.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ingo Molnar:

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
>> @@ -176,7 +176,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
>>  	u32 flags, event_mask;
>>  	int ret;
>>  
>> -	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS))
>> +	if (WARN_ON_ONCE(cs_flags & RSEQ_CS_NO_RESTART_FLAGS) || cs_flags)
>>  		return -EINVAL;
>>  
>>  	/* Get thread flags. */
>> @@ -184,7 +184,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
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

I believe glibc initializes the flag fields to zero before calling the
rseq system call.  (I don't know if the rseq system call does its own
initialization; maybe it should if it doesn't do so already.)

Thanks,
Florian

