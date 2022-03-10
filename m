Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E92D4D3E4D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239047AbiCJAli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiCJAlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:41:36 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCFD12550E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:40:36 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n15so3450133plh.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 16:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RzBwZmXuL2mtDGId2fRGQ9cdH48yHESLY1EUls+Y0mA=;
        b=3fblK4Lx9eyAfaGQJ50OJygXLr3+yngV/09AYMG9DMOQXco1UvGBl0AA0tGjTcpBuL
         qHt6ZCzQlf8sISB0V93pZihkUafr9czsnHqjVeIJB64e7Odk4gEDbBLGV7HMcnb4CNqe
         2ZNlLK9eCP8cYoVJIeqOzgqErWYFpZzaGGpTl6YSYDkjL3SmiSahCh+xtHEDjO0njdJK
         1yi1kqR3uM1lGNvzVBUU6G3FKCEUFo9CWrmmN/lwTOnG6fRdAzpVscQ6LsXIDFtDZ9nk
         89nyYEbe1yTf8OUZXOg10LSsxznBJiSXMT/KFTyNyCSDq5UlCiSA4eUHry3XcY/oaIw4
         Fcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RzBwZmXuL2mtDGId2fRGQ9cdH48yHESLY1EUls+Y0mA=;
        b=gsu8ju8FcbrJY4SxyXO63TWNl3JjjjiQTkL8VJrN2xQxEikr2eKjDDmJHSTB/8VtHw
         r3Ct2tS6IBmFPtrjfECJiJ7gtas5Ri/43hUNaBlqTe6qgbqRP3ujDKEiO88Jh+g2ao6a
         GXFWoXMIb0rBfnyB8FNN4wJ8mZIsLqiz/hvu0Opo5xE5O/a1f8Y6c41XutRCp1zh0Zrs
         ceirq+4z3sRPhkzB4VnuGiddfwIENCKfWa3JER4p7+2GGPykIJUzRcvoshVdBBIvRFyp
         DfMCGGN4DLDuPRiMNl0QhCXz+7Q1hYTOiL+vhmyhEglfC1L/LayFdhr7yCQIoyoIInSh
         2DNg==
X-Gm-Message-State: AOAM530RY+2d3OGIpLYeAzScpkc/yFD30DaBECrAnUx4lQId1NjGo/wE
        Wt0rCIT6Lio+gXj5AOqtvb7ikN98brHwnI7ggUTTtw==
X-Google-Smtp-Source: ABdhPJwFz17SQgb4pCOtnBdy5++/qwKC6LSIgtrRreuv2Nn2kEZn09A8yZqo+ZyLEO0m2rhpRcsK1XX++GWIEmAQt2U=
X-Received: by 2002:a17:90a:990c:b0:1bc:3c9f:2abe with SMTP id
 b12-20020a17090a990c00b001bc3c9f2abemr2235610pjp.220.1646872836330; Wed, 09
 Mar 2022 16:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20220302082718.32268-1-songmuchun@bytedance.com>
 <20220302082718.32268-4-songmuchun@bytedance.com> <CAPcyv4iv4LXLbmj=O0ugzo7yju1ePbEWWrs5VQ3t3VgAgOLYyw@mail.gmail.com>
In-Reply-To: <CAPcyv4iv4LXLbmj=O0ugzo7yju1ePbEWWrs5VQ3t3VgAgOLYyw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 9 Mar 2022 16:40:25 -0800
Message-ID: <CAPcyv4hSg8tZdKSxZtk_iqm=8h-iVyWA_Qj+aqL5aEddnsXEDg@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Hugh Dickins <hughd@google.com>, xiyuyang19@fudan.edu.cn,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ross Zwisler <zwisler@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, duanxiongchun@bytedance.com,
        Muchun Song <smuchun@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 4:26 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Wed, Mar 2, 2022 at 12:29 AM Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > The page_mkclean_one() is supposed to be used with the pfn that has a
> > associated struct page, but not all the pfns (e.g. DAX) have a struct
> > page. Introduce a new function pfn_mkclean_range() to cleans the PTEs
> > (including PMDs) mapped with range of pfns which has no struct page
> > associated with them. This helper will be used by DAX device in the
> > next patch to make pfns clean.
>
> This seems unfortunate given the desire to kill off
> CONFIG_FS_DAX_LIMITED which is the only way to get DAX without 'struct
> page'.
>
> I would special case these helpers behind CONFIG_FS_DAX_LIMITED such
> that they can be deleted when that support is finally removed.

...unless this support is to be used for other PFN_MAP scenarios where
a 'struct page' is not available? If so then the "(e.g. DAX)" should
be clarified to those other cases.
