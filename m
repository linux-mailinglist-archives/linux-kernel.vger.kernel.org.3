Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20E84AC63B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357453AbiBGQnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 11:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241483AbiBGQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 11:39:57 -0500
Received: from mail.efficios.com (mail.efficios.com [167.114.26.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E78C0401CE;
        Mon,  7 Feb 2022 08:39:55 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D878036758E;
        Mon,  7 Feb 2022 11:39:54 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 49AoB8w6YSvL; Mon,  7 Feb 2022 11:39:54 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5BA6136758D;
        Mon,  7 Feb 2022 11:39:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5BA6136758D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1644251994;
        bh=4E6ttFwpPTiBJHpxFWSJaEUv0d7GNSZ47Y9QpUOUgLc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=FihTULIwKNOb0P0OMjTGUZlw6X5vR9omfcdluk/r2KLPlkIby+eXa+Uvq5GRwt+YZ
         lJL9P+rOeMmKOSyCGIgdXuA3RmB6Qflaoy5yaSE+dtrBOdzD8uZZpfZljEbx7bJO5B
         xZ+PXXSYI5YgLrBqDiz6kiBSypQeoXEKukGsWEWPUR1s41ppnvc012woBlHcLT4N/U
         JDT1qtwVJQDqAKWthKFa8pXv3ZNnc/enT8xAU29lcizifI1ExxrsSMVg/DiaJGKbTH
         ywgHwxuEdLkI6+wMo21UJeg7zXTZzyK3sQy8PpAdY3wt8zcEDZzLjY99hnpe2ZVMB5
         2hgXh44ytdccA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Uza1-sigjqfM; Mon,  7 Feb 2022 11:39:54 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 475DA367515;
        Mon,  7 Feb 2022 11:39:54 -0500 (EST)
Date:   Mon, 7 Feb 2022 11:39:54 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api <linux-api@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        David Laight <David.Laight@aculab.com>,
        carlos <carlos@redhat.com>, Peter Oskolkov <posk@posk.io>,
        libc-coord <libc-coord@lists.openwall.com>
Message-ID: <1069583975.46528.1644251994113.JavaMail.zimbra@efficios.com>
In-Reply-To: <YgBDDVZSZqID8L3R@hirez.programming.kicks-ass.net>
References: <20220203193853.21511-1-mathieu.desnoyers@efficios.com> <20220203193853.21511-3-mathieu.desnoyers@efficios.com> <YgBDDVZSZqID8L3R@hirez.programming.kicks-ass.net>
Subject: Re: [RFC PATCH 3/3] rseq: extend struct rseq with numa node id
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4203 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4203)
Thread-Topic: rseq: extend struct rseq with numa node id
Thread-Index: JygeOzRonTrMEViFglh4jrP23b2dow==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 6, 2022, at 4:52 PM, Peter Zijlstra peterz@infradead.org wrote:

> On Thu, Feb 03, 2022 at 02:38:53PM -0500, Mathieu Desnoyers wrote:
>> +static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
>>  {
>> -	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED;
>> +	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0;
>>  
>>  	/*
>>  	 * Reset cpu_id_start to its initial state (0).
>> @@ -124,6 +126,11 @@ static int rseq_reset_rseq_cpu_id(struct task_struct *t)
>>  	 */
>>  	if (put_user(cpu_id, &t->rseq->cpu_id))
>>  		return -EFAULT;
>> +	/*
>> +	 * Reset node_id to its initial state (0).
>> +	 */
>> +	if (put_user(node_id, &t->rseq->node_id))
>> +		return -EFAULT;
> 
> Why 0 vs -1 ?

That's because we are adding this field as a replacement of 4 from the 12 bytes
of padding at the end of the original struct rseq uapi. I expect this padding to be
zero-initialized in glibc, but I don't think its initial value matters very much.

The initial value for cpu_id (-1) mattered  because that field was used to check whether
rseq was initialized. It should not matter as much for extended fields. Taking the
glibc userspace ABI into account, I would expect the following for node_id feature
discovery by applications:

- use __rseq_size (symbol exposed by glibc) to validate whether rseq is registered for
  the process.
- use getauxval(AT_RSEQ_FEATURE_SIZE) to know how many rseq fields are populated by the
  kernel.

So there are really only a few possible scenarios here:

- __rseq_size == 0: rseq registration unsuccessful
- else:
  - getauxval(AT_RSEQ_FEATURE_SIZE) == 0:
    - Kernel only implements the features of original rseq (last populated field is "flags",
      offsetofend(, flags) == 20).
  - else if getauxval(AT_RSEQ_FEATURE_SIZE) <= 32:
    - all exposed kernel features can be used, because the original rseq len was 32 bytes,
      so glibc always registers at least a 32-byte area.
  - else
    - only min(__rseq_size, getauxval(AT_RSEQ_FEATURE_SIZE)) features can be used.
      glibc is required to allocate a memory area large enough to hold all features,
      except when it allocates the original uapi 32 bytes.

So until we reach the 32 bytes limit of the original rseq structure, applications can directly
use getauxval() to use the additional features before glibc is made aware of them. From that
point on, glibc needs to allocate a larger memory area to hold those features.

I suspect that future glibc versions might want to expose a new "__rseq_feature_size"
symbol which contains the result of

    min(__rseq_size, getauxval(AT_RSEQ_FEATURE_SIZE) ? : offsetofend(, flags))

so applications don't have to do this computation on their own.

Considering that applications will likely check for rseq registration and feature availability
by checking offsetofend(, field) <= __rseq_feature_size, then I don't think the initialization
value matters much.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
