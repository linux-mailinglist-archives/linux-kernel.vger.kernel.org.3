Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96F152F6D2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 02:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354227AbiEUAbz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 20:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbiEUAbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 20:31:51 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCE91966A0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 17:31:50 -0700 (PDT)
Date:   Fri, 20 May 2022 17:31:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1653093108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/PvswcI13Yf4q0l94RXQB7xvET7jRmzJANLdVyC6U+A=;
        b=BZxSssMM56O+65UCUfQpz9fJkEhid3CADJGmnG88vw0ZXU6GVY5FCSTCnUZRxyQSJ9nhcC
        1kJLsZoU+x8BW/bPXcJo/CH4BMxdIIwFlZSOvK3zy/VshPgDCFgrVFx56VW9IGkMdBxAFS
        bEXLmD1vJthOX2YMbMW5txVXPs06K1s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v3 3/6] mm: shrinkers: provide shrinkers with names
Message-ID: <Yogy79yg44BX7sI1@carbon>
References: <20220509183820.573666-1-roman.gushchin@linux.dev>
 <20220509183820.573666-4-roman.gushchin@linux.dev>
 <20220520164115.oectf3x5hkwesioi@moria.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520164115.oectf3x5hkwesioi@moria.home.lan>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:41:15PM -0400, Kent Overstreet wrote:
> On Mon, May 09, 2022 at 11:38:17AM -0700, Roman Gushchin wrote:
> > diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
> > index ad9f16689419..c1f734ab86b3 100644
> > --- a/drivers/md/bcache/btree.c
> > +++ b/drivers/md/bcache/btree.c
> > @@ -812,7 +812,7 @@ int bch_btree_cache_alloc(struct cache_set *c)
> >  	c->shrink.seeks = 4;
> >  	c->shrink.batch = c->btree_pages * 2;
> >  
> > -	if (register_shrinker(&c->shrink))
> > +	if (register_shrinker(&c->shrink, "btree"))
> >  		pr_warn("bcache: %s: could not register shrinker\n",
> >  				__func__);
> 
> These drivers need better names for their shrinkers - there will often be
> multiple instances in use on a system and we need to distinguish.
> 
> Also, "btree" isn't a good name for the bcache shrinker - "bcache-%pU",
> c->set_uuid would be a good name for bcache's shrinker, it'll match up with the
> cache set directory in /sys/fs/bcache/.

Sure, will improve in the next version. Thanks!

> 
> For others (device mapper, md, etc.) there should be a minor device number you
> can reference.

Good point, will think of it.

Thank you for taking a look!
