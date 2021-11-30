Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D55C462A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhK3Chc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:37:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237604AbhK3Chb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:37:31 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374A8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:34:13 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id f186so48024576ybg.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TfYJSxsbLxhJzDiPj/duqxgB5VLSDdQGpN98L3/Vhrc=;
        b=UEEaYp1rLqFfBNJuI4XBpjEIV4blhdNGa6OpmQA7R2W1kKP7XcaCntTLjpKwR6K3RQ
         VMYKrD0/Q8VC1qN+WJy8o9OZ6RwTPQlGJlikqV9dbnwip85PFuOYqiNs3Nu0GrcaZliF
         5va9RGfS7KHnurWlFafNaoSyoaDCmZchlPpkkesDPamLLCs+mn/8+PgygwYZoHr9M+C7
         KxYr8k5QoaUWzztDqs5dC8/TbDmGNUBepo+9/C8r45UWk48EeSqMA8zRuC/z/5exwkbs
         Ne1H8t3DhBECAZzDC877WHZQjGwqFSUArJ40GOQ8GBS/Eb7zZIcBPaJtl/XUPbbAG+7V
         BqzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TfYJSxsbLxhJzDiPj/duqxgB5VLSDdQGpN98L3/Vhrc=;
        b=sT1Zsko/gfT1JcKU9fsrY94quhz0YKcRbXDhJFLlA1KkjwvWOl+9aCw4Av/qAQtHvm
         8i3aiNXiXtgGk6SO6v5OQHOw3JN/KAaWiwx04QsuFwo3dL6edIX0b9iLSWthzwetvD9i
         pteDh8K9DnATZtFYHixszO+uqtf6HtzaYv9XGBXAMT8lieDru+9weJPQq4NSKhRDDC9J
         55z+Xc5z5ETa9zFU6NZGrF5uOQ6IH6smiKP9fbhBmY43svw+gyHko3jX9y3+GRVUh/WP
         4rsDsWF8O0T5/L5qfzwG//QYwO2L0irAqMDsmENoF70iJl+TJAx2nNmOx5m3AfAqIGBp
         ye2g==
X-Gm-Message-State: AOAM532tV7eErMP+CSBk5X2D8xjMu6z1DOL+l1MqVC1fvm6rZw2g4kcy
        oteby0keA8tZqD0fJm3eNf2mJdZTe0yr6JOa/gZeZA==
X-Google-Smtp-Source: ABdhPJwyWy1rg8/bds7VX4f9iqBpEkOuLqZ+jy8TvkRIqTYzZLwheruQmkgxkuWRm1xOf0FttRg1G4Cr4TorKlduAnE=
X-Received: by 2002:a25:b285:: with SMTP id k5mr39430450ybj.132.1638239652378;
 Mon, 29 Nov 2021 18:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20211129133803.15653-1-yaozhenguo1@gmail.com>
In-Reply-To: <20211129133803.15653-1-yaozhenguo1@gmail.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 30 Nov 2021 10:33:35 +0800
Message-ID: <CAMZfGtUxihm0_G6P2L=Vcf97p3kHj=X+MCRUOBb_M4-H7LHdQQ@mail.gmail.com>
Subject: Re: [BUG] hugetlbfs: Fix issue of preallocation of gigantic pages
 can't work
To:     Zhenguo Yao <yaozhenguo1@gmail.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, mlevitsk@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:27 PM Zhenguo Yao <yaozhenguo1@gmail.com> wrote:
>
> Preallocation of gigantic pages can't work bacause of commit:b5389086ad7b
> (hugetlbfs: extend the definition of hugepages parameter to support node
> allocation). When nid is NUMA_NO_NODE(-1), alloc_bootmem_huge_page will
> always return without doing allocation. Fix this by adding more check.
>
> Signed-off-by: Zhenguo Yao <yaozhenguo1@gmail.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
