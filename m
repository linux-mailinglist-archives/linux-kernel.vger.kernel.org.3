Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EF75ADE3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 05:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238015AbiIFDzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 23:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233083AbiIFDzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 23:55:06 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C131403D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 20:54:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EA0E21F8F5;
        Tue,  6 Sep 2022 03:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662436493; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSRahjjgGZuy7SAGmGAziVDOy+dePLJGxm+nbGz1xQs=;
        b=0r2him/7A7lO2AaP2zJRSEqXLj6qDVz+jhQSLrH9rWMFZYjB1GBsYe6CcP5EeJjGVd6QpG
        TV1dbupG79lcAAnW1hxQtuvqJESwvesnHunQuwjWDbDDkMEQhUSRkDHsOeojFudnDAR3oP
        QGfciLYON15UP7iv82WKX2i/gzvdUyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662436493;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wSRahjjgGZuy7SAGmGAziVDOy+dePLJGxm+nbGz1xQs=;
        b=Jv/sE0gzGBvf5gnCz0Nvl9mSkO7T5doUVrR4k8V+4vkyjyqiKr8fzDb1FsLmg6z+wSTLRh
        cgvwFDF7Bgv2JUBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5798B13A19;
        Tue,  6 Sep 2022 03:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ho7ZEo3EFmNWbwAAMHmgww
        (envelope-from <osalvador@suse.de>); Tue, 06 Sep 2022 03:54:53 +0000
Date:   Tue, 6 Sep 2022 05:54:51 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v2 1/3] lib/stackdepot: Add a refcount field in
 stack_record
Message-ID: <YxbEi7A3e+y5qNwY@localhost.localdomain>
References: <20220905031012.4450-1-osalvador@suse.de>
 <20220905031012.4450-2-osalvador@suse.de>
 <CA+fCnZcNr2JeCkTF=uCxjPCJKFi_d1chv0tjubvMisUdQtCeRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZcNr2JeCkTF=uCxjPCJKFi_d1chv0tjubvMisUdQtCeRw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2022 at 10:57:20PM +0200, Andrey Konovalov wrote:
> On Mon, Sep 5, 2022 at 5:10 AM Oscar Salvador <osalvador@suse.de> wrote:
> > +enum stack_depot_action {
> > +       STACK_DEPOT_ACTION_NONE,
> > +       STACK_DEPOT_ACTION_COUNT,
> > +};
> 
> Hi Oscar,

Hi Andrey

> Why do we need these actions? Why not just increment the refcount on
> each stack trace save?

Let me try to explain it.

Back in RFC, there were no actions and the refcount
was incremented/decremented in __set_page_ownwer()
and __reset_page_owner() functions.

This lead to a performance "problem", where you would
look for the stack twice, one when save it
and one when increment it.

We figured we could do better and, at least, for the __set_page_owner()
we could look just once for the stacktrace when calling __stack_depot_save,
and increment it directly there.

We cannot do that for __reset_page_owner(), because the stack we are
saving is the freeing stacktrace, and we are not interested in that.
That is why __reset_page_owner() does:

 <---
 depot_stack_handle_t alloc_handle;

 ...
 alloc_handle = page_owner->handle;
 handle = save_stack(GFP_NOWAIT | __GFP_NOWARN, STACK_DEPOT_ACTION_NONE);
 page_owner->free_handle = handle
 stack_depot_dec_count(alloc_handle);
 --->

alloc_handle contains the handle for the allocation stacktrace, which was set
in __set_page_owner(), and page_owner->free handle contains the handle for the
freeing stacktrace.
But we are only interested in the allocation stack and we only want to increment/decrement
that on allocation/free.


> Could you split out the stack depot and the page_owner changes into
> separate patches?

I could, I am not sure if it would make the review any easier though,
as you could not match stackdepot <-> page_owner changes.

And we should be adding a bunch of code that would not be used till later on.
But I can try it out if there is a strong opinion.

thanks for your time!


-- 
Oscar Salvador
SUSE Labs
