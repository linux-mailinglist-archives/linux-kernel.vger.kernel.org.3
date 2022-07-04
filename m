Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2F1564BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiGDCXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiGDCXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:23:09 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FEA655E
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 19:23:07 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 83CA8C01C; Mon,  4 Jul 2022 04:23:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656901385; bh=q8wO2Giah1CU56v0XUb1wFCi91xX9n08Z7n0ybE+2AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PkpuaVl9eDrSEl/dDfcz2NQnG18VYnoHQyhQq7flanNlQAFbTke16IrL4ibJDmQV+
         k6AUYSSzxn0Y/xHLaNedDu1PBXusu8uvmKg/0OYmiKJwqAWAkG0CdHKBEjtrl3q5TR
         U+7FEvUrKnSFAqFlkbCR7FffM9bv77nLWj1dZsuUwZyJvy/rOOiQA0Y5RcSKRDCApQ
         rA4hqhFS5ftpq7wIX+E7Bo2QzI2R0d6NrBpXEup1SutQWRtXII0nda8uR672xd8Z7/
         8227PCUAa46jFgv3HGJJSoFBWCV9kA1QsWCrTIfhteFxRqa+WPAdXhuuPR+BY8JxYX
         80qWVBPJXMHFw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id D3D49C009;
        Mon,  4 Jul 2022 04:23:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1656901384; bh=q8wO2Giah1CU56v0XUb1wFCi91xX9n08Z7n0ybE+2AI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owjueqXCFJZsSfm2J9G1xNZVCNRnlIS5jgMBguCtmJvpq5iHvxH7lCvyjyGBSaYvV
         e+rdLH87udm1wqA9LDWhzNF4zZ/zzHmhI4qPtAM88IJN3YtiVn6RM0cxqT4oGwRkW3
         pg5c6OlcEse0l2TLlNq7svyxXcBbXBm1WJdYiWX/V/8JSjc8LA/DltcGbqCxw/NvBl
         1NINJzIbdZ95fbbJ+FEylJJVQReS63v4KfLH7iTd7hEZv+s1NIzNWFfToItPrdYvJT
         6Gz3+UOdwLKPvbwvMbo/Ub8zpOqNTxWNOV+V/GmHbbJLMtAtpKw9toIdl1Gq2ERm+e
         AM6CoYE0HHAKQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id 91b7738f;
        Mon, 4 Jul 2022 02:22:57 +0000 (UTC)
Date:   Mon, 4 Jul 2022 11:22:42 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Message-ID: <YsJO8gJeRwf96yTi@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <20220704014243.153050-1-kent.overstreet@gmail.com>
 <20220704014243.153050-3-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220704014243.153050-3-kent.overstreet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patches!

first two patches look good, couple of comments below for this one

