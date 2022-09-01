Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573345A9F30
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbiIAShS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234594AbiIASgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:36:48 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF976844E8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 11:35:53 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id fa2so10286104pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=AX3fzHYEs7u6kdVK4Qs+eOMX44O84bf2e3kDlHfwCsw=;
        b=HzzGeH9PUSqbJBaIv0M6qWaufMd1sypFAfiavflRADgj+pQSIkXGfY3gh586qtu/Uf
         mbSzlvTgPdZdhJ/vypXl9jl2fsePGaXz4B260Kpx27oX8skWydJhgxA5h+lus50POgtB
         SYb9KqmTkTv/dgafq36/WAjYr9de12J7pW2+Z/nwPiehZO7np0nLLs60eXGxkbhmVVpB
         wOm81GfpOQdOg46aJsaqjX+A6StnYuku/MUIGq/n5XqZPYHJ0zjsbNQ4iHsbIBiiETA1
         oZfJODrsT7tBTR2hjj5ptCWVPx9X5jdLVQgfIVqtodOX8FKoM+dlwry0pwHhypylixRT
         0VTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AX3fzHYEs7u6kdVK4Qs+eOMX44O84bf2e3kDlHfwCsw=;
        b=EnW2HaB62nNC3+EpkvJjSJAwN0uwat3wUREQkl8CC0ej1/Mk+Zrdl+sIpMzqYaI6XW
         uipBcBfAyO/UXgZTzWxB/I6eOPY+n9W3wyo2OJVfDirjYWDsXXB5agJMdWbRmtG4IKlb
         bUl1frQHE6IUUc0UAJBBfyNblFeLi+kMByb9o4ggHmpaen67x3FekQxBq4waCkBVo3NG
         Np3ktv8Lb6FyiyuoM4l6QG/q/j4FzPl2ZnPok20P6aeQCb5RnTw203oyhB4em4N+O6v0
         TJvspQPxwqv3lSiwHN+J8sfF1kogfEMGHYHs1bUYpapZluXKEJR36x5oOBe651Uiewc9
         aqdw==
X-Gm-Message-State: ACgBeo28/JNKgLla5E4COhIj+8gIsMUGrpdBqGako77Db7UuRwVbKmae
        CRFpPHybL5pRG3WGn4Ny9s1Jh8/daCCAMZkgNtA=
X-Google-Smtp-Source: AA6agR6jyk3LtLKA0zuMZAbutNLOKIGcWvcAQrbLS5YsEwKlseOYfH6newzvEimzGqoNaJ7zZOGgg7cioZHVttTcziA=
X-Received: by 2002:a17:902:e5c3:b0:175:534:1735 with SMTP id
 u3-20020a170902e5c300b0017505341735mr15867766plf.87.1662057352663; Thu, 01
 Sep 2022 11:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220901072119.37588-1-david@redhat.com> <YxDdycTur733hMgt@xz-m1.local>
 <fa0bb4b1-3edd-eb5a-7ad6-dff785d88d8f@redhat.com> <YxDghv54uHYMGCfG@xz-m1.local>
 <c9dc3f22-4a72-9b9d-7a74-ad77fe4f3b6e@redhat.com> <CAHbLzkpdUMq2fMxqx-NgSZ2VLBU5RGqSpJRWH6eRrYymErAbaw@mail.gmail.com>
 <YxD00K1lv151X/eq@xz-m1.local>
In-Reply-To: <YxD00K1lv151X/eq@xz-m1.local>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 1 Sep 2022 11:35:40 -0700
Message-ID: <CAHbLzkrA-jKzTBq_Mn3NZYc91exovv1gH2LNzetCNiVu8+W6Kg@mail.gmail.com>
Subject: Re: [PATCH v1] mm/gup: adjust stale comment for RCU GUP-fast
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Jerome Marchand <jmarchan@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 11:07 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 01, 2022 at 10:50:48AM -0700, Yang Shi wrote:
> > Yeah, because THP collapse does copy the data before clearing pte. If
> > we want to remove pmdp_collapse_flush() by just clearing pmd, we
> > should clear *AND* flush pte before copying the data IIRC.
>
> Yes tlb flush is still needed.  IIUC the generic pmdp_collapse_flush() will
> still be working (with the pte level flushing there) but it should just
> start to work for all archs, so potentially we could drop the arch-specific
> pmdp_collapse_flush()s, mostly the ppc impl.

I'm don't know why powperpc needs to have its specific
pmdp_collapse_flush() in the first place, not only the mandatory IPI
broadcast, but also the specific implementation of pmd tlb flush. But
anyway the IPI broadcast could be removed at least IMO.

>
> This also reminded me that the s390 version of pmdp_collapse_flush() is a
> bit weird, since it doesn't even have the tlb flush there.  I feel like
> it's broken but I can't really tell whether something I've overlooked.
> Worth an eye on.

I don't know why. But if s390 doesn't flush tlb in
pmdp_collapse_flush(), then there may be data integrity problem since
the page is still writable when copying the data because pte is
cleared after data copying. Or s390 hardware does flush tlb
automatically?

>
> --
> Peter Xu
>
