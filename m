Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AAE14C7AF8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 21:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiB1UuN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 15:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiB1UuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 15:50:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55876C970
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 12:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qpQ/kpbf1GOpHDn6LLoilwm/c0J2gkjnAf3qAZ1Z3Yw=; b=uvVQGeVCP5RVFIraAvp5Jlap8q
        Yd9nzeyRvG3UP22VgcqwfVGiw99QIWnnELJ6igO1X3GuyTdHM+M3qxuhyiMCCMqol/igSkyvcd+gC
        wpc9LQ4wgQnvUR+n34ov0s8icMHKYzjE6aNKiaasueXfjbPKKhsTHsUZnmC11IOXyLW/hTEDD8Bas
        VoOoq/JiFRNPOJ2SaIq0OM95JqhoAKf0Gef+KPzIbTMtAXkwGVeOPQVK4LpdlEGDXR5WheFYZMezh
        nv8/jQk+hI77nLYM7mbCYyJmXGuvvUt5b3qdjnlNvJU8RBJF1ILqDpz71G/VQ9RQpkryzyDCyOmdg
        1u13vNdg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOmxU-008u4L-3v; Mon, 28 Feb 2022 20:49:28 +0000
Date:   Mon, 28 Feb 2022 20:49:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH next] mm/migrate: fix remove_migration_pte() of hugetlb
 entry
Message-ID: <Yh01WH6CdHjpUFkZ@casper.infradead.org>
References: <bd28ebcf-4d42-7184-8189-ffed6fe7d4dc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd28ebcf-4d42-7184-8189-ffed6fe7d4dc@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 26, 2022 at 06:25:15PM -0800, Hugh Dickins wrote:
> -		if (!folio_test_ksm(folio))
> +		/* Skip call in common case, plus .pgoff is invalid for KSM */
> +		if (pvmw.nr_pages != 1 && !folio_test_hugetlb(folio))
>  			idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;

How do you feel about this instead?

-               if (!folio_test_ksm(folio))
+               /* pgoff is invalid for ksm pages, but they are never large */
+               if (folio_test_large(folio) && !folio_test_hugetlb(folio))
                        idx = linear_page_index(vma, pvmw.address) - pvmw.pgoff;

