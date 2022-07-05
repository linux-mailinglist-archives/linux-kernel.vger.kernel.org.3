Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40C05671B2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 17:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiGEO7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiGEO7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:59:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F38D140F8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22D09B817E0
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 413FBC341C7;
        Tue,  5 Jul 2022 14:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657033186;
        bh=P+EcrXXNEt/rePwEWGeD5bu+qo1aM95IAgvORAW4fBM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Fpvm46HdJEWljCVfIaAndcBmtxjvLtlmuXG9JuT+Qv0WEKVadEnx2iQvzIhc1n1qz
         68uQQ6flFLXeoNalzJFnNyMuQqn7tGOgv9xDR0zhsdg4umIkzCQ/i0T14EI6gs3q2x
         bn9TvMyl4WwJAuayY0jp6x0x+Z3YyYv3cZaYfQx70gyQULgR0u+ZuYBlaZezsBXfiT
         V365COmz6LJ9qgi05b+I1lIZPy/5g4+PQfDqGEHeWyhI18CmZK9jNphVyLONZqnMYr
         cgMFU51yN8DfPzJp4I2mPpWRuwjre7YrGtMuiRmafg6K1Rwyzb1ju5qfnpTRjaB+CR
         3LZzNvEwWaT+w==
Message-ID: <243e8ec016b415d71849d8d5c92394ef67a8ca04.camel@kernel.org>
Subject: Re: [Linux-cachefs] [PATCH] fscache: Fix if condition in
 fscache_wait_on_volume_collision()
From:   Jeff Layton <jlayton@kernel.org>
To:     Yue Hu <huyue2@coolpad.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com
Cc:     zhangwen@coolpad.com, linux-kernel@vger.kernel.org,
        zbestahu@gmail.com
Date:   Tue, 05 Jul 2022 10:59:45 -0400
In-Reply-To: <20220525023212.32642-1-huyue2@coolpad.com>
References: <20220525023212.32642-1-huyue2@coolpad.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-25 at 10:32 +0800, Yue Hu wrote:
> After waiting for the volume to complete the acquisition with timeout,
> the if condition under which potential volume collision occurs should be
> acquire the volume is still pending rather than not pending so that we
> will continue to wait until the pending flag is cleared. Also, use the
> existing test pending wrapper directly instead of test_bit().
>=20
> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> ---
>  fs/fscache/volume.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/fscache/volume.c b/fs/fscache/volume.c
> index 71d3a6d6d72c..f2009cc22002 100644
> --- a/fs/fscache/volume.c
> +++ b/fs/fscache/volume.c
> @@ -143,7 +143,7 @@ static void fscache_wait_on_volume_collision(struct f=
scache_volume *candidate,
>  {
>  	wait_var_event_timeout(&candidate->flags,
>  			       !fscache_is_acquire_pending(candidate), 20 * HZ);
> -	if (!fscache_is_acquire_pending(candidate)) {
> +	if (fscache_is_acquire_pending(candidate)) {
>  		pr_notice("Potential volume collision new=3D%08x old=3D%08x",
>  			  candidate->debug_id, collidee_debug_id);
>  		fscache_stat(&fscache_n_volumes_collision);
> @@ -182,7 +182,7 @@ static bool fscache_hash_volume(struct fscache_volume=
 *candidate)
>  	hlist_bl_add_head(&candidate->hash_link, h);
>  	hlist_bl_unlock(h);
> =20
> -	if (test_bit(FSCACHE_VOLUME_ACQUIRE_PENDING, &candidate->flags))
> +	if (fscache_is_acquire_pending(candidate))
>  		fscache_wait_on_volume_collision(candidate, collidee_debug_id);
>  	return true;
> =20

Nice catch:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
