Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44C53D671
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 12:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbiFDKfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 06:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234648AbiFDKf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 06:35:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4E66419
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 03:35:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id c14so9069947pgu.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jun 2022 03:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=7+Vijt1MmRlglM0RAhiDFZa/De73PheL/nJ1Y6TP4mg=;
        b=fNk+wU+DGYtPgG+Iju3kGdOyw8wpYvWGyfqNV6GwAnks4Q8oBo/sK+6U+Pc97W4r7x
         pD/hcQ7HCt6iAC2QnCXa+vErQS9Z43A7skPBwhGnM7TrE0r1L9wSFehUynRf6Wy27sNt
         1rUQPVEyfXdWsNpwYkLxCnlju4sB4ZC/cneGeHJA+veN37tvH8TNc4Yl0h/ginXuneqg
         y+SuVwvfOsLnEnTTyd70CF4lHIoCbIdylu9d4d4ZTMUsPKKnWMoQFQBoVK229Btgdrwa
         uBsoawepodYH8JHaq/HUhJ1BNBFVq27XlJJDFVOooAdWSMrhE7mSxntKLlIFUmPXrt4c
         8z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=7+Vijt1MmRlglM0RAhiDFZa/De73PheL/nJ1Y6TP4mg=;
        b=IjqvEfURTcOzmg8mtqE6v0Pmekv00OcTHN406LY+5WP2A955/tET5kIQc5xLDwEW55
         +CPDmM1hOkN8+G0tRG56ALWRXaggGNJTEWswdPq/Y0BexSg9xfDFxfHN9g/WpmT4kgZ2
         hFV8iUfnUIG5ay7gbZdGK4kqDxgNSIkWEXkzkwma1oRUgaeAMwRsZ+lclyLWUlifhETx
         VBVbIgX/flQsZ+n10RPxZGeD4TjQN1RY76tlIQcL432v4yEINGO92qFJeZIZCvxWYpCq
         tBP5Alfhlmjbbr4Eagp0LNj5UeXbY5o6WMaiy7B6yvgFlfbkkhSxSMUI4wXrMyZAcmrf
         ADpw==
X-Gm-Message-State: AOAM531G5aPsEQ662B40HuTT+c09G6djPlY4kyudOw5pJpIzw+NqFXx+
        aIn+ZFEPPaPDI70LwjPQJJQ=
X-Google-Smtp-Source: ABdhPJzLS1o0rUf644L3/MWMFdGVzogH3ajNhHeorqFsKKa5P8DMxoVpEm+jHn4CmYziDDgz86t3LA==
X-Received: by 2002:a63:4964:0:b0:3fc:a87a:bd8d with SMTP id y36-20020a634964000000b003fca87abd8dmr12575373pgk.257.1654338924703;
        Sat, 04 Jun 2022 03:35:24 -0700 (PDT)
Received: from pc ([103.142.140.127])
        by smtp.gmail.com with ESMTPSA id ik29-20020a170902ab1d00b00163f3e91ea0sm6916153plb.238.2022.06.04.03.35.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jun 2022 03:35:23 -0700 (PDT)
Date:   Sat, 4 Jun 2022 18:35:19 +0800
From:   Zackary Liu <zackary.liu.pro@gmail.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     "=?utf-8?Q?akpm=40linux-foundation.org?=" <akpm@linux-foundation.org>,
        "=?utf-8?Q?linux-mm=40kvack.org?=" <linux-mm@kvack.org>,
        "=?utf-8?Q?linux-kernel=40vger.kernel.org?=" 
        <linux-kernel@vger.kernel.org>
Message-ID: <6BC32F66-2AC4-450D-90D5-B7A09455B617@getmailspring.com>
In-Reply-To: <YpcZFvVZRPTyTQ7s@dhcp22.suse.cz>
References: <YpcZFvVZRPTyTQ7s@dhcp22.suse.cz>
Subject: Re: [PATCH] mm/oom_kill: break evaluation when a task has been
 selected
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 1 2022, at 3:45 pm, Michal Hocko <mhocko@suse.com> wrote:

> On Sat 14-05-22 15:52:28, Zhaoyu Liu wrote:
>> oom points no longer need to be calculated if a task is oom_task_origin(),
>> so return 1 to stop the oom_evaluate_task().
> 
> This doesn't really explain why this is really desired. Is this a fix,
> optimization?
> 
> Please also note that this change has some side effects. For one, the
> task marked as oom origin will get killed even if there is still a
> pending oom victim which hasn't been fully dismantled. Is this
> intentional?

Thank you very much for reminding.

From my point of view, the victim was marked in the last oom, and now it
has entered the oom again, which means that the system still has no
deprecated memory available. In order to ensure that the system can
return to normal as soon as possible, killing the origin task
immediately should be A good choice, and the role of this patch is to
end oom_evaluate_task and return true as soon as the origin task is found.
Maybe this patch is not the optimal solution, it has a trade-off.

It is an honor to discuss with you, thank you very much!

zackary

>> Signed-off-by: Zhaoyu Liu <zackary.liu.pro@gmail.com>
>> ---
>>  mm/oom_kill.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
>> index 3996301450e8..b407fba21d19 100644
>> --- a/mm/oom_kill.c
>> +++ b/mm/oom_kill.c
>> @@ -308,7 +308,7 @@ static enum oom_constraint
>> constrained_alloc(struct oom_control *oc)
>>  static int oom_evaluate_task(struct task_struct *task, void *arg)
>>  {
>>  	struct oom_control *oc = arg;
>> -	long points;
>> +	long points = 0;
>>  
>>  	if (oom_unkillable_task(task))
>>  		goto next;
>> @@ -349,7 +349,7 @@ static int oom_evaluate_task(struct task_struct
>> *task, void *arg)
>>  	oc->chosen = task;
>>  	oc->chosen_points = points;
>>  next:
>> -	return 0;
>> +	return points == LONG_MAX;
>>  abort:
>>  	if (oc->chosen)
>>  		put_task_struct(oc->chosen);
>> -- 
>> 2.17.1
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
