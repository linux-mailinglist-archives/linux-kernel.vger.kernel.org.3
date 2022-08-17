Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEC95979C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238885AbiHQWqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231491AbiHQWqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:46:45 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B9572FF6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:46:43 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id r4so10016vkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 15:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=DDYa0NkpZnfPkuNgNtVdNw0U5huUCrPQSI4Eq/K5ZGE=;
        b=EivyvwvbX0nShi7rq1KRKU0EayT3iTsOq7w1mj2ynwhrQlCHpRIYWdQQKOn8N0+ZGS
         vOu2Ti1iDQ4f5vsP6q+fy2UBu8QdSJexKdhULQ75AbiGcmvUJzvWPkrWFLPn8N6Z4WRB
         PqQPDDIBPuvIsK6ZAxfQbYTq5ypK3jFjg1TiBmDDYDixI/Fky+lW9Xe+1Pw0pJVXcdDv
         FIJZH1BBukguaWLbMZdaMMO3LwDKGRDpxri6NRFFCHKBor9UQUKIQjVzBHWr6Z0iby79
         3kZ3vbfCdGpBYdO3sn2bwpWzEWLi//eRVQrnD71KZGtScY2YH9FWC5TmUUpo3u0VSzZv
         xWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=DDYa0NkpZnfPkuNgNtVdNw0U5huUCrPQSI4Eq/K5ZGE=;
        b=LOJ7IJIYUUFrLfbZlV+UNIzF2ktsEplcH8bwO9qK28CCXVI4xEsUaxtdsO90rSO69y
         5Am92glyKo2xnnnDY3g7V9YbL5eXiBX0247vhpXWzUVe6PG5uxi0TKysiCasIc0eRDaY
         WxZbd4T0YsxEuLPJAgV+As/YSecxcxKaUYq5pFQPYGj8k1YJXlPZvcsufSwTbTT9K0UX
         jX+lEbRMCfEYPUDUzsCBxOopaUDAUAb/1UhPUEDGayNuN9fNcRJPMOkse2quVwh0ZzPg
         45sXeOdUO27qRcQtGlg0+0RQQ9YbTP3iouegCGGwuztjS4rQ59NrneKgL9DmEx6hLWZc
         R+jQ==
X-Gm-Message-State: ACgBeo1GEWQBAj4LFHFNBj8GujcB0XkPJPm/y19LRo+TAGvhUVRACZhV
        7t298pGrwcqRMoL8UbFiNdhECfwbfRapf893/1SCCw==
X-Google-Smtp-Source: AA6agR7+54RbmKLXgOFnbAw8swEhHcq1k09hfnwML1ug3kUNXZofzVNtT/6onk+6QkoHM/RciDYOGdGJS04e7OmQgeg=
X-Received: by 2002:a1f:9b07:0:b0:378:7c48:c6c with SMTP id
 d7-20020a1f9b07000000b003787c480c6cmr115530vke.32.1660776402455; Wed, 17 Aug
 2022 15:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220815071332.627393-1-yuzhao@google.com> <20220815071332.627393-14-yuzhao@google.com>
 <YvoOAJhJlvCr35Xc@kernel.org>
In-Reply-To: <YvoOAJhJlvCr35Xc@kernel.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 17 Aug 2022 16:46:06 -0600
Message-ID: <CAOUHufab5S3Xzak+ExhYaMzi-hx7O2Ff8jL3gjKHkatMvuF=WA@mail.gmail.com>
Subject: Re: [PATCH v14 13/14] mm: multi-gen LRU: admin guide
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        Brian Geffon <bgeffon@google.com>,
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

On Mon, Aug 15, 2022 at 3:13 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Mon, Aug 15, 2022 at 01:13:32AM -0600, Yu Zhao wrote:
> > Add an admin guide.
...
> > +Users can write ``+ memcg_id node_id max_gen_nr
> > +[can_swap [force_scan]]`` to ``lru_gen`` to create a new generation
>
> I think this would look nicer if the command would be a literal block, say
>
> Users can write:
>
>         + memcg_id node_id max_gen_nr [can swap [force_scan]]
>
> to ``lru_gen`` ...

Thanks. I have queued this and will refresh the series one more time
probably around rc5.
