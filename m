Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4F0502849
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352307AbiDOK2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350201AbiDOK2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:28:48 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528A1BBE1F;
        Fri, 15 Apr 2022 03:26:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id u15so14636264ejf.11;
        Fri, 15 Apr 2022 03:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EtDl/BnBqyaqmvNLPjWYvphBfIcsljxIrWQRv32e4H8=;
        b=m4qCrQ1uGb3UnhyzgxnHQ29si2Yo2S8ghaU7xMVP0qXgiMhgFKso/9N+uhSQSQqJ1I
         rQnzVisPwlzhsOsTAEeLSu1ebmPt0n8OtWGYFBl4yu4KJj7kO88co+sLF7Xqgs4m9vmd
         04mZCu4QPhFnUG0K8YqqZO7VMY7oBOnNwouYz88ShlAkAVN/s87Co1yL7zVHqJW5TE+R
         aRIUQSKT81I7MsoeXVvrMRoFYX9Ar3OyUEzrMdbfXafaEb8v7MYciVnZrbYqGFDHWuid
         1Msm3+ZKEW9qRjOtin3wVbTJkz9tn7ox5tdE7+13UGfPA0V7vj++3zNz3cca+YADbodu
         wSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtDl/BnBqyaqmvNLPjWYvphBfIcsljxIrWQRv32e4H8=;
        b=toasQ2hXw7/c0MhTA3l68d65WAPAk4uPIOhaDoMfNqNze0BlthEy2RF1qK0wjJ3ckY
         mMsu+/SRjMtU5TeXXqAcbJmqSfvtagVj9LpPtm48L9Nu/K30u+LXXeW8FnGveteH9v+8
         BoYsJLABLjWfIfXBtZVwFXB/2c3hvZT7uGuRix/oLzT6r1LLceKU9C8Ehg3qUuNVDg3M
         U1gHkMhNgfLuzzYFyvuS9i9H+dtXveP7unMgJw6NGyclJsh5gde7Vrg8RlM5yQ9HP0mb
         cdmCsLSPWEGQs6GWoqX/np9qQdjbXcsozDIJsS4L+K/e8tIebGh9YVJvmlbU5/x0Wg9O
         KfaQ==
X-Gm-Message-State: AOAM5337V5KZAYq+4YXVimr9EVhay9gOE9e4VaSK+XWZz/CXa+kCzxvU
        UJVyKPM4ZOYXrQu7RIcLr+71ofQTcRjSxtlid2g=
X-Google-Smtp-Source: ABdhPJx188kl7Hz4e0/sADxts1l08dfuqnxi4RajAY94xDZT5CAK32+z2N7VLWp7X9SwHSIUbAHO5Ks11HdisEYJGeE=
X-Received: by 2002:a17:906:39da:b0:6cf:7f09:a7bc with SMTP id
 i26-20020a17090639da00b006cf7f09a7bcmr5896450eje.457.1650018378797; Fri, 15
 Apr 2022 03:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-7-yuzhao@google.com>
 <CAGsJ_4xqm4L4E4dW4PPHos8Ed9ej6hph28tSGy21Re3u7WiuOA@mail.gmail.com> <YliFs3NOHeo2LeXl@google.com>
In-Reply-To: <YliFs3NOHeo2LeXl@google.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Fri, 15 Apr 2022 22:26:07 +1200
Message-ID: <CAGsJ_4yYP1Wv7_KqX+bo2u=YZNGAqYsLf8evekqz9Y6djbWD7Q@mail.gmail.com>
Subject: Re: [PATCH v10 06/14] mm: multi-gen LRU: minimal implementation
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        x86 <x86@kernel.org>, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
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

On Fri, Apr 15, 2022 at 8:36 AM Yu Zhao <yuzhao@google.com> wrote:
>
> On Thu, Apr 14, 2022 at 06:03:10PM +1200, Barry Song wrote:
> >
> > On Thu, Apr 7, 2022 at 3:16 PM Yu Zhao <yuzhao@google.com> wrote:
> > >
> > > +
> > > +static int isolate_folios(struct lruvec *lruvec, struct scan_control *sc, int swappiness,
> > > +                         int *type_scanned, struct list_head *list)
> > > +{
> > > +       int i;
> > > +       int type;
> > > +       int scanned;
> > > +       int tier = -1;
> > > +       DEFINE_MIN_SEQ(lruvec);
> > > +
> > > +       VM_BUG_ON(!seq_is_valid(lruvec));
> > > +
> > > +       /*
> > > +        * Try to make the obvious choice first. When anon and file are both
> > > +        * available from the same generation, interpret swappiness 1 as file
> > > +        * first and 200 as anon first.
> > > +        */
> >
> > Has this changed the ABI of swapiness?
>
> No.
>
> > or it is only something
> > meaningful for the internal code?
>
> This is how swappiness is interpreted.
>
> > if so, can we rename it to
> > something else? otherwise, it is quite confusing.
>
> Feel free to suggest something.
>
> > it seems 1 is set internally as a magic number here:
> > +static void lru_gen_shrink_lruvec(struct lruvec *lruvec, struct
> > scan_control *sc)
> > +{
> > + ...
> > + else if (!cgroup_reclaim(sc) && get_swappiness(lruvec, sc))
> > + swappiness = 1;
> > + else
> > + swappiness = 0;
> > + }
> > obviously this swappiness is neither /proc/sys/vm/swappiness  nor
> > /sys/fs/cgroup/memory/<group>/>memory.swappiness, right?
>
> Right.
>
> > > @@ -3928,6 +4726,11 @@ static void age_active_anon(struct pglist_data *pgdat,
> > >         struct mem_cgroup *memcg;
> > >         struct lruvec *lruvec;
> > >
> > > +       if (lru_gen_enabled()) {
> > > +               lru_gen_age_node(pgdat, sc);
> > > +               return;
> > > +       }
> >
> > is it really a good place for  lru_gen_age_node() since the function
> > is named age_active_anon()
> > but here you are doing aging for both anon and file pages?
>
> Yes.
>
> > obviously
> > lru_gen_age_node() is not

> > doing "age active anon".
>
;> We can rename it if you have something in mind.

i wonder if we can directly do:

if (lru_gen_enabled())
      lru_gen_age_node(pgdat, sc);
else
     age_active_anon();

rather than:

/*
 * Do some background aging of the anon list, to give
 * pages a chance to be referenced before reclaiming. All
 * pages are rotated regardless of classzone as this is
 * about consistent aging.
 */
age_active_anon()
{
    if (lru_gen_enabled())
          return lru_gen_age_node(pgdat, sc);
}

the comment above makes no sense to lru_gen_age_node(pgdat, sc);

another way is that we can add a wrapper for them as below,
age_node()
{
    if (lru_gen_enabled())
          return lru_gen_age_node(pgdat, sc);
    age_active_anon();
}

Thanks
Barry
