Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFBB54670B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 15:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbiFJNGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 09:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbiFJNGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 09:06:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F2B212;
        Fri, 10 Jun 2022 06:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2B334CE3584;
        Fri, 10 Jun 2022 13:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40AAFC34114;
        Fri, 10 Jun 2022 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654866360;
        bh=xkCJiA855qlPrws/61dN5ylG/Dd/FlQB186Hu3KHC2I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Nf/UQFyu0Gb6hxnCkffPqNTS5oF5hm4QLJRJWaWGbxDS2n4VemEepH3dO2SobKZ76
         iBYTPCh3mX5ldY79S5Bwe1dvGN7+9pFRhXJhyL/R94YGBWrIsyWo65utQfXa1EZ1/+
         AZ26IMyqOA04h2+4VbhNfTjGr6TLuIb7zltPIdrAdiIWRRmzxD2IRQEqsiyzxg7EA0
         gsTgru0aXRtmwbn7aExCICJb9GM9z/FlkaBLC2UiVevHX80wyDFVH8ZAj7tOK8L4TT
         KO0ccMbpqDHZkyXLYnjKhjg0USQC6dGYSvrh4TYr6rAmvNSUYuj81waLQX2uYvoOaU
         RX0ip3KKyuRGw==
Message-ID: <0e451780-31c8-b1e9-0205-b9e68a57e958@kernel.org>
Date:   Fri, 10 Jun 2022 21:05:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] docs: filesystems: f2fs: fix description about compress
 ioctl
Content-Language: en-US
To:     Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-f2fs-devel@lists.sourceforge.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
References: <20220602072540.998638-1-chaoliu719@gmail.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20220602072540.998638-1-chaoliu719@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/2 15:25, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> Since commit c61404153eb6 ("f2fs: introduce FI_COMPRESS_RELEASED
> instead of using IMMUTABLE bit"), we no longer use the IMMUTABLE
> bit to prevent writing data for compression. Let's correct the
> corresponding documentation.
> 
> BTW, this patch fixes some alignment issues in the compress
> metadata layout.
> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>
> ---
>   Documentation/filesystems/f2fs.rst | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index ad8dc8c040a2..98dc24f5c6f0 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -818,10 +818,11 @@ Compression implementation
>     Instead, the main goal is to reduce data writes to flash disk as much as
>     possible, resulting in extending disk life time as well as relaxing IO
>     congestion. Alternatively, we've added ioctl(F2FS_IOC_RELEASE_COMPRESS_BLOCKS)
> -  interface to reclaim compressed space and show it to user after putting the
> -  immutable bit. Immutable bit, after release, it doesn't allow writing/mmaping
> -  on the file, until reserving compressed space via
> -  ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or truncating filesize to zero.
> +  interface to reclaim compressed space and show it to user after setting a
> +  special flag to the inode. Once the compressed space is released, the flag
> +  will block writing data to the file until either the compressed space is
> +  reserved via ioctl(F2FS_IOC_RESERVE_COMPRESS_BLOCKS) or the file size is

s/file size/filesize/

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

> +  truncated to zero.
>   
>   Compress metadata layout::
>   
> @@ -830,12 +831,12 @@ Compress metadata layout::
>   		| cluster 1 | cluster 2 | ......... | cluster N |
>   		+-----------------------------------------------+
>   		.           .                       .           .
> -	.                       .                .                      .
> +	  .                      .                .                      .
>       .         Compressed Cluster       .        .        Normal Cluster            .
>       +----------+---------+---------+---------+  +---------+---------+---------+---------+
>       |compr flag| block 1 | block 2 | block 3 |  | block 1 | block 2 | block 3 | block 4 |
>       +----------+---------+---------+---------+  +---------+---------+---------+---------+
> -	    .                             .
> +	       .                             .
>   	    .                                           .
>   	.                                                           .
>   	+-------------+-------------+----------+----------------------------+
