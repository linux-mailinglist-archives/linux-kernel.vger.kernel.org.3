Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCB84A645F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiBAS7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:59:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiBAS7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:59:40 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DADC06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 10:59:39 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ah7so56920188ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J+6/JTvSQO/Z1ymdKLCb+WYJq0+43v8HNMzB8JVyjj8=;
        b=Xgs2Eb9H29ppazYKAkLV3REJkGUYm32LVTOgyr5qeb+rxykyfHyqV+trlCRNnd50/w
         GrmtgHGLQl1AL+SWr2NgzGCc+DFYqNgOqLb+bL0oeO7K555tBtcRRfMmtt2RSEDqZRTs
         7zqSN6XQjIymFA9+VKMrttu3o6/ZNSnSESguQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J+6/JTvSQO/Z1ymdKLCb+WYJq0+43v8HNMzB8JVyjj8=;
        b=WTZCBZYsA2Nta3cMXj5Az+XWkSqvV2suBZinoJPV0IJQ+d85ILYghAMgOcmrqOmUov
         oNhFOFgIZowl4WhvFIkqUDHSyC+VVEPm/mL/Roz3TRDeoOPkYOhd+AYAflUPIb/3m3Jr
         0P9cWVEEVlGcReQzvrRMmV/tk9Qk5ygXySIJhsgkkZ5OBOfaLiXDIT1aCSp8DgDffSbs
         LXxgDMjAV+gtJEz3su72JQVebkNQ5FyEFcl4bhv+qs34SklqXgLGeLChaww+NB1mHOyf
         z496+1wh6oMqNZhHFE6USRSePexjgdvIWcQebzK8+7TKRLMWgkEtQ92LfYk1RUBCvMHT
         QRxA==
X-Gm-Message-State: AOAM532OHZNF0I/qV7aGTnaSueWddoSqzgjlsy4Y4+LifUa8ZDtE0xg0
        V6qPRx6bArAsCq5iRPE2EjyFuL9MgPd5Mznm
X-Google-Smtp-Source: ABdhPJw//MLxl+r7ELdOj18nI1KblGReSyyyGCg459VsnxHEoVtBG8KcJcbBPcbeJvmzof44T9MjpA==
X-Received: by 2002:a17:906:58c8:: with SMTP id e8mr21367549ejs.706.1643741978236;
        Tue, 01 Feb 2022 10:59:38 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id j19sm3911981ejm.111.2022.02.01.10.59.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 10:59:37 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id f80-20020a1c1f53000000b0035399b8bedcso2452406wmf.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 10:59:36 -0800 (PST)
X-Received: by 2002:a05:600c:2245:: with SMTP id a5mr3017640wmm.8.1643741976571;
 Tue, 01 Feb 2022 10:59:36 -0800 (PST)
MIME-Version: 1.0
References: <20220131162940.210846-1-david@redhat.com>
In-Reply-To: <20220131162940.210846-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Feb 2022 10:59:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtzz8kY=cgY0NbVHDSuS8piMtfycb44CihgKjtJSaL+A@mail.gmail.com>
Message-ID: <CAHk-=wgtzz8kY=cgY0NbVHDSuS8piMtfycb44CihgKjtJSaL+A@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] mm: COW fixes part 1: fix the COW security issue
 for THP and swap
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
        Linux-MM <linux-mm@kvack.org>, Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 8:31 AM David Hildenbrand <david@redhat.com> wrote:
>
>  7 files changed, 98 insertions(+), 241 deletions(-)

The series looks sane to me, and I love that diffstat..

               Linus
