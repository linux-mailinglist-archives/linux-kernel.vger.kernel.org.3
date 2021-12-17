Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 137974795B8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 21:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237113AbhLQUqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 15:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbhLQUqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 15:46:03 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB99C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:46:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so12504201edu.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mvtI4+YSdquMi4008PNndF9RQGlniB2TT2AdOD25k8M=;
        b=TiDJROI9W5ycY3V9UTpl5dSHKHMEZnWf33NVmEsRwKuJFClSlc4drizCRjtvX0nU1J
         mcXdn9RlVnT274Z77xOxrX9ujv1qBIOdnmYLgr3mJtCslSOMD3PQUkkkx6ZV6OQDfbmN
         vDn6BLFj3k3shFoPGq1aawhK/RRcCUCSrsyjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mvtI4+YSdquMi4008PNndF9RQGlniB2TT2AdOD25k8M=;
        b=LrxtLVD4HQTxvRGlEqH/O3sm2TrfX1fGJnomzM+BBtculXxTekyanItZotl278Pz85
         ccn+EWPfBvSmtD1wZFL1twEoWpMSng9vDNHh+dVCZQ77rE7V/eFMncVhdUFdFAPih8vZ
         ewCbfsDroRe5tBpxfqReeykWoxwKcFunXqflmNklH5pujzTAL2sxPaXG2o7wQRVe22n+
         qJ53GUewtvulXDyuCphCXAUqi4OYfE2A5kQ0lNOfr+aR0Lzhfm1UYLaIDbBQU4cPM5io
         hU5Pw9vdM0xetAXJseKUIS0b7uiicaBStHptKQnhdSJShdVzCn6eC8ybmVjK29kqnMYY
         dhrA==
X-Gm-Message-State: AOAM532efLVz5JeQfrVmsCQA2KUvQiDIciLxQnmeVV3mZGOij0LJGFIU
        mMFsBddrWvJ8Ge7SFJbtm8I0WkFvwKcP+WPNXT4=
X-Google-Smtp-Source: ABdhPJwoYbeaX4aoJWZaUgCkyXv8n6qA8AGZWExdbBzuN64VW4tRc0vAl59w2RVCSrOJTpOlZWsi1Q==
X-Received: by 2002:a17:907:608d:: with SMTP id ht13mr3682925ejc.205.1639773962091;
        Fri, 17 Dec 2021 12:46:02 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id qf12sm2347917ejc.107.2021.12.17.12.46.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 12:46:02 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so2260251wme.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 12:46:01 -0800 (PST)
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr4080563wms.144.1639773961365;
 Fri, 17 Dec 2021 12:46:01 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <17bfb2fd-da51-1264-513f-f9e928ec36c6@redhat.com>
In-Reply-To: <17bfb2fd-da51-1264-513f-f9e928ec36c6@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 12:45:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wir5fG_OGe_38nhJZegw0uL5+0oH3k48xWQLcAwc4W0Rg@mail.gmail.com>
Message-ID: <CAHk-=wir5fG_OGe_38nhJZegw0uL5+0oH3k48xWQLcAwc4W0Rg@mail.gmail.com>
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

On Fri, Dec 17, 2021 at 12:42 PM David Hildenbrand <david@redhat.com> wrote:
>
> > Then somebody else modified that page, and you got exactly what you
> > asked for - a COW event. The original R/O pin has the original page
> > that it asked for, and can read it just fine.
>
> Where in the code did I ask for a COW event? I asked for a R/O pin, not
> any kind of memory protection.

Why didn't you ask for a shared pin, if that is what you want?

We already support that.

If you don't like the read-only pins, don't use them. It's that simple.

              Linus
