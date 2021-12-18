Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A6E47987F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 04:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhLRDpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 22:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbhLRDpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 22:45:52 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413FDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 19:45:52 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so15131096edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 19:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BxFK+093IJRQnbXW5Og88SuGPphlDPFlB6O2bfY/1Ws=;
        b=AAZ+me/h1XGaSaNRrJXizPg0Km/qG0INBdJS0TmFPdkE5f9PsFTYB6Txr2Gz38XLIX
         zPP/iYefPweJa/M91dvLwmoT3+O9qR+Qjw0z2ZxHVcC+2bWTEslsEbGndeCEoqoGaoON
         TWmidbo8qai3FAIzAu88GdctoyASGDe47Cq0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BxFK+093IJRQnbXW5Og88SuGPphlDPFlB6O2bfY/1Ws=;
        b=1PHL40Lti+KpiAPDlwRCO5Hz5CL/jzQwQSClS0AKP5J3gU4J7P8BGmN4OSlm5pBtd6
         h6/q9k9gGMOB+CC/7RIOJR+fPuGYVkYpt/TqGluv4spQzcZbwbZoLsdWlnKiuYjCeU6r
         GeRIr2HLfl1A4sN4BVnUPtoH8R5R+ppDxY3aYu2ESPZ1BoMaAaC99M8k7eYnkVJmXrjB
         1psuvEbd+ZyEI4hI8Bx10eoYeRCfvt4fRrxm1NjrQSywHrbTGHd/JptRpkaqXchO0/vt
         iVaN2sjYiJDqPch5dWGvaCchCvAtjnt4YZmtOk8ZGmj82WNDkfDsKlznfGLq96A7KdT6
         PkHw==
X-Gm-Message-State: AOAM531nF5+bRWhmcN2woj6mCliEh4bGbUJtgvKRpAheXdMpg/pWYRu/
        ZT9MQToihF8ZJTaO+UTaB1W8RjphOgHY1Usqayo=
X-Google-Smtp-Source: ABdhPJyFblkaztMcgoSbyiodj2FbJXfNMzxssLTnsxnt+9nGKozR1NWDZCOWvGO0xvzzZShqgopeHQ==
X-Received: by 2002:a17:906:5d01:: with SMTP id g1mr4828755ejt.219.1639799150637;
        Fri, 17 Dec 2021 19:45:50 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id hq9sm3492062ejc.119.2021.12.17.19.45.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 19:45:50 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id b7so15072472edd.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 19:45:50 -0800 (PST)
X-Received: by 2002:a05:6000:10d2:: with SMTP id b18mr3943603wrx.193.1639798735711;
 Fri, 17 Dec 2021 19:38:55 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com> <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
 <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
 <20211218030509.GA1432915@nvidia.com> <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
In-Reply-To: <5C0A673F-8326-4484-B976-DA844298DB29@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 19:38:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
Message-ID: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Nadav Amit <namit@vmware.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
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

On Fri, Dec 17, 2021 at 7:30 PM Nadav Amit <namit@vmware.com> wrote:
>
> In such a case, I do think it makes sense to fail uffd-wp (when
> page_count() > 1), and in a prototype I am working on I do something
> like that.

Ack. If uddf-wp finds a page that is pinned, just skip it as not
write-protectable.

Because some of the pinners might be writing to it, of course - just
not through the page tables.

So that sounds like the right thing to do. I _think_ we discussed this
the last time this came up. I have some dim memory of that. Jason,
ring a bell?

             Linus
