Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01EF4D6941
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351173AbiCKT6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:58:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241078AbiCKT6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:58:48 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5C129CA6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:57:44 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id u3so13546361ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wd/VfUESiedi2T20MDzQRQGroPtqGURIlMD0YY8oI7c=;
        b=Mrv0ya7At6brNnSMetWxGly9F3DEvixI5X0RSd0S2xAl8G8x/qAsW2i4SfvlNRGXmY
         IJciyrCO4rFR0y1TF0IhVUjhikkLVMgtOCQVeEnv1wi1AL2tDinPKnvD5p9hTSrEBqvo
         Bais2VxhX6RGbk78jzHb5/kN7xAkSYu0sOREI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wd/VfUESiedi2T20MDzQRQGroPtqGURIlMD0YY8oI7c=;
        b=UeRPP0fAxnFTxCMoefVgMaMcnl4E8F1TF1CQWocNcE0qsDOQ1FoicC1LRpJW5a3PyX
         DNo/ZW+pYaS58lylOeYBTNQSPqeLkJFeqTEekhMqjHzqarD4ChAlamVJreaEpJ/R1ExF
         nMDFWp+n8kOXOG2+VYKpBhJu/hxhc9KXdZc77qz/188rv1lG0EwtrdjkBNaR9R3ij6QH
         Uz8RFuGrqrvOPhWW+9YSHndY5xNHetJGfx7UTeBxFp7pFj3F50VoJ4MGsgdP9aUBEs6j
         Nrn5+W7qmwFu9HBiLPePCfpkxWVgokTqEC6upRVBf0DeAoUDQny/VaAKiuVPzTkpb5KM
         cozg==
X-Gm-Message-State: AOAM531CjcaD0TO1s7u/Bqzcvr71IwHYiSCZNKXvMRYDD3yMjjcfF2V6
        ryuIU4Mv+9eHRpbgG0VDCScEKOpAHREwN05jBEQ=
X-Google-Smtp-Source: ABdhPJzRqIBP/GqAjuhMu77XjTWSSMoSr7Q1d3Ui71GRQZqCTV139jOXmqsdN75m2RC6Z6UZLYbDuw==
X-Received: by 2002:a05:651c:1503:b0:244:c075:2103 with SMTP id e3-20020a05651c150300b00244c0752103mr6852040ljf.442.1647028662398;
        Fri, 11 Mar 2022 11:57:42 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p2-20020a196042000000b00448729bbc48sm596517lfk.82.2022.03.11.11.57.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 11:57:42 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id z11so16805358lfh.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:57:42 -0800 (PST)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr6789578lji.291.1647028186416; Fri, 11
 Mar 2022 11:49:46 -0800 (PST)
MIME-Version: 1.0
References: <20220308141437.144919-1-david@redhat.com> <20220308141437.144919-11-david@redhat.com>
 <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com> <CAHk-=wjWx_bPBLB=qMMae8Sy3KrO+Kvaf4juPknO5HX-+Ot0XQ@mail.gmail.com>
 <e166e925-508e-3830-574f-59b2d2cf2431@redhat.com>
In-Reply-To: <e166e925-508e-3830-574f-59b2d2cf2431@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Mar 2022 11:49:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSNvb=0B=QzwCO7Xg6xZPJwe20p8ogsS=iOphkbNsKTw@mail.gmail.com>
Message-ID: <CAHk-=wiSNvb=0B=QzwCO7Xg6xZPJwe20p8ogsS=iOphkbNsKTw@mail.gmail.com>
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

On Fri, Mar 11, 2022 at 11:36 AM David Hildenbrand <david@redhat.com> wrote:
>
> Yes, but PG_has_hwpoisoned is located on the second subpage of a
> compound page, not on the head page.

Ahh. Ok, I missed that when just looking at the patch.

I wish we had a different namespace entirely for those separate bits
or something.

                  Linus
