Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8F04D690E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351088AbiCKTYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbiCKTYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:24:01 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B29BD2C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:22:57 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bt26so16752460lfb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H7n1YvsIIMVU0yD5Kw0dRd0A4o29AK9NIGIeI+suF/g=;
        b=gIwXqqhLxEknG2SVxJpgF5T+/hhfGL1Bnx0I0RE6GXCBzlc/EmkVOeZzVHW9UGMtlB
         +GTqZtmRsTIvvN0+db/z3YpNJCL8oYeKgLoiGP4y8cyrzLaZK0HxyY2xpk6Dt3Cw7UU0
         Q1j7ksQhdQcUAisYukcnEh2/SH3WID00W6Ok0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H7n1YvsIIMVU0yD5Kw0dRd0A4o29AK9NIGIeI+suF/g=;
        b=7iG8mS5YR5Qoj3PmRxOO66l56FUwVrNFzPt1dwL2vnXuW69+pvG4S0eHdaoepoXrIc
         LVZT2wXEal/s9mZSHYXv93rEm2MJZJnLBFyiSX6CqxAs8FvAe2B8j3lGivjS9ju3vEJO
         tPKZbCpqJGJPtQriPjaBBInYQfTjCHNZhAOxJj9RqMnWQjI7I9fffc4aMMKQhOLZ7qxm
         JcO5RmhOzWWUI4AfeJ38ag3fklMqHwYtyALUEcP72Li58eWCqiIouP6vHnDAQYnsgzmX
         H1jP7RvrZ4N34CfgvPSIQktskh3Mfv9+1brEG3o/eQo9keimma1oKrBlNoIGoH6x7x0M
         eO8g==
X-Gm-Message-State: AOAM532OVHXUucSnFrZs1PniGdKpeGXN8aIVibJDHtWJpE51TpxD4eZM
        /RiF7dDXbRyb6s6Ht8ml+gYRTF5IeNPK9Aen1Y0=
X-Google-Smtp-Source: ABdhPJyfJukBY12ZyizLXWsokfwGw//D8Jt81wQ4tOJW29s7r5p/fdOrP8QQ1Fkf/zPBASRRSkY01A==
X-Received: by 2002:a05:6512:1398:b0:445:bcef:e4fd with SMTP id p24-20020a056512139800b00445bcefe4fdmr6757435lfa.398.1647026575322;
        Fri, 11 Mar 2022 11:22:55 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id o3-20020a2ebd83000000b002461808adbdsm1814420ljq.106.2022.03.11.11.22.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 11:22:54 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id u7so13306939ljk.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:22:53 -0800 (PST)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr6746871lja.443.1647026573426; Fri, 11
 Mar 2022 11:22:53 -0800 (PST)
MIME-Version: 1.0
References: <20220308141437.144919-1-david@redhat.com> <20220308141437.144919-11-david@redhat.com>
 <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com>
In-Reply-To: <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Mar 2022 11:22:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjWx_bPBLB=qMMae8Sy3KrO+Kvaf4juPknO5HX-+Ot0XQ@mail.gmail.com>
Message-ID: <CAHk-=wjWx_bPBLB=qMMae8Sy3KrO+Kvaf4juPknO5HX-+Ot0XQ@mail.gmail.com>
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 10:46 AM David Hildenbrand <david@redhat.com> wrote:
>
> -       PG_has_hwpoisoned = PG_mappedtodisk,
> +       PG_has_hwpoisoned = PG_waiters,

That makes me too nervous for words. PG_waiters is very subtle.

Not only is it magical in bit location ways (and the special
clear_bit_unlock_is_negative_byte() macro that *literally* exists only
for unlocking a page), it just ends up having fairly subtle semantics
with intentionally racy clearing etc.

Mixing that up with any hwpoison bits - that aren't used by any normal
mortals and thus get very little coverage - just sounds horribly
horribly wrong.

              Linus
