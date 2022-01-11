Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C913B48B683
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 20:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350345AbiAKTKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 14:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243149AbiAKTKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:10:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C1C06173F;
        Tue, 11 Jan 2022 11:10:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C07061727;
        Tue, 11 Jan 2022 19:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03745C36AE3;
        Tue, 11 Jan 2022 19:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928237;
        bh=qmKCuoNw704bDeh7L4g6m5F2I/O7DL+oovNuO+zidxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWfE54au3cW8vgT2DKB8Xk+vKGqg58Y20DpMTbAbzheJVYNM+o20wtww20uG4kSgd
         LcMK28GRQCfOLL38Pv9ILipGatxt6Xtnv2MvpGKQcITZsCrxJ0rR5rkdNJdvmfv15Q
         S72JG4gnGz20Yh0ma7+36gr82SlHV+PagPIN3QAlNyKnHkCNgIFyjBvhmcut4PyJ4+
         xKIJdEJE7scmOPu1DkePibTl370urn/1C6aWm5bZsM2xFAdctWgKzR9Pd6dXAe4GiS
         P91kjYSwSRTJN4GU4Ov76OmTJ+Lj+0layikvcoyxdgiF1f4NySMr2VzVuJGOUSgDJG
         dNQSLsT1NbXNw==
Date:   Tue, 11 Jan 2022 11:10:36 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     cgel.zte@gmail.com
Cc:     linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] xfs: use swap() to make code cleaner
Message-ID: <20220111191036.GD656707@magnolia>
References: <20211028112830.16381-1-deng.changcheng@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211028112830.16381-1-deng.changcheng@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 11:28:30AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Use swap() in order to make code cleaner. Issue found by coccinelle.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Odd, I pushed this into 5.16 but never publicly RVB'd it.

Sloppy, Darrick, sloopy...

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/xfs_inode.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index a4f6f034fb81..518c82bfc80d 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -564,8 +564,6 @@ xfs_lock_two_inodes(
>  	struct xfs_inode	*ip1,
>  	uint			ip1_mode)
>  {
> -	struct xfs_inode	*temp;
> -	uint			mode_temp;
>  	int			attempts = 0;
>  	struct xfs_log_item	*lp;
>  
> @@ -578,12 +576,8 @@ xfs_lock_two_inodes(
>  	ASSERT(ip0->i_ino != ip1->i_ino);
>  
>  	if (ip0->i_ino > ip1->i_ino) {
> -		temp = ip0;
> -		ip0 = ip1;
> -		ip1 = temp;
> -		mode_temp = ip0_mode;
> -		ip0_mode = ip1_mode;
> -		ip1_mode = mode_temp;
> +		swap(ip0, ip1);
> +		swap(ip0_mode, ip1_mode);
>  	}
>  
>   again:
> -- 
> 2.25.1
> 
