Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EEF50B1B5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444900AbiDVHh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444876AbiDVHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:37:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AA1260F;
        Fri, 22 Apr 2022 00:35:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9226E210F4;
        Fri, 22 Apr 2022 07:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650612899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CoKlO+fXUiau8VMVUQKx3k/6EuFzG9GIbfxFrogHx6w=;
        b=dySGsqJdEmSJDYmSvOklfVpkuZHJ23u9g1XhRJDcQoLdKgRG5kmI1lpiTUWcSy7MtqR7zM
        kXwCyLTlbnp+iE9neiu8jg1lhFPIDng+OjhqwbJ52cuWGbwwYU1o5p6p+n2i/KC3xGvKZl
        0hE/7gJMEJKlgdQaF4sMg91/V0j/qiM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6010B2C146;
        Fri, 22 Apr 2022 07:34:59 +0000 (UTC)
Date:   Fri, 22 Apr 2022 09:34:57 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Scott Cheloha <cheloha@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drivers/base/memory: Fix a reference counting issue in
 __add_memory_block()
Message-ID: <YmJaoSam6g95yToH@dhcp22.suse.cz>
References: <d44c63d78aafe844f920dc02ad6af25acc448fcf.1650611702.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44c63d78aafe844f920dc02ad6af25acc448fcf.1650611702.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 22-04-22 09:15:21, Christophe JAILLET wrote:
> There is no point in doing put_device()/device_unregister() on a
> device that has just been registered a few lines above. This will lead to
> a double reference decrement.

This is a bit confusing. I would rephrase.
"
__add_memory_block calls both put_device and device_unregister when
storing the memory block into the xarray. This is incorrect because
xarray doesn't take an additional reference and device_unregister
already calls put_device.
"

Btw. I do not think this failure path can be triggered, or is there a
way to hit it?
 
> I guess that this put_device()/device_unregister() is a cut'n'paste from
> remove_memory_block() (i.e. unregister_memory() at the time being) which
> does need it.
> 
> Fixes: 4fb6eabf1037 ("drivers/base/memory.c: cache memory blocks in xarray to accelerate lookup")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Other than that looks good to me. With the changelog clarified,
especially the part that evaluates whether this is a real or a
theoretical problem, feel free to add
Acked-by: Michal Hocko <mhocko@suse.com>

Thanks!

> ---
>  drivers/base/memory.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index 7222ff9b5e05..084d67fd55cc 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -636,10 +636,9 @@ static int __add_memory_block(struct memory_block *memory)
>  	}
>  	ret = xa_err(xa_store(&memory_blocks, memory->dev.id, memory,
>  			      GFP_KERNEL));
> -	if (ret) {
> -		put_device(&memory->dev);
> +	if (ret)
>  		device_unregister(&memory->dev);
> -	}
> +
>  	return ret;
>  }
>  
> -- 
> 2.32.0

-- 
Michal Hocko
SUSE Labs
