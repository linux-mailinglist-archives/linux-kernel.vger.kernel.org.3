Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1331752DA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbiESQq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241854AbiESQqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:46:19 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F550014
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:46:18 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id t144so3887539oie.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7fJ9ExdcjjMQQ8V9d8hANiOgdYItD7YLNbxTme23ZaE=;
        b=jLgjd69zQsVPDeA1HfRulTSBId6Jel7vK3DYbGBFs4aCDwIeEjTqiBSVIbinXdZXSy
         H6pU66QyQhVlzK9Qgv5dzmsWXOTD+9v3ewdMTJMvAzQXYv0rHwO3CX+lZVlOb038Bawf
         aFIMEnkZSc600FwmQyzRcrHKJRkVIaSZk48fBNz3kJn7lvNXHIYYkYYQs8aB0zAWNCC8
         lgr7dDbrs8t3EVZTh1TAft8M/f3q2eES9ZbaVFXTrZmaYDz0QSgsvFKAHAmpKSzlg2lA
         vsAE/JOrY5L0m62XoqemIFUOBLHyUS5+B0km8ca8ZcLtxyCYim6C4FZplB/7IoFdw/CC
         Gd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7fJ9ExdcjjMQQ8V9d8hANiOgdYItD7YLNbxTme23ZaE=;
        b=Yvmmpm6yPRonh05HQEIDnEn4cqLvjZ7wgcbp3NFIgMfRv5RUwM28/PgrHQJ7V7bgNW
         B62qGsiStm0/BWTk+170vxyzQGY58doRWFqqSxUapEj2PlsTMtqfbqLRLYwf0JN5X9xI
         MiRfNQ/VR+9cqaCs/0g84Lf2FFtIIMBWaZEuQWs69XUv3FOvqQ0+fIxd94+QIix6dpqJ
         ns0ak5cfSg1+T11JBV/AZD65SWFGLTQZSP16915XIZ9db49x2R3L983j5AqCe7tCD+tG
         62rgOaLetu8Pez7ibAAA5agZkMXrj4gDdfLaNfr1JXQuBfMVZ+au2BreotytZiLkmdvq
         4kKA==
X-Gm-Message-State: AOAM533OB3ah0kCStMAPCB7mpwijj/QPIF/Nis0R3ShSOci8W5MajWo5
        lkGXboLCfS9yPQFSdhhwVDqC3zECTpno1w4lrJA=
X-Google-Smtp-Source: ABdhPJwo/EyOwOX9rasgoIVnk0lwkm0WnFT8LdCq/lP/2MOke764W2F8BpdgksmffHbXtT3Cmzclj4Am7z2TeAfo1Sg=
X-Received: by 2002:a05:6808:bd4:b0:326:c2e8:2d1e with SMTP id
 o20-20020a0568080bd400b00326c2e82d1emr3084544oik.52.1652978777294; Thu, 19
 May 2022 09:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220519161125.41144-1-schspa@gmail.com> <xhsmha6bd1o6a.mognet@vschneid.remote.csb>
In-Reply-To: <xhsmha6bd1o6a.mognet@vschneid.remote.csb>
From:   Schspa Shi <schspa@gmail.com>
Date:   Fri, 20 May 2022 00:46:06 +0800
Message-ID: <CAMA88TrCgyHDb=bOq37hgDZayHMKmL_yb4ZQowyw3DXdTk1Dig@mail.gmail.com>
Subject: Re: [PATCH] sched: Dump stacktrace when some task failed to stop
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Valentin Schneider <vschneid@redhat.com> writes:

> On 20/05/22 00:11, Schspa Shi wrote:
>> Some processes may not be stopped, such as workqueue workers.
>>
>> Add this dump_stack to easily figure out which process caused the problems.
>>
>> Before this change:
>>
>> <4>[  517.545889] ------------[ cut here ]------------
>> <4>[  517.545901] Dying CPU not properly vacated!
>> <4>[  517.546366] ---[ end trace 0000000000000002 ]---
>> <4>[  518.546831] CPU6 enqueued tasks (2 total):
>> <4>[  518.546855]    pid: 49, name: migration/6
>> <4>[  518.547010]    pid: 6231, name: kworker/6:0
>>
>> Signed-off-by: Schspa Shi <schspa@gmail.com>
>> ---
>>  kernel/sched/core.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 53596842f0d8..de6b5320e4d7 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -9416,7 +9416,14 @@ static void dump_rq_tasks(struct rq *rq, const char *loglvl)
>>                      continue;
>>
>>              printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
>> +            if (p != current)
>> +                    sched_show_task(p);
>>      }
>> +    /*
>> +     * We need the stack of each cpu to analyze who is blocking the
>> +     * current cpu scheduling
>> +     */
>> +    trigger_all_cpu_backtrace();
>>  }
>>
>
> Given you get a WARN() when this happens, can't you get the same thing with
>
>   panic_on_warn=1
>   panic_print=PANIC_PRINT_ALL_CPU_BT
>
> ?

Yes, I can get the information with these two parameters set.

But this is generally a difficult problem to reproduce, so wanted
to print it here so that useful information can be obtained without
turning on these switches.

>
>>  int sched_cpu_dying(unsigned int cpu)
>> --
>> 2.24.3 (Apple Git-128)

--
BRs

Schspa
