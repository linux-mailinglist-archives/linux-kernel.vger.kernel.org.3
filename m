Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15090510AF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 23:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355238AbiDZVJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 17:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243506AbiDZVJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 17:09:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2616D4D6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 14:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3E1C9CE2192
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 21:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436CFC385A4;
        Tue, 26 Apr 2022 21:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1651007202;
        bh=d4vNieU9C1R0ukFjOzDog7Jl8A2oEUBzKVDoPNTk3nM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AXxJUn48WsZtYjaYH0DI8pHLDlx7PBvGooyg/6vOF38p1y+7q1zK+T7jRi3mLFiGa
         KdEp1mW7w514E4UPK26+Bm+gp7OHsUr65lEFgt+a0ENPg6Gzks5Iqqzrp3ueHC14rF
         LEiUkPPhvZzEkEGXIGeVTbve4XAKCs7oOKmxqqjg=
Date:   Tue, 26 Apr 2022 14:06:41 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wan Jiabing <wanjiabing@vivo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH] mm/filemap: Fix NULL pointer dereference in
 pagecache_get_page
Message-Id: <20220426140641.cc78a429e1fa32ed0e15520b@linux-foundation.org>
In-Reply-To: <YmfgqKcMmstgfz+0@casper.infradead.org>
References: <20220426082549.590899-1-wanjiabing@vivo.com>
        <YmfgqKcMmstgfz+0@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022 13:08:08 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Apr 26, 2022 at 04:25:48PM +0800, Wan Jiabing wrote:
> > Fix following coccicheck error:
> > mm/folio-compat.c:128:17-21: ERROR: folio is NULL but dereferenced.
> >  	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
> > -	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
> > +	if (!folio)
> > +		return NULL;
> > +	if ((fgp_flags & FGP_HEAD) || xa_is_value(folio))
> >  		return &folio->page;
> 
> That doesn't dereference the folio.  Coccicheck is wrong.

Doing

		return &(0->page);

is a rather obscure way of doing `return NULL;'.

I agree the patch doesn't fix anything, but it results in saner-looking code?
