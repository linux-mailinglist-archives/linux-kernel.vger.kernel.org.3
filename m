Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888C6496940
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 02:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiAVBlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 20:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiAVBls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 20:41:48 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB31AC06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=isIBTVsbnY0YR1Hkp92U+P4zi+XpFnHNGT0viRKHgoM=; b=ccKWQZ6hZ3WawGbvA0hGzH0jS2
        g5hOl2KZ8PUgvE898zYzuEAL/DOAy//YF6HcthkOOuibrRXePDzvD9QkmmknFWLiq2ha3OARL5mQl
        mtaf6o1JikOiIG/xhXvvPfd+/KykwXo+uFX37jLKxu3Tu93bpsZpeS+fgGkWdrjQjKjxBaFqm9ANQ
        o0Xqm0JjhYDZ/Czlc31jYpJL0EQvtz4HE/YzeCLlvRWkPdagQQdAcsKNuh9fEfmxDaS1JVEr47bqk
        9oPVGLW7QtwR2S2ufRVZxmRaDketS8ztJcrUoTpIBffnQXO1c/S/HbDHHwjDPNyEM3a0r+mGeTcO6
        gCqoG0vw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nB5PH-00G3f5-4m; Sat, 22 Jan 2022 01:41:31 +0000
Date:   Sat, 22 Jan 2022 01:41:31 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     "Longpeng (Mike, Cloud Infrastructure Service Product Dept.)" 
        <longpeng2@huawei.com>
Cc:     Khalid Aziz <khalid.aziz@oracle.com>,
        Barry Song <21cnbao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [RFC PATCH 0/6] Add support for shared PTEs across processes
Message-ID: <Yetgy/eT+rZBgSq7@casper.infradead.org>
References: <cover.1642526745.git.khalid.aziz@oracle.com>
 <20220121010806.5607-1-21cnbao@gmail.com>
 <YeoW4CMiU8qbRFST@casper.infradead.org>
 <CAGsJ_4wv144TUSQPNOnHnmNmJrXe4Fn8d14JeAJ5ka-S+dRxRA@mail.gmail.com>
 <YerHceldiYXLk2DE@casper.infradead.org>
 <0ec88ae7-9740-835d-1f07-60bd57081fcd@oracle.com>
 <b34ded1e11154eabbce07618bf0a6676@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b34ded1e11154eabbce07618bf0a6676@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 01:39:46AM +0000, Longpeng (Mike, Cloud Infrastructure Service Product Dept.) wrote:
> > > Our use case is that we have some very large files stored on persistent
> > > memory which we want to mmap in thousands of processes.  So the first
> 
> The memory overhead of PTEs would be significantly saved if we use
> hugetlbfs in this case, but why not?

Because we want the files to be persistent across reboots.
