Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9574A499C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241762AbiAaOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242023AbiAaOpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:45:07 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A669AC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 06:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S37hV5LKYMZr1FwdKbRBbnns+EHid9XjyHNmHg+zn0s=; b=T67AodPbh6KjEXf58AyRu2Mb9k
        Ja+cbgWubfMKArkw4GvrZ9bhtm5QFzrcusJg2M5hdW7/TnNDHDIFDLnXqo/zlv0o7+vNa0MEXbKbV
        gn0Kbzbm3yfdMO4sXhjpVlYY2kNCCE0FBRaaTRQThzFifyvARd8MrOTtiG0e7wGpBRB9VG1F/kccB
        0pmOEDERa1yMdETLCBl4+fBNvBd7wk/RLUXDpj46b4ppYCyVgv72Q2Vq38p6BURmRfm9/VGKQeXhQ
        /LVSXR00CgQL++0RFinoAjEtt/cPws6pjPE0lDzE5BiqQsMTfmCNc32hjC4E/1QWLsgQ9Cnl2teoP
        zNZWi0cw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEXvL-009z9U-6c; Mon, 31 Jan 2022 14:44:55 +0000
Date:   Mon, 31 Jan 2022 14:44:55 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Michel Lespinasse <michel@lespinasse.org>
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 12/35] mm: separate mmap locked assertion from find_vma
Message-ID: <Yff152H3FFVdQBfy@casper.infradead.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
 <20220128131006.67712-13-michel@lespinasse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128131006.67712-13-michel@lespinasse.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 05:09:43AM -0800, Michel Lespinasse wrote:
> This adds a new __find_vma() function, which implements find_vma minus
> the mmap_assert_locked() assertion.
> 
> find_vma() is then implemented as an inline wrapper around __find_vma().

You might like to take inspiration from the maple tree patches
where we assert that either the RCU lock is held or the mmap_lock
is held.
