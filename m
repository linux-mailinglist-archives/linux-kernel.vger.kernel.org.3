Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1854795C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:51:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237214AbhLQUvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:51:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234738AbhLQUvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:51:41 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A5CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:51:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id j21so8089494edt.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TG2f+1lEN9hemuQjgMe4Yp+YI3NU/6U4WSw8/cJzPxw=;
        b=Yrgcl5joP5IKSH1feNkTltzJLVVG8zrXENqo7vUe3EVV9XknZ07REOeQRBojTzTO86
         ru0XQjTptmuCTBKHvUxnc0k1m5boTQTeFASvq7tIIKB6yCjG9+KF1TpJp2uSt5cPlXfQ
         mvyq0AjNx+7bb2we1uo6ifMBNTtiDYvBUnRhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TG2f+1lEN9hemuQjgMe4Yp+YI3NU/6U4WSw8/cJzPxw=;
        b=aL61vpkTbYkfC8MxOBrxdr2QMF28fGamBwp0nvgKvQntnijSCvVEtYH15wRvc20SoT
         N++PFgQy/w0dpnSKE6WDdTehgY/+LjZIMtk6OiyXM7ulmSYQoQx1W0X9tZGzza0swHkI
         NmEOCp3POas/PiJKVEMUxMy5ak6hcb626fOdzQOEY1wz2jav5u+LAzagROdwmV3ll9vP
         PXHnsDkCvvn3yFLmohWevtp83ROjcliA7GTW+wvNanHSIu4QgecJVbg95hsvtBR9eWdH
         4nb4xyc+OrABThtMIHLbEdSWTedz0snX8QeDqmNxn6V6rPNhfF74EgNY551jQa/AS0do
         lsyA==
X-Gm-Message-State: AOAM533b8YKsnJbD9R72OGKQfDTwQLMPDdk6jrr1sEd1eZqOlKY2UhQ0
        gGW3McZx3Ey+VSD3hiHQd+I0IkLXPAjkK2cx0i8=
X-Google-Smtp-Source: ABdhPJxllAa0GP3O1VDcs+XZ2exX0ObZbrr0uGQ91zv2brT3N9XLjVu0yis0PmwVHyt4f/q1cND0gw==
X-Received: by 2002:aa7:c497:: with SMTP id m23mr4517847edq.65.1639774299702;
        Fri, 17 Dec 2021 12:51:39 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id sg12sm1814336ejc.46.2021.12.17.12.51.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:51:39 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so2269255wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:51:38 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr11082980wmq.26.1639774298625;
 Fri, 17 Dec 2021 12:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com> <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
In-Reply-To: <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 12:51:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
Message-ID: <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
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
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:45 PM David Hildenbrand <david@redhat.com> wrote:
>
> If a page is mapped exactly once, page_mapcount(page) == 1 and there is
> nothing to do.

Why?

You state that, but you stating that doesn't magically make it so.

What makes "mapcount==1" stable and special? Your "it's an
atomic_read()" argument is nonsense - it implies that the count can be
changing, but you will get _one_ answer.

What makes that one answer of a changing count special?

What if there are other references to that same page, gotten with
vmsplice(), and just about to be mapped into another address space?

This is the meat of my argument. You claim that "mapcount==1" is
special. I claim that you haven't explained why it would be. And I do
not believe it is.

                 Linus
