Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 620815688E8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiGFND4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiGFNDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:03:55 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60091582D;
        Wed,  6 Jul 2022 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nD/aqJU0V41bWXT6P36l4XHLuMfgkO3GGtQpfGI2ywI=; b=x0EJkDkXitmxoeJzqogaK4bQIE
        ALOdZhyoMDBwdqovGnEVunRzWDjLmdJD7U2J6RwLOl1puU8yIeRivZxF4q4Ax6fto1InE3pfp98gk
        K1M40Ttxtf70UOwCeDCL2fE9yacGmp/Ua7BCk7/o82lMaVh0GYutMzor1uSyLX5BMJzPyT37Cwquo
        cQNp0Co+6aR+lhHx/vFu1gafDL8fIHec4YA8m1Ha2NpXIGaRH2BgaLtUrhykhgiXxF5piFC4EAGFB
        N3UFVeO6/pnSsT6xiKP/FvrczIcZLb39/v8QIuFnuymcj7F/VQxSJbwLpnU4w5KTwo33T5ilQ8Rlp
        n2SClWhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o94h7-00A938-DJ; Wed, 06 Jul 2022 13:03:53 +0000
Date:   Wed, 6 Jul 2022 06:03:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Sergei Shtepa <sergei.shtepa@veeam.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/20] block, blksnap: header file of the module interface
Message-ID: <YsWIOYqO4QVnd2Ru@infradead.org>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
 <1655135593-1900-3-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655135593-1900-3-git-send-email-sergei.shtepa@veeam.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 06:52:55PM +0300, Sergei Shtepa wrote:
> The header file contains a set of declarations, structures and control
> requests (ioctl) that allows to manage the module from the user space.

I think this should go into include/uapi/ if you want it in a global
place.

> +#pragma once

In the kernel we use classic #ifdef based guards.

> +#include <linux/types.h>
> +#include <linux/uuid.h>

The uuid_t type can't be used in a userspae API.  Please use a raw
__u8 API and then use import_uuid.

> +#define BLK_SNAP_MODULE_NAME "blksnap"

Does this belong into a user interface?

> +#define BLK_SNAP_IMAGE_NAME "blksnap-image"
> +#define BLK_SNAP 'V'
> +
> +enum blk_snap_ioctl {
> +	/*
> +	 * Service controls
> +	 */
> +	blk_snap_ioctl_version,
> +	/*
> +	 * Contols for tracking
> +	 */
> +	blk_snap_ioctl_tracker_remove,
> +	blk_snap_ioctl_tracker_collect,
> +	blk_snap_ioctl_tracker_read_cbt_map,
> +	blk_snap_ioctl_tracker_mark_dirty_blocks,
> +	/*
> +	 * Snapshot contols
> +	 */
> +	blk_snap_ioctl_snapshot_create,
> +	blk_snap_ioctl_snapshot_destroy,
> +	blk_snap_ioctl_snapshot_append_storage,
> +	blk_snap_ioctl_snapshot_take,
> +	blk_snap_ioctl_snapshot_collect,
> +	blk_snap_ioctl_snapshot_collect_images,
> +	blk_snap_ioctl_snapshot_wait_event,
> +	blk_snap_ioctl_end,

For uapis classic #defines have the adnvantage that userspace can test
for their presence if new ones get added.  Also the _end one should not
be in an UAPI header as new ones can be added at any time.

