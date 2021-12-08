Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67B7546DD4D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 21:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbhLHU7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 15:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbhLHU7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 15:59:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0305C0617A1;
        Wed,  8 Dec 2021 12:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e0av1DdKA6IByIYuV+WI1PzAoi3CS3Y42D0EdbIPCFg=; b=B17zQy3eOMQUrtOqIvyWjTYkyD
        WhO0NiNydB0Yv/mnFL0JDLzbrFCtUcgZRkW8qaryNOlYCmkGgHUC2Gf9QsD2ez97s6NVbFlPQ9t1F
        +7KWPnmaCC4ptLOJmjkIq/hR7/NtGJny7xm6sT8sAVRJNtYyig9Vq2lzS/XY+0XikkDft0f8YUQ0c
        KLjcPOIRVTJRmOOp9262pbqzLIDe/wvwTyOKptwnSCw8ZJAd2AcyUwo6OlCi3ikuYhrMkZm1ru9NM
        1orRSuMM/E6If5PQVhS3EBRjKLZnwunz83ynVfmSpGz78GEiw5KNmsGdZk551Kj5qIhVhgtmeR+CF
        bpfVQVcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv3yJ-008ldr-8j; Wed, 08 Dec 2021 20:55:27 +0000
Date:   Wed, 8 Dec 2021 20:55:27 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-m68k@lists.linux-m68k.org, anshuman.khandual@arm.com,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        mike.kravetz@oracle.com, vbabka@suse.cz, geert@linux-m68k.org,
        schmitzmic@gmail.com, rostedt@goodmis.org, mingo@redhat.com,
        hannes@cmpxchg.org, guro@fb.com, songmuchun@bytedance.com,
        weixugc@google.com, gthelen@google.com, rientjes@google.com,
        pjt@google.com
Subject: Re: [PATCH 01/10] mm: page_ref_add_unless() does not trace 'u'
 argument
Message-ID: <YbEbvwU81QKK/wUu@casper.infradead.org>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
 <20211208203544.2297121-2-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208203544.2297121-2-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 08:35:35PM +0000, Pasha Tatashin wrote:
> In other page_ref_* functions all arguments and returns are traced, but
> in page_ref_add_unless the 'u' argument which stands for unless boolean
> is not traced. However, what is more confusing is that in the tracing
> routine:
> 	__page_ref_mod_unless(struct page *page, int v, int u);
> 
> The 'u' argument present, but instead a return value is passed into
> this argument.
> 
> Add a new template specific for page_ref_add_unless(), and trace all
> arguments and the return value.

The special casing of '1' for device pages is going away, so NAK
to this user-visible change.
