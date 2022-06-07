Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0F053FAC3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240597AbiFGKDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiFGKDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:03:41 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD675EBD6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:03:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u8so19068458wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7o1kiVWsps+vIhkxg/IQloUD0Hiziwxoz/V6KdYQOyY=;
        b=kZxbJqy8Rryx67Dly8fVIGhpCGeSMjXzDS/TzRgdUe+mns8uwIPq5w8T3YTSksZGSk
         7PZEksRo4iNy2ivxtfRpDMYW6D227T+ctLTR3Iv7RBmAF7ecFKBfYSI6tNGukvssJSJZ
         gDSfhlEPFV8i/BN7HMzEAthwO3Kz/JiHIUza5UOsbZqXBjov/yeJuD4Gcu7L6hoKTZH0
         Aw12LIZ5zh7InYN9JjDZGZppLMoxsY2w8ERk+XrFyJgWQOHt8mzt+UMsVII12zcrchUz
         DKiq1ysCMHrBh3cHwoexwGWWUZdnu+Vt4cAz7YmisCosu8jK1Dwo6zfjs/CIJaDWarWM
         fxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7o1kiVWsps+vIhkxg/IQloUD0Hiziwxoz/V6KdYQOyY=;
        b=WX/85cyIA7D5wEWy2sB8QotpvyKs4zjifL/d+zsZCk7ozaKlrWMdMu7sfEpc987JMj
         97RmcNSz+s/xg11WDuluK73iGP23SI+/h7Nk0BBSZJaCadhtneOvVmoXIAAQiXDjw1bI
         EhdS4r3cDgdhmWX+Y4AGAR203ogZazyUGOzUn200mzFXmZCr0u34U/qMa+zBg7SdoGHA
         PkQoGsZeNziUNKhZ3zTttRfe0ubwfkNXs05hKd08MQlaoF75c9oBrPPKzCqeJg29LPEP
         gJNkCt7JLu1frU7s0J7Mrt3+ZQW0fANR9fNknAyLvkxES+a7Ckhh1d8o5ijYcSZBVq+O
         aFYw==
X-Gm-Message-State: AOAM533SwWo9ArvA4rMEcR6Lzk4+owqPbtP7GbyLEKPwdo0TxLq8fB36
        7EOTyglz4Mp2kabEkHfopihm5A==
X-Google-Smtp-Source: ABdhPJxdvXoxqy1gKgabD4qSW0C2ND08SuuVKFFlV892xB593AXTOV8DdKelMTCVM+1Op2CGk/c4KA==
X-Received: by 2002:a05:6000:1861:b0:216:4019:9ee6 with SMTP id d1-20020a056000186100b0021640199ee6mr16754179wri.172.1654596215125;
        Tue, 07 Jun 2022 03:03:35 -0700 (PDT)
Received: from google.com (109.36.187.35.bc.googleusercontent.com. [35.187.36.109])
        by smtp.gmail.com with ESMTPSA id q16-20020adfcd90000000b00213abce60e4sm13745840wrj.111.2022.06.07.03.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:03:34 -0700 (PDT)
Date:   Tue, 7 Jun 2022 11:03:30 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, tao.zhou@linux.dev, kernel-team@android.com
Subject: Re: [PATCH v9 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Message-ID: <Yp8ico+B8USmi7fY@google.com>
References: <20220523155140.2878563-1-vdonnefort@google.com>
 <20220523155140.2878563-3-vdonnefort@google.com>
 <72bd6945-c167-65ba-6f81-fad2768972dc@arm.com>
 <Yp3JZIokwFxT+X6M@google.com>
 <CAKfTPtD6TpaJoz37Xv2_1Cc8ij_XGFjDTwA+TvN3ddiASkYc4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD6TpaJoz37Xv2_1Cc8ij_XGFjDTwA+TvN3ddiASkYc4g@mail.gmail.com>
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

[...]

> > >
> > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > index bf4a0ec98678..97bc26e5c8af 100644
> > > > --- a/kernel/sched/sched.h
> > > > +++ b/kernel/sched/sched.h
> > > > @@ -648,6 +648,10 @@ struct cfs_rq {
> > > >     int                     runtime_enabled;
> > > >     s64                     runtime_remaining;
> > > >
> > > > +   u64                     throttled_pelt_idle;
> > > > +#ifndef CONFIG_64BIT
> > > > +   u64                     throttled_pelt_idle_copy;
> > > > +#endif
> > > >     u64                     throttled_clock;
> > > >     u64                     throttled_clock_pelt;
> > > >     u64                     throttled_clock_pelt_time;
> > > > @@ -1020,6 +1024,12 @@ struct rq {
> > > >     u64                     clock_task ____cacheline_aligned;
> > > >     u64                     clock_pelt;
> > > >     unsigned long           lost_idle_time;
> > > > +   u64                     clock_pelt_idle;
> > > > +   u64                     enter_idle;
> > > > +#ifndef CONFIG_64BIT
> > > > +   u64                     clock_pelt_idle_copy;
> > > > +   u64                     enter_idle_copy;
> > > > +#endif
> > > >
> > > >     atomic_t                nr_iowait;
> > >
> > > `throttled_pelt_idle`, `clock_pelt_idle` and `enter_idle` are clock
> > > snapshots when cfs_rq resp. rq go idle. But the naming does not really
> > > show this relation. And this makes reading those equations rather difficult.
> > >
> > > What about something like `throttled_clock_pelt_time_enter_idle`,
> > > `clock_pelt_enter_idle`, `clock_enter_idle`? Especially the first one is
> > > too long but something which shows that those are clock snapshots when
> > > enter idle would IMHO augment readability in migrate_se_pelt_lag().
> >
> > What if I drop the "enter"?
> >
> >  clock_idle;
> >  clock_pelt_idle;
> >  throttled_clock_pelt_time_idle;
> 
> and you can even remove the _time for throttled_clock_pelt_idle
> 

Hum, "throttled_clock_pelt" already exists, while what we really snapshot is
"throttled_clock_pelt_time".
