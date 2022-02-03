Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7C4A7F4D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 07:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240527AbiBCG17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 01:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbiBCG16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 01:27:58 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410F4C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 22:27:58 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id c19so5911992ybf.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 22:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QfWsHpzMv7MOEjkEvoCjQ/ClTe4kUM35UqplmdMDux8=;
        b=OBMo4dGol6rni5b6HIbWk5iep7kV8XHSEWwdEisb/CFGwbISqKM9cOqNH80tEw/we8
         GM0IjMMesVSzsbWAERweOtuYWPsr5Z/25MRCvUfd8+aiBBBgtiZWqZpaEFfEFJA53a4L
         61McLr8vButdB0dVzPyoJQvV/LhcNCgcohB18QsiWo4a22iuN2xmPh+BgOYEwK4zv+5n
         PfI5fshWL59Oxws2+cZppbruB+vcVoulopkaQACbU8w9mzqd0nVQUPx6r9wOHILfgXaH
         pLEnTdEDbRFR9L8Tt19QfypIikRGUIAGnCEfT+FpNMCle1hKIZUqZ0Y7/veEj1zTeqWe
         MrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QfWsHpzMv7MOEjkEvoCjQ/ClTe4kUM35UqplmdMDux8=;
        b=fNtFSOcbGfYknZ8ujixJr6bzlXA0fZPwdb7AAr4G2dg+ZK2DzM0c6x01GJhwm+m+3K
         ksKjeWlDYL5jvWSGVlhScD/ehQIccx+pj3QdG3l8lnZdU1iEpOpcARtlxefwQOlJwWL2
         EVbKte8/utTzZWcIXYhetnw1Ku1DZS4/rtx3alM/4h3TkkMJq4jyJJDcrMH+dHdfIq82
         jp9YSw24Y082z/v7fPx1wAQB+9uNxaFIdVtsdBKibt5CqraZPo0UUlOALufzdGWdV44b
         Hvj2syENjR6evIltc7H9CD7rVs7DfL5UO2YfaDIgWirzi+l4hOoS7cx9W8ouVssbFdI6
         /mfQ==
X-Gm-Message-State: AOAM532GCsvByQA0hUQiuh+cx1sMqIsrdVElhQGkI1953jbbLou4mww0
        CU7iVjcFvIOSd9a8lyYfF9b55jMkpyHUczfMj88=
X-Google-Smtp-Source: ABdhPJy0Hu4ydKHwQYod2o1W54szLZ7k5hXr0PDzOiAj/+6SoJN/icaRyi2aU388GT9SGtkkroNKj4gT9APgtErPUNc=
X-Received: by 2002:a25:b003:: with SMTP id q3mr41741638ybf.767.1643869677470;
 Wed, 02 Feb 2022 22:27:57 -0800 (PST)
MIME-Version: 1.0
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 3 Feb 2022 07:27:47 +0100
Message-ID: <CAKXUXMxFK9bo8jDoRZbQ0r2j-JwAGg3Xc5cpAcLaHfwHddJ7ew@mail.gmail.com>
Subject: Weird code with change "mm/gup: clean up follow_pfn_pte() slightly"
To:     Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear John,

Your change "mm/gup: clean up follow_pfn_pte() slightly" (see Link),
visible in linux-next as commit 05fef840b5c6 ("mm/gup: clean up
follow_pfn_pte() slightly"), is somehow weird.

In the new branch if (pages), you set page = ERR_PTR(-EFAULT) and goto
out. However, at the label out, the value of page is not used, but the
return uses the variables i and ret.

Static analysis tools, such as clang-analyzer, rightfully complain
about such weird code.

Maybe you can have another look at what you intended to set in the
branch of that commit or if you intend to jump to the label out?


Best regards,

Lukas

Link: https://lkml.kernel.org/r/20220201101108.306062-3-jhubbard@nvidia.com
