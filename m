Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F5858E31F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiHIWTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiHIWTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:19:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1C827168;
        Tue,  9 Aug 2022 15:19:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72087B81A06;
        Tue,  9 Aug 2022 22:19:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D133C433D6;
        Tue,  9 Aug 2022 22:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660083572;
        bh=wHVLGurtpig3wRrDEX8sCmkmlxVZ2CjSsnikZT1umF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t6wis/JyOLC1KdpDSETpCBf9M6HWsIb+juzYY2kVV6uYNj9bCPbgIv+KYaR9C0aKr
         9tKzsCTQ/BxO91vz0LNiDH5GblE9TEWhWofwbeLZPnv+ULvlgUA09cGc5F5HlKF+v7
         O1kCf0tEJe8TltO93/RQEZ0Ntre8LUUptexmQn+l0q77N+uk/x9s8TNhcMnAuV0w1D
         dM9WCGJrgb2cJRPunJhE4gTJstIOXznZnwWkB8wuc20bDPMFGVabZ3ixn5543P8c3B
         8L7IQK9HoTBk0SfhfHWHKs7kaP+N2LxJ9uQOIrdT/+MN4oB1o7D18XJ+u/8/hYyok9
         FcRLkg7jlGRVw==
Date:   Tue, 9 Aug 2022 15:19:31 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Zhang Boyang <zhangboyang.id@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>, Ming Lei <ming.lei@redhat.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] loop: introduce LO_FLAGS_NO_DEALLOC
Message-ID: <YvLdc8GtbZ968qF6@magnolia>
References: <20220806153022.83748-1-zhangboyang.id@gmail.com>
 <20220806153022.83748-2-zhangboyang.id@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806153022.83748-2-zhangboyang.id@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 11:30:22PM +0800, Zhang Boyang wrote:
> Previously, for file-backed loop devices, REQ_OP_DISCARD and
> REQ_OP_WRITE_ZEROES (without REQ_NOUNMAP) are implemented using
> fallocate(FALLOC_FL_PUNCH_HOLE), which will cause the underlying file to
> be sparse and disk space freed. The users have no choice to prevent this
> this from happening.
> 
> This patch introduces LO_FLAGS_NO_DEALLOC. With this flag set,
> REQ_OP_DISCARD and REQ_OP_WRITE_ZEROES are forced to use
> fallocate(FALLOC_FL_ZERO_RANGE). The disk space of underlying file is
> kept allocated. This is useful if users, for example, want to use a
> preallocated file as the backing file.

Considering that discard isn't required to do anything, why not
echo 0 | sudo tee /sys/block/loopX/queue/discard_max_bytes ?

--D

