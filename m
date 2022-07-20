Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890BE57BD30
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiGTRuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234235AbiGTRuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:50:06 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7715FCC9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:50:05 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id g12so1353263pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPK1xSGNueZDg4ifFUEI8PtrdzUASZ9LzW78x/FVmdA=;
        b=o1lu30MhEHLv+1z/UwxTaic3Ke1o1strn9J68S6fTgqRNYxf94G2Cot76fFiDQbdii
         0se9bQGwJdlYVgwZjOP56cixjvOQRJMwNcggtcG3LIkguFvbfBZmYbT80Jaa6+W6I5Ow
         v+QM9AChW0NqOSSf+3+sisR3WOy7akkF6MbWoBlW9Mx2jqVW5DFmxlzWePrcQwX7s5xG
         AHNkzva6mCpi8uXZTnnRLzLO5FR1vUBytyLiwtw0iJTDerJX5Mgl2XXaNTqet7KzwaRW
         cQ9yxOnkk7OBkoutgMSNYB0dPosQxch8Y4Kq4iNTdQtEW4BTwXMkhRasJSjsGu1InOzr
         Wp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPK1xSGNueZDg4ifFUEI8PtrdzUASZ9LzW78x/FVmdA=;
        b=7LjG0Kkw8COSkf0V5tLzHukoSxQEVFm+yuZr7RXzjeHXnz6mC4nVZ2oT+2v5tzDwpr
         mlrKuoEmCPgOGwdHNJd9+Ig6T0JS9Fs+euvM9XqrbQ6cpWM7EweInv2kVOVZRj8V3GUa
         sWSOyHAS2E48/dpVO+qP9zgKnaH5wPUnMnpIxi3Stt3cyLMPZFrrfsj8Z6IOhNl0UO7R
         6OZivNYLP3AfkClNIGLbvUrE64kSYqU/PvyH7p0RpecdoAfK9o6gxi9XcHAkWyMZ5oRH
         tIuc+rJS8zuU08+u31jcIW/FRZjzQBXQ0QWyen4gAKWej2cDOX0x5bYC9+zdj34X3EmP
         8NLw==
X-Gm-Message-State: AJIora9UnHrKGiGY/GYsZem5xmgnbI1KqqZnItlm5voJL1dHZs54l7XB
        KaCrg3L6e91qPf1v1oNMEGG9x9hPMSAG6oLfp+LFoQ==
X-Google-Smtp-Source: AGRyM1vn1UfRAhqTF02gy4Fa67sB/TV9LWC+MWq4qk7Ub3qiFTRlQbSTFwOECLKyOfrPgQJTG8a4S3GrI7h0jUnZido=
X-Received: by 2002:a63:c106:0:b0:419:b303:2343 with SMTP id
 w6-20020a63c106000000b00419b3032343mr28798192pgf.166.1658339404600; Wed, 20
 Jul 2022 10:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220714064918.2576464-1-yosryahmed@google.com> <YtfJug77XJ9BPA8L@dhcp22.suse.cz>
In-Reply-To: <YtfJug77XJ9BPA8L@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 20 Jul 2022 10:49:53 -0700
Message-ID: <CALvZod7X3PsM2+ZrWXwb75FNBBjaBGJpjd+WVmzr5hStROvW+g@mail.gmail.com>
Subject: Re: [PATCH v4] mm: vmpressure: don't count proactive reclaim in vmpressure
To:     Michal Hocko <mhocko@suse.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022 at 2:24 AM Michal Hocko <mhocko@suse.com> wrote:
>
[...]
>
> I think what we are missing here is
> - explain that this doesn't have any effect on existing users of
>   vmpressure user interface because that is cgroup v1 and memory.reclaim
>   is v2 feature. This is a trivial statement but quite useful for future
>   readers of this commit
> - explain the effect on the networking layer and typical usecases
>   memory.reclaim is used for currently and ideally document that.

I agree with the above two points (Yosry, please address those) but
the following third point is orthogonal and we don't really need to
have an answer for this patch to be accepted.

> - how are we going to deal with users who would really want to use
>   memory.reclaim interface as a replacement for existing hard/high
>   memory reclaim? Is that even something that the interface is intended
>   for?

I do agree that this question is important. Nowadays I am looking at
this from a different perspective and use-case. More concretely how
(and why) to replace vmpressure based network throttling for cgroup
v2. I will start a separate thread for that discussion.
