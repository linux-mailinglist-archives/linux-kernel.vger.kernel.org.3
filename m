Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 734064880DF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 03:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiAHCVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 21:21:31 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42574 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiAHCVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 21:21:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01048B827B9
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 02:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DBCC36AEB;
        Sat,  8 Jan 2022 02:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641608488;
        bh=d6tCE8L07WiRQLdTYY6Wo8RkTxESU2i1+P95PULKkIY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bujMAGF6pgyHVhKQKZcmvfxdRkR7hdH8E6Z2WtaUI2kJMt7ZWdpVwY8j28eU2pjsr
         eB5noMBWxJLjXGt9AcSc0tOordHBLhAGcEG2AamuSvy68MFEZo3PDnu/ABNdOr7kNN
         eVvAoNt+VdAVYfNQvBxNV1RQ8y5vpoXfoFTsikDFRDKP5WfV+Dq2pzuon6Vvx89/GM
         pPyfOWeeIn9MFS8cyWShjIWRIulzTGoOGrlCleBvMUoCpmQAhgA4Hltgn3v/Hd9dAS
         jTjmLEi6J8oJj9mwqcFpZ+QG/nqm1jBrWQPb8QvBnh8iG8yHSi4U1PtpNz1uJALVz3
         IrBDXX/qYgtfw==
Date:   Fri, 7 Jan 2022 18:21:26 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/6] f2fs: do not expose unwritten blocks to user by DIO
Message-ID: <Ydj1JvEeLo1mrqvb@sol.localdomain>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-3-jaegeuk@kernel.org>
 <YdjJAS7Ua4aJEFhz@sol.localdomain>
 <YdjucBBopEDuUb5b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdjucBBopEDuUb5b@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 05:52:48PM -0800, Jaegeuk Kim wrote:
> On 01/07, Eric Biggers wrote:
> > Hi Jaegeuk,
> > 
> > On Tue, Jan 04, 2022 at 01:24:16PM -0800, Jaegeuk Kim wrote:
> > > DIO preallocates physical blocks before writing data, but if an error occurrs
> > > or power-cut happens, we can see block contents from the disk. This patch tries
> > > to fix it by 1) turning to buffered writes for DIO into holes, 2) truncating
> > > unwritten blocks from error or power-cut.
> > > 
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >  fs/f2fs/data.c  |  5 ++++-
> > >  fs/f2fs/f2fs.h  |  5 +++++
> > >  fs/f2fs/file.c  | 27 ++++++++++++++++++---------
> > >  fs/f2fs/inode.c |  8 ++++++++
> > >  4 files changed, 35 insertions(+), 10 deletions(-)
> > 
> > Unfortunately, this patch doesn't completely fix the uninitialized data
> > exposure.  The problem is that it only makes DIO writes fall back to buffered
> > writes for holes, and not for reserved blocks (NEW_ADDR).  f2fs's reserved
> > blocks are *not* the same as the unwritten extents that other filesystems have;
> > f2fs's reserved blocks have to be turned into regular blocks before DIO can
> > write to them.  That immediately exposes them to concurrent reads (at least
> > buffered reads, but I think DIO reads too).
> 
> Isn't it resolved by i_size which gives the written blocks only?
> 

I'm not sure what you mean, but this is for non-extending writes, so i_size
isn't relevant.

- Eric
