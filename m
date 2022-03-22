Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B78D24E43F0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236313AbiCVQMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiCVQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:12:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08EF1E0D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:10:52 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id h11so24620501ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4grXaZDRtzVFEImdnWSYsmh756fJ7h8Ts6/UkZ9wdbQ=;
        b=fGX/oDELudWkZfbJNfkbrdU3sEtYsHfs8ovbdYPuONxNITeyO8o4b4Nh2Q9bcXni1h
         nLDhYDSR/xHHxYg15icHwFx/7YQE9nlqbxYPXY1lIc0J1qyzOiOwx1opS7Xs13VJmqMf
         ie4PaeLQsIvUmRJlJBNWEoJHceLQuDZAcZhxvMv887AtS5OsGmGMns2e7CmnSRZWZy4Y
         UX5z1QsfKAyOn9lGrE2YexTsmEYTps/XBzexPXee//ZuQyiay00T2tE11PJ/fVD4et+9
         v0p8lpvyQvFaGf7EmcgXegEapEaQApjZpLwMVoBU57kBJmgrbGOHC39N70U6D9EJSB4/
         Hd8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4grXaZDRtzVFEImdnWSYsmh756fJ7h8Ts6/UkZ9wdbQ=;
        b=cKE56esECIcOwL7+jBGMDDXG39DNGMp8d2gc7AOSogQ+AP3cvGBeU8nG/yGq0jd+2b
         EA71mlS+yVto0pUwt+0XUM//T745amgDa60tEJoRLvgCnqZTZydCf8YFkGmDlL7QHn1J
         Y0V0LdezFLBu5EjwZTGvvKl3ITu9GBbaJ5EV8zdOSGZpEKV/ODw01JT8PouTwU/gGqX0
         L94BbrUnDhznr0E8AZCtAqqNKW7pKpUR0pg/q8fFUe+Jb4NXr9YTSMVvq9QQ7RcSj9t7
         RZU44+v9HXmDIogRGotBAFzSEit0lraJnI5QNgtxVEyXJz+NrDpmz+UmbwWz2koPqFJD
         kSQQ==
X-Gm-Message-State: AOAM532kbjJs0cGqd245FlHqXBTz317Ufxk17YY7p8sT/+6PhpiYaQoO
        ePz4lb3OczuLjHlAlic0dxk1QJDcJ8G4+8IjFRFNJw==
X-Google-Smtp-Source: ABdhPJwZoZKcS2ZwVyreBz+BfBh8iT7TR2Ba68asMk7bTQTZOSKdtivfu0F7KOSzec802BRwSP3/7AyxVcgY9VB69K0=
X-Received: by 2002:a2e:b5b9:0:b0:246:b30:64c8 with SMTP id
 f25-20020a2eb5b9000000b002460b3064c8mr18972308ljn.17.1647965448013; Tue, 22
 Mar 2022 09:10:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-7-vincent.guittot@linaro.org> <Yji0twS4N+0b/Rs9@slm.duckdns.org>
In-Reply-To: <Yji0twS4N+0b/Rs9@slm.duckdns.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 22 Mar 2022 17:10:36 +0100
Message-ID: <CAKfTPtA8g-MJMPRM2R_Bfo9rGSyR3cYAUy_j5UrRM+SAB=Mm7w@mail.gmail.com>
Subject: Re: [RFC 6/6] sched/fair: Add sched group latency support
To:     Tejun Heo <tj@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, Valentin.Schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@google.com, tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Mon, 21 Mar 2022 at 18:24, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Mar 11, 2022 at 05:14:06PM +0100, Vincent Guittot wrote:
> > Tasks can set its latency priority which is then used to decide to preempt
> > the current running entity of the cfs but sched group entities still have
> > the default latency priority.
> >
> > Add a latency field in task group to set the latency priority of the group
> > which will be used against other entity in the parent cfs.
>
> One thing that bothers me about this interface is that the configuration
> values aren't well defined. We have the same problems with the nice levels
> but at least have them map to well defined weight values, which likely won't
> change in any foreseeable future. The fact that we have the
> not-too-well-defined nice levels as an interface shouldn't be a reason we
> add another one. Provided that this is something scheduler folks want, it'd
> be really great if the interface can be better thought through. What are the
> numbers actually encoding?

latency_nice is quite similar to nice. The nice latency is used as an
index to get a latency weight in the range [-1024:1024].  latency_nice
is in the range [-20:19] and latency_prio shifts it in the range
[0:40] . This index is then used to get the latency weight similar to
how the nice prio is used to get a weight. That being said, the
latency should probably reflect the latency_weight instead of the
latency_prio in order to be aligned with the weight and weight.nice
fields of cgroups.

As described in patch 5 commit message, the weight is then used to
compute a relative offset to check whether the waking task can preempt
the current running task.

Vincent

>
> Thanks.
>
> --
> tejun
