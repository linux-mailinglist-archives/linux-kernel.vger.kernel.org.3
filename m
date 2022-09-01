Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53465A9232
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233568AbiIAIiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiIAIiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:38:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61FA126DE2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:38:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5E08B1FB58;
        Thu,  1 Sep 2022 08:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1662021489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NrHpzMz41QmduVOHpV9GnZB1kYyiHKDCqktpestefcU=;
        b=tZeFnsBgvZN6JzMwErJ11ohD5yGPe2CJTezUP6foJPfV4OKUBAAU3RcJOFpSRn4MkMiJQc
        8+7Hrgyh2hI/kyJ0UrL1nq0SjQtoKssxX57d+GfLKyXlmgqWx9iJ53yHizE/g3NBBrE9Cu
        tEuPLNok/zsJdO1eqZdb0nz3tVEor2c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C1D713A79;
        Thu,  1 Sep 2022 08:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KlFtDHFvEGPpNwAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 01 Sep 2022 08:38:09 +0000
Date:   Thu, 1 Sep 2022 10:38:08 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Marco Elver <elver@google.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/3] lib/stackdepot: Add a refcount field in stack_record
Message-ID: <YxBvcDFSsLqn3i87@dhcp22.suse.cz>
References: <20220901044249.4624-1-osalvador@suse.de>
 <20220901044249.4624-2-osalvador@suse.de>
 <YxBsWu36eqUw03Dy@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxBsWu36eqUw03Dy@elver.google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01-09-22 10:24:58, Marco Elver wrote:
> On Thu, Sep 01, 2022 at 06:42AM +0200, Oscar Salvador wrote:
[...]
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index 5ca0d086ef4a..aeb59d3557e2 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -63,6 +63,7 @@ struct stack_record {
> >  	u32 hash;			/* Hash in the hastable */
> >  	u32 size;			/* Number of frames in the stack */
> >  	union handle_parts handle;
> > +	refcount_t count;		/* Number of the same repeated stacks */
> 
> This will increase stack_record size for every user, even if they don't
> care about the count.

Couldn't this be used for garbage collection?
-- 
Michal Hocko
SUSE Labs