Kent Overstreet wrote on Sun, Jul 03, 2022 at 09:42:43PM -0400:
> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: Eric Van Hensbergen <ericvh@gmail.com>
> Cc: Latchesar Ionkov <lucho@ionkov.net>
> Cc: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  include/net/9p/9p.h     |  6 ++++-
>  include/net/9p/client.h |  5 +++-
>  net/9p/client.c         | 58 ++++++++++++++++++++++++++++++-----------
>  net/9p/trans_rdma.c     |  2 +-
>  4 files changed, 53 insertions(+), 18 deletions(-)
> 
> diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
> index 24a509f559..c0d59b53c1 100644
> --- a/include/net/9p/9p.h
> +++ b/include/net/9p/9p.h
> @@ -539,12 +539,16 @@ struct p9_rstatfs {
>  struct p9_fcall {
>  	u32 size;
>  	u8 id;
> +	enum p9_fcall_alloc {
> +		P9_FCALL_KMEM_CACHE,
> +		P9_FCALL_KMALLOC,
> +		P9_FCALL_MEMPOOL,
> +	} allocated;
>  	u16 tag;
>  
>  	size_t offset;
>  	size_t capacity;
>  
> -	struct kmem_cache *cache;
>  	u8 *sdata;
>  };
>  
> diff --git a/include/net/9p/client.h b/include/net/9p/client.h
> index cb78e0e333..6517ca36bf 100644
> --- a/include/net/9p/client.h
> +++ b/include/net/9p/client.h
> @@ -9,6 +9,7 @@
>  #ifndef NET_9P_CLIENT_H
>  #define NET_9P_CLIENT_H
>  
> +#include <linux/mempool.h>
>  #include <linux/utsname.h>
>  #include <linux/idr.h>
>  
> @@ -106,6 +107,7 @@ struct p9_client {
>  	enum p9_trans_status status;
>  	void *trans;
>  	struct kmem_cache *fcall_cache;
> +	mempool_t pools[2];
>  
>  	union {
>  		struct {
> @@ -222,7 +224,8 @@ int p9_client_mkdir_dotl(struct p9_fid *fid, const char *name, int mode,
>  				kgid_t gid, struct p9_qid *qid);
>  int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status);
>  int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *fl);
> -void p9_fcall_fini(struct p9_fcall *fc);
> +void p9_fcall_fini(struct p9_client *c, struct p9_fcall *fc,
> +		   int fc_idx);
>  struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag);
>  
>  static inline void p9_req_get(struct p9_req_t *r)
> diff --git a/net/9p/client.c b/net/9p/client.c
> index a36a40137c..82061c49cb 100644
> --- a/net/9p/client.c
> +++ b/net/9p/client.c
> @@ -219,22 +219,34 @@ static int parse_opts(char *opts, struct p9_client *clnt)
>  }
>  
>  static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
> -			 int alloc_msize)
> +			 int fc_idx, unsigned alloc_msize)
>  {
> +	WARN(alloc_msize > c->msize, "alloc_mize %u client msize %u",
> +	     alloc_msize, c->msize);
> +
>  	if (likely(c->fcall_cache) && alloc_msize == c->msize) {
>  		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
> -		fc->cache = c->fcall_cache;
> +		fc->allocated = P9_FCALL_KMEM_CACHE;
>  	} else {
>  		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
> -		fc->cache = NULL;
> +		fc->allocated = P9_FCALL_KMALLOC;
>  	}
> -	if (!fc->sdata)
> +
> +	if (!fc->sdata >> alloc_msize > c->msize)
>  		return -ENOMEM;

probably meant && instead of >> ?

I'd also move this alloc_msize > c->msize check just below the warn to
keep it early if you want to keep it, but if we want to warn here it
really should be in p9_tag_alloc that alreadys cuts the user argument
short with a `min(c->msize, max_size)`

We shouldn't have any user calling with more at this point (the
user-provided size comes from p9_client_prepare_req arguments and it's
either msize or header size constants); and it probably makes sense to
check and error out rather than cap it.

