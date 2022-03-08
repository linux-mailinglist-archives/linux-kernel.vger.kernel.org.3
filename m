Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0176A4D2357
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 22:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350493AbiCHVan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 16:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349965AbiCHVak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 16:30:40 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1463849273
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 13:29:43 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id v28so403156ljv.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 13:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITqWpEZwrmmJzxal3MypORnmA0mDOzhlH8+XcvCxIyo=;
        b=HBj/d6ypv10UMkfaM2OS15pVbsLfF4xN6WVmpOfhU/y5gJzN5IFBq1T04eDhff8+n3
         G2fSh+r/zEea/7VW6snxkdVJFPV846h0LVdPFFmKUFSATqCBw+wjJGQDAqaDfbX2/4WM
         6s5tfRAAowQx5Php/TTtIUA6tereJtP6Hwk5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITqWpEZwrmmJzxal3MypORnmA0mDOzhlH8+XcvCxIyo=;
        b=ypH7ir+Q/6MwdfooP3Gb1qcXdWS57Potmv3H+WmwGDdLDgizhtM4HuTYNbBz3w9dkW
         DInpn2GZcbyUpqb9h1UdDXAagC86PsMhcAeHW+bnzkusGbWx768HlQPCOms5DFu9kOjw
         n9KygrdlZDzTsMTVZ4YMQWzMQOO35Bc911miqa7C7uJqXIDIrCb3ivrlBX4v1EHpd89q
         jrw6LZ2KOcIdxAk1FcJZde1VuzmG1QogSGiYKmcswNyraqiKHzFoTD0edRTeP4Ih/81c
         T+7SO4QspN5uTNvVjhczfIS7q2wElUP49cM3vYzIJqMntJw3gkPaZPEjbJXudU7vOKoD
         F2Iw==
X-Gm-Message-State: AOAM533/o81zSc6JOnq2LirDZQXoYEdxFhmbX0UGIys198SvGyq6dIx5
        sohd6ohOFwuLlC6W+Ppr9tl9ApocYaWl1dyk+zM=
X-Google-Smtp-Source: ABdhPJwfROa0IfxjdhvJmmOR18YPwSNdgmiBP/SF86c1MP6Nx60aBPXuTsRdm4OCg0faFVTY4oIucA==
X-Received: by 2002:a2e:81d5:0:b0:247:feb8:5e25 with SMTP id s21-20020a2e81d5000000b00247feb85e25mr1020113ljg.178.1646774981105;
        Tue, 08 Mar 2022 13:29:41 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id n5-20020a056512388500b004439696b40csm3689627lft.47.2022.03.08.13.29.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 13:29:40 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id r22so432918ljd.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 13:29:40 -0800 (PST)
X-Received: by 2002:a2e:6f17:0:b0:248:124:9c08 with SMTP id
 k23-20020a2e6f17000000b0024801249c08mr334510ljc.506.1646774547965; Tue, 08
 Mar 2022 13:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20220308141437.144919-1-david@redhat.com>
In-Reply-To: <20220308141437.144919-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Mar 2022 13:22:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiA0KMVbLacK-Gi5_ZsZhXVi++6ePTtPrJkgf0az7r2ww@mail.gmail.com>
Message-ID: <CAHk-=wiA0KMVbLacK-Gi5_ZsZhXVi++6ePTtPrJkgf0az7r2ww@mail.gmail.com>
Subject: Re: [PATCH v1 00/15] mm: COW fixes part 2: reliable GUP pins of
 anonymous pages
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
        Linux-MM <linux-mm@kvack.org>,
        Khalid Aziz <khalid.aziz@oracle.com>
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

On Tue, Mar 8, 2022 at 6:14 AM David Hildenbrand <david@redhat.com> wrote:
>
> This series fixes memory corruptions when a GUP pin (FOLL_PIN) was taken
> on an anonymous page and COW logic fails to detect exclusivity of the page
> to then replacing the anonymous page by a copy in the page table [...]

From a cursory scan of the patches, this looks sane.

I'm not sure what the next step should be, but I really would like the
people who do a lot of pinning stuff to give it a good shake-down.
Including both looking at the patches, but very much actually running
it on whatever test-cases etc you people have.

Please?

                 Linus
