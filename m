Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F204D731B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 07:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbiCMGZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 01:25:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbiCMGZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 01:25:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6451642A;
        Sat, 12 Mar 2022 22:23:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EE8C60F1C;
        Sun, 13 Mar 2022 06:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B1BC340F3;
        Sun, 13 Mar 2022 06:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1647152632;
        bh=r5ve3QQqDztmWSyNqt57pEYrCXV23g3Xex3BHLDSgQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W9tERT6YvLQm6gvnCZbmJtXcLrBMD4jj5tWre40pwg48xvw0Bd7Ioe/L9XpA76+4N
         aDH/1GZidcyjB1POUFkZ6ChGABFbkE2wqJCNwNwrFRQnCtX829mj2zX9YRiGcpYn0O
         LonVH573IL59gJhV6OXdmdoGZpSgOgV+1fRSt78U=
Date:   Sat, 12 Mar 2022 22:23:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-nilfs <linux-nilfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: nilfs: WARNING: CPU: 2 PID: 1510 at
 include/linux/backing-dev.h:269 __folio_mark_dirty+0x31d/0x3b0
Message-Id: <20220312222351.89844f74d3cf10212f308caf@linux-foundation.org>
In-Reply-To: <CAKFNMonQtBe=pjrUuACqzKL36RTWmvoULwzD9NCP7PET8B73bQ@mail.gmail.com>
References: <9a20b33d-b38f-b4a2-4742-c1eb5b8e4d6c@redhat.com>
        <YivTnPMUpvX8ivpj@casper.infradead.org>
        <CAKFNMonQtBe=pjrUuACqzKL36RTWmvoULwzD9NCP7PET8B73bQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Mar 2022 15:09:27 +0900 Ryusuke Konishi <konishi.ryusuke@gmail.com> wrote:

> Hi Matthew, and Andrew,
> 
> On Sat, Mar 12, 2022 at 7:56 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Mar 11, 2022 at 08:43:57PM +0100, David Hildenbrand wrote:
> > > Hi,
> > >
> > > playing with swapfiles on random file systems, I stumbled over the
> > > following nilfs issue (and reproduced it on latest greatest
> > > linux/master -- v5.17-rc7+). I did not try finding out when this
> > > was introduced and I did not run into this issue on other file
> > > systems I tried.
> >
> > It's a known bug in NILFS, and I think yours is the fifth report
> > of it dating back eight months.
> 
> The root cause of this issue is that NILFS uses two page caches
> per inode, one for data blocks and another for b-tree node blocks.
> 
> Even though __folio_end_writeback(), __folio_start_writeback(), and
> __folio_mark_dirty() acquire lock for mapping->i_pages,
> inode_to_wb(inode) inside them performs lockdep test for the former one
> (i.e. inode->i_mapping->i_pages.xa_lock).
> 
> So, mark_buffer_dirty(), end_page_writeback(), and set_page_writeback()
> for pages in the latter NILFS specific page cache hit the LOCKDEP warning.
> 
> I tried to find a way to  resolve this, but have no good idea so far.

If things are set up appropriately, inode_to_wb() should be able to
test inode->i_mapping->host->i_mapping->i_pages.xa_lock and get the
desired result.

At least, that's the case with blockdevs.  I don't know if nilfs2 sets
things up that way.

