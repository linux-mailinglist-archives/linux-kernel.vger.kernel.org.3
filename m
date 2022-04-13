Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B0E4FF455
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiDMKCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 06:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbiDMKCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:02:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20968220C8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 03:00:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D28EFB821C6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:00:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4975FC385A3;
        Wed, 13 Apr 2022 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649844006;
        bh=bFHLd2on4EXVWdfSMTSSo6pgffdVcKne9F5/ux58zCI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=knp9y3l34Jtwnj3uW4sH03VRLSK+6L5dK8UYSnUp+jGgYXNc0tCe7IthmpOVod9Iq
         ol8597b1wpABiLepJqHMOXH1/UidF230xZ00U/afrZlorK+4zH1L8RH+KMkwr3e1yC
         sCxGE78c4ZXIVBFePGw5LmghURzQzyFZDzBxyPNY=
Date:   Wed, 13 Apr 2022 12:00:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alessandro Astone <ales.astone@gmail.com>
Cc:     tkjos@android.com, brauner@kernel.org, arve@android.com,
        linux-kernel@vger.kernel.org, maco@android.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] binder: Address corner cases in deferred copy and fixup
Message-ID: <YlafI74E/5HttdeB@kroah.com>
References: <20220413085428.20367-1-ales.astone@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413085428.20367-1-ales.astone@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 10:54:27AM +0200, Alessandro Astone wrote:
> When handling BINDER_TYPE_FDA object we are pushing a parent fixup
> with a certain skip_size but no scatter-gather copy object, since
> the copy is handled standalone.
> If BINDER_TYPE_FDA is the last children the scatter-gather copy
> loop will never stop to skip it, thus we are left with an item in
> the parent fixup list. This will trigger the BUG_ON().
> 
> Furthermore, it is possible to receive BINDER_TYPE_FDA object
> with num_fds=0 which will confuse the scatter-gather code.
> 
> In the android userspace I could only find these usecases in the
> libstagefright OMX implementation, so it might be that they're
> doing something very weird, but nonetheless the kernel should not
> panic about it.
> 
> Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
> Signed-off-by: Alessandro Astone <ales.astone@gmail.com>
> ---
>  drivers/android/binder.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index 8351c5638880..18ad6825ba30 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -2295,7 +2295,7 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
>  {
>  	int ret = 0;
>  	struct binder_sg_copy *sgc, *tmpsgc;
> -	struct binder_ptr_fixup *pf =
> +	struct binder_ptr_fixup *tmppf, *pf =

Just make this a new line:
	struct binder_ptr_fixup *tmppf;
above the existing line.

>  		list_first_entry_or_null(pf_head, struct binder_ptr_fixup,
>  					 node);
>  
> @@ -2349,7 +2349,11 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
>  		list_del(&sgc->node);
>  		kfree(sgc);
>  	}
> -	BUG_ON(!list_empty(pf_head));

So you are hitting this BUG_ON() today?

> +	list_for_each_entry_safe(pf, tmppf, pf_head, node) {
> +		BUG_ON(pf->skip_size == 0);
> +		list_del(&pf->node);
> +		kfree(pf);
> +	}
>  	BUG_ON(!list_empty(sgc_head));
>  
>  	return ret > 0 ? -EINVAL : ret;
> @@ -2486,6 +2490,9 @@ static int binder_translate_fd_array(struct list_head *pf_head,
>  	struct binder_proc *proc = thread->proc;
>  	int ret;
>  
> +	if (fda->num_fds == 0)
> +		return 0;

Why return 0?

This feels like a separate issue from above, should this be 2 different
commits?

thanks,

greg k-h
