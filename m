Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED65515B7D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382366AbiD3IjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382349AbiD3Ii6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:38:58 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9AF703EF
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:35:36 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id m62so8964455vsc.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 01:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vB6b0OsclRhsfa0BGYC5pN5Jiqb3R8wblKU+DHxf55k=;
        b=c+KE7NgeCUjgW6fufZvypmuDgjo3R1mtTFUuYDtoa+zctGO+OLbz3um7pVDYCpwiDS
         ojv3Y4ZOfhknCWiq2HBRl7riuhys4gzmkclEE9PJx8czMf7BpVfNAaDyO/0br9FveOdQ
         U1qC+ASYzF9EXH1TqnT7KudHMZBE64wj7f8NJ3jQv03e0SEZOjscLeXLGMBpQcCC+7VK
         hlRzhRWanST7CcP8lOkNJ4NtDGyFBnXJH/fpsL0bl9cX1m7g7icWM2tkhYyKaPn4Qaix
         ujJ210JAv/sLrgC/FOu7suCcUe7+P13QKpQNqJKeCc7dzKXJ4uMyl75dJvda8og7tliZ
         fDNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vB6b0OsclRhsfa0BGYC5pN5Jiqb3R8wblKU+DHxf55k=;
        b=ZGbhbnndWN+RmInGfb/oEsgNsLJEpyGpR2PRymzLjpUPwqR2Hk7cr6OS4QUTUp3+d2
         0kBXMx8ymNIdBNtm6KcVZcxcEBpJC0iyhhF+pJu2Bby7shIiR3pYSUk4m4TL5zfwtuzL
         QFoeLfwQMZtPPekyNgnGLovmWzVEgNak5Z9JyKkqN8QC0LnoYXzFtzQhC+KoFVPld+/0
         s7/zGwYYcrfyAr8nTqug/I7h+YZFOLr1Hm4tnb30d/R07qPsuhHfjZAYfFY2ePhDUZ5i
         wWXHTE4GzxzJnzdXL5+ON12nc90ruX1JzcORdK7pz9g7h3LSzM8GAyrulZ//X7KNdPfl
         6brQ==
X-Gm-Message-State: AOAM532gFCt9jHsM2yAZfKQt3A2WWCVUiKBazDvfvjOITdB7OzTKJD27
        aiHamLP1lEqc+J9aGLFbpTQt4ivw62S9RL34RLH0Og==
X-Google-Smtp-Source: ABdhPJwYtSR0vb/W5NGDO8xmZyNqOks/t5WKeA1apZdBFsLD7KeL6uFFgvGUV8V3NjoBQP8jf7LLQczG5k6X2PxozJ4=
X-Received: by 2002:a05:6102:e8a:b0:32d:114f:ae96 with SMTP id
 l10-20020a0561020e8a00b0032d114fae96mr898946vst.84.1651307734788; Sat, 30 Apr
 2022 01:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-9-yuzhao@google.com>
 <ed714a8c-4f36-0b86-0b36-c6708d6f26fb@linux.alibaba.com>
In-Reply-To: <ed714a8c-4f36-0b86-0b36-c6708d6f26fb@linux.alibaba.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sat, 30 Apr 2022 01:34:58 -0700
Message-ID: <CAOUHufbPoxd=GrYR721dcrgf58UH1kqBp3X74Cw-OtdeTdiBWg@mail.gmail.com>
Subject: Re: [PATCH v10 08/14] mm: multi-gen LRU: support page table walks
To:     zhong jiang <zhongjiang-ali@linux.alibaba.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 7:10 AM zhong jiang
<zhongjiang-ali@linux.alibaba.com> wrote:
>
> On 2022/4/7 11:15 =E4=B8=8A=E5=8D=88, Yu Zhao wrote:
...
> > +     while (!mm && mm_state->head !=3D &mm_list->fifo) {
> > +             mm =3D list_entry(mm_state->head, struct mm_struct, lru_g=
en.list);
> > +
> > +             mm_state->head =3D mm_state->head->next;
> > +
> > +             /* full scan for those added after the last iteration */
> > +             if (!mm_state->tail || mm_state->tail =3D=3D &mm->lru_gen=
.list) {
> > +                     mm_state->tail =3D mm_state->head;
> > +                     walk->full_scan =3D true;
> > +             }
> > +
>
> The full_scan seems to be alway true.   because mm_state->tail points to
> the first item in mm_list,  hence the walker's
>
> condition mm_state->tail =3D=3D &mm->lru_gen.list alway equal.  Am I miss=
ing
> something?

mm_state->tail points to the first item *added after the last
iteration*. If no new items, mm_state->tail parks at mm_list->fifo.
