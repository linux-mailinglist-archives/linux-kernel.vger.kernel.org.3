Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E32557EEA8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239595AbiGWKVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239395AbiGWKVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 06:21:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A2E9EB5A0;
        Sat, 23 Jul 2022 03:10:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77F3D6135C;
        Sat, 23 Jul 2022 10:10:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DCB2C341C0;
        Sat, 23 Jul 2022 10:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658571051;
        bh=Mhj0fxlNgLETsShHldqHVQieQooTSHPA5ALqygMSW9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFrRfKLLwEMY5fsQxtg5TlPPTlBY8DCVrwPaG6oFEY90c9w/4fxPeTYSahHprzAch
         WyfLmUmQ8qAyCWvvBBRYdEgQKpx9rJti2j+VLflIWN8vV1sJTfze4oRam+Dqjh8jJm
         msDsS20skul7L+8iykXqxGNP3dKq3noIrW8eomos=
Date:   Sat, 23 Jul 2022 12:10:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     akpm@linux-foundation.org, feng.tang@intel.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [RFC PATCH] devres: avoid over memory allocation with managed
 memory allocation
Message-ID: <YtvJKF+2wSD57NbO@kroah.com>
References: <92ec2f78e8d38f68da95d9250cf3f86b2fbe78ad.1658570017.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ec2f78e8d38f68da95d9250cf3f86b2fbe78ad.1658570017.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 12:04:33PM +0200, Christophe JAILLET wrote:
> On one side, when using devm_kmalloc(), a memory overhead is added in order
> to keep track of the data needed to release the resources automagically.
> 
> On the other side, kmalloc() also rounds-up the required memory size in
> order to ease memory reuse and avoid memory fragmentation.
> 
> Both behavior together can lead to some over memory allocation which can
> be avoided.
> 
> For example:
>   - if 4096 bytes of managed memory is required
>   - "4096 + sizeof(struct devres_node)" bytes are required to the memory
> allocator
>   - 8192 bytes are allocated and nearly half of it is wasted
> 
> In such a case, it would be better to really allocate 4096 bytes of memory
> and record an "action" to perform the kfree() when needed.
> 
> On my 64 bits system:
>    sizeof(struct devres_node) = 40
>    sizeof(struct action_devres) = 16
> 
> So, a devm_add_action() call will allocate 56, rounded up to 64 bytes.
> 
> kmalloc() uses hunks of 8k, 4k, 2k, 1k, 512, 256, 192, 128, 96, 64, 32, 16,
> 8 bytes.
> 
> So in order to save some memory, if the 256 bytes boundary is crossed
> because of the overhead of devm_kmalloc(), 2 distinct memory allocations
> make sense.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch is only a RFC to get feed-back on the proposed approach.
> 
> It is compile tested only.
> I don't have numbers to see how much memory could be saved.
> I don't have numbers on the performance impact.
> 
> Should this makes sense to anyone, I would really appreciate getting some
> numbers from others to confirm if it make sense or not.
> 
> 
> The idea of this patch came to me because of a discussion initiated by
> Feng Tang <feng.tang@intel.com>. He proposes to track wasted memory
> allocation in order to give hints on where optimizations can be done.
> 
> My approach is to avoid part of these allocations when due to the usage of
> a devm_ function.
> 
> 
> The drawbacks I see are:
>    - code is more complex
>    - this concurs to memory fragmentation because there will be 2 memory
>      allocations, instead of just 1
>    - this is slower for every memory allocation because of the while loop
>      and tests
>    - the magic 256 constant is maybe not relevant on all systems
>    - some places of the kernel already take advantage of this over memory
>      allocation. So unpredictable impacts can occur somewhere! (see [1],
>      which is part of the [2] thread)
>    - this makes some assumption in devres.c on how memory allocation works,
>      which is not a great idea :(
> 
> The advantages I see:
>    - in some cases, it saves some memory :)
>    - fragmentation is not necessarily an issue, devm_ allocated memory
>      are rarely freed, right?

I think devm_  allocated memory does not happen that much, try it on
your systems and see!

Numbers would be great to have, can you run some benchmarks?  Try it on
a "common" SoC device (raspberry pi?) and a desktop to compare.

thanks,

greg k-h
