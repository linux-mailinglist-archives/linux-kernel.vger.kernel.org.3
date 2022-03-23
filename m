Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC19F4E54D8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbiCWPG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbiCWPG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:06:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AA474618
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:04:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id c15so2221156ljr.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pcd7ERBlVyrelAyEbyObU06kBBZOkR02qCmkyHS2E3g=;
        b=v2rsIJOBb9hrCntLGx10hrQjMUUe1nejvycHnYkVPeIT/aqymErAxqoioMJxOEn5ee
         R7xiXcOqHIxn8eF007FnOhjldCXye1l5PZZM3t6/tUAFJUtxboFW4/NnAkv5U3xKPGtX
         0QUbiwvu9i19hsBN7j4ayWon6TNQ9RI1CykFtX7IcsgVhoTNw68KXiQBDXBK1N0xc9yk
         gXYA7lmUct6cu3ptPOczwleiyN+Z6kLRi+K+uKAbczFQhtXAImzohMWl8CBQqF1GF+in
         n4esI55NrdnsSytPwtrgkis+WyuPbiQFCNIQDO9Jq8Cx9Qr7q7PH5RTP61Nj/sVfej5x
         Z9VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcd7ERBlVyrelAyEbyObU06kBBZOkR02qCmkyHS2E3g=;
        b=csMUtlTgLwPOI6cuyyVcLEcHxU6L+m3U2AQ/v70g0QY2bV+5Tdb9F0EMwBAdeP1+/K
         36Iy9LVQ+mW9ECxH5MGTbGS6ypUzeilCCEWO49+W0UbXfnLG5YfO8rErbCo7Sw4V5J33
         2gYgaD5X1pmjtNO86VgMu7hCfx2EpNes4JNsUCvSQ5R57O8k6lzLUrw5576gZJFLfUao
         YC3QTNCwWK3YAvLcKU+y4rQp7sPQek88OIuYxiP6m8wBu2TsLe2i3rsU3WOYhZLDiP+f
         4CjSz1RzLd5ttJ6L4ADCvnh+HkMNp+/tZIk8JKM9fuYc+MCNjePcT498KLLhr2qlQPSK
         I8AQ==
X-Gm-Message-State: AOAM530zTGIYOdcU5SbFHiGIH5pLPwq94aGxWrlRGoTIkXr/dpcN5oZG
        bMmgWVbeesOsIxZALSt23wbSsicsQBAixrEN2ut1UFEsg58=
X-Google-Smtp-Source: ABdhPJwHuw7AXpEDapQAqgnI0V8E4UY6hrxwX2g9mOVk2Zzbv8ajOTETjzuci19FfvzyZwhAXcicZnZzacBqexlMlu8=
X-Received: by 2002:a2e:b5b9:0:b0:246:b30:64c8 with SMTP id
 f25-20020a2eb5b9000000b002460b3064c8mr325264ljn.17.1648047894521; Wed, 23 Mar
 2022 08:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-7-vincent.guittot@linaro.org> <Yji0twS4N+0b/Rs9@slm.duckdns.org>
 <CAKfTPtA8g-MJMPRM2R_Bfo9rGSyR3cYAUy_j5UrRM+SAB=Mm7w@mail.gmail.com> <Yjn8DohJ8CZ6pEvf@slm.duckdns.org>
In-Reply-To: <Yjn8DohJ8CZ6pEvf@slm.duckdns.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 23 Mar 2022 16:04:42 +0100
Message-ID: <CAKfTPtB4iV0Z40grV3w=WwpOUAZAgx_ZoBfvjA63H8Am-RYdNw@mail.gmail.com>
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

On Tue, 22 Mar 2022 at 17:40, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Mar 22, 2022 at 05:10:36PM +0100, Vincent Guittot wrote:
> > latency_nice is quite similar to nice. The nice latency is used as an
> > index to get a latency weight in the range [-1024:1024].  latency_nice
> > is in the range [-20:19] and latency_prio shifts it in the range
> > [0:40] . This index is then used to get the latency weight similar to
> > how the nice prio is used to get a weight. That being said, the
> > latency should probably reflect the latency_weight instead of the
> > latency_prio in order to be aligned with the weight and weight.nice
> > fields of cgroups.
> >
> > As described in patch 5 commit message, the weight is then used to
> > compute a relative offset to check whether the waking task can preempt
> > the current running task.
>
> So, what I'm trying to say is if it is actually a weight, just use weight
> values instead of arbitrary mapped nice values. Nobody can tell how the
> latency nice value of -2 compares against, say, 3. If you can define it
> clearly in terms of weights (or something else clearly describable), it'd be
> a lot better.

The current use is mapped to weight because weight makes sense when
comparing vruntime but others might want to map the latency nice to
something else in other places of the scheduler. Time but also others
have mentioned the depth of the loop for looking an idle CPU

>
> Thanks.
>
> --
> tejun
