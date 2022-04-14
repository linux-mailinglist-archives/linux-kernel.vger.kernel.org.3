Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF815016E6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348654AbiDNPPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347573AbiDNN7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:20 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D1D424B3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:50:07 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d9so4023663qvm.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DZ02OiwvpoOudfUuXhmFdF/LMUteXQjwkth1cncdRqE=;
        b=TRd/DJlidLiTENryi8hJOWQ7DbU+V+oJV+aCWm7ID73Is1heA2raX3GCKDUv58xmYs
         rXfzFch2ZWXj5lPBdzvlcZXULsz+ON8KUQIWuj1IEd8CJQh0Lrq2mf1XjoQ7NRQlyAwA
         xVoLGZ4D5Du0JlIVo6Bvyr2xQyITzQQzkBrWcbiuHlP45mzbJPhiZAY93fo8uPCpMp1V
         3U20Cm6H+boQDQEovyKCsV4Xzn/0Gg/lozu6yM0rpm6xuWP6WyD46oBFVKTlrYP1D7K0
         dUtxo1AoSVsgMQn9u4OdRCZtjLm5f7WULVVUIlGc79nK7Ujhjb8xZvGvOT5H3uQ8oj/4
         5UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZ02OiwvpoOudfUuXhmFdF/LMUteXQjwkth1cncdRqE=;
        b=5iK3roQE+apMHyTyJewTOGiq9n060J+H2LAcGyDRG/jwjJWc4YWNphoRLZbuXyW0Js
         0rBsXsj6ow4yw92GkpmJMKtM+Fno2duNwN5+VR1Oy/UW23narpmaSBohSP8CcuuQYjlH
         Zu1l3QFEUZoYnZOdodqHI3AkSWw4YLZb2XSNg1CQNesY+002Ak2+FY0i+4zlaL7gSc9y
         Yuuh4Q6DGxOXTQHasza5JKfGu7He8PY+9PekdUPDjv/sa+rqF2tquxlAFWto7kaAAFy1
         c+hPwLezLAZpvnHi0FjMbAmWkTOzzC+ju0ib7i1jQqAzq+gyj8Aim2qRuoWBPco37Dc0
         IlYA==
X-Gm-Message-State: AOAM5305sWo3FLzI5Qe8XX69FP6oq1cwVKG3+JzSNLxNK8T8WPKt9WW3
        UztWiIewTwIt5cpQZZnE4Zf5C5cEa3TELQ==
X-Google-Smtp-Source: ABdhPJwCAeRQPqvRqkol66RwYWsGBA2YHqxCqfXW0PhVDSBI90WE7X6BH4PXSunjumR5qg4yyWkNeg==
X-Received: by 2002:a05:6214:89:b0:444:4e37:9d7a with SMTP id n9-20020a056214008900b004444e379d7amr3390462qvr.119.1649944206719;
        Thu, 14 Apr 2022 06:50:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id u5-20020a05622a198500b002ee933faf83sm1198877qtc.73.2022.04.14.06.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 06:50:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nezrJ-0023v3-5t; Thu, 14 Apr 2022 10:50:05 -0300
Date:   Thu, 14 Apr 2022 10:50:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, christian.koenig@amd.com,
        jhubbard@nvidia.com, rcampbell@nvidia.com
Subject: Re: [PATCH] mm/mmu_notifier.c: Fix race in
 mmu_interval_notifier_remove()
Message-ID: <20220414135005.GJ64706@ziepe.ca>
References: <20220414031810.1787209-1-apopple@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414031810.1787209-1-apopple@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 01:18:10PM +1000, Alistair Popple wrote:
> In some cases it is possible for mmu_interval_notifier_remove() to race
> with mn_tree_inv_end() allowing it to return while the notifier data
> structure is still in use. Consider the following sequence:
> 
> CPU0 - mn_tree_inv_end()            CPU1 - mmu_interval_notifier_remove()
>                                     spin_lock(subscriptions->lock);
>                                     seq = subscriptions->invalidate_seq;
> spin_lock(subscriptions->lock);     spin_unlock(subscriptions->lock);
> subscriptions->invalidate_seq++;
>                                     wait_event(invalidate_seq != seq);
>                                     return;
> interval_tree_remove(interval_sub); kfree(interval_sub);
> spin_unlock(subscriptions->lock);
> wake_up_all();
> 
> As the wait_event() condition is true it will return immediately. This
> can lead to use-after-free type errors if the caller frees the data
> structure containing the interval notifier subscription while it is
> still on a deferred list. Fix this by changing invalidate_seq to an
> atomic type as it is read outside of the lock and moving the increment
> until after deferred lists have been updated.

Oh, yes, that is a mistake.

I would not solve it with more unlocked atomics though, this is just a
simple case of a missing lock - can you look at this and if you like
it post it as a patch please?

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 459d195d2ff64b..f45ff1b7626a62 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -1036,6 +1036,18 @@ int mmu_interval_notifier_insert_locked(
 }
 EXPORT_SYMBOL_GPL(mmu_interval_notifier_insert_locked);
 
+static bool
+mmu_interval_seq_released(struct mmu_notifier_subscriptions *subscriptions,
+			  unsigned long seq)
+{
+	bool ret;
+
+	spin_lock(&subscriptions->lock);
+	ret = subscriptions->invalidate_seq != seq;
+	spin_unlock(&subscriptions->lock);
+	return ret;
+}
+
 /**
  * mmu_interval_notifier_remove - Remove a interval notifier
  * @interval_sub: Interval subscription to unregister
@@ -1083,7 +1095,7 @@ void mmu_interval_notifier_remove(struct mmu_interval_notifier *interval_sub)
 	lock_map_release(&__mmu_notifier_invalidate_range_start_map);
 	if (seq)
 		wait_event(subscriptions->wq,
-			   READ_ONCE(subscriptions->invalidate_seq) != seq);
+			   mmu_interval_seq_released(subscriptions, seq));
 
 	/* pairs with mmgrab in mmu_interval_notifier_insert() */
 	mmdrop(mm);

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
