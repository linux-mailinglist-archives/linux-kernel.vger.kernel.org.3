Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53B66520125
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238356AbiEIPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 11:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238342AbiEIPf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 11:35:28 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3D714677D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:31:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id y2so25600216ybi.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 08:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RF6NlJgBC2duKXQ/qm8aP7sq/2Tq7ZiMGqrzTmGWNqU=;
        b=pa3FHCoGa+7oq2sUGs7BEuDitGhL3+5eQHvzemtAVZKt9B3hGPB9JL0mKMHVpySsKF
         ix9tDji4hV6ZarBd/2WiUVrE5ujAFKMi+WD/i46ImLcUtjQRYrR1NGa0P7Yum8D7tkav
         +w5FehzivW1Jd5jyq8bhuEJkX4X70bwNctHW7md8YKOw8H5gZOXj6mNJChYrH5eSWLf6
         aLeW2ULDZwd46rkLVUbXKKQ/eQ8DqQcFBF2V4rJgLLWcBLe8WWTOfP/HO2gW9Agy3FqE
         cDx6xTWSeArTrAKLRlaBa52GgZFTswYWgxgo5NE8KQX0XW1ZwvbLx7KcahzY5RzljmC8
         AVxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RF6NlJgBC2duKXQ/qm8aP7sq/2Tq7ZiMGqrzTmGWNqU=;
        b=clfdTDGbvJFhscxCe05+I4v5N+cBKZvuLgj2/aVCidZK3gpbX04YYVdFD/dFBobXhU
         UMyJ9S9XvwI+Tt6l6YLCUN2VpI8nG0agQhPdymlIKFkxINeQ/5pjZIrsR3vACXKEdt3a
         ZtBGxM7FNHqRUrsCxzjajgbJ4m0oQ66/Av2dBvEjiKvTmmjON+V10OO0IFrXDa/EB3xp
         wFPnXtiZnXrUe7oIkV5Km2420EHxJ8trPGKuZPymrqqagwdr/HXa7SF/+p30J21BcYez
         r3XyenQsyWZiSIe4MCJz7PeC/Gs++RYxFjLeMkWt1A8wyhLBC0fvyKjnLwB4bVpvNTtE
         NCyw==
X-Gm-Message-State: AOAM531itpmzwo69ffBvWjAbg2Ctz6OA2aJ/M72NBE+x0aBsQ8kO1rNy
        I8wplr4yZp7+zSagL5VDwnphS7N9MZs4wgUFWZ0=
X-Google-Smtp-Source: ABdhPJxMhTuD/EyviRB9SuDpP+3lk3z4uR0numqtMQJnVRcO5e84FhSTojhe+vQt1aGiwVf2h9zkgOPie09gZakgTeY=
X-Received: by 2002:a25:e7c5:0:b0:64a:718d:2f78 with SMTP id
 e188-20020a25e7c5000000b0064a718d2f78mr12838239ybh.564.1652110292668; Mon, 09
 May 2022 08:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
 <CADjb_WTRYjSD8z0BCE=u322iJmQVuEq5cUMTZO6ij9V-=ViY-w@mail.gmail.com>
 <53fcde27-7dd2-5150-633b-4e2acc37bb6f@bytedance.com> <CADjb_WRmXh0tj7nZZR3QybhLxtoxZBy6OMKRNygtKOx-wUPxZA@mail.gmail.com>
In-Reply-To: <CADjb_WRmXh0tj7nZZR3QybhLxtoxZBy6OMKRNygtKOx-wUPxZA@mail.gmail.com>
From:   Chen Yu <yu.chen.surf@gmail.com>
Date:   Mon, 9 May 2022 23:31:21 +0800
Message-ID: <CADjb_WTfXDrKzAs09+Gf-xqrFuFBoi=9=Egy0_M5rU9a21+eRg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
To:     Abel Wu <wuyun.abel@bytedance.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
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

On Mon, May 9, 2022 at 11:21 PM Chen Yu <yu.chen.surf@gmail.com> wrote:
>
> On Sun, May 8, 2022 at 1:50 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
> >
> > Hi Chen,
> >
> > On 5/8/22 12:09 AM, Chen Yu Wrote:
> [cut]
> > >> @@ -81,8 +81,20 @@ struct sched_domain_shared {
> > >>          atomic_t        ref;
> > >>          atomic_t        nr_busy_cpus;
> > >>          int             has_idle_cores;
> > >> +
> > >> +       /*
> > >> +        * Tracking of the overloaded cpus can be heavy, so start
> > >> +        * a new cacheline to avoid false sharing.
> > >> +        */
> > > Although we put the following items into different cache line compared to
> > > above ones, is it possible that there is still cache false sharing if
> > > CPU1 is reading nr_overloaded_cpus while
> > > CPU2 is updating overloaded_cpus?
> >
> > I think it's not false sharing, it's just cache contention. But yes,
> > it is still possible if the two items mixed with others (by compiler)
> > in one cacheline, which seems out of our control..
> >
> My understanding is that, since nr_overloaded_cpus starts with a new
> cache line,  overloaded_cpus is very likely to be in the same cache line.
> Only If the write to nr_overloaded_cpus mask is not frequent(maybe tick based
> update is not frequent), the read of nr_overloaded_cpus can survive from cache
> false sharing, which is mainly read by SIS.  I have a stupid thought
> that if nr_overloaded_cpus
> mask and nr_overloaded_cpus could be put to 2 cache lines.
Not exactly, as overloaded_cpus and nr_overloaded_cpus are updated at the same
time, it is not a false sharing case.

-- 
Thanks,
Chenyu
