Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2230B5AA3A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 01:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiIAXSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 19:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiIAXST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 19:18:19 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44E69C1F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 16:18:16 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-33da3a391d8so2136017b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=rjiF9dcJ/mORZlmNTO18kEduhbATdpbM6SHMK6U+ruY=;
        b=miInjSJE+fzo5gS/eKt5cfKejZWjk/URgt0UsOF5yFYhBi4SW0mjlLLL/BxcWNS7q1
         ZbX9dW3k1PQz07RhMq4TY0IKX8uDz5gqWib15fn/ENu8F4BQEoeMpBqRR4aXJyehSLYL
         rlX+s6DOoRRQDDNJOyrdh0XgYf16gCuBQ8/5nYMEbXay2V4G5ElxQsF4iKh7ls3v0nku
         D6GH4AzNn0lGwU6+bKnN6gfpnyUHAp3BKdNloRCyIKDJYsKSeK4d/tInEIryGNWiC42i
         SC0dR4U7pJvq0mNT8d7KhoSD0pTCfW3Ka8zPz/CWyWvVkBglY+I9aRF6ESuk5tijxW2i
         1vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rjiF9dcJ/mORZlmNTO18kEduhbATdpbM6SHMK6U+ruY=;
        b=YgxDvZ6pIMrMbgBIlUCtPrM54HGtOwABj/x+L3DnNizHzKIVdkGDLAHMZu7S/PaNll
         7AmUk/9GroyS4/7vXoz5a3itjeaJKIAZSB62RjjEfT2dK4TSuow9yYUiYJPAfuVqQLca
         nFsiVxlT0SjZmVAuLGO4/VKqULO4u8TKGB3oBL56KXq8pJ+giwkzI6dnLWZOlatjDV3N
         6SzVv8G1qiakLIMFBu+NbMdHrXaukXJw1SjV40tsqr0v1qnp9D38NpBnHkTnfnxgjeP4
         owi4lmEgTAHvG/sNPd1UGO3kqU6mGj6Bp27Div5uRYzKm/7ulI+hU+K7a2QtXV+eY7H0
         Nzqg==
X-Gm-Message-State: ACgBeo2aXrFWTpTd+SwbC++a+9ffoHRt/ey4rYGrsSqD+iOszYsrMJ7+
        0QYPnLrRjrrvs8/wBQRMQ2rX2eTdxs4X5sjGi18KKg==
X-Google-Smtp-Source: AA6agR6m7scNwFemz6Af1WoGTDIcSPP5pnTPi8sC0t6BGCdPYrcUbrHz9JxtFN2qOLjSTkeI4M1Lodd/jngX9vslX64=
X-Received: by 2002:a0d:c981:0:b0:330:dc03:7387 with SMTP id
 l123-20020a0dc981000000b00330dc037387mr25164956ywd.380.1662074295806; Thu, 01
 Sep 2022 16:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220901173516.702122-1-surenb@google.com> <20220901173516.702122-4-surenb@google.com>
 <20220901202239.tnnzlbermiyvkmih@moria.home.lan>
In-Reply-To: <20220901202239.tnnzlbermiyvkmih@moria.home.lan>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 1 Sep 2022 16:18:04 -0700
Message-ID: <CAJuCfpFqK+Gfd100C8s8jnJci+UCt9y6dqsn=eqYin6g-VVx6Q@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND 03/28] mm: introduce __find_vma to be used
 without mmap_lock protection
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michel Lespinasse <michel@lespinasse.org>,
        Jerome Glisse <jglisse@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Laurent Dufour <laurent.dufour@fr.ibm.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Song Liu <songliubraving@fb.com>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, dhowells@redhat.com,
        Hugh Dickins <hughd@google.com>, bigeasy@linutronix.de,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Minchan Kim <minchan@google.com>,
        kernel-team <kernel-team@android.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
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

On Thu, Sep 1, 2022 at 1:22 PM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> On Thu, Sep 01, 2022 at 10:34:51AM -0700, Suren Baghdasaryan wrote:
> > Add __find_vma function to be used for VMA lookup under rcu protection.
>
> So it was news to me that the rb tree code can be used for lockless lookups -
> not having looked at lib/rbtree.c in over 10 years :) - I still think it should
> be mentioned in the commit message that that's what you're doing and why it's
> safe, because it's not exactly common knowledge and lockless stuff deserves
> extra scrutiny.
>
> Probably worth a comment, too.

Ack.

>
> Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>

Thanks!

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
