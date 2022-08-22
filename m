Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8459BA06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbiHVHIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 03:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiHVHIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 03:08:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D35513D5F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 00:08:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4B4CF33E10;
        Mon, 22 Aug 2022 07:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661152123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NA0kLecKkbEPuy+QziXKxLugfBAhixGPNsxIPQUKjGI=;
        b=kSpDNWZgJw9yZTi2McPVhwPWreQnHY5cQwBre6r6eFLvm8dSmq+mEDVSYaqsS/D8qOmZX3
        +phgH4Bhdk6ki0dllOoNJ0SD3nACn+3ODSxmQLQse4qjV9ouRF0Xk/lZNEAtzXwX0Gxv0X
        SpJgjITa4gv9mXJJ9nvjZfaXoZZfCl8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 274A513523;
        Mon, 22 Aug 2022 07:08:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EkXSBnsrA2OfGQAAMHmgww
        (envelope-from <mhocko@suse.com>); Mon, 22 Aug 2022 07:08:43 +0000
Date:   Mon, 22 Aug 2022 09:08:42 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     lizhe.67@bytedance.com
Cc:     Jason@zx2c4.com, akpm@linux-foundation.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, mark-pk.tsai@mediatek.com,
        mhiramat@kernel.org, rostedt@goodmis.org, vbabka@suse.cz,
        yuanzhu@bytedance.com
Subject: Re: [PATCH] page_ext: move up page_ext_init() to catch early page
 allocation if DEFERRED_STRUCT_PAGE_INIT is n
Message-ID: <YwMresZeGmEA6qZP@dhcp22.suse.cz>
References: <Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz>
 <20220820010257.11488-1-lizhe.67@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820010257.11488-1-lizhe.67@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 20-08-22 09:02:57, lizhe.67@bytedance.com wrote:
> On 2022-08-18 7:36 UTC, mhocko@suse.com wrote:
> >> From: Li Zhe <lizhe.67@bytedance.com>
> >> 
> >> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
> >> we call page_ext_init() after page_alloc_init_late() to avoid some panic
> >> problem. It seems that we cannot track early page allocations in current
> >> kernel even if page structure has been initialized early.
> >> 
> >> This patch move up page_ext_init() to catch early page allocations when
> >> DEFERRED_STRUCT_PAGE_INIT is n. After this patch, we only need to turn
> >> DEFERRED_STRUCT_PAGE_INIT to n then we are able to analyze the early page
> >> allocations. This is useful especially when we find that the free memory
> >> value is not the same right after different kernel booting.
> >
> >is this actually useful in practice? I mean who is going to disable
> >DEFERRED_STRUCT_PAGE_INIT and recompile the kernel for debugging early
> >allocations?
> 
> Yes it is useful. We use this method to catch the difference of early
> page allocations between two kernel.

I was not questioning the functionality itself but the way how it is
achieved. Recompiling the kernel to achieve debuggability has proven to
be really a bad approach historically. Most people are using
pre-compiled kernels these days.

> > I do see how debugging those early allocations might be useful but that
> > would require a boot time option to be practical IMHO. Would it make
> > sense to add a early_page_ext parameter which would essentially disable
> > the deferred ipage initialization. That should be quite trivial to
> > achieve (just hook into defer_init AFAICS).
> 
> It is a good idea. A cmdline parameter is a flexible and dynamic method for
> us to decide whether to defer page's and page_ext's initilization. For
> comparison, this patch provides a static method to decide whether to defer
> page's and page_ext's initilization. They are not conflicting. My next
> work is trying to achieve your idea.

They are not conflicting but this patch adds ifdefs and additional code
that needs compile time testing with different options set. I.e. it adds
maintenance burden for something that can be achieved by better means.
So if you are ok to work on the runtime knob then I would propose to
drop this patch from the mm tree and replace it by a trivial patch to
allow early boot debugging by a cmd line parameter.
-- 
Michal Hocko
SUSE Labs
