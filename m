Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A255333CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 01:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242525AbiEXXMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 19:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiEXXMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 19:12:49 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED785BE49
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 16:12:48 -0700 (PDT)
Message-ID: <a9cd5385-5a26-c410-2609-4575cc0d6adf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653433965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mk7xRNKNX0AOjCU5G7KogWbcujD8+WpYXrtI2ETV4XE=;
        b=jbyXtlbZqNLrbFY1S2vnVXbfwQVr7DceO1EXyKdR6qAsHKO5XsshFKzXtd3RxBrN866jNM
        yQBnKE2abWf1OfF+EvaXxqIq1sNo05pgot/iYufWGjiRK/GBOJy0xPePZYOgo8uUXrdYeN
        m1yUzychkjRXcWo7joeT7mC8/u+Op6c=
Date:   Wed, 25 May 2022 02:12:44 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   vasily.averin@linux.dev
Subject: Re: [PATCH] ipc: Remove dead code in perform_atomic_semop()
Content-Language: en-US
To:     Gautam Menghani <gautammenghani201@gmail.com>,
        akpm@linux-foundation.org, shakeelb@google.com, mhocko@suse.com,
        manfred@colorfullife.com
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
References: <20220524182244.42987-1-gautammenghani201@gmail.com>
In-Reply-To: <20220524182244.42987-1-gautammenghani201@gmail.com>
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

On 5/24/22 21:22, Gautam Menghani wrote:
> Remove the line which is dead code. Fixes the clang scan warning:
> warning: Value stored to 'result' is never read [deadcode.DeadStores]
>                 result = curr->semval;
> 
> Signed-off-by: Gautam Menghani <gautammenghani201@gmail.com>
> ---
>  ipc/sem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 0dbdb98fdf2d..156824bcda47 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -766,7 +766,6 @@ static int perform_atomic_semop(struct sem_array *sma, struct sem_queue *q)
>  	for (sop = sops; sop < sops + nsops; sop++) {
>  		curr = &sma->sems[sop->sem_num];
>  		sem_op = sop->sem_op;
> -		result = curr->semval;
>  
>  		if (sop->sem_flg & SEM_UNDO) {
>  			int undo = un->semadj[sop->sem_num] - sem_op;

Perhaps it would be better to keep the "result" but use it in the
marked line below, like it was done in previous part of this function?

                        un->semadj[sop->sem_num] = undo;
                }
                curr->semval += sem_op; <<<<<< VvS: here ?
                ipc_update_pid(&curr->sempid, q->pid);

Thank you,
	Vasily Averin
