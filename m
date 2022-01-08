Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 243DC48811F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 04:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiAHDgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 22:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbiAHDgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 22:36:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D66C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 19:36:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3E00B827CA
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 03:35:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14B1C36AE0;
        Sat,  8 Jan 2022 03:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641612957;
        bh=hKYGsyuzBJO04oP8yE2Lv5IRXUyoE6ue4ZmbzPKsNy4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jh4jugah5bS70Ajj89OvfPQIQL70fkjFwA6WnYZV6iQNjM/Mu8IPvebDk9fobfF/C
         RYVp8vfWSNhq2UhLG4uCKbpuQd4wiWxdf336Huvr9dzs3x8SrDBBFIWS7ddsoH8+N0
         p4zeTklnTJ/UzmDC+tBmYetCNurDoUnUG+yKkFfDKkIzQdWlQg+Vq/PDQv01SQIHH9
         M28VhIs+YpRAtFLpWimJolSgDWQir6PYghTKa85Q0aV5eD1b2B5jTmjFkCv0rM8Xw3
         mRZmS+nOv+WQT0z3SG1KzvERgBCgh0gN7o09J1gC1mHZBvNGSYk1cJJFbDKDG7otO7
         6t0zxB0QO2k/w==
Date:   Fri, 7 Jan 2022 19:35:56 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/6] f2fs: do not expose unwritten blocks to user by DIO
Message-ID: <YdkGnA3/3f/Qka5M@google.com>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-3-jaegeuk@kernel.org>
 <YdjJAS7Ua4aJEFhz@sol.localdomain>
 <YdjucBBopEDuUb5b@google.com>
 <Ydj1JvEeLo1mrqvb@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydj1JvEeLo1mrqvb@sol.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/07, Eric Biggers wrote:
> On Fri, Jan 07, 2022 at 05:52:48PM -0800, Jaegeuk Kim wrote:
> > On 01/07, Eric Biggers wrote:
> > > Hi Jaegeuk,
> > > 
> > > On Tue, Jan 04, 2022 at 01:24:16PM -0800, Jaegeuk Kim wrote:
> > > > DIO preallocates physical blocks before writing data, but if an error occurrs
> > > > or power-cut happens, we can see block contents from the disk. This patch tries
> > > > to fix it by 1) turning to buffered writes for DIO into holes, 2) truncating
> > > > unwritten blocks from error or power-cut.
> > > > 
> > > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > > ---
> > > >  fs/f2fs/data.c  |  5 ++++-
> > > >  fs/f2fs/f2fs.h  |  5 +++++
> > > >  fs/f2fs/file.c  | 27 ++++++++++++++++++---------
> > > >  fs/f2fs/inode.c |  8 ++++++++
> > > >  4 files changed, 35 insertions(+), 10 deletions(-)
> > > 
> > > Unfortunately, this patch doesn't completely fix the uninitialized data
> > > exposure.  The problem is that it only makes DIO writes fall back to buffered
> > > writes for holes, and not for reserved blocks (NEW_ADDR).  f2fs's reserved
> > > blocks are *not* the same as the unwritten extents that other filesystems have;
> > > f2fs's reserved blocks have to be turned into regular blocks before DIO can
> > > write to them.  That immediately exposes them to concurrent reads (at least
> > > buffered reads, but I think DIO reads too).
> > 
> > Isn't it resolved by i_size which gives the written blocks only?
> > 
> 
> I'm not sure what you mean, but this is for non-extending writes, so i_size
> isn't relevant.

Ah, do you mean the file has NEW_ADDR within i_size? If so, let me continue
to investigate further based on the current -dev, as it's quite hard to remove
the old commits.

> 
> - Eric
