Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68C54B42B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:05:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349458AbiFNPEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345495AbiFNPEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:04:35 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C88E201B6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:04:34 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-313a8a8b95aso32764847b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XIBvhcDPAImiME+crbgSzqcAVyK5RrJiycpGa3Gh/l4=;
        b=0PnOrGgpJ2T40WIGeWlqfe/7/P0mm2HsYZ5fk4ogSdBAK1xTGuH753i05BrzCE+UCI
         dmA7HA/rlLTTv9Qgr4XQRKnG1Vx8W0THFIv8ZKSoijZickuOFVqAuWWFe2AcF084THZk
         dL+oE7eq7OLxr1fKys961spGM2elS000lmIpnBOsq63uIRU3m+xgtj9XVgucb+z82JDe
         7z+OOp5gWEJrkIutCK2+EXuw3UH4MK1m0QCzPTuobIno+7nI/HY9OuBqdG8AB3YRML3+
         y/E1f4+21TXJpA1l1AuHaZ0u7WyUmL/t4xgbWfeJSzTRruxBdsYLz2mPXofihh6mOPUO
         f2ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XIBvhcDPAImiME+crbgSzqcAVyK5RrJiycpGa3Gh/l4=;
        b=TRqxYK7yqD1No6IUre6a/DIMj/38kGZHWYE58bBYMI1pR++FvhY/j4SJVhnfk+vcw6
         Fgo60mbv3sAb2Wr+sN11HbOvc1lbSjSIbFl1ijBnKBQ+0kx7VTBcFwmH2E14ekIzXCkB
         33Mn79sr43E+Dg28gu0Z2T8m+Ym0Qpp8244OLnYUH9VEq4HU1Y0k7xCUWn+CYrLbuF9A
         uSb2QVGGWHCZ974lIF5Lbxzy75RNK4fcxGKqF4AGmJP8azuWPNyBVGLMwI3yotzq/asM
         ysUeTnV+L7Zgix379oYwtdzeqcM4KW4QdiA+jc4/YYq7NkMTq+vKGNAbBUGXhmLpq2nB
         aJfA==
X-Gm-Message-State: AJIora9OGLTYBTNMHKAAZgxhWCHBITcCdvniUzcLxhjdzBLvE72eezOf
        goaQWYgoUktbnVSx+OlWFSM7DMEXp6uYhnibsvUhkA==
X-Google-Smtp-Source: AGRyM1upO05v6xN4nB/RVN7MAJIXzcxBfDFQGXwdBAgFIaK6CPOHJDOhBFd8M+IxGlaJo5VwjhwxHgMK2SaPtM0MgcU=
X-Received: by 2002:a05:690c:297:b0:30f:b472:5ff1 with SMTP id
 bf23-20020a05690c029700b0030fb4725ff1mr6322963ywb.31.1655219073117; Tue, 14
 Jun 2022 08:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220613180858.15933-1-mike.kravetz@oracle.com> <YqeiMlZDKI1Kabfe@monkey>
In-Reply-To: <YqeiMlZDKI1Kabfe@monkey>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 14 Jun 2022 23:03:55 +0800
Message-ID: <CAMZfGtWUheQWeFNF0jgpttbMV9gBjFtZzaOar2gGvUTRx5h8bQ@mail.gmail.com>
Subject: Re: [PATCH] hugetlbfs: zero partial pages during fallocate hole punch
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 4:46 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> Below is v2 of the patch.  I was just going to change the type of start/end
> hugetlbfs_zero_partial_page arguments.  However, Matthew also convinced me
> to do the simple folio conversion.  Tested with new libhugetlbfs code.
>
>
> From 36a18e0b07c2e189092cc2d516e8cfedcb57d191 Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Mon, 13 Jun 2022 13:36:48 -0700
> Subject: [Patch v2] hugetlbfs: zero partial pages during fallocate hole punch
>
> hugetlbfs fallocate support was originally added with commit 70c3547e36f5
> ("hugetlbfs: add hugetlbfs_fallocate()").  Initial support only operated
> on whole hugetlb pages.  This makes sense for populating files as other
> interfaces such as mmap and truncate require hugetlb page size alignment.
> Only operating on whole hugetlb pages for the hole punch case was a
> simplification and there was no compelling use case to zero partial pages.
>
> In a recent discussion[1] it was assumed that hugetlbfs hole punch would
> zero partial hugetlb pages as that is in line with the man page
> description saying 'partial filesystem  blocks  are  zeroed'.  However,
> the hugetlbfs hole punch code actually does this:
>
>         hole_start = round_up(offset, hpage_size);
>         hole_end = round_down(offset + len, hpage_size);
>
> Modify code to zero partial hugetlb pages in hole punch range.  It is
> possible that application code could note a change in behavior.  However,
> that would imply the code is passing in an unaligned range and expecting
> only whole pages be removed.  This is unlikely as the fallocate
> documentation states the opposite.
>
> The current hugetlbfs fallocate hole punch behavior is tested with the
> libhugetlbfs test fallocate_align[2].  This test will be updated to
> validate partial page zeroing.
>
> [1] https://lore.kernel.org/linux-mm/20571829-9d3d-0b48-817c-b6b15565f651@redhat.com/
> [2] https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/fallocate_align.c
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

LGTM.

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