> Signed-off-by: Zhang Boyang <zhangboyang.id@gmail.com>
> ---
>  drivers/block/loop.c      | 17 +++++++++++++++--
>  include/uapi/linux/loop.h | 15 +++++++++++----
>  2 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
> index 084f9b8a0ba3..36bd9906a154 100644
> --- a/drivers/block/loop.c
> +++ b/drivers/block/loop.c
> @@ -483,11 +483,15 @@ static int do_req_filebacked(struct loop_device *lo, struct request *rq)
>  		 * write zeroes the range.  Otherwise, punch them out.
>  		 */
>  		return lo_fallocate(lo, rq, pos,
> -			(rq->cmd_flags & REQ_NOUNMAP) ?
> +			((rq->cmd_flags & REQ_NOUNMAP) ||
> +			 (lo->lo_flags & LO_FLAGS_NO_DEALLOC)) ?
>  				FALLOC_FL_ZERO_RANGE :
>  				FALLOC_FL_PUNCH_HOLE);
>  	case REQ_OP_DISCARD:
> -		return lo_fallocate(lo, rq, pos, FALLOC_FL_PUNCH_HOLE);
> +		return lo_fallocate(lo, rq, pos,
> +			(lo->lo_flags & LO_FLAGS_NO_DEALLOC) ?
> +				FALLOC_FL_ZERO_RANGE :
> +				FALLOC_FL_PUNCH_HOLE);
>  	case REQ_OP_WRITE:
>  		if (cmd->use_aio)
>  			return lo_rw_aio(lo, cmd, pos, WRITE);
> @@ -719,12 +723,20 @@ static ssize_t loop_attr_dio_show(struct loop_device *lo, char *buf)
>  	return sysfs_emit(buf, "%s\n", dio ? "1" : "0");
>  }
>  
> +static ssize_t loop_attr_no_dealloc_show(struct loop_device *lo, char *buf)
> +{
> +	int no_dealloc = (lo->lo_flags & LO_FLAGS_NO_DEALLOC);
> +
> +	return sysfs_emit(buf, "%s\n", no_dealloc ? "1" : "0");
> +}
> +
>  LOOP_ATTR_RO(backing_file);
>  LOOP_ATTR_RO(offset);
>  LOOP_ATTR_RO(sizelimit);
>  LOOP_ATTR_RO(autoclear);
>  LOOP_ATTR_RO(partscan);
>  LOOP_ATTR_RO(dio);
> +LOOP_ATTR_RO(no_dealloc);
>  
>  static struct attribute *loop_attrs[] = {
>  	&loop_attr_backing_file.attr,
> @@ -733,6 +745,7 @@ static struct attribute *loop_attrs[] = {
>  	&loop_attr_autoclear.attr,
>  	&loop_attr_partscan.attr,
>  	&loop_attr_dio.attr,
> +	&loop_attr_no_dealloc.attr,
>  	NULL,
>  };
>  
> diff --git a/include/uapi/linux/loop.h b/include/uapi/linux/loop.h
> index 6f63527dd2ed..91a0a8b1f298 100644
> --- a/include/uapi/linux/loop.h
> +++ b/include/uapi/linux/loop.h
> @@ -18,17 +18,24 @@ enum {
>  	LO_FLAGS_AUTOCLEAR	= 4,
>  	LO_FLAGS_PARTSCAN	= 8,
>  	LO_FLAGS_DIRECT_IO	= 16,
> +	LO_FLAGS_NO_DEALLOC	= 32,
>  };
>  
>  /* LO_FLAGS that can be set using LOOP_SET_STATUS(64) */
> -#define LOOP_SET_STATUS_SETTABLE_FLAGS (LO_FLAGS_AUTOCLEAR | LO_FLAGS_PARTSCAN)
> +#define LOOP_SET_STATUS_SETTABLE_FLAGS (LO_FLAGS_AUTOCLEAR		\
> +					| LO_FLAGS_PARTSCAN		\
> +					| LO_FLAGS_NO_DEALLOC)
>  
>  /* LO_FLAGS that can be cleared using LOOP_SET_STATUS(64) */
> -#define LOOP_SET_STATUS_CLEARABLE_FLAGS (LO_FLAGS_AUTOCLEAR)
> +#define LOOP_SET_STATUS_CLEARABLE_FLAGS (LO_FLAGS_AUTOCLEAR		\
> +					 | LO_FLAGS_NO_DEALLOC)
>  
>  /* LO_FLAGS that can be set using LOOP_CONFIGURE */
> -#define LOOP_CONFIGURE_SETTABLE_FLAGS (LO_FLAGS_READ_ONLY | LO_FLAGS_AUTOCLEAR \
> -				       | LO_FLAGS_PARTSCAN | LO_FLAGS_DIRECT_IO)
> +#define LOOP_CONFIGURE_SETTABLE_FLAGS (LO_FLAGS_READ_ONLY		\
> +				       | LO_FLAGS_AUTOCLEAR		\
> +				       | LO_FLAGS_PARTSCAN		\
> +				       | LO_FLAGS_DIRECT_IO		\
> +				       | LO_FLAGS_NO_DEALLOC)
>  
>  #include <asm/posix_types.h>	/* for __kernel_old_dev_t */
>  #include <linux/types.h>	/* for __u64 */
> -- 
> 2.30.2
> 
