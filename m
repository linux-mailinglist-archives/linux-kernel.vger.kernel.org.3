Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 517114A4F85
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376905AbiAaTe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:34:58 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:59034 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376812AbiAaTe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:34:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEBED61449
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 19:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1423BC340E8;
        Mon, 31 Jan 2022 19:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643657695;
        bh=aDSxNsqNgxymIMupEkRchSOtPKLku8ZLqWJGphw2KQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+jVDeyPLfSdinXQiVT8qLMyS4gdD4wPOBdtcRKMrTuHwdej7Xazt9hNQX3RZnHZs
         gm8lEqyFvWHXe9DMWkouGaL2fqPw6dM198xxt7024uTR8L9GKI8lnyWjuYrynhgYF2
         4KGubMHYmSc0/CMNBlFsYttKZRs6IRj1inC49dlsboaeXF10N3Z+hgfLbuzhCy9003
         1KXB1Ox8axiWipBP9B9Mc6sTatYl1E4F/FfgzAAv+s8BIj7/sYQ3YBXT8X+s5z76iH
         NuGvOGqLR8qckiFe1v0E7Jf3CLXxWxHLl46SYiW7DZ3tfoEJkhg8P0f04aHGbkr/zj
         GBh2a0BkJj9Sw==
Date:   Mon, 31 Jan 2022 19:34:53 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Harry Austen <harryausten@hotmail.co.uk>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, jaegeuk@kernel.org, chao@kernel.org
Subject: Re: [RFC PATCH] f2fs: disallow setting unsettable file attributes
Message-ID: <Yfg53VflpMY3eDB4@gmail.com>
References: <AM6PR10MB2838F71E6117BFFAD3FD5A69FA249@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR10MB2838F71E6117BFFAD3FD5A69FA249@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 05:21:39PM +0000, Harry Austen wrote:
> After Eric kindly pointed out the reasons why my initial kernel patch
> attempt was incorrect
> (https://lore.kernel.org/lkml/Ye79OLCFLR3H+GnY@gmail.com/), I had a
> rethink as to if the current implementation could be improved in any
> way.
> 
> I wondered whether something along the lines of the following patch
> would be more acceptable? It is intentionally verbose in order to
> demonstrate the concept as this is intended purely as an RFC.
> 
> What if SETFLAGS returned EOPNOTSUPP if userspace is actually trying to
> *set* one of the unsettable flags (i.e. it isn't set already)? I believe
> this would therefore not break chattr(1), as flags that are retrieved
> from GETFLAGS can still be passed into SETFLAGS without error.
> 
> If there is some other ABI compatibility that needs to be maintained
> that is broken by this, then please let me know. Also, I have not yet
> determined whether there are any concerns with calling f2fs_fileattr_get
> from inside f2fs_fileattr_set, e.g. speed/performance? so any thoughts
> would be greatly appreciated.
> 
> Signed-off-by: Harry Austen <harryausten@hotmail.co.uk>
> ---
>  fs/f2fs/file.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)

This makes sense, but this ioctl isn't f2fs-specific; it's implemented by other
filesystems, most notably ext2/ext4 where it originated.  f2fs shouldn't have
different behavior for the same ioctl.  If you want to change this ioctl, you
need to start a wider discussion (including the linux-fsdevel and linux-ext4
mailing lists) where the change is proposed for all filesystems.

- Eric
