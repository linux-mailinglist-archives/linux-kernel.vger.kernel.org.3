Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18E1052FC37
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 13:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbiEULuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 07:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbiEULuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 07:50:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B742623;
        Sat, 21 May 2022 04:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tBqF11f/Pfve6vYK0C0UtDJ8LKpLRNRFFTC1tti/yvg=; b=SIqzWV1jH6xPkrVylOZRnT+8Qo
        DS+qxc+ERhJafqUYNtPfZIxjhyCWjNNdT90BA84b6dkL2QADh5RaV1o/B3jeRjoTV4QXyAK1+9I5B
        8rnUWXqAMLATy4VGC8HC0nrpyJ7zcBCDBdLUt4ElDjm9rlc1XRgnoE5OVgkBYi1WRNyKGXsMQj+3k
        gzD7V72w76BQt/0tpC+QKrtCKyl5i+4qzBcqgX/ttUE1894rUDBGxfBE3ds5yAT2g8+yXHDcTJ2De
        MdXy/wu0c0GjuwQ5zT8YC195j1gGwJPxNzqxlDzSAoMS/NLnUNlhvL8RYiGnHrAjeQDhv5EHzNDRZ
        IhMo51KA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nsNd9-00GQpP-5S; Sat, 21 May 2022 11:50:47 +0000
Date:   Sat, 21 May 2022 04:50:47 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Xiao Ni <xni@redhat.com>, Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Subject: Re: [PATCH v1 12/15] md/raid5-cache: Add RCU protection to conf->log
 accesses
Message-ID: <YojSF1CYN4Irv8XD@infradead.org>
References: <20220519191311.17119-1-logang@deltatee.com>
 <20220519191311.17119-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519191311.17119-13-logang@deltatee.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2022 at 01:13:08PM -0600, Logan Gunthorpe wrote:
> The mdadm test 21raid5cache randomly fails with NULL pointer accesses
> conf->log when run repeatedly. conf->log was sort of protected with
> a RCU, but most dereferences were not done with the correct functions.
> 
> Add rcu_read_locks() and rcu_access_pointers() to the appropriate
> places.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/md/raid5-cache.c | 135 +++++++++++++++++++++++++++------------
>  drivers/md/raid5-log.h   |  14 ++--
>  drivers/md/raid5.c       |   4 +-
>  drivers/md/raid5.h       |   2 +-
>  4 files changed, 104 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
> index f7b402138d16..1dbc7c4b9a15 100644
> --- a/drivers/md/raid5-cache.c
> +++ b/drivers/md/raid5-cache.c
> @@ -254,7 +254,14 @@ static bool __r5c_is_writeback(struct r5l_log *log)
>  
>  bool r5c_is_writeback(struct r5conf *conf)
>  {
> -	return __r5c_is_writeback(conf->log);
> +	struct r5l_log *log;
> +	bool ret;
> +
> +	rcu_read_lock();
> +	log = rcu_dereference(conf->log);
> +	ret = __r5c_is_writeback(log);

Nit: I'd do away with the local variable

	ret = __r5c_is_writeback(rcu_dereference(conf->log));

> +static struct r5l_log *get_log_for_io(struct r5conf *conf)
> +{
> +	/*
> +	 * rcu_dereference_protected is safe because the array will be
> +	 * quiesced before log_exit() so it can't be called while
> +	 * an IO is in progress.
> +	 */
> +	return rcu_dereference_protected(conf->log, 1);
> +}

The hardcoded one (shouldn't that be a true, btw?) kinda defeats the
purpose of rcu_dereference_protected.  But I can't really think of any
good runtime assert that we could use here.

>  void r5c_check_stripe_cache_usage(struct r5conf *conf)
>  {
> +	struct r5l_log *log = get_log_for_io(conf);
>  	int total_cached;
>  
> -	if (!r5c_is_writeback(conf))
> +	if (!__r5c_is_writeback(log))

This mostly just undoes earlier chanes.  Maybe we should have just let
r5c_is_writeback as-is and have a r5c_conf_is_writeback helper on top and
avoid this churn?  In general it would also be nice to have all these
newly added or removal local variables in place before the big fixup.

>  void r5c_check_cached_full_stripe(struct r5conf *conf)
>  {
> -	if (!r5c_is_writeback(conf))
> -		return;
> +	struct r5l_log *log = get_log_for_io(conf);

This looks odd.