> +
> +	if (!fc->sdata) {
> +		fc->sdata = mempool_alloc(&c->pools[fc_idx], GFP_NOFS);
> +		fc->allocated = P9_FCALL_MEMPOOL;
> +		alloc_msize = c->msize;

hm, so you try with the kmalloc/kmem_cache first and only fallback to
mempool if that failed?

What's the point of keeping the kmem cache in this case, instead of
routing all size-appropriate requests to the mempool?
(honest question)

> +	}
> +
>  	fc->capacity = alloc_msize;
>  	return 0;
>  }
>  
> -void p9_fcall_fini(struct p9_fcall *fc)
> +void p9_fcall_fini(struct p9_client *c, struct p9_fcall *fc,
> +		   int fc_idx)
>  {
>  	/* sdata can be NULL for interrupted requests in trans_rdma,
>  	 * and kmem_cache_free does not do NULL-check for us
> @@ -242,10 +254,17 @@ void p9_fcall_fini(struct p9_fcall *fc)
>  	if (unlikely(!fc->sdata))
>  		return;
>  
> -	if (fc->cache)
> -		kmem_cache_free(fc->cache, fc->sdata);
> -	else
> +	switch (fc->allocated) {
> +	case P9_FCALL_KMEM_CACHE:
> +		kmem_cache_free(c->fcall_cache, fc->sdata);
> +		break;
> +	case P9_FCALL_KMALLOC:
>  		kfree(fc->sdata);
> +		break;
> +	case P9_FCALL_MEMPOOL:
> +		mempool_free(fc->sdata, &c->pools[fc_idx]);
> +		break;
> +	}
>  }
>  EXPORT_SYMBOL(p9_fcall_fini);
>  
> @@ -270,9 +289,9 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  	if (!req)
>  		return ERR_PTR(-ENOMEM);
>  
> -	if (p9_fcall_init(c, &req->tc, alloc_msize))
> +	if (p9_fcall_init(c, &req->tc, 0, alloc_msize))
>  		goto free_req;
> -	if (p9_fcall_init(c, &req->rc, alloc_msize))
> +	if (p9_fcall_init(c, &req->rc, 1, alloc_msize))

given the two rc/tc buffers are of same size I don't see the point of
using two caches either, you could just double the min number of
elements to the same effect?

>  		goto free;
>  
>  	p9pdu_reset(&req->tc);
> @@ -310,8 +329,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
>  	return req;
>  
>  free:
> -	p9_fcall_fini(&req->tc);
> -	p9_fcall_fini(&req->rc);
> +	p9_fcall_fini(c, &req->tc, 0);
> +	p9_fcall_fini(c, &req->rc, 1);
>  free_req:
>  	kmem_cache_free(p9_req_cache, req);
>  	return ERR_PTR(-ENOMEM);
> @@ -373,8 +392,8 @@ static int p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
>  int p9_req_put(struct p9_client *c, struct p9_req_t *r)
>  {
>  	if (refcount_dec_and_test(&r->refcount)) {
> -		p9_fcall_fini(&r->tc);
> -		p9_fcall_fini(&r->rc);
> +		p9_fcall_fini(c, &r->tc, 0);
> +		p9_fcall_fini(c, &r->rc, 1);
>  		kmem_cache_free(p9_req_cache, r);
>  		return 1;
>  	}
> @@ -999,7 +1018,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  	char *client_id;
>  
>  	err = 0;
> -	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
> +	clnt = kzalloc(sizeof(*clnt), GFP_KERNEL);

yes, thanks. Can simplify exit path a bit more with that but I'll do it.

>  	if (!clnt)
>  		return ERR_PTR(-ENOMEM);
>  
> @@ -1063,6 +1082,11 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  					   clnt->msize - (P9_HDRSZ + 4),
>  					   NULL);
>  
> +	err =   mempool_init_kmalloc_pool(&clnt->pools[0], 4, clnt->msize) ?:
> +		mempool_init_kmalloc_pool(&clnt->pools[1], 4, clnt->msize);

I was thinking of using the slab helpers when I looked at it earlier,
e.g.
  mempool_init_slab_pool(XYZ, clnt->fcall_cache);

Are there any real differences between the two?

(that also made me notice create/init difference, I agree init is
probably better than create here)

-- 
Dominique

> +	if (err)
> +		goto close_trans;
> +
>  	return clnt;
>  
>  close_trans:
> @@ -1070,6 +1094,8 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
>  put_trans:
>  	v9fs_put_trans(clnt->trans_mod);
>  free_client:
> +	mempool_exit(&clnt->pools[1]);
> +	mempool_exit(&clnt->pools[0]);
>  	kfree(clnt);
>  	return ERR_PTR(err);
>  }
> @@ -1094,6 +1120,8 @@ void p9_client_destroy(struct p9_client *clnt)
>  
>  	p9_tag_cleanup(clnt);
>  
> +	mempool_exit(&clnt->pools[1]);
> +	mempool_exit(&clnt->pools[0]);
>  	kmem_cache_destroy(clnt->fcall_cache);
>  	kfree(clnt);
>  }
> diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
> index d817d37452..99d878d70d 100644
> --- a/net/9p/trans_rdma.c
> +++ b/net/9p/trans_rdma.c
> @@ -431,7 +431,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
>  	if (unlikely(atomic_read(&rdma->excess_rc) > 0)) {
>  		if ((atomic_sub_return(1, &rdma->excess_rc) >= 0)) {
>  			/* Got one! */
> -			p9_fcall_fini(&req->rc);
> +			p9_fcall_fini(client, &req->rc, 1);
>  			req->rc.sdata = NULL;
>  			goto dont_need_post_recv;
>  		} else {
