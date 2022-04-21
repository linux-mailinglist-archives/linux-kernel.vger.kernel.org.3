Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57F7509AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386184AbiDUIqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiDUIqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:46:48 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D93CE088
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650530637; x=1682066637;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=jjxNJwS+YZW/zBq3mAwvmbF1vWlfZ/Y1rEOvGKLC1EI=;
  b=Pl0TtWa4bMJriHM1OIAtN7eN5X91MPTmYSCZnTdOZxcR78Bs81PkLyJM
   Bm9wjIZrlgmYCqxTlpz2+WgxT+Dl9vfqPWc8EIw+jkytjwOLNTGtnNRhm
   +BotHOxHCePYHG3kIr3mTtP2ayDyFRdJIPEynI172F3Gw/Pe8pkypQSvD
   jp3uM1oz5GnqticpJQDCI8hotJzMxxmV0b3psQ5cZNZlSIJFMyyj4+246
   otOTWjPBxmgNxi/Moq5W9rnaThGvwEIR6izRBWjNIKIPmo7xzNkDTtNly
   nQZiOXmWC2f4jLlJxTvVzi57OFcwPrCeGVIq44MC2un/Ry0txZ3fM7NGe
   g==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643644800"; 
   d="scan'208";a="203318194"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 16:43:57 +0800
IronPort-SDR: EBiTvqCsLxTt6eYXvtlsi8noKGMlxfNCN9TLv4fxyOQJstMYg5MckuG8Wgi7oqCFtGSAf7Dd2p
 N5ULAJdB9m6RYk3dztrBWZi+ooPMULAxUCYE+V8HWy4NgLnQ1jGc+C6GLEASnPL7SIl1kk+oqz
 RSbGqdr7nWQm0NKuVrbCafqKpQ6o6VKyXO4tBJL6ZFtBWHINc2UT0HA1NwVr3mbP6CmCDUoW6J
 JtSuj/1mrCC+sXKaDoRyqE67X4snUPLNd2NybfMHJJaz0lnbE+wPIBad1oa2OAXs7QUka1hia/
 dAUBXV/gX4gerB6LcXO1rkqh
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 01:14:16 -0700
IronPort-SDR: RopTIDJ5lYBy/aGJlmsZVsAvwfPAF/BDH8ZiHmK7+5UhyayV48691t8TRiDXImXbOEUeCwM1no
 spklgv3nFK8CO6GgM+UUVrw0u/TDV8eRO4Jj4NL8DvT7+RbSs2PJHFKOdkqi/bgNgzINZrb99h
 zHpT+Cos2b3jJpbSLaxY5cxEbkgvhqbDTX+NkM4i78pSkxo0ZmZHKjqNHw2TCoPiWn5aXjMVLd
 WjaJRaOgZRb+JPm4nwLKLDMz3Nw8xmEW9wibwStkk28RCId4Tug1xyJJqKOaCxTZskQ2YUwtr8
 nmU=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Apr 2022 01:43:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KkWKp2H5Jz1Rwrw
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:43:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1650530637; x=1653122638; bh=jjxNJwS+YZW/zBq3mAwvmbF1vWlfZ/Y1rEO
        vGKLC1EI=; b=dxF+AJOuGzC8fLAlKv9YZEwj/yT44phEEZv94QCsADg6IGURHvP
        AhwL0OmixvYHRcFgg8dWcy7x+j8bPNjxX6Q/Lj/959eFfDMY1qw68hZ3pSDh6KUf
        H++Mekc0qIzLn+bksdKCNaJUj951AmQ/98FtXmZSK8mxAXEptMjCPA8rpkFqU8il
        RuUFTljqac8Jgilu/YFkjR18ZhWg6IyNeOfMF7br1tjVTqtjraMz5A0L3Be+wDrI
        jDqWlErgA1G1A1BRGafGN7M01KocAEiDJiYLwl5OH8RcSZGnkL3f4Emj9UWnvO7J
        nclsp5uPetKnq8LXEYJ5E0Ku1s8ufyrplmQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 27VHczRCcsmQ for <linux-kernel@vger.kernel.org>;
        Thu, 21 Apr 2022 01:43:57 -0700 (PDT)
Received: from [10.225.163.19] (unknown [10.225.163.19])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KkWKn0h0Wz1Rvlx;
        Thu, 21 Apr 2022 01:43:56 -0700 (PDT)
Message-ID: <42e10758-e50a-7aaa-dfa9-dcf6338ebaff@opensource.wdc.com>
Date:   Thu, 21 Apr 2022 17:43:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] f2fs: use flush command instead of FUA for zoned device
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20220419215703.1271395-1-jaegeuk@kernel.org>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220419215703.1271395-1-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 06:57, Jaegeuk Kim wrote:
> The block layer for zoned disk can reorder the FUA'ed IOs. Let's use flush
> command to keep the write order.

Stricktly speaking, for a request that has data, the problem is triggered
by REQ_PREFLUSH since in this case the request does not go through the
scheduler and is processed through the blk-flush machinery. REQ_FUA on its
own should not matter if the device supports it. If the device does not
support FUA, then the same problem can happen due to POSTFLUSH (again no
scheduler).

Bypassing the scheduler leads to the write not write-locking the zone,
which leads to reordering... Completely overlooked that case when the zone
write locking was implemented.

Ideally, the FS should not have to care about this. blk-flush machinery
should be a little more intelligent and process the write phase of the
request using the scheduler. Need to look into that.

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/file.c | 4 +++-
>  fs/f2fs/node.c | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f08e6208e183..2aef0632f35b 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -372,7 +372,9 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  	f2fs_remove_ino_entry(sbi, ino, APPEND_INO);
>  	clear_inode_flag(inode, FI_APPEND_WRITE);
>  flush_out:
> -	if (!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER)
> +	if ((!atomic && F2FS_OPTION(sbi).fsync_mode != FSYNC_MODE_NOBARRIER) ||
> +			(atomic && !test_opt(sbi, NOBARRIER) &&
> +					f2fs_sb_has_blkzoned(sbi)))

Aligning the conditions and not breaking the second line would make this a
lot easier to read...

>  		ret = f2fs_issue_flush(sbi, inode->i_ino);
>  	if (!ret) {
>  		f2fs_remove_ino_entry(sbi, ino, UPDATE_INO);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index c280f482c741..7224a980056f 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1633,7 +1633,7 @@ static int __write_node_page(struct page *page, bool atomic, bool *submitted,
>  		goto redirty_out;
>  	}
>  
> -	if (atomic && !test_opt(sbi, NOBARRIER))
> +	if (atomic && !test_opt(sbi, NOBARRIER) && !f2fs_sb_has_blkzoned(sbi))
>  		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;

Is this really OK to do ? flush + write as different operations may not
lead to the same result as a preflush+fua write.

Until the block layer is fixed to properly handle this, a simpler fix for
f2fs would be to force enable the NOBARRIER option for zoned drives ? That
would avoid these changes no ?

Also, with all the testing we do on SMR disks and f2fs (smaller, older SMR
disks due to the 16TB limit), we never have triggered this problem. How
did you trigger it ?

>  
>  	/* should add to global list before clearing PAGECACHE status */


-- 
Damien Le Moal
Western Digital Research
