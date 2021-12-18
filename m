Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 746F4479A88
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 12:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhLRLRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 06:17:08 -0500
Received: from nautica.notk.org ([91.121.71.147]:58874 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhLRLRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 06:17:07 -0500
X-Greylist: delayed 690 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Dec 2021 06:17:07 EST
Received: by nautica.notk.org (Postfix, from userid 108)
        id 52700C01D; Sat, 18 Dec 2021 12:17:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1639826226; bh=8CSxbc5WL1k9ccoiWDDaGfsWN/iRL7BkpYTEy76X/4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZTqdmRywC9U7LQrM+zMrWByW5RkhT1tb4OXOzA/K9L0G5vMRwroDEOkAQRjSUlRhh
         DplAlrczMjz9XMVo7t1sgXiXJhyCQ1+W++tCVrw39d0FMBKPBm+3+CN6w+j6petNJW
         bYdq/ScRIyr0EL7aEYVUtq+Abj4bLmYK6X1/UqQnNTEHQ3bAxAS2YaEZcOgTGnYyQ1
         qkGEFQzjlw6ExdAYWBxJXXnnDupd42t4BZtkGHUeuKXEtJ+QhYM4cH303fh9vwBAJA
         2lMC8UQJ6svZj84nJYQvJmlqUC2VqYiv4VSnZ7GSegvyZAbg0hd2U7kFP29gwIHS11
         GeLEQSqdTXWiw==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
        autolearn=unavailable version=3.3.2
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 96C03C009;
        Sat, 18 Dec 2021 12:17:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1639826224; bh=8CSxbc5WL1k9ccoiWDDaGfsWN/iRL7BkpYTEy76X/4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIzjkSptoI6TTpfj/IR3eA52mZE8NyVvKXRyBr/V1b8ImSn5W7v5gBM3otX51jRIE
         5p9kbrEjgWjHq1xQChET357PtxOdaftgV+izFJ0xXkf7kePu76HE1q+gE9ZyWfdxYP
         90Pv7urwyRhfC5BrmYoX12CvzyaBciKc/Uf+1/1FLPsmZTpJOKzPrRpRXKJqslU4Xn
         VKhw+45zL9Q1Z39cGxFPxfVfv9xot0BCGRImIuim5RQIvnoizyGrVEEa0t3zWSZ0jV
         nfNKDZfH54g4+mSd4X/Ui7egDwlv3bXSw21FvuFTxQ+345GPBDD0WnigLEq3AHIHr2
         RRAD7z+wgm9ng==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 6bbaf76b;
        Sat, 18 Dec 2021 11:17:00 +0000 (UTC)
Date:   Sat, 18 Dec 2021 20:16:44 +0900
From:   asmadeus@codewreck.org
To:     cgel.zte@gmail.com
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Zhang Mingyu <zhang.mingyu@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] 9p: Use BUG_ON instead of if condition followed by BUG.
Message-ID: <Yb3DHNHjk0SwMJPU@codewreck.org>
References: <20211112092547.9153-1-zhang.mingyu@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211112092547.9153-1-zhang.mingyu@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cgel.zte@gmail.com wrote on Fri, Nov 12, 2021 at 09:25:47AM +0000:
> From: Zhang Mingyu <zhang.mingyu@zte.com.cn>
> 
> This issue was detected with the help of Coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>

I realize I've never replied to this mail when applying old patches now,
I've picked this up too.

> ---
>  fs/9p/vfs_file.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/9p/vfs_file.c b/fs/9p/vfs_file.c
> index 4244d48398ef..f2375448cafc 100644
> --- a/fs/9p/vfs_file.c
> +++ b/fs/9p/vfs_file.c
> @@ -139,8 +139,7 @@ static int v9fs_file_do_lock(struct file *filp, int cmd, struct file_lock *fl)
>  	fid = filp->private_data;
>  	BUG_ON(fid == NULL);
>  
> -	if ((fl->fl_flags & FL_POSIX) != FL_POSIX)
> -		BUG();
> +	BUG_ON((fl->fl_flags & FL_POSIX) != FL_POSIX);
>  
>  	res = locks_lock_file_wait(filp, fl);
>  	if (res < 0)

-- 
Dominique
