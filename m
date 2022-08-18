Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80559597F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 09:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243651AbiHRHgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 03:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiHRHgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 03:36:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DDCA1D7C
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 00:36:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7E9C520482;
        Thu, 18 Aug 2022 07:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1660808170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yl1Pen1j6PXS4WaSSfKFxeBAgtLRMAEPu+N1R08H4mc=;
        b=aiMQ9YcgrFgtXtEGbMwuVFij2+5DgvhZ8hLT96Scd6FYtJbaAjoYA/PGzA540HPaGsdWSJ
        F3y5KaD0k2hkMviL29CbGbXeiG+2attrpveUMgTtOI4TMfOBJ2lhTfEhmNIzKfsKBy8izK
        KEzvuS4+SGG2LthQgzLXTNEyx4LFETA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 61E54139B7;
        Thu, 18 Aug 2022 07:36:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jp2oFerr/WK/VAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 18 Aug 2022 07:36:10 +0000
Date:   Thu, 18 Aug 2022 09:36:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     lizhe.67@bytedance.com
Cc:     akpm@linux-foundation.org, mhiramat@kernel.org, vbabka@suse.cz,
        keescook@chromium.org, Jason@zx2c4.com, mark-pk.tsai@mediatek.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com, yuanzhu@bytedance.com
Subject: Re: [PATCH] page_ext: move up page_ext_init() to catch early page
 allocation if DEFERRED_STRUCT_PAGE_INIT is n
Message-ID: <Yv3r6Y1vh+6AbY4+@dhcp22.suse.cz>
References: <20220815120954.65957-1-lizhe.67@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815120954.65957-1-lizhe.67@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 15-08-22 20:09:54, lizhe.67@bytedance.com wrote:
> From: Li Zhe <lizhe.67@bytedance.com>
> 
> In 'commit 2f1ee0913ce5 ("Revert "mm: use early_pfn_to_nid in page_ext_init"")',
> we call page_ext_init() after page_alloc_init_late() to avoid some panic
> problem. It seems that we cannot track early page allocations in current
> kernel even if page structure has been initialized early.
> 
> This patch move up page_ext_init() to catch early page allocations when
> DEFERRED_STRUCT_PAGE_INIT is n. After this patch, we only need to turn
> DEFERRED_STRUCT_PAGE_INIT to n then we are able to analyze the early page
> allocations. This is useful especially when we find that the free memory
> value is not the same right after different kernel booting.

is this actually useful in practice? I mean who is going to disable
DEFERRED_STRUCT_PAGE_INIT and recompile the kernel for debugging early
allocations?

I do see how debugging those early allocations might be useful but that
would require a boot time option to be practical IMHO. Would it make
sense to add a early_page_ext parameter which would essentially disable
the deferred ipage initialization. That should be quite trivial to
achieve (just hook into defer_init AFAICS).
-- 
Michal Hocko
SUSE Labs
