Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7DB533600
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 06:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243714AbiEYEUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 00:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiEYEUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 00:20:45 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BFD55345
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 21:20:43 -0700 (PDT)
Message-ID: <3e686290-14e4-a4e9-3825-afb011b8c0e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653452442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B9G5hUzauDQzBCUae+mMyfXNu37nLvF3U6X5lDAQKU8=;
        b=Cj4xv31bNF8YNaPcGnC1xELW0EyErW5WTV859fFs4ztuqVR4Xwh+1JDuOk4bTATL1kXrnB
        /AABN63X9RWpLQ80c7v7K8nrVtjvaj9IXQKIlwxJ0Z0Omt5cChBvbiYz/cGSGViO4ec40c
        /Eqs7CzNMxJlnO7aNBd/AFf90RDNnno=
Date:   Wed, 25 May 2022 07:20:40 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: Re: [PATCH] ipc: Remove dead code in perform_atomic_semop()
Content-Language: en-US
To:     Gautam Menghani <gautammenghani201@gmail.com>,
        akpm@linux-foundation.org, shakeelb@google.com, mhocko@suse.com,
        manfred@colorfullife.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20220524182244.42987-1-gautammenghani201@gmail.com>
 <a9cd5385-5a26-c410-2609-4575cc0d6adf@linux.dev>
In-Reply-To: <a9cd5385-5a26-c410-2609-4575cc0d6adf@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/22 02:12, vasily.averin@linux.dev wrote:
> On 5/24/22 21:22, Gautam Menghani wrote:
>> Remove the line which is dead code. Fixes the clang scan warning:
>> warning: Value stored to 'result' is never read [deadcode.DeadStores]
>>                 result = curr->semval;
>>
>> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
>> ---
>>  ipc/sem.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/ipc/sem.c b/ipc/sem.c
>> index 0dbdb98fdf2d..156824bcda47 100644
>> --- a/ipc/sem.c
>> +++ b/ipc/sem.c
>> @@ -766,7 +766,6 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
>>  	for (sop = sops; sop < sops + nsops; sop++) {
>>  		curr = &sma->sems[sop->sem_num];
>>  		sem_op = sop->sem_op;
>> -		result = curr->semval;
>>  
>>  		if (sop->sem_flg & SEM_UNDO) {
>>  			int undo = un->semadj[sop->sem_num] - sem_op;
> 
> Perhaps it would be better to keep the "result" but use it in the
> marked line below, like it was done in previous part of this function?

Sorry, I was wrong.
Reviewed-by: Vasily Averin <vvs@openvz.org>
