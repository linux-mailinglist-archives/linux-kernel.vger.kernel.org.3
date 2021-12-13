Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D179447385B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 00:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244168AbhLMXWw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 18:22:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbhLMXWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 18:22:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFFDC061574;
        Mon, 13 Dec 2021 15:22:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04043612BA;
        Mon, 13 Dec 2021 23:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BABC8C34601;
        Mon, 13 Dec 2021 23:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639437770;
        bh=u7Kel0+0ccO1Da8cNlI1rybWn6ykZj9EAsVVNG6GBDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkMAiGXcQjVPohxFUWXmZU4qt/FQxzeoBUMhTKM0zFWCesiFmdvg8OqTZB8umgLcU
         0MIASMr4trRABy5lXotJp2JZdXYl5PuU2CaotpKaXA85qDJG/Bm67+Er6rEXKK6FT3
         MTXiWZ/sQSus+J298YMe1TxwV0tY08ZlCCfCon39A9DYErBIwDtAKeBekW2pVd8gOl
         Ru4jrrS5Exqx0QFY41+CWahrb7Hfn8jSweseQDDFMfeM0V7L88g08n0ZErECf/lWdz
         YWbdsVjBF5dXR1DDlwIyQqwVxz+cCXGxc30zkWy+Yz/pZncOrjmEvxkrhECdx1DkGd
         7XZinRD++8wQg==
Date:   Mon, 13 Dec 2021 17:28:28 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] drbd: Use struct_group() to zero algs
Message-ID: <20211213232828.GC60133@embeddedor>
References: <20211118203712.1288866-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211118203712.1288866-1-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 12:37:12PM -0800, Kees Cook wrote:
> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> field bounds checking for memset(), avoid intentionally writing across
> neighboring fields.
> 
> Add a struct_group() for the algs so that memset() can correctly reason
> about the size.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/block/drbd/drbd_main.c     | 3 ++-
>  drivers/block/drbd/drbd_protocol.h | 6 ++++--
>  drivers/block/drbd/drbd_receiver.c | 3 ++-
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 53ba2dddba6e..feac72e323bd 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -729,7 +729,8 @@ int drbd_send_sync_param(struct drbd_peer_device *peer_device)
>  	cmd = apv >= 89 ? P_SYNC_PARAM89 : P_SYNC_PARAM;
>  
>  	/* initialize verify_alg and csums_alg */
> -	memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
> +	BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
> +	memset(&p->algs, 0, sizeof(p->algs));
>  
>  	if (get_ldev(peer_device->device)) {
>  		dc = rcu_dereference(peer_device->device->ldev->disk_conf);
> diff --git a/drivers/block/drbd/drbd_protocol.h b/drivers/block/drbd/drbd_protocol.h
> index dea59c92ecc1..a882b65ab5d2 100644
> --- a/drivers/block/drbd/drbd_protocol.h
> +++ b/drivers/block/drbd/drbd_protocol.h
> @@ -283,8 +283,10 @@ struct p_rs_param_89 {
>  
>  struct p_rs_param_95 {
>  	u32 resync_rate;
> -	char verify_alg[SHARED_SECRET_MAX];
> -	char csums_alg[SHARED_SECRET_MAX];
> +	struct_group(algs,
> +		char verify_alg[SHARED_SECRET_MAX];
> +		char csums_alg[SHARED_SECRET_MAX];
> +	);
>  	u32 c_plan_ahead;
>  	u32 c_delay_target;
>  	u32 c_fill_target;
> diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
> index 1f740e42e457..6df2539e215b 100644
> --- a/drivers/block/drbd/drbd_receiver.c
> +++ b/drivers/block/drbd/drbd_receiver.c
> @@ -3921,7 +3921,8 @@ static int receive_SyncParam(struct drbd_connection *connection, struct packet_i
>  
>  	/* initialize verify_alg and csums_alg */
>  	p = pi->data;
> -	memset(p->verify_alg, 0, 2 * SHARED_SECRET_MAX);
> +	BUILD_BUG_ON(sizeof(p->algs) != 2 * SHARED_SECRET_MAX);
> +	memset(&p->algs, 0, sizeof(p->algs));
>  
>  	err = drbd_recv_all(peer_device->connection, p, header_size);
>  	if (err)
> -- 
> 2.30.2
> 
> 
> 
> 
