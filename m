Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237675A66A5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiH3Ov0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiH3OvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 10:51:23 -0400
Received: from sandeen.net (sandeen.net [63.231.237.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 21D40E193C;
        Tue, 30 Aug 2022 07:51:21 -0700 (PDT)
Received: from [10.0.0.146] (liberator.sandeen.net [10.0.0.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by sandeen.net (Postfix) with ESMTPSA id 81B29FB431;
        Tue, 30 Aug 2022 09:49:36 -0500 (CDT)
Message-ID: <b19dd730-28f4-982d-2ae7-471e0c11db0e@sandeen.net>
Date:   Tue, 30 Aug 2022 09:51:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Content-Language: en-US
To:     Zeng Heng <zengheng4@huawei.com>, djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220830135422.2734749-1-zengheng4@huawei.com>
From:   Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH -next] xfs: remove "%Ld" which doesn't meet C standard
In-Reply-To: <20220830135422.2734749-1-zengheng4@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 8:54 AM, Zeng Heng wrote:
> The "%Ld" specifier, which represents long long unsigned,
> doesn't meet C language standard, and even more,
> it makes people easily mistake with "%ld", which represent
> long unsigned. So replace "%Ld" with "lld".
> 
> Do the same with "%Lu".
> 
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>

I think this probably makes sense, but there are many more instances of
%Ld and %Lu in the xfs code, so why change just these 3?

$ cd fs/xfs
$ grep -r "%Lu\|%Ld" .
./libxfs/xfs_inode_fork.c:	"corrupt inode %Lu (bad size %d for local fork, size = %zd).",
./libxfs/xfs_inode_fork.c:		xfs_warn(mp, "corrupt inode %Lu (btree).",
./libxfs/xfs_bmap.c:				xfs_warn(mp, "%s: thispa(%d) == pp(%d) %Ld",
./xfs_inode.c:			"%s: Bad inode %Lu magic number 0x%x, ptr "PTR_FMT,
./xfs_inode.c:				"%s: Bad regular inode %Lu, ptr "PTR_FMT,
./xfs_inode.c:				"%s: Bad directory inode %Lu, ptr "PTR_FMT,
./xfs_inode.c:			"%s: bad inode %Lu, forkoff 0x%x, ptr "PTR_FMT,
./xfs_stats.c:	len += scnprintf(buf + len, PATH_MAX-len, "xpc %Lu %Lu %Lu\n",
./cscope/csdb:, "corrupt inode %Lu (btree).",
./cscope/csdb:", dino bp = "PTR_FMT", ino = %Ld",
./cscope/csdb:", ino %Ld",
./cscope/csdb:-len, "xpc %Lu %Lu %Lu\n",
./xfs_inode_item_recover.c:	"%s: Bad inode magic number, dip = "PTR_FMT", dino bp = "PTR_FMT", ino = %Ld",
./xfs_inode_item_recover.c:			"%s: Bad inode log record, rec ptr "PTR_FMT", ino %Ld",


> ---
>  fs/xfs/xfs_inode_item_recover.c | 4 ++--
>  fs/xfs/xfs_stats.c              | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode_item_recover.c b/fs/xfs/xfs_inode_item_recover.c
> index d28ffaebd067..0e5dba2343ea 100644
> --- a/fs/xfs/xfs_inode_item_recover.c
> +++ b/fs/xfs/xfs_inode_item_recover.c
> @@ -321,7 +321,7 @@ xlog_recover_inode_commit_pass2(
>  	 */
>  	if (XFS_IS_CORRUPT(mp, !xfs_verify_magic16(bp, dip->di_magic))) {
>  		xfs_alert(mp,
> -	"%s: Bad inode magic number, dip = "PTR_FMT", dino bp = "PTR_FMT", ino = %Ld",
> +	"%s: Bad inode magic number, dip = "PTR_FMT", dino bp = "PTR_FMT", ino = %lld",
>  			__func__, dip, bp, in_f->ilf_ino);
>  		error = -EFSCORRUPTED;
>  		goto out_release;
> @@ -329,7 +329,7 @@ xlog_recover_inode_commit_pass2(
>  	ldip = item->ri_buf[1].i_addr;
>  	if (XFS_IS_CORRUPT(mp, ldip->di_magic != XFS_DINODE_MAGIC)) {
>  		xfs_alert(mp,
> -			"%s: Bad inode log record, rec ptr "PTR_FMT", ino %Ld",
> +			"%s: Bad inode log record, rec ptr "PTR_FMT", ino %lld",
>  			__func__, item, in_f->ilf_ino);
>  		error = -EFSCORRUPTED;
>  		goto out_release;
> diff --git a/fs/xfs/xfs_stats.c b/fs/xfs/xfs_stats.c
> index 70d38b77682b..90a77cd3ebad 100644
> --- a/fs/xfs/xfs_stats.c
> +++ b/fs/xfs/xfs_stats.c
> @@ -74,7 +74,7 @@ int xfs_stats_format(struct xfsstats __percpu *stats, char *buf)
>  		defer_relog += per_cpu_ptr(stats, i)->s.defer_relog;
>  	}
>  
> -	len += scnprintf(buf + len, PATH_MAX-len, "xpc %Lu %Lu %Lu\n",
> +	len += scnprintf(buf + len, PATH_MAX-len, "xpc %llu %llu %llu\n",
>  			xs_xstrat_bytes, xs_write_bytes, xs_read_bytes);
>  	len += scnprintf(buf + len, PATH_MAX-len, "defer_relog %llu\n",
>  			defer_relog);
