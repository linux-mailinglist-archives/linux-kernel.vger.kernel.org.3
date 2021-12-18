Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EAE479E0B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 23:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbhLRWwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 17:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbhLRWwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 17:52:07 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C4FC06173E
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 14:52:06 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id b19so9281671ljr.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 14:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sBAqL0XY9282u/0srwjss6qXrjgZeQHxTeBtfP/uo2s=;
        b=06+e7ZSL8NY2K9ycNOgtqQKzLoV2iVXgJHTOQigteBPj/ZOex9LWOC1mqyZ/ImY+Vt
         V0dhR5VWQuQdDNFUPzEEPZgl1uEC5jvVOaSfp11EowtFzgBH198sJcTbfYvNSD4OMciB
         cb7qi1PyXQHvxtCFLzlDY0NfkHtCUpZy5Sorl7/ev9/O9HYcYP9XZJ7eCCssLbEWAqLG
         2glXjmE2ot4NY+li0IA8TZ3KCWgxcpZxQEFqNjueuysGKyq6qWV8jiKkea5YrbfaqALF
         QOO5eZ/TMts2abWMrcvEgv6gp7/NHTx22k+3CRUmrZgpQqs8DbuqlrpW7cNhDmhO12tO
         wQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sBAqL0XY9282u/0srwjss6qXrjgZeQHxTeBtfP/uo2s=;
        b=IQFMgvkQ7UYi5uNM/Q4Za4ySWEDM2P1009V3+cyJa3lYyiFMF37mH0FoPF4sKbrWak
         0dbGZ5siCxqQ5PnNUzRjS665sWbA3JN/z7uC94mNXkAe1twqoDrxE148sgAqQ7yQuRJv
         4gDg0rLUFDigC966MPjXxZ9lVQHMVB6D93bR+wXI1dNsgLyJNoAgRrQc6oyTGpSAHuKa
         0ceflURcirFe90Ue7oltdwYqTA+oHMlmmrz6HWr/mNFrQ2t9IpJIEZVZ/q0GO0iVWMH6
         dpZM+YCNTYHy3M+ku4FzdKWVy2l5pNQeyDrCda298Fb1N2Wyr/IQ5uwIUzgJwefUHF7c
         CK3w==
X-Gm-Message-State: AOAM531Tqxv3AUbgyi0BO3KkcL/FdVn1Qe3zgVHSBofwSU+sSDAc/onZ
        /XketSTg9gJ9CE7C+pZpOY//nQ==
X-Google-Smtp-Source: ABdhPJzXddwDWhETx4tx/cc328GQhtkY7FtcFFyvtxzAQcRcwh6sSqhfWQGUglCw+yDcpwHWbpBbUQ==
X-Received: by 2002:a2e:918e:: with SMTP id f14mr8300713ljg.109.1639867924837;
        Sat, 18 Dec 2021 14:52:04 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l11sm1285186lfg.248.2021.12.18.14.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 14:52:04 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 6041E102E5E; Sun, 19 Dec 2021 01:52:11 +0300 (+03)
Date:   Sun, 19 Dec 2021 01:52:11 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
Message-ID: <20211218225211.epa4u6mtjnvgkw4x@box.shutemov.name>
References: <20211217113049.23850-1-david@redhat.com>
 <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <CAHk-=wgKft6E_EeLA1GnEXcQBA9vu8m2B-M-U7PuiNa0+9gpHA@mail.gmail.com>
 <54c492d7-ddcd-dcd0-7209-efb2847adf7c@redhat.com>
 <CAHk-=wgjOsHAXttQa=csLG10Cp2hh8Dk8CnNC3_WDpBpTzBESQ@mail.gmail.com>
 <17bfb2fd-da51-1264-513f-f9e928ec36c6@redhat.com>
 <CAHk-=wir5fG_OGe_38nhJZegw0uL5+0oH3k48xWQLcAwc4W0Rg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wir5fG_OGe_38nhJZegw0uL5+0oH3k48xWQLcAwc4W0Rg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 12:45:45PM -0800, Linus Torvalds wrote:
> On Fri, Dec 17, 2021 at 12:42 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > > Then somebody else modified that page, and you got exactly what you
> > > asked for - a COW event. The original R/O pin has the original page
> > > that it asked for, and can read it just fine.
> >
> > Where in the code did I ask for a COW event? I asked for a R/O pin, not
> > any kind of memory protection.
> 
> Why didn't you ask for a shared pin, if that is what you want?
> 
> We already support that.
> 
> If you don't like the read-only pins, don't use them. It's that simple.

So you are saying that if a GUP user wants to see changes made by
userspace to the page after the GUP it must ask for FOLL_WRITE, even if it
doesn't have intend to write to the page?

That's news to me.

Or did I misunderstand you?

-- 
 Kirill A. Shutemov
