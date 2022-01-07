Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BCD487F40
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:13:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiAGXNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:13:09 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:42358 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbiAGXNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:13:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D75561EA6
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 23:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1552C36AE9;
        Fri,  7 Jan 2022 23:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641597186;
        bh=ICdoyhLp4mfXiHECs/IAYYg5cV1mgJexXdcbH5yA24A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=We7ZfrlbepKtokTbFzqyCMUcoDW79GKYBwQIZtKFESHnEWhsq6AuOnm5nSJv8qCXF
         aVeg17F+lH6k2ol+fWCp980eHzmH2cV0o5u3s0N3O1tpv4S3LM0wOnN0YHtT2tkYiz
         /0MXWEcAO2MgZ/9vDrhXg9MKMNDcRsn7Y6+XYAxLPy08b+xh3JBHpI9xEQrbu2Mw6b
         5MMuUpxptY3chVnEaqNqGD93EcgZxRAgKGiiaJklmhv7bFi1Y68M3NcF3E7i4VAexN
         gQGChSnFzb2HWw0yJrmhj7FPWRZ/mVPgDzQEcR/JkLCEUMV0txKS+4kr0vrAuEP/ud
         Jauf6p4+t/fIQ==
Date:   Fri, 7 Jan 2022 15:13:05 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/6] f2fs: do not expose unwritten blocks to user by DIO
Message-ID: <YdjJAS7Ua4aJEFhz@sol.localdomain>
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-3-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104212419.1879225-3-jaegeuk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jaegeuk,

On Tue, Jan 04, 2022 at 01:24:16PM -0800, Jaegeuk Kim wrote:
> DIO preallocates physical blocks before writing data, but if an error occurrs
> or power-cut happens, we can see block contents from the disk. This patch tries
> to fix it by 1) turning to buffered writes for DIO into holes, 2) truncating
> unwritten blocks from error or power-cut.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/data.c  |  5 ++++-
>  fs/f2fs/f2fs.h  |  5 +++++
>  fs/f2fs/file.c  | 27 ++++++++++++++++++---------
>  fs/f2fs/inode.c |  8 ++++++++
>  4 files changed, 35 insertions(+), 10 deletions(-)

Unfortunately, this patch doesn't completely fix the uninitialized data
exposure.  The problem is that it only makes DIO writes fall back to buffered
writes for holes, and not for reserved blocks (NEW_ADDR).  f2fs's reserved
blocks are *not* the same as the unwritten extents that other filesystems have;
f2fs's reserved blocks have to be turned into regular blocks before DIO can
write to them.  That immediately exposes them to concurrent reads (at least
buffered reads, but I think DIO reads too).

This can be reproduced using the aiodio_sparse program from LTP, as follows:

	aiodio_sparse -i 4 -a 8k -w 1024k -s 4096k -n 6

This was reported at
https://lore.kernel.org/r/20211226132851.GC34518@xsang-OptiPlex-9020 as a
regression from the commit "f2fs: use iomap for direct I/O", but it actually
failed before too.  Note that it's nondeterministic; writing random data to the
block device before creating the filesystem helps with reproduction.

I see only three possible solutions:

* Make DIO writes to reserved blocks fall back to buffered writes, just like
  writes to holes.  This would mean that a file would have to be written to
  before direct writes would work; fallocate() wouldn't be enough.  Note that my
  patch https://lore.kernel.org/r/20210728015154.171507-1-ebiggers@kernel.org
  would have done this.

* Or, change the f2fs on-disk format to support unwritten extents.

* Or, split up block allocation into two parts, so that blocks could be
  preliminarily allocated and not exposed to reads yet.  This would be like
  Ted's suggestion here: https://lore.kernel.org/r/YQS5eBljtztWwOFE@mit.edu

- Eric
