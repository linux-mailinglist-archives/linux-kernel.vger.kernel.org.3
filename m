Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2394D9286
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 03:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344341AbiCOCXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 22:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbiCOCXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 22:23:03 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40095289BD
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:21:52 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id l2so34572551ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 19:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jS7HXX60JFn1Unsr00TBuiMw8USABkpK3RB4v29+bJ4=;
        b=LibLel7rMVDIEuti1y+/Td6hFbdEe6xrA4vSNXEdKW3DFoS4gnvwSCPa41sbOunY7U
         MZ1+ItdYOAQqAtbqh+eMrFAGm+6UR5nvnGLQlpG7t5lyOESkWEHml583iKs+ldb8lwMj
         R9OQSA4DwMj8bKP+cSnz63ZvNje5LTXOX2X4JD7PhzHpwLs8ETUWAgPiQDu7HXoeRW4u
         JYittx4sL+y5+iTiZHqXpKktwVrbsi1Dxrgg55ZBmiBY5gG7mSX2wsB+rQf384rE1gCR
         TGBg0A+B2c3yyFQxnjOwPkH5Opr8Trv3AIBm+KUGT0EAIpiQPY+VuTq63sfXGyU3uphu
         /sWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jS7HXX60JFn1Unsr00TBuiMw8USABkpK3RB4v29+bJ4=;
        b=jGCzfnnn8k5ZVJE0P65o0sgVs8X25KvPd8ozagYEplurK5RSSDQObIC+PtoixmGBkp
         6wuvtj6yi28xHw3yrgL7BdVi2Gm/EN2paTjn0xkdZ3uKBeDR2RTykxgc8gYwCSmVLRrR
         +IEd2ulHP0GMetnxsecNQQiZuSwxjwz3tZ4RWjfOtIei035CRNqwiToZutBMF1UbEJpo
         WXfDzoWPCor+Sp+2lBNkN4kEMB8EuE2Oz/sLI3kEMF/mnfX//+umYM3r+7kiSbXvkn/+
         Drf2U2bk+pjbdZbZR5nZVZLK8K+Vljew19LneRDLWfSt+fvwq2suNd2qxwe5va7E50n9
         Bbnw==
X-Gm-Message-State: AOAM532QGqs1zS/kshVcg9BP7vIGrDGJ3Pv5QRjy8T+YPajYcY+Gf1cI
        0hso1r7U9EnbmvJE7uBvS0Mf9G4a7UpaKXTJlV56nA==
X-Google-Smtp-Source: ABdhPJzHWbJzdfJP8TUCtxPfF3bBGjsrZm7XycwvjMwlUiqRshYsD6gHXSzv/VWq4B++r8GvUcj3T2X/KbOfP4ssMCw=
X-Received: by 2002:a25:b991:0:b0:610:bf4e:1b33 with SMTP id
 r17-20020a25b991000000b00610bf4e1b33mr21743376ybg.352.1647310911218; Mon, 14
 Mar 2022 19:21:51 -0700 (PDT)
MIME-Version: 1.0
References: <f87a8c0d-527d-a9bc-9653-ff955e0e95b4@bytedance.com>
 <20220312120309.GB6235@worktop.programming.kicks-ass.net> <a528d7bf-a634-00b6-42ab-dcb516567c34@bytedance.com>
 <20220313090222.GL28057@worktop.programming.kicks-ass.net>
 <e57c7166-b484-0d32-e4e8-5a47ef0bb53c@bytedance.com> <CABk29NsBEZ63eQ-avDBHe1LYj+wJNSTkCxPDQ=eTNS9_i9e0NA@mail.gmail.com>
 <5de97c7f-2c71-34d0-9443-27f71960b4dd@bytedance.com>
In-Reply-To: <5de97c7f-2c71-34d0-9443-27f71960b4dd@bytedance.com>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 14 Mar 2022 19:21:40 -0700
Message-ID: <CABk29NskiBBk--FJDux34mt-iQnZ4L-_p9XPtKUerFbtr5AMcQ@mail.gmail.com>
Subject: Re: [External] Re: Subject: [PATCH] sched/fair: prioritize normal
 task over sched_idle task with vruntime offset
To:     chenying <chenying.kernel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Benjamin Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        duanxiongchun@bytedance.com, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        zhoufeng.zf@bytedance.com, ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Mar 14, 2022 at 7:05 PM chenying <chenying.kernel@bytedance.com> wr=
ote:
>
> =E5=9C=A8 2022/3/15 8:30, Josh Don =E5=86=99=E9=81=93:
> > On Sun, Mar 13, 2022 at 3:07 AM chenying <chenying.kernel@bytedance.com=
> wrote:
> >>
> >> If I set the sched_idle_vruntime_offset to a relatively small value
> >> (e.g. 10 minutes), can this issues be avoided?
> >
> > That's still long enough to cause lockups.
> >
> > Is the issue that you have a large number of sched_idle entities, and
> > the occasional latency sensitive thing that wakes up for a short
> > duration? Have you considered approaching this from the other
> > direction (ie. if we have a latency sensitive thing wake onto a cpu
> > running only sched idle stuff, we could change entity placement to
> > position the latency sensitive thing further left on the timeline,
> > akin to !GENTLE_FAIR_SLEEPERS).
>
> I think this may not guarantee that latency sensitive tasks are always
> to the left of idle tasks. And it may get complicated if a
> latency-sensitive task is woken up onto a cpu which there are already
> multiple latency-sensitive tasks and sched_idle tasks.

If you're waking onto a cpu with lots of latency-sensitive tasks
already, you're already outside the bounds of being able to guarantee
the latency tails you're after (given that the default
idle_min_granularity and idle weight aren't giving you the performance
at the tails that you want right now). It would be helpful to get a
clearer statement as to the problem you're trying to solve.

Perhaps Vincent's recent patch series adding latency support to CFS
("Add latency_nice priority") would be of interest?
