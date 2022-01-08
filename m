Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B0A488149
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 05:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiAHEVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 23:21:50 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46086 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiAHEVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 23:21:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8C37B8248F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 04:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8856CC36AE0;
        Sat,  8 Jan 2022 04:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641615707;
        bh=9F8SZHGAQUDCatH81wxQRvcS4OWRwa7E3axfNM55X+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BiwSz/c8UgBo43mqs29QRpTUUj/h3Bq1TWnWwL/Y9t/BWxW5qxUJ0vzv5MFS/DWIH
         aQ6dkJuDSXkT0+H/xTPDaD4X8tdEctWtDq6L5ByMnFNQkJSLivdXxpa//5SIN8q9QX
         llpUiAo7n9at74GaOStpoAN5bAavLwuyPNsZ5ef9CIkZPtebrdhkaGvh74BinUoaog
         MiXzFBImolh62z45e9P/I9EeQSRQqeJy0apJXO2K3LVSA1e7OstqJNcav3rt9b6KV4
         wKaTi9Y9QUWWgxUmDQhV0DmW+b8PiW1WtILu86WlVEEmpBbX2xZqAk+F9uPIYXhVMt
         D6v9zzKVO0/fA==
Date:   Fri, 7 Jan 2022 20:21:46 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/6] f2fs: do not expose unwritten blocks to user by DIO
Message-ID: <YdkRWgvZEkRM+RSP@sol.localdomain>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-3-jaegeuk@kernel.org>
 <YdjJAS7Ua4aJEFhz@sol.localdomain>
 <YdjucBBopEDuUb5b@google.com>
 <Ydj1JvEeLo1mrqvb@sol.localdomain>
 <YdkGnA3/3f/Qka5M@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdkGnA3/3f/Qka5M@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 07:35:56PM -0800, Jaegeuk Kim wrote:
> On 01/07, Eric Biggers wrote:
> > On Fri, Jan 07, 2022 at 05:52:48PM -0800, Jaegeuk Kim wrote:
> > > On 01/07, Eric Biggers wrote:
> > > > Hi Jaegeuk,
> > > > 
> > > > On Tue, Jan 04, 2022 at 01:24:16PM -0800, Jaegeuk Kim wrote:
> > > > > DIO preallocates physical blocks before writing data, but if an error occurrs
> > > > > or power-cut happens, we can see block contents from the disk. This patch tries
> > > > > to fix it by 1) turning to buffered writes for DIO into holes, 2) truncating
> > > > > unwritten blocks from error or power-cut.
> > > > > 
> > > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > > ---
> > > > >  fs/f2fs/data.c  |  5 ++++-
> > > > >  fs/f2fs/f2fs.h  |  5 +++++
> > > > >  fs/f2fs/file.c  | 27 ++++++++++++++++++---------
> > > > >  fs/f2fs/inode.c |  8 ++++++++
> > > > >  4 files changed, 35 insertions(+), 10 deletions(-)
> > > > 
> > > > Unfortunately, this patch doesn't completely fix the uninitialized data
> > > > exposure.  The problem is that it only makes DIO writes fall back to buffered
> > > > writes for holes, and not for reserved blocks (NEW_ADDR).  f2fs's reserved
> > > > blocks are *not* the same as the unwritten extents that other filesystems have;
> > > > f2fs's reserved blocks have to be turned into regular blocks before DIO can
> > > > write to them.  That immediately exposes them to concurrent reads (at least
> > > > buffered reads, but I think DIO reads too).
> > > 
> > > Isn't it resolved by i_size which gives the written blocks only?
> > > 
> > 
> > I'm not sure what you mean, but this is for non-extending writes, so i_size
> > isn't relevant.
> 
> Ah, do you mean the file has NEW_ADDR within i_size? If so, let me continue
> to investigate further based on the current -dev, as it's quite hard to remove
> the old commits.
> 

Yes, "NEW_ADDR within i_size" is the intended result of fallocate() on f2fs,
right?  The problem is that DIO writes convert the NEW_ADDR blocks to real
blocks, which makes uninitialized data immediately visible to reads before the
write actually happens.

- Eric
