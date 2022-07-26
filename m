Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC175809C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 05:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237469AbiGZDGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 23:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237452AbiGZDGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 23:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051A265CE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 20:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F9D60AB0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 03:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE69AC341C6;
        Tue, 26 Jul 2022 03:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658804763;
        bh=BG5qK3aJ/NArmA2+kWBQy2r1JAy+zCyYOayPl9ugDfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gNz798HYTU/vWDTpnLj3UldzbmHe/kraKhjQj8MMOoEluvKYZ7YCKPFOCozP7i7D/
         5UFKF9MmHJu5uii3D1nNO74Ec85KyzJlKXMQ7JZ8KkiYjalA2jV4mhIv1zzfue3Nhj
         /5uwVEkPXNbfCjng2j+XL834c7laIkR5zjpODxE9rpMMYNpjOOlBBFqj4HjSXqse5s
         Xq2Zb7w/oJna1yA8ljf+rAOd/7D+o4eBT6NqLWz7RzlaCAoDncxYPB1ZM9SNZ2Darn
         CoKOd7ZoNz+vq4G3X0tPANV/D/R6Ky/bGWxEjb9ZYj2wU8IpRVeLqEkB1JHry4tBR/
         zRk50SZnYtVQA==
Date:   Mon, 25 Jul 2022 20:06:01 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Nathan Huckleberry <nhuck@google.com>,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH 3/3] dm-verity: Add try_verify_in_tasklet
Message-ID: <Yt9aGRXNNPGZFvld@sol.localdomain>
References: <20220722093823.4158756-1-nhuck@google.com>
 <20220722093823.4158756-4-nhuck@google.com>
 <Yt9KTzXUeA8xAiGv@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt9KTzXUeA8xAiGv@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 09:58:39PM -0400, Mike Snitzer wrote:
> 
> > @@ -1156,7 +1217,7 @@ static int verity_ctr(struct dm_target *ti, unsigned argc, char **argv)
> >  		goto bad;
> >  	}
> >  
> > -	v->tfm = crypto_alloc_ahash(v->alg_name, 0, 0);
> > +	v->tfm = crypto_alloc_ahash(v->alg_name, 0, CRYPTO_ALG_ASYNC);
> >  	if (IS_ERR(v->tfm)) {
> >  		ti->error = "Cannot initialize hash function";
> >  		r = PTR_ERR(v->tfm);
> 
> This hunk that adds the CRYPTO_ALG_ASYNC flag _seems_ unrelated.

I believe it's needed to ensure that only a synchronous algorithm is allocated,
so that verity_hash_update() doesn't have to sleep during the tasklet.  It
should be conditional on v->use_tasklet, though.

> @@ -321,14 +320,12 @@ static int verity_verify_level(struct dm_verity *v, struct dm_verity_io *io,
>  		if (likely(memcmp(verity_io_real_digest(v, io), want_digest,
>  				  v->digest_size) == 0))
>  			aux->hash_verified = 1;
> -		else if (io->in_tasklet) {
> +		else if (io->in_tasklet)
>  			/*
>  			 * FEC code cannot be run in a tasklet since it may
> -			 * sleep.  We need to resume execution in a work-queue
> -			 * to handle FEC.
> +			 * sleep, so fallback to using a work-queue.
>  			 */
>  			return -EAGAIN;
> -		}


Doesn't this need to be:

			r = -EAGAIN;
			goto release_ret_r;

- Eric
