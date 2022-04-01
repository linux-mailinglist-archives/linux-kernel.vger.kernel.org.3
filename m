Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518B4EF7BD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiDAQWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349367AbiDAQRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:17:46 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712B21C4B3D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:41:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t13so2666190pgn.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 08:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqJWbvvbg0qdWklwqs2qhrfKKi69liUYvCt62FUbnWk=;
        b=Fn5jpMZAmMPReAvL0Tyf7tj5rAcmThNhnq1xKoKFkJI0vR0fJhwRbtqFchPRvfX4q1
         ONoUm1fDJi9X/SdotI5xdBPmgeBbrWo8/YaW2ybUubSt1izJy97NcFaxs+dJxWC0WBMf
         6z+iwlN+sbK2nfsp4T5xwzKsl3sE9+883flPy03nnksy67+Yj2ZYN4oSkYQiIHtJaUUH
         6+GoJw85rhIbSF3mvBhZg+VFZFkJaWhhkPhJhHoJqg/NLIlaGVi7lJF460tom7CJNf71
         QLXswXjH3yWTPwjM8DWIfiObLitVJeSiXu0UH1DAOa8qNyI5WVPl/7tgONlEth6eYrLf
         Uwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqJWbvvbg0qdWklwqs2qhrfKKi69liUYvCt62FUbnWk=;
        b=c5g8JG4OqgcfWCh00G4mGOGw2BmHj7UqqrU4M+vto+lR2aHHaJZuW3+xoe+/8VaH5b
         SyvMhNaEu/ipxiotDiwfLhT0PVj280NHnJ8hAVPctnLMd3k85hdj44jeVbtQXW4GieVs
         CLsyOEi29T1tUZFLfr+et4wO/ke4pi/dqncmi6ZdbOnkeZwtLnHTeBAYPYfUCIpMUoNB
         8ZTRHP+Fy+QVWiMRz+/B7nPL+b0YHi2NDRb/SvReg7MM+fZflg+FpLZQpqKERk8EaSvn
         uR9sTIQyGupNTQPx96WvfYYtekNc+tAByy0NAZwXt+FSMZIFxWjOOGi8hvH0+p82hhX4
         PlHA==
X-Gm-Message-State: AOAM530zojLarJWlKgSkhe+c14uwMLwA8oVYZf9f8e8t0oo8cl+/qRHg
        G2kwMMmecReyHBo0l1fsC3Tp/wtkIYbPyy+yBroCPg==
X-Google-Smtp-Source: ABdhPJxICFXuqj/lX5mtK0KnO7e8FwZzOC70mH0krkoDwxL8TroQr5Ghmg+DK+Zw9WUBYtZMvmLXl8GvFlOCo2bG5as=
X-Received: by 2002:a05:6a00:2392:b0:4fa:dcd2:5bc1 with SMTP id
 f18-20020a056a00239200b004fadcd25bc1mr11451248pfc.8.1648827682692; Fri, 01
 Apr 2022 08:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220331084151.2600229-1-yosryahmed@google.com>
 <YkXkA+Oh1Bx33PrU@carbon.dhcp.thefacebook.com> <CAJD7tkZxqWg2NRi=83wSWLiykZBfrP8Kx_C5JWy48=rZoBWoHw@mail.gmail.com>
In-Reply-To: <CAJD7tkZxqWg2NRi=83wSWLiykZBfrP8Kx_C5JWy48=rZoBWoHw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 1 Apr 2022 08:41:11 -0700
Message-ID: <CALvZod7TSQ2RdL4iKx5egYOtDvZdGY--T90As_guZK+BoBvAOw@mail.gmail.com>
Subject: Re: [PATCH resend] memcg: introduce per-memcg reclaim interface
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Cgroups <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Jonathan Corbet <corbet@lwn.net>,
        Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 2:16 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
[...]
> > > +     {
> > > +             .name = "reclaim",
> > > +             .flags = CFTYPE_NOT_ON_ROOT | CFTYPE_NS_DELEGATABLE,
> > > +             .write = memory_reclaim,
> >
> > Btw, why not on root?
>
> I missed the root question in my first reply. I think this was
> originally modeled after the memory.high interface, but I don't know
> if there are other reasons. Shakeel would know better.
>
> AFAIK this should work naturally on root as well, but I think it makes
> more sense then to use a global interface (hopefully introduced soon)?
> I don't have an opinion here let me know what you prefer for v2.

We will follow the psi example which is exposed for root as well as
for system level in procfs but both of these (for memory.reclaim) are
planned as the followup feature.
