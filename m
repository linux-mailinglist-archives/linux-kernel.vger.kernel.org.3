Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555B152F602
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353990AbiETXJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347085AbiETXJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:09:48 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C771E1912CC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:09:45 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id d137so16415245ybc.13
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r1fS3IXIw/s+vzbyRwSGih92mZvaWIhj50yzhP08HyE=;
        b=eiVwXC0jIMcRJTf0ETo7duPL65FRe2ML4mHwbAFMyPHAT97FZdTn0OUukopDTLklTQ
         D6aVh2Ox1qFMAorJaL82OLTnTzqqu7dgw4M0PxB3s3e/K1KQmDJd+vrx3sZeBweXeoTE
         /ARoKm3VLXPGEiXqjNU33aMYqulHt5V/zvM2+3gHmxIVNEQ1oNt35l3vgsQJEmneuvql
         VEUOjvyJTSyoUllwvjSZsc3OHReV73tYP7XkaRjJn6rAhH4mNusEekmpZIQfuTW+qGdX
         WroCkVOTZcRVwC37ute8cckL/U5q4wunJSFV3xrOgpA9phs4OFwlyYA10C2UPf8wcnsF
         5RDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r1fS3IXIw/s+vzbyRwSGih92mZvaWIhj50yzhP08HyE=;
        b=YCn7tpyTgt/GfNokH0T3GMa4D8nlhnuqslNGsNL9Q1vRbXUGXuQTBLkXXZzNxvYARi
         1KNGlRyyakTabO2EVZfUNUyl5QX9neuP8xzXP+tjJjAmVy80nv0mmBkzcLGcWgItKhnu
         abXHdGFW5qVW7d5Y2aEaxz/8/+uj2N1xM8LugzJjw/k5IW8Wi2/xuiMcX92MiYJIUUMN
         cuOq5+xJBbLTWPjb6FU4cEv47iM2orioPVot3FO372LEEzGJzlI7OgzIlFVQe36PR8ev
         2qdqZENATcAifcUtHB5K1butv1FgAPoFDpOhCJkNn+1JaTDVO5OQ1xB1n5HwrVXZ22M+
         VS2A==
X-Gm-Message-State: AOAM533V2eh+5oAuPYSknMu1VmbBeRQAzIKRIIfoJtLnpwzKS2sJF7z4
        YlfIIEmMimipVrYJc7AohSJTgfGFkOTwvT+TmzbHpA==
X-Google-Smtp-Source: ABdhPJxlU22cOefLredZAHHeypNDPSdE5Pt9H/urovIJVUKpP8npAKqcXzeX8kmrcYMopGgq3pHqrYQ9ECH8+ZDrh68=
X-Received: by 2002:a25:2c55:0:b0:64d:f682:db36 with SMTP id
 s82-20020a252c55000000b0064df682db36mr12248097ybs.352.1653088184749; Fri, 20
 May 2022 16:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220513005427.2507335-1-joshdon@google.com> <Yn3JTpXhWRTeahyG@slm.duckdns.org>
 <CABk29Nv=J_ZUnDTkRhwdQop=REr_XDGjJxn_zVy4kBqwx8K57w@mail.gmail.com> <YofhY8kcTrQOs2iF@slm.duckdns.org>
In-Reply-To: <YofhY8kcTrQOs2iF@slm.duckdns.org>
From:   Josh Don <joshdon@google.com>
Date:   Fri, 20 May 2022 16:09:33 -0700
Message-ID: <CABk29NvpHQrnK2S8yBZhzjieJ59mGAZR8NdtZQAgu0YE_y3LPA@mail.gmail.com>
Subject: Re: [PATCH] sched/core: add forced idle accounting for cgroups
To:     Tejun Heo <tj@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 11:43 AM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> Sorry about late reply and thanks for the ping. I missed this one.
>
> On Fri, May 13, 2022 at 12:23:16PM -0700, Josh Don wrote:
> > Yea, that's right, this doesn't require the cpu controller to be
> > enabled. Are you suggesting to add a new field to cgroup_base_stat?
>
> Yes, that's what I meant. I think it'd fit there better.

Sounds good, I'll send a second version of the patch with that change.

> > One other weird artifact of collecting forceidle time is that a cpu
> > may account it on behalf of its hyperthread sibling. Currently, the
> > core rstat code always accounts to the current cpu's percpu rstat
> > field. I can add an accounting function to support writes to a
> > different cpu's field, in order to make sure that the per-cpu totals
> > are correct (the forceidle accounting code holds rq->__lock, which
> > protects all HT siblings of a core). percpu totals aren't currently
> > exported in cgroup v2, but this is useful information that we'll
> > consume, so it would be nice to keep it accurate.
>
> Sure, as long as it doesn't incur overhead when not used.

The extra complexity actually doesn't seem to be required. Per-core
totals will be accurate, which is the important part.

Thanks,
Josh
