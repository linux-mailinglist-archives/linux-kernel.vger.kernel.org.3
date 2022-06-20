Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126B255219D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbiFTPwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiFTPw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:52:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A3B1C92D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 08:52:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 62C9E21B2F;
        Mon, 20 Jun 2022 15:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655740345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sFrNkLmQVBsGTGEriUNS1o9LyiWXjD8lzDz4B1bsy88=;
        b=YFpq/JaHRz/KiQ66fsfPnEdadgkqCr/nFcyYc/rUA+kGODkLqt6kbfJJyNVH7oSzBM+H7O
        9guLocjbacZqamk8a+W9u/zk8KEJ2nrLCp7QD9kJpss9+JZ2dx8hptcI9AvXByZGExX9Qc
        0eRhzDwoWAvvyCpI7Cb0tTPWihXh344=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EFBEB2C141;
        Mon, 20 Jun 2022 15:52:24 +0000 (UTC)
Date:   Mon, 20 Jun 2022 17:52:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, pmladek@suse.com,
        rostedt@goodmis.org, enozhatsky@chromium.org,
        linux@rasmusvillemoes.dk, willy@infradead.org
Subject: Re: [PATCH v4 24/34] mm/memcontrol.c: Convert to printbuf
Message-ID: <YrCXuNOEUEGiR6Gp@dhcp22.suse.cz>
References: <20220620004233.3805-1-kent.overstreet@gmail.com>
 <20220620004233.3805-25-kent.overstreet@gmail.com>
 <YrBcFLpvvfJOnhGO@dhcp22.suse.cz>
 <20220620151356.gxmpv3wceg3kn4k2@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220620151356.gxmpv3wceg3kn4k2@moria.home.lan>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-06-22 11:13:56, Kent Overstreet wrote:
> On Mon, Jun 20, 2022 at 01:37:56PM +0200, Michal Hocko wrote:
> > On Sun 19-06-22 20:42:23, Kent Overstreet wrote:
> > > This converts memory_stat_format() from seq_buf to printbuf. Printbuf is
> > > simalar to seq_buf except that it heap allocates the string buffer:
> > > here, we were already heap allocating the buffer with kmalloc() so the
> > > conversion is trivial.
> > > 
> > > Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> > 
> > I have asked for a justification two times already not hearing anything.
> > Please drop this patch. I do not see any actual advantage of the
> > conversion. The primary downside of the existing code is that an
> > internal buffer is exposed to the caller which is error prone and ugly.
> > The conversion doesn't really address that part.
> 
> Do you want to tone down the hostility? Yeesh.

I have merely pointed out you have ignored my review feedback _twice_
already. Ignoring the review feedback and posting new versions without
questions being addressed is wasting other people's time.

> This patch is part of a wider series that deletes seq_buf, if you missed it here
> you go: https://lore.kernel.org/all/20220620004233.3805-1-kent.overstreet@gmail.com/

Each patch should have its justification. If the reasoning is that
seq_buf is going away then I can live with that. That is not obvious
from this patch which I care about because it falls into area I maintain
and review. Unlike the rest of the large patchset which I do not really
have time to review in its entirety.

> > Moreover there is an inconsistency between failrure case where the
> > printbuf is destroyed by a docummented way (printbuf_exit) and when the
> > caller frees the buffer directly. If printbuf_exit evers need to do more
> > than just kfree (e.g. kvfree) then this is a subtle bug hard to find.
> 
> Ok, _that's_ a technical point we can talk about and address. I'll add
> documentation to the printbuf code that the buffer must be freeable with
> kfree().

Hmm, wouldn't that be just too restrictive without any good reasons?
Maybe there are no seq_buf users currently but if there ever raises a
need for larger buffers then you might want to use kvmalloc for the
allocation and you will need to change all users to use kvfree
(potentially missing some). You could either start requiring kvfree
since the beginning or get rid of exposing internal buffer altogether
and use printbuf_exit in all cases.
-- 
Michal Hocko
SUSE Labs
