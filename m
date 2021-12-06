Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4650846A4FE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 19:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347827AbhLFS4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 13:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347732AbhLFS4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 13:56:17 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD91DC0613F8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v9emWhdzp63CN2LN1Xu2H8SaVorImjqcQXxFTzuy8e8=; b=X8cghBR2+xx7JpmVZlkV8diiAn
        Wr84pAFAzFenaKjtyg8iJEUS+hvDNFCh/1aOYksMpwsZiwYn5kVnCfFQvijdGShQ9ElcIh+uDVjd2
        Zq7HA7gtccteDFguLLUZA3PVtI+8gHEWomSN/GyE3RgBaODXsdXFM2MP3Pq2aBTyZh1nJTN/sNvD6
        cNiRzRIKzabDrfLhOFMCpY82SgzSeVgk+wYCa67xQu+lbDjUWlAPtdrNhygPiuUEiwh8xD/JjFuRb
        N/WRQKxsy9kAUxjw512iqtftoZbE3UxeH8EvH6iJqZSRAlOyLcNacI7DjJb+0PViv8LmCpWiZDw6M
        Tj9m9kSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muJ6C-005mVu-57; Mon, 06 Dec 2021 18:52:28 +0000
Date:   Mon, 6 Dec 2021 18:52:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org,
        rientjes@google.com, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 1/2] mm: protect free_pgtables with mmap_lock write
 lock in exit_mmap
Message-ID: <Ya5b7NEKGr57rKh3@casper.infradead.org>
References: <20211124235906.14437-1-surenb@google.com>
 <YaS4KxCSLK+02xaF@dhcp22.suse.cz>
 <CAJuCfpEZi=4V7=nD-4gWi=QyQ8-=ezwmx80twndtoPpZSCzEGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpEZi=4V7=nD-4gWi=QyQ8-=ezwmx80twndtoPpZSCzEGQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 10:35:03AM -0800, Suren Baghdasaryan wrote:
> > Other than that looks OK to me. Maybe we want to add an explicit note
> > that vm_ops::close cannot take mmap_sem in any form. The changelog
> > should also mention that you have considered remove_vma and its previous
> > no MM locking assumption. You can argue that fput is async and close
> > callback shouldn't really need mmap_sem.
> 
> Should I post another version of this patch with the patch description
> clarifying these points and additional comments as you suggested?

fyi, vm_ops->close() is already called with the mmap_sem held for write
in __split_vma().  If that needs to be documented, it's a separate patch
because it's absolutely not a consequence of this patch.
