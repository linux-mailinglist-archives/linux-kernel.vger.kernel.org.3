Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEBF573644
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiGMMYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235326AbiGMMYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:24:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA739369F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:24:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b26so15278676wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFN/+qZ2tpt7SOKVBZ29gM46VHaQCK9ulBVoZA5bxDA=;
        b=Q/A22LCNnj1rmw5Ny2Y1hFvTQq0+/X+5chBITGh3s32co0tvV0co9yk8S3AbQK+IlA
         iS4ici2OqlXIi1vQc3Zdu31p6wQmlb1O0QbX2sNLq5+0fZTtziSSsYu6E4X8lfL4jYzt
         bz0f/IO6IogM1CivR43KCFdTbQ/Q8/yTZ1bbdZjajTtPPHRoIlMpwoLNbEPeCJQvIjaG
         tCGRskgCU36CBCQnqQWHXAfnQq9668+XUn3+h6YZVd10clMwOhNwuAuoz6+Jrk+rktTI
         LImNYWyrvcB6xUJg5keZImkHHH2J4w+xyQ6wCUrNVIRMqhImlPaFNd1MCUDuIfm4sr7G
         o/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFN/+qZ2tpt7SOKVBZ29gM46VHaQCK9ulBVoZA5bxDA=;
        b=ldzItXSQA4JZTSC1NPfcdAlTYBHEB0TqdSDMy8Tm96Ud4JF08g9iucsVGBc2pCzzEU
         GHDLwKqlQ1SaXK4vB97TexPdPQQkaj8fzjXSYd6UexEdNjiRVtWrG5Z/0ertwOYKsJtf
         ifxpnCtml+o6Yf99hTUZPhX3pz850FVRNZ2MUEDsoeICETmkIPDxdgRCEaz8gJoaCtuC
         DtZvlcSWKeGBwdu0gAnizX9dDg8v+R3bbhHaA7fw+E0876EXg7djYjCE56bum6rZJce+
         zsUnclAyVnnZZpuBn2mf0Ll/jAU+zOcohPnoJ0lYDPKGbsaczjMjqKidSpIJ6uieAT/8
         DDGQ==
X-Gm-Message-State: AJIora+8YwXO5UdZgLYiWMhSstF4yeTyhhH3xSrpTG2XPKwVA1kMRgiF
        c8HyJQzdj3bmplyE11DytKk07B+aq/wWXqffOBQ=
X-Google-Smtp-Source: AGRyM1uBvT4jIM3VGh071yQG7IradvhoosrJc9OfmDcfF8VJhDffv8J+vxrumnGRxuC2NbBRw4IrKRLyOPLc8EEvMyk=
X-Received: by 2002:a05:6000:2a7:b0:21d:bbda:4fcd with SMTP id
 l7-20020a05600002a700b0021dbbda4fcdmr3085867wry.316.1657715078726; Wed, 13
 Jul 2022 05:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220712150506.632304-1-schspa@gmail.com> <20220712150506.632304-2-schspa@gmail.com>
 <5f0d6bef-9e9e-7083-9657-ae5e6dd10d2a@arm.com>
In-Reply-To: <5f0d6bef-9e9e-7083-9657-ae5e6dd10d2a@arm.com>
From:   Schspa Shi <schspa@gmail.com>
Date:   Wed, 13 Jul 2022 20:24:27 +0800
Message-ID: <CAMA88Tre3iVu+Dsxv4W_eWY2TrTPR-j_hfXVzQPCEynnCbgBeg@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] sched/rt: Trying to push current task when target
 disable migrating
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     mingo@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com, Valentin Schneider <vschneid@redhat.com>,
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

Dietmar Eggemann <dietmar.eggemann@arm.com> writes:

> On 12/07/2022 17:05, Schspa Shi wrote:
>
> [...]
>
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 7bd3e6ecbe45e..e2d7b085a93d9 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -2136,6 +2136,12 @@ static int push_rt_task(struct rq *rq, bool pull)
>>               */
>>              task = pick_next_pushable_task(rq);
>>              if (task == next_task) {
>> +                    /*
>> +                     * If next task has now disabled migrating, see if we
>> +                     * can push the current task.
>> +                     */
>> +                    if (unlikely(is_migration_disabled(task)))
>
> Doesn't this need a `put_task_struct(next_task)`?

Thanks for the review, I missed this.

>
>> +                            goto retry;
>>                      /*
>>                       * The task hasn't migrated, and is still the next
>>                       * eligible task, but we failed to find a run-queue
>
> Why not introduce in push_dl_task() as well?

OK, push_dl_task() needs this too, I missed it.

I will upload a new patch version to fix it.


-- 
BRs
Schspa Shi
