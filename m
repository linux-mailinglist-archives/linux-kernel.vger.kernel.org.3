Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D6C570F15
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiGLAug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGLAue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:50:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FA9248E1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:50:34 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id z1so5890812plb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=nq5VDTxnZLTeB3sMypNbVikOvabvDzmucjQyVWV8Mbw=;
        b=ZNcOdc0oHW7mvchFZZ3WG4YtzPiUj5LGAp3PVmSX1JTAaQkK0VocOEHQRn0ioDkAD/
         LVQm28xLDyvplVuV4zehdCLo55A51S6LbFI6BCPsI6EGdUtipoMv+Jvpy+Zg2jLfpbZQ
         lMjyxEmlGl0xfAN4ErdnVKzoHLpNTSfyXSdUvo33XocZAtAScDVZQm02ircDLxCxZ/rL
         6l51AKmZ6YR3TS/qtUyvKt49EZHaXXq0LWJaQy2NjkP6k07C9PcUykxzRvNqhHadE7uH
         8j02N3ms/F03A+wWHaxpTllOl7u2Pj1Vy690icO6TvwCfHl2HiCS6yr2k1mDgxQWVxd6
         DYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=nq5VDTxnZLTeB3sMypNbVikOvabvDzmucjQyVWV8Mbw=;
        b=qBgb1SEWE6jPHxwtMD9RoyGz9Z2jhil/uB3wGOD7uMao/gfUWq3RNTuoUUolDJWyPM
         ChTa9Ii8/4iiTEhTiUfqea9B4T0Hr4rOqQVIPxX5srut5rPWM0iRPEWdPldvm4txnAvQ
         ZhRA326jfJX0kA5BaOb9/ae436B7d9FE4YCi8qC6Bbs7ZQINX+redQl3z7KRyuQsPdP+
         feVqqmSXVO57czGf95LxW8ei0QTHnBUyuUOPDcAoHZR8M84ODmcMcE3jP+fWlb29n6gV
         vuHfK/tkHfOAr3h5IC9RRzfSLGAWKYoO5ZxmQV759DsYaIC4ljSdq6U+NbJSl0FhX2ch
         L4zg==
X-Gm-Message-State: AJIora+gHI8DaWHZAqdj2wFgrzSaCGg0435nmYgJoOAIJWxHM0ApX8dj
        VXMXT3U0faMiGy67Hq8n1uQ=
X-Google-Smtp-Source: AGRyM1sEEa926e/qwc78doygaREQbplTVW9CcC3PGLsudg2YHFDq9IlA2rYG7qhcIPCSCSpNd1pnIQ==
X-Received: by 2002:a17:903:1c4:b0:16c:4e45:38a3 with SMTP id e4-20020a17090301c400b0016c4e4538a3mr6635115plh.41.1657587033798;
        Mon, 11 Jul 2022 17:50:33 -0700 (PDT)
Received: from localhost (193-116-203-247.tpgi.com.au. [193.116.203.247])
        by smtp.gmail.com with ESMTPSA id i14-20020a170902c94e00b0016c4331e61csm3314982pla.137.2022.07.11.17.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 17:50:33 -0700 (PDT)
Date:   Tue, 12 Jul 2022 10:50:28 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 12/13] locking/qspinlock: separate pv_wait_node from the
 non-paravirt path
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20220704143820.3071004-1-npiggin@gmail.com>
        <20220704143820.3071004-13-npiggin@gmail.com>
        <YsR2IQsnqAOgDxXu@worktop.programming.kicks-ass.net>
In-Reply-To: <YsR2IQsnqAOgDxXu@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1657586928.uawdad42k7.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Peter Zijlstra's message of July 6, 2022 3:34 am:
> On Tue, Jul 05, 2022 at 12:38:19AM +1000, Nicholas Piggin wrote:
>> pv_wait_node waits until node->locked is non-zero, no need for the
>> pv case to wait again by also executing the !pv code path.
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  kernel/locking/qspinlock.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
>> index 9db168753124..19e2f286be0a 100644
>> --- a/kernel/locking/qspinlock.c
>> +++ b/kernel/locking/qspinlock.c
>> @@ -862,10 +862,11 @@ static inline void queued_spin_lock_mcs_queue(stru=
ct qspinlock *lock, bool parav
>>  		/* Link @node into the waitqueue. */
>>  		WRITE_ONCE(prev->next, node);
>> =20
>> +		/* Wait for mcs node lock to be released */
>>  		if (paravirt)
>>  			pv_wait_node(node, prev);
>> -		/* Wait for mcs node lock to be released */
>> -		smp_cond_load_acquire(&node->locked, VAL);
>> +		else
>> +			smp_cond_load_acquire(&node->locked, VAL);
>> =20
>=20
> (from patch #6):
>=20
> +static void pv_wait_node(struct qnode *node, struct qnode *prev)
> +{
> +       int loop;
> +       bool wait_early;
> +
> 	...
> +
> +       /*
> +        * By now our node->locked should be 1 and our caller will not ac=
tually
> +        * spin-wait for it. We do however rely on our caller to do a
> +        * load-acquire for us.
> +        */
> +}
>=20
>=20

Oh good catch, thanks so much that's a dumb bug. I'll add a=20
smp_load_acquire at the end of pv_wait_node where that comment
is.

Thanks,
Nick
