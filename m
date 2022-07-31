Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1D4585CC7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 03:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiGaBWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 21:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiGaBWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 21:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D6113E1B
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jul 2022 18:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F309360FE5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 01:22:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D43C433C1;
        Sun, 31 Jul 2022 01:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659230539;
        bh=+JDFzr0rIHbOOzwsVagV8xXUPfCyfziwvLXSfsBNeR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gqzl88ia55Ui5VHLB6miDo0pdctIC5Q8hh2HKpECT/grdBP0+22WCMvIoxEDR+nDt
         Wvq72HAVzcJa7/0aKQDVAyKDKLiL9XlvwntvQn/Aw+9KV/+a6ORsOTki7HOB28I/FC
         wgL7YZMb+beK21aEKyE6bAYyXv0z/VkafPIM/5YeWqomRQHhOlWwYIWr0nB1UToa+o
         XVI0xe8oieflGXlH+edthBmUepMJrRkftJTi3MqGNbm5tC4R3Xzh9NzvYzjchvnJiS
         XyblyC1FdMXHYechJn9CToWTApwdpBZTTzaLkKHi1dEuAZRw0KpY0qOiJtwjRdiJoY
         1+brv9oTWs57A==
Date:   Sat, 30 Jul 2022 18:22:17 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eunhee Rho <eunhee83.rho@samsung.com>
Cc:     "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v0] f2fs: allow direct read for zoned device
Message-ID: <YuXZSTw4reBDtLgk@google.com>
References: <CGME20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
 <20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729002517epcms2p35eed262c3349287436c1848ab350c2d4@epcms2p3>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/29, Eunhee Rho wrote:
> For zoned devices, f2fs forbids direct IO and forces buffered IO
> to serialize write IOs. However, the constraint does not apply to
> read IOs.
> 
> Signed-off-by: Eunhee Rho <eunhee83.rho@samsung.com>
> ---
>  fs/f2fs/f2fs.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index d0f428aef34b..f69731f17402 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4471,7 +4471,7 @@ static inline bool f2fs_force_buffered_io(struct inode *inode,
>  	 * for blkzoned device, fallback direct IO to buffered IO, so
>  	 * all IOs can be serialized by log-structured write.
>  	 */
> -	if (f2fs_sb_has_blkzoned(sbi))
> +	if (f2fs_sb_has_blkzoned(sbi) && (rw == WRITE))
>  		return true;

Actually we don't need to check the device type, but rely on the
filesystem allocation policy like the below lfs mode. Can we remove this
line simply?

>  	if (f2fs_lfs_mode(sbi) && (rw == WRITE)) {
>  		if (block_unaligned_IO(inode, iocb, iter))
> -- 
> 2.25.1
