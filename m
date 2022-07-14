Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9861F5755AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiGNTQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiGNTQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:16:22 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7212D2DA88
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=Tkxkd+pdE19XC0lUU8oQ8Peb4YvHVWYiASesMiTlbkA=; b=aBWehos5u3QQ6zPND9TqxbbuSv
        21buZRhuZOirrfTY6IvbvL/WPWQzQwX8B4cD3bcuZhnPZVj8OIXGML0Fh4o5eyRw23XdAS0yQKOed
        SA/i014SKaKlo2kikH2XDdvpV9mxs0SwZU0HTA/Q/wmovTxmq9rSHuW7KJHD8gv3KhA2+QdOO7XFd
        EMqvd7iQGAWLqyXhhAr+4SO3SnCYMFg2HXL8vTAbAUrueqJFWkLnOnLCDud3BMRh80QZmF3iNM5VC
        GKLdHoULMZbL3W+GQwUUgiOgZ9GhwpDOFl74fOaGsbBG2H+k82Qi59NeAfmiJ7vNyAjEvoNuhWeyf
        eX5LIk7xzJgjWocySGfbSJQbMZER3NU0twvnzrMwspnCrX5Umydu+48kMT0y7SuDjXkhLbGH5jDbW
        YM2ObQWjVzvoZ5jBt1hNLOlhXZSWROftZo0A0QzWeY7uyUxE1Sf6upSn8juF6iJj7REUrhMccxwfN
        WVw2BJbTJne3buHSPGA5eyphwzSZyEEiv3m7yVZHw5Te8beP8XuLKfJv4H/S1uUjhLb5CCupDpvrS
        ZWNAwx03vnjuf5m8BfpfdlOL+FQTz2Cz4yT6007IPIUAlmcyfR6U2bwB5Y/K3MyIQUCruzqCs3rh5
        X8mYCxX4OHKxUb/aOCrdCBcwQPhqOfYCkA/fyYvmo=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Greg Kurz <groug@kaod.org>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [RFC PATCH] 9p: forbid use of mempool for TFLUSH
Date:   Thu, 14 Jul 2022 21:16:14 +0200
Message-ID: <2229731.hRsvSkCM7u@silver>
In-Reply-To: <20220713041700.2502404-1-asmadeus@codewreck.org>
References: <12950409.o0bIpVV1Ut@silver>
 <20220713041700.2502404-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mittwoch, 13. Juli 2022 06:17:01 CEST Dominique Martinet wrote:
> TFLUSH is called while the thread still holds memory for the
> request we're trying to flush, so mempool alloc can deadlock
> there. With p9_msg_buf_size() rework the flush allocation is
> small so just make it fail if allocation failed; all that does
> is potentially leak the request we're flushing until its reply
> finally does come.. or if it never does until umount.
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---

Patch looks fine on first impression, but I'll postpone testing this. And yes, 
I also think that exempting Tflush should be fair. If 4k (soon) cannot be 
allocated, then you probably have worse problems than that.

> Here's a concrete version of what I had in mind: literally just make
> allocation fail if the initial alloc failed.
> 
> I can't reproduce any bad hang with a sane server here, but we still
> risk hanging with a bad server that ignores flushes as these are still
> unkillable (someday I'll finish my async requests work...)
> 
> So ultimately there are two things I'm not so happy about with mempools:
>  - this real possibility of client hangs if a server mishandles some
> replies -- this might make fuzzing difficult in particular, I think it's

Concrete example of such a mishap?

> easier to deal with failed IO (as long as it fails all the way back to
> userspace) than to hang forever.
> I'm sure there are others who prefer to wait instead, but I think this
> should at least have a timeout or something.

Not sure if it was easy to pick an appropriate timeout value. I've seen things 
slowing down extremely with 9p after a while. But to be fair, these were on 
production machines with ancient kernel versions, so maybe already fixed.

A proc interface would be useful though to be able to identify things like 
piling up too many fids and other performance related numbers.

>  - One of the reasons I wanted to drop the old request cache before is
> that these caches are per mount/connection. If you have a dozen of
> mounts that each cache 4 requests worth as here, with msize=1MB and two
> buffers per request we're locking down 8 * 12 = 96 MB of ram just for
> mounting.
> That being said, as long as hanging is a real risk I'm not comfortable
> sharing the mempools between all the clients either, so I'm not sure
> what to suggest.

Why would a shared mempool increase the chance of a hang or worsen its 
outcome?

> Anyway, we're getting close to the next merge request and I don't have
> time to look deeper into this; I'll be putting the mempool patches on
> hold for next cycle at least and we can discuss again if Kent still
> encounters allocation troubles with Christian's smaller buffers
> optimization first.
> These will very likely get in this cycle unless something bad happens,
> I've finished retesting a bit without trouble here.
> 
> 
>  net/9p/client.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/net/9p/client.c b/net/9p/client.c
> index 928c9f88f204..f9c17fb79f35 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -218,7 +218,7 @@ static int parse_opts(char *opts, struct p9_client
> *clnt) return ret;
>  }
> 
> -static void p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
> +static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
>  			  int fc_idx, unsigned alloc_msize)
>  {
>  	gfp_t gfp = GFP_NOFS|__GFP_NOWARN;
> @@ -232,11 +232,13 @@ static void p9_fcall_init(struct p9_client *c, struct
> p9_fcall *fc, if (alloc_msize < c->msize)
>  		fc->sdata = kmalloc(alloc_msize, gfp);
> 
> -	if (!fc->sdata) {
> +	if (!fc->sdata && fc_idx >= 0) {
>  		fc->sdata = mempool_alloc(&c->pools[fc_idx], gfp);
>  		fc->used_mempool = true;
>  		fc->capacity = c->msize;
>  	}
> +
> +	return fc->sdata == NULL;
>  }
> 
>  void p9_fcall_fini(struct p9_client *c, struct p9_fcall *fc,
> @@ -280,6 +282,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint
> t_size, uint r_size, struct p9_req_t *req = kmem_cache_alloc(p9_req_cache,
> GFP_NOFS); int alloc_tsize;
>  	int alloc_rsize;
> +	int fc_idx = 0;
>  	int tag;
>  	va_list apc;
> 
> @@ -294,8 +297,19 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint
> t_size, uint r_size, if (!req)
>  		return ERR_PTR(-ENOMEM);
> 
> -	p9_fcall_init(c, &req->tc, 0, alloc_tsize);
> -	p9_fcall_init(c, &req->rc, 1, alloc_rsize);
> +	/* We cannot use the mempool for TFLUSH because flushes can be
> +	 * allocated when the thread still holds memory for the request
> +	 * we're flushing. A negative fc_idx will make p9_fcall_init
> +	 * error out.
> +	 */
> +	if (type == P9_TFLUSH) {
> +		fc_idx = -2;
> +	}
> +
> +	if (p9_fcall_init(c, &req->tc, fc_idx, alloc_tsize))
> +		goto free_req;
> +	if (p9_fcall_init(c, &req->rc, fc_idx + 1, alloc_rsize))
> +		goto free;
> 
>  	p9pdu_reset(&req->tc);
>  	p9pdu_reset(&req->rc);
> @@ -334,6 +348,7 @@ p9_tag_alloc(struct p9_client *c, int8_t type, uint
> t_size, uint r_size, free:
>  	p9_fcall_fini(c, &req->tc, 0);
>  	p9_fcall_fini(c, &req->rc, 1);
> +free_req:
>  	kmem_cache_free(p9_req_cache, req);
>  	return ERR_PTR(-ENOMEM);
>  }




