Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FDA547E30
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 05:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiFMDhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 23:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiFMDhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 23:37:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7651EEE5;
        Sun, 12 Jun 2022 20:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Bm4ARRt1HNB10/2s2wOYEo//lZze1cTnCnGg9flh8L4=; b=twFTjyvmQkRTeLKn7bTrmtOcux
        WIkklfU8g2svsuj6mS0XaT2EHZt+VSHSi2g5WFl+fjjcZifI5loA62Kc9bEaCvnlATGNSvClM/ekR
        hn8YYeAYl+HN8ZTYM3U9IFazKu4WBvl5kglt2H5a1WwChJ74r/nz/DafUuttwJKEY+jHfoCsalEep
        Q9Mfk1IPsyNPJaeRkcLsd4F7mnsEjTTOnTvm85cIJOYOkPKrlivLyo6tW0bVzP6J+gsVjSdXLYvjc
        HdaeQuoFtwOmG7IhlqLZxMQruQf8B/P7mfoARgBlsNlljFSrjk/dwAIPexy7PqKy0fOrecoGjgjBF
        L9H+xsHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0asv-00GU6J-Iv; Mon, 13 Jun 2022 03:37:01 +0000
Date:   Mon, 13 Jun 2022 04:37:01 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chao Liu <chaoliu719@gmail.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: Re: [PATCH v2] docs: filesystems: f2fs: fix description about
 compress ioctl
Message-ID: <Yqaw3VTD46PAMN8O@casper.infradead.org>
References: <20220613020800.3379482-1-chaoliu719@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613020800.3379482-1-chaoliu719@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:08:00AM +0800, Chao Liu wrote:
> v2:
> - s/file size/filesize/

Why would you change it to be wrong?

>  Documentation/filesystems/f2fs.rst | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index ad8dc8c040a2..531b0f8a3946 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -818,10 +818,11 @@ Compression implementation
>    Instead, the main goal is to reduce data writes to flash disk as much as
>    possible, resulting in extending disk life time as well as relaxing IO
>    congestion. Alternatively, we've added ioctl(F2FS_IOC_RELEASE_COMPRESS_BLOCKS)
> -  interface to reclaim compressed space and show it to user after putting the
> -  immutable bit. Immutable bit, after release, it doesn't allow writing/mmaping
> -  on the file, until reserving compressed space via
> -  ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or truncating filesize to zero.
> +  interface to reclaim compressed space and show it to user after setting a
> +  special flag to the inode. Once the compressed space is released, the flag
> +  will block writing data to the file until either the compressed space is
> +  reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the filesize is
> +  truncated to zero.
>  
>  Compress metadata layout::
>  
> @@ -830,12 +831,12 @@ Compress metadata layout::
>  		| cluster 1 | cluster 2 | ......... | cluster N |
>  		+-----------------------------------------------+
>  		.           .                       .           .
> -	.                       .                .                      .
> +	  .                      .                .                      .
>      .         Compressed Cluster       .        .        Normal Cluster            .
>      +----------+---------+---------+---------+  +---------+---------+---------+---------+
>      |compr flag| block 1 | block 2 | block 3 |  | block 1 | block 2 | block 3 | block 4 |
>      +----------+---------+---------+---------+  +---------+---------+---------+---------+
> -	    .                             .
> +	       .                             .
>  	    .                                           .
>  	.                                                           .
>  	+-------------+-------------+----------+----------------------------+
> -- 
> 2.36.1
> 
