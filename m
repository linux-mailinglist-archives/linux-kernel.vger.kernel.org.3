Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437624D5E9E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347640AbiCKJkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235553AbiCKJkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:40:00 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35BE171289
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:38:56 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id u124so8859921vsb.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jiPYRMkrssmQzhaA+Ut3AsPHiZnVrbpMyqtiM6imme0=;
        b=FYJDVYp4jLwtTtitWngDo5FGfkc8c03zpG8SnvTYpahLC3AelPSYyLMYNAGhTG4VdF
         xLjr+y5KA9uU4gGu9fhpcWbrOLyp8kGthXUqsFuMerUqj9AimOum/jJLsWVNTLOwwU1a
         k2nj0zS9O2VJfNPm4/Y8NcPZsmkGYn8PAg69LStqYzZHZNOMz5uh7C4RENG7UEmxQLGF
         UnN/waGsIi7ZmEPeqSWePdu0pHt9siZhCU1vUHXVL58JWvrnKYmywRnaWuGpBYQc2SBM
         6+NTT4pwRj1bKkuab2Ra/4bQc7zWJmZrshbJd/0Jv5yqOOuoZEzl5R8yFEn264CTeDNj
         tPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jiPYRMkrssmQzhaA+Ut3AsPHiZnVrbpMyqtiM6imme0=;
        b=H39+v7UI7IZRLyufj8MNOu2lml3Uab8CKpcoDOn5q4QnnFH6kI3Bw8CXKlzrjj9oJ2
         DiJoFEUVLxDdD280FAb/c1phPc2lpUA5Jdlq01tcPgvdsvDIKPrrHrAg0gRxHLm58RTN
         R93qbIfcF2+X7tBU3mKUwAWtrE1YML+PlF4HbJtgiAmQ6z7Kb95XzkOAew8hwyVdV5eV
         KMMzHDbix5Rx/rByIsYeKt4xY0xfWyt0OEzf1cBnNXDvDNJnTwAyi/Td7lmtyKO97K7J
         n/vlpPS9d2aqivFsVGnHZ7dY7Q58qajxh/zb75LQX2b0IUoHrYX9zVbWvojAIL2s1urx
         47EA==
X-Gm-Message-State: AOAM532jcvqxiF1/WT3LveLKyVnhSJzHkBZCxYKIfymV340FIjnCuw+i
        naiJBc7nwIAsRSlrJhZMACuAMrI4GNX7OmWeBJbs7Q==
X-Google-Smtp-Source: ABdhPJyWkIuShICN/g+cr9kKiAVDP7OUj02RNJNBgTrtT7zPUqhp5mxEsIs3uoDtHddgk+3Iym9p2pqEpEMU9kaYyWk=
X-Received: by 2002:a05:6102:3a06:b0:31b:d9c6:c169 with SMTP id
 b6-20020a0561023a0600b0031bd9c6c169mr4424556vsu.22.1646991535079; Fri, 11 Mar
 2022 01:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20220309021230.721028-1-yuzhao@google.com> <20220309021230.721028-15-yuzhao@google.com>
 <YisG1Q5wZP16B13o@kernel.org>
In-Reply-To: <YisG1Q5wZP16B13o@kernel.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 11 Mar 2022 02:38:43 -0700
Message-ID: <CAOUHufahKqU-xr5PJY02S0fPqh-SpNvmaag9fYCcvs3b-zQohg@mail.gmail.com>
Subject: Re: [PATCH v9 14/14] mm: multi-gen LRU: design doc
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 1:23 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> On Tue, Mar 08, 2022 at 07:12:31PM -0700, Yu Zhao wrote:
> > Add a design doc.
> >
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> > Acked-by: Brian Geffon <bgeffon@google.com>
> > Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> > Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> > Acked-by: Steven Barrett <steven@liquorix.net>
> > Acked-by: Suleiman Souhlal <suleiman@google.com>
> > Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> > Tested-by: Donald Carr <d@chaos-reins.com>
> > Tested-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> > Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> > Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> > Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> > Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > ---
> >  Documentation/vm/index.rst        |   1 +
> >  Documentation/vm/multigen_lru.rst | 156 ++++++++++++++++++++++++++++++
> >  2 files changed, 157 insertions(+)
> >  create mode 100644 Documentation/vm/multigen_lru.rst
> >
> > diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> > index 44365c4574a3..b48434300226 100644
> > --- a/Documentation/vm/index.rst
> > +++ b/Documentation/vm/index.rst
> > @@ -25,6 +25,7 @@ algorithms.  If you are looking for advice on simply =
allocating memory, see the
> >     ksm
> >     memory-model
> >     mmu_notifier
> > +   multigen_lru
> >     numa
> >     overcommit-accounting
> >     page_migration
> > diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multi=
gen_lru.rst
> > new file mode 100644
> > index 000000000000..cde60de16621
> > --- /dev/null
> > +++ b/Documentation/vm/multigen_lru.rst
> > @@ -0,0 +1,156 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Multi-Gen LRU
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Here I also miss an introductory paragraph about what Multi-Gen LRU is.
>
> All the rest looks good to me.

Will add one in the next spin. Thanks.
