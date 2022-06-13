Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7454A19E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237746AbiFMVjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352638AbiFMVjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:39:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929EE102B;
        Mon, 13 Jun 2022 14:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
        :In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=ZHOzswuFc4gDE4h/q3IgGDDruuCRynevUPtETq+uhC8=; b=cIj2OZ6FBCoDpgRhR4glzTdRLk
        jb0j9dbYysOB6CZkdv39d56ve50HV4HDWhDGkh9VVzrV6FVmFI8syoqrueJVuhLSO0hu4ddITQ5C2
        rzThyHpmqPlzyttInYVAx9ZmcRpy7c6WCACl/1zEzT0VbKflvnUeWC6/hCIRNErjLIFmtQFH02nnQ
        12ovjPszvmUDjJkOvtPKgRpySY4+o/yyPwSo7UUTynvw0jAfuhfT3FvhCJEZQuYgtXEqhLJdiTuaa
        D/ZvniR/3H6xOAe0CUb0syF1elqrFC53cd088z5abIBQmTCiNmraMplqwa1mHmSo/E972M5UiVLsX
        IDoDMUYA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o0rm2-007gHb-Oy; Mon, 13 Jun 2022 21:39:03 +0000
Message-ID: <61dd808d-daff-55c7-7213-26f6bae3a5c7@infradead.org>
Date:   Mon, 13 Jun 2022 14:38:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 18/20] block, blksnap: Kconfig
Content-Language: en-US
To:     Sergei Shtepa <sergei.shtepa@veeam.com>, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-19-git-send-email-sergei.shtepa@veeam.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <1655135593-1900-19-git-send-email-sergei.shtepa@veeam.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/13/22 08:53, Sergei Shtepa wrote:
> The module configuration file allows you to set default values for
> module parameters.
> 
> Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
> ---
>  drivers/block/blksnap/Kconfig | 101 ++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 drivers/block/blksnap/Kconfig
> 
> diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
> new file mode 100644
> index 000000000000..8588a89e30ad
> --- /dev/null
> +++ b/drivers/block/blksnap/Kconfig
> @@ -0,0 +1,101 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# block io layer filter module configuration

I prefer   IO or I/O
but that's up to Jens.

> +#
> +#
> +
> +config BLK_SNAP
> +	tristate "Block device snapshot and change tracker module"
> +	depends on BLK_FILTER
> +	help
> +	  Allow to create snapshots and track block changes for a block

	                                                    for block

> +	  devices. Designed for creating backups for any block devices
> +	  (without device mapper). Snapshots are temporary and are released
> +	  then backup is completed. Change block tracking allows you to
> +	  create incremental or differential backups.
> +
> +config BLK_SNAP_TRACKING_BLOCK_MINIMUM_SHIFT
> +	depends on BLK_SNAP
> +	int "The power of 2 for minimum trackings block size"

	                                tracking                 (I think.)

> +	default 16
> +	help
> +	  The minimum tracking block size by default is 64 KB (shift 16)

	End above with a period ('.'):                        (shift 16).

> +	  It's looks good for block device 128 GB or lower.

          It looks good
except saying something about performance would be better than "looks good".

> +	  In this case, the block device is divided into 2097152 blocks.
> +
> +config BLK_SNAP_TRACKING_BLOCK_MAXIMUM_COUNT
> +	depends on BLK_SNAP
> +	int "The limit of the maximum number of trackings blocks"

	                                        tracking           (IMO)

> +	default 2097152
> +	help
> +	  As the size of the block device grows, the size of the tracking block
> +	  size should also grow. For this purpose, the limit of the maximum
> +	  number of block size is set.
> +
> +config BLK_SNAP_CHUNK_MINIMUM_SHIFT
> +	depends on BLK_SNAP
> +	int "The power of 2 for minimum snapshots chunk size"
> +	default 18
> +	help
> +	  The minimum chunk size by default is 256 KB (shift 18)

	                                              (shift 18).

> +	  It's looks good for block device 128 GB or lower.

	  It looks good
except that something more technical would be better here.

> +	  In this case, the block device is divided into 524288 chunks.
> +
> +config BLK_SNAP_CHUNK_MAXIMUM_COUNT
> +	depends on BLK_SNAP
> +	int "The limit of the maximum number of snapshots chunks"
> +	default 2097152
> +	help
> +	  As the size of the block device grows, the size of the chunk
> +	  should also grow. For this purpose, the limit of the maximum number
> +	  of chunks is set.

Is the "limit of the maximum number" the same as "the maximum number" of chunks?
Using "limit ... maximum" seems redundant to me.

> +
> +config BLK_SNAP_CHUNK_MAXIMUM_IN_CACHE
> +	depends on BLK_SNAP
> +	int "The limit of the maximum chunks in memory cache"

or just     "Maximum number of chunks in memory cache"
?

> +	default 64
> +	help
> +	  Since reading and writing to snapshots is performed in large chunks,
> +	  a cache is implemented to optimize reading small portions of data
> +	  from the snapshot image. As the number of chunks in the cache
> +	  increases, memory consumption also increases.
> +	  The minimum recommended value is four.
> +
> +config BLK_SNAP_FREE_DIFF_BUFFER_POOL_SIZE
> +	depends on BLK_SNAP
> +	int "The maximum size of the free buffers pool"
> +	default 128
> +	help
> +	  A buffer can be allocated for each chunk. After use, this buffer is
> +	  not released immediately, but is sent to the pool of free buffers.
> +	  However, if there are too many free buffers in the pool, they are

	                                          Here,  does      "they"
mean the extra buffers (> BLK_SNAP_DIFF_BUFFER_POOL_SIZE) or all of the
pool of free buffers?


> +	  released immediately. The maximum size of the pool is regulated by
> +	  this define.

I would s/define/configuration/.

> +
> +config BLK_SNAP_DIFF_STORAGE_MINIMUM
> +	depends on BLK_SNAP
> +	int "The minimum allowable size of the difference storage in sectors"

What is "difference storage"?

> +	default 2097152
> +	help
> +	  When reached, an event is generated about the lack of free space.
> +
> +config BLK_SNAP_DEBUG_MEMORY_LEAK
> +	depends on BLK_SNAP
> +	bool "Enable memory leak detector"
> +	default n
> +	help
> +	  Enables debugging code to monitor memory consumption by the module.
> +
> +	  If unsure, say N.
> +
> +config BLK_SNAP_ALLOW_DIFF_STORAGE_IN_MEMORY
> +	depends on BLK_SNAP
> +	bool "Allow difference storage in memory"

Is "difference storage" described somewhere?

> +	default n
> +	help
> +	  Enables the ability to create a repository of changes in memory.
> +	  This feature can be useful for debugging. Or it can be used for
> +	  mobile phones or other devices if there are guaranteed not to be
> +	  a large number of writings during the snapshot hold.
> +
> +	  If unsure, say N.

thanks.
-- 
~Randy
