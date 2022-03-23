Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE6844E54F0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 16:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245037AbiCWPNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 11:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbiCWPNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 11:13:21 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1CAE03D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mbYKYLyioxmza+e6kvwBLRa+wBIGtShUFd+o0R6xiJk=; b=r/jOVR6MXN/nWXyZ48Dv3k4bvG
        ilab5Md7xTipHLs97i2tJVNYIUv/657Y21wb82u6qTibtgVu7+yCvdoL2nxomXv9Z4UxHucGsmTxh
        4LRecorV9C2zwyVYV4vACW8YS5JQuo26kRmYLS5SA4Qxsk2lj4LtvuksYQwUzsmnCsoBz/25yUP2W
        7zV//YSFNTnBlaSr3mZodcH4WesAJdXlGJFOSPXpmN4rBhqgq5ddk1DCrPZfgUOCQ80e3n+F2IYCH
        DG+CuJA2O23DrmkrVrDqjantyZx+XGk3+86cTFGvGiB1mpPYf44enzE/O8HvzWpCAtuIt+ToXbRNF
        RE7EZjOA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nX2e5-00Ccu6-3N; Wed, 23 Mar 2022 15:11:33 +0000
Date:   Wed, 23 Mar 2022 15:11:33 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v6 27/39] kasan, mm: only define ___GFP_SKIP_KASAN_POISON
 with HW_TAGS
Message-ID: <Yjs4pSGr/h9ChCQ3@casper.infradead.org>
References: <cover.1643047180.git.andreyknvl@google.com>
 <44e5738a584c11801b2b8f1231898918efc8634a.1643047180.git.andreyknvl@google.com>
 <63704e10-18cf-9a82-cffb-052c6046ba7d@suse.cz>
 <YjsaaQo5pqmGdBaY@linutronix.de>
 <CA+fCnZeG5DbxcnER1yWkJ50605_4E1xPtgeTEsSEc89qUg4w6g@mail.gmail.com>
 <b4d598ac-006e-1de3-21e5-8afa6aea0538@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d598ac-006e-1de3-21e5-8afa6aea0538@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 02:57:30PM +0100, Vlastimil Babka wrote:
> I guess it's the simplest thing to do for now. For the future we can
> still improve and handle all combinations of kasan/lockdep to occupy as
> few bits as possible and set the shift/mask appropriately. Or consider
> first if it's necessary anyway. I don't know if we really expect at any
> point to start triggering the BUILD_BUG_ON() in radix_tree_init() and
> then only some combination of configs will reduce the flags to a number
> that works. Or is there anything else that depends on __GFP_BITS_SHIFT?

The correct long-term solution is to transition all the radix tree
users to the XArray, which has the GFP flags specified in the correct
place (ie at the call site) instead of embedding the GFP flags in the
data structure.

I've paused work on that while I work on folios; by my count there are
about 60 users left.  What I really need is something which prevents
any attempt to add new users.  Maybe that's a job for checkpatch.
