Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3688C5B12F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiIHDcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIHDce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:32:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35E4C7BA3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 20:32:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9255D220BE;
        Thu,  8 Sep 2022 03:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662607951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oM/TdedenIQlQuKX4DHi/gp9jbEY2MeF287tY+t0mjE=;
        b=ib26AO1UtuXU3zm1beeP/PcV2lOp1JPiRStd5b3gTXbYMElNoEQF0+tkeEbfEUot/6eXap
        eVQ+d3pJS2yxNd1FxeJI74GN8hRSRZiedcIUpuY7a0zI+lODeJYRP7bo45w1s9aPk783At
        BLv8Ym4Khe/xZfKB1qkD6jqzmWEyk+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662607951;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oM/TdedenIQlQuKX4DHi/gp9jbEY2MeF287tY+t0mjE=;
        b=1nFbNex9kfeqeYo+0+xVd9B/TQRuiEe5S7hMOSaDRy0qArfR9zFUsnRkukAk4dqdu1hd/i
        9xyXZTgxHDOFKVBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0CAF1348C;
        Thu,  8 Sep 2022 03:32:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bT8OOE5iGWP1BgAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 08 Sep 2022 03:32:30 +0000
Date:   Thu, 8 Sep 2022 05:32:28 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Marco Elver <elver@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 2/3] mm, page_owner: Add page_owner_stacks file to
 print out only stacks and their counter
Message-ID: <YxliTBGU/gEzLr+S@localhost.localdomain>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-3-osalvador@suse.de>
 <YxXyThZanSl3wboo@elver.google.com>
 <Yxb6PiwBDVuCOp1Q@localhost.localdomain>
 <CANpmjNMNxsoyBqR4U8ybP1ZzNGfkFDcZYJfpiv73wgD=xi6TDA@mail.gmail.com>
 <YxgXd0Z+cqRk7Y7U@localhost.localdomain>
 <CANpmjNNn0cSpszRJyeF9_ogER9m859MYh745bqOr1DLEp7kibQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNn0cSpszRJyeF9_ogER9m859MYh745bqOr1DLEp7kibQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 09:14:35AM +0200, Marco Elver wrote:
> Why are you casting a stack_record** to a stack_record*? stack_table
> is already appropriately typed, and there should be no need to cast
> things around.
> 
> 'stacks' is supposed to be the bucket? In which case you need to
> dereference it to get the first entry in the bucket: bucket =
> stack_table[table_i];
> 
> stack_i cannot be used to index into the bucket, because the elements
> in it are a linked list and not necessarily adjacent in memory. You
> have to traverse the linked list stack_i elements to get to the start:

Yea, I figured that much after thinking about more, but I was overly
eager.

>   for (int i = 0; stack && i < stack_i; stack = stack->next, ++i);

But this seems suboptimal.
With this code, we have to walk the list till we find the right index
every time we enter the function, while the actual code of v2
or even the patch from v1 [1], we do not really need to do that
because we already have the pointer to the stack.

So I much rather prefer that, than having to traverse the stacks
till the find the right one.



-- 
Oscar Salvador
SUSE Labs
