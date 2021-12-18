Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2547980F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbhLRByG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhLRByF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:54:05 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693DAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:54:04 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id t5so14639941edd.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTrxVAtwDNxhFPmosFFlt9H6t41hXU+6IxlHAslUllg=;
        b=O6XfYNdscSUNLQjZoscLmlmMkKSNijulCuTb4Q2B3XsFA/h3vGu6jHAV244eaLTQvy
         GT8/tCMwpxagvHqj2STHyeIgCPUE4XWMdxwbC8cqaUaik8OpMW26B4HMkzJprc5CisjR
         3B7w6JIGSGDhfKhsb55bYBk2eovn1g5toVtHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTrxVAtwDNxhFPmosFFlt9H6t41hXU+6IxlHAslUllg=;
        b=jYZFUbGc1Wr0fNkvtOefMMYfdqiiX4vzAfw2N5klnuik+XU3Uglw4PBdb7H48E9cru
         +02dLzqaGNso/r6exu1nbyzdJvAnKkBUrKe5yFiDbCpi29YISvk2KfylvVHysRTEdgUv
         7r7MWrtBP3EnOWU9LTbkihQWd+k3ulk2u4ihNRrS1n/9PhAQblLlFTQ+ilYFxXIOEUC8
         NQMO9b/xmi5aXvUIu3Dbq0j79WkbwXKV9negn85M2O1nChUTjOZFkRdScn9H3FbxjPnF
         h0UeminnSBKm6NfCQsg0eBRyscz0BUKlRXeaTuwQeU06GtPxQQhz6AiAHapha59sw6Fd
         NkyA==
X-Gm-Message-State: AOAM533rjbgRJru4yQotGtgSl0hSrGsDDpHAQjDGL6K/+iv+yKESRn1M
        jv4xfKBSZXiLUePa2U4q6Bpp/Imep1al8F6YyE0=
X-Google-Smtp-Source: ABdhPJx2QbNjT5sCBNh9JGfNPqDg5I2H4470hoVY/L+eKQR4Jfcg/qE8fj7J2VK8QwmB3A0aPsg+bw==
X-Received: by 2002:a05:6402:5188:: with SMTP id q8mr5430635edd.181.1639792442696;
        Fri, 17 Dec 2021 17:54:02 -0800 (PST)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id j14sm4378833edw.96.2021.12.17.17.54.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 17:54:02 -0800 (PST)
Received: by mail-wr1-f44.google.com with SMTP id v11so7206557wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 17:54:01 -0800 (PST)
X-Received: by 2002:adf:d1a6:: with SMTP id w6mr4363313wrc.274.1639792441589;
 Fri, 17 Dec 2021 17:54:01 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com> <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <20211217204705.GF6385@nvidia.com> <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
In-Reply-To: <2E28C79D-F79C-45BE-A16C-43678AD165E9@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 17:53:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
Message-ID: <CAHk-=wgw5bEe8+qifra-aY9fAOf2Pscp1vuXX=f4hESyCK_xLg@mail.gmail.com>
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

[ Going back in the thread to this one ]

On Fri, Dec 17, 2021 at 1:15 PM Nadav Amit <namit@vmware.com> wrote:
>
> I think that there is an assumption that once a page is COW-broken,
> it would never have another write-fault that might lead to COW
> breaking later.

Right. I do think there are problems in the current code, I just think
that the patches are a step back.

The problems with the current code are of two kinds:

 - I think the largepage code (either THP or explicit hugetlb) doesn't
do as good a job of this whole COW handling as the regular pages do

 - some of the "you can make pages read-only again explicitly" kinds of loads.

But honestly, at least for the second case, if somebody does a GUP,
and then starts playing mprotect games on the same virtual memory area
that they did a GUP on, and are surprised when they get another COW
fault that breaks their own connection with a page they did a GUP on
earlier, that's their own fault.

So I think there's some of "If you broke it, you get to keep both
pieces". Literally, in this case. You have your GUP page that you
looked up, and you have your virtual address page that you caused COW
on with mprotect() by making it read-only and then read-write again,
then you have two different pages, and at some point it really is just
"Well, don't do that then".

But yes, there's also some of "some code probably didn't get fully
converted to the new world order".  So if VFIO only uses
FOLL_LONGTERM, and didn't ask for the COW breaking, then yes, VFIO
will see page incoherencies. But that should be an issue of "VFIO
should do the right thing".

So part of it is a combination of "if you do crazy things, you'll get
crazy results". And some of it is some kernel pinning code that
doesn't do the right thing to actually make sure it gets a shared page
to be pinned.

And then there's THP and HUGETLB, that I do think needs fixing and
aren't about those two kinds of cases.

I think we never got around to just doing the same thing we did for
regular pages. I think the hugepage code simply doesn't follow that
"COW on GUP, mark to not COW later" pattern.

           Linus
