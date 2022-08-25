Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B195A08D5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 08:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbiHYG14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 02:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHYG1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 02:27:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437439F77C;
        Wed, 24 Aug 2022 23:27:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F1F205C825;
        Thu, 25 Aug 2022 06:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1661408873; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0spxPtpuY4nMM9lIZ8wJ8lR+BxR1fXRkfAOF1d5glCI=;
        b=eq/4tfrvxgvx73IX4ZqhksV9e/s3wS8AVykgXRb7pBPsKA4slFdbEyupVAc1d9czG9R3ZE
        BCB3DiYpY7h9NYjSnG8XdYVLhzSjt4V01q5kNiiFB0qUvA0Zk3Y30HvAyWW7Am7WEC4Nbi
        dxP6HrKPqeuZvUS6KKdQ0KCOaapCA0g=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB50813A89;
        Thu, 25 Aug 2022 06:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3hX5LmgWB2N/NwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 25 Aug 2022 06:27:52 +0000
Date:   Thu, 25 Aug 2022 08:27:52 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     lizhe.67@bytedance.com
Cc:     Jason@zx2c4.com, akpm@linux-foundation.org, corbet@lwn.net,
        keescook@chromium.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lizefan.x@bytedance.com, mark-pk.tsai@mediatek.com,
        mhiramat@kernel.org, rostedt@goodmis.org, vbabka@suse.cz,
        yuanzhu@bytedance.com
Subject: Re: [PATCH v2] page_ext: introduce boot parameter 'early_page_ext'
Message-ID: <YwcWaO1Z5pSRRokc@dhcp22.suse.cz>
References: <YwXczj8Dh0uI0EA9@dhcp22.suse.cz>
 <20220825062129.92091-1-lizhe.67@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825062129.92091-1-lizhe.67@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25-08-22 14:21:29, lizhe.67@bytedance.com wrote:
> On 2022-08-24 8:09 UTC, mhocko@suse.com wrote:
[...]
> >> diff --git a/init/main.c b/init/main.c
> >> index 91642a4e69be..3760c0326525 100644
> >> --- a/init/main.c
> >> +++ b/init/main.c
> >> @@ -849,6 +849,8 @@ static void __init mm_init(void)
> >>  	pgtable_init();
> >>  	debug_objects_mem_init();
> >>  	vmalloc_init();
> >> +	/* Should be run after vmap initialization */
> >> +	page_ext_init(true);
> >
> >you can just 
> >	if (early_page_ext)
> >		page_ext_init();
> >
> >>  	/* Should be run before the first non-init thread is created */
> >>  	init_espfix_bsp();
> >>  	/* Should be run after espfix64 is set up. */
> >> @@ -1606,7 +1608,7 @@ static noinline void __init kernel_init_freeable(void)
> >>  	padata_init();
> >>  	page_alloc_init_late();
> >>  	/* Initialize page ext after all struct pages are initialized. */
> >> -	page_ext_init();
> >> +	page_ext_init(false);
> >
> >	if (!early_page_ext)
> >		page_ext_init();
> 
> I think we can use an inline function instead of 'early_page_ext' here. The
> reason is that if CONFIG_PAGE_EXTENSION=n, 'early_page_ext' is undefined.
> Thought we can #define early_page_ext as false, it is ugly.

Agreed!

-- 
Michal Hocko
SUSE Labs
