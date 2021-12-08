Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC446DD6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 22:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237016AbhLHVJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 16:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236037AbhLHVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 16:09:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFE7C061746;
        Wed,  8 Dec 2021 13:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wfGVR1ugfio80qHoYgFooKwxEA1hyJqmhObGUGLGdRE=; b=UHZb5D0rSPlga3rU/aoFkgxwfm
        im90IK2Z4as9B2kR5tsM0/ra1inVpb/52HzgHG6V0SkTxcTKx0ZTNEhW8XqHc2y89ukIEoDSBwCUF
        hcz+NXC/+v8r31pITytHSwuiWArFaK9m0TZGR9ODnJihHq2csZDs67WX0xpR1nVX0MolGODYryzOa
        YL2lGIPuQBwCRgupLLzGTzRUXIhmQ601+QR1AoO1v7ahUGhOAlMsthaH3/C0hHEBA6F4kzj2SY0W2
        1lTZtYPtsesv7rRnh8abfRwys38i6FHDuA/p/N0QiSVQEjuuL1xCU7bDPblvteXyt8S9RiNk91ZFz
        MVt0GH1w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mv48I-008m0q-Kr; Wed, 08 Dec 2021 21:05:46 +0000
Date:   Wed, 8 Dec 2021 21:05:46 +0000
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
Subject: Re: [PATCH 00/10] Hardening page _refcount
Message-ID: <YbEeKiatjGoCD6Yi@casper.infradead.org>
References: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208203544.2297121-1-pasha.tatashin@soleen.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 08:35:34PM +0000, Pasha Tatashin wrote:
> It is hard to root cause _refcount problems, because they usually
> manifest after the damage has occurred.  Yet, they can lead to
> catastrophic failures such memory corruptions. There were a number
> of refcount related issues discovered recently [1], [2], [3].
> 
> Improve debugability by adding more checks that ensure that
> page->_refcount never turns negative (i.e. double free does not
> happen, or free after freeze etc).
> 
> - Check for overflow and underflow right from the functions that
>   modify _refcount
> - Remove set_page_count(), so we do not unconditionally overwrite
>   _refcount with an unrestrained value
> - Trace return values in all functions that modify _refcount

You're doing a lot more atomic instructions with these patches.  Have you
done any performance measurements with these patches applied and debug
disabled?  I'm really not convinced it's worth closing
one-instruction-wide races of this kind when they are "shouldn't ever
happen" situations.  If the debugging will catch the problem in 99.99%
of cases and miss 0.01% without using atomic instructions, that seems
like a better set of tradeoffs than catching 100% of problems by using
the atomic instructions.
