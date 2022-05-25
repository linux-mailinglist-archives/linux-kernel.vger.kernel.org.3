Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2894534379
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 21:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343904AbiEYTAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 15:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344080AbiEYS75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:59:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C219BA9BD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 11:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B389618F2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:59:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388D6C385B8;
        Wed, 25 May 2022 18:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1653505186;
        bh=odI4jkB20tEIxtAuX3JIawo0E45ZjVnU7zCj/mQ04hY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sojdLojMUzNi57DGiQ+9h5DL2af9LX1VlGApnwynRJFt7DaKX+7m4xs02lu+4GV39
         4kf1SroLaHv5sZ5lBDzD3HS+0Baz4ar4reA61RawAoDNdJX4Wkgyz2JGKmIWKb8UEF
         ZD6ld/W80XwZyOGe2ANxLl6LDC1JKi1NgV+MGsoU=
Date:   Wed, 25 May 2022 11:59:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     syzbot <syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in do_sync_mmap_readahead
Message-Id: <20220525115945.6256638242ee99db2a94d2e7@linux-foundation.org>
In-Reply-To: <Yo52gzYYOpU0NwDo@casper.infradead.org>
References: <0000000000008cfbca05dfd6db81@google.com>
        <20220525095842.f97b64de9cbcc0e15d1257a6@linux-foundation.org>
        <Yo5uI9w7lll5B93r@casper.infradead.org>
        <Yo52gzYYOpU0NwDo@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 19:33:39 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, May 25, 2022 at 06:57:55PM +0100, Matthew Wilcox wrote:
> > 
> > Ohh, that makes sense.  We unlocked the mmap_sem, so the file is
> > pinned, but the VMA isn't.  I'll whip up a patch.
> 
> #syz test
> 
> >From 01a4917c4cfe400eb310eba4f2fa466d381623c1 Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Wed, 25 May 2022 14:23:45 -0400
> Subject: [PATCH] mm/filemap: Cache the value of vm_flags
> 
> After we have unlocked the mmap_lock for I/O, the file is pinned, but
> the VMA is not.  Checking this flag after that can be a use-after-free.
> It's not a terribly interesting use-after-free as it can only read one
> bit, and it's used to decide whether to read 2MB or 4MB.  But it
> upsets the automated tools and it's generally bad practice anyway,
> so let's fix it.
> 
> Reported-by: syzbot+5b96d55e5b54924c77ad@syzkaller.appspotmail.com
> Fixes: 4687fdbb805a ("mm/filemap: Support VM_HUGEPAGE for file mappings")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

cc:stable also, please.


