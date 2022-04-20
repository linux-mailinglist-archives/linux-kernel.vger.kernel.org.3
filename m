Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8C850928A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382799AbiDTWPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354188AbiDTWOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:14:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA60448E5D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:11:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21A65B821B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 22:11:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB941C385A0;
        Wed, 20 Apr 2022 22:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1650492703;
        bh=3jG6oVH2gHG5S5CoAbfXYb/iLXrxT6JSgZNfp2QlZu8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=V/De21DIy005tQ4qGJq93QHov1T5vmFg6sTyk8WF3N9JVU1eXzvQe/vdLctKK9LgG
         DG8GbaEXYzmUGU+LHJID/Rpf9FhhPDRcx0w1T5E9maBKHQItsowHsJ9kVqx1GOt5gr
         nxRv/I+tWZ4n3svPJ/nVkxjDSbiwZ8f32a518Z9Q=
Date:   Wed, 20 Apr 2022 15:11:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com, jhubbard@nvidia.com,
        rcampbell@nvidia.com, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2] mm/mmu_notifier.c: Fix race in
 mmu_interval_notifier_remove()
Message-Id: <20220420151142.f60307e749033a24ef0c68d5@linux-foundation.org>
In-Reply-To: <20220420043734.476348-1-apopple@nvidia.com>
References: <20220420043734.476348-1-apopple@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Apr 2022 14:37:34 +1000 Alistair Popple <apopple@nvidia.com> wrote:

> In some cases it is possible for mmu_interval_notifier_remove() to race
> with mn_tree_inv_end() allowing it to return while the notifier data
> structure is still in use. Consider the following sequence:
> 
> CPU0 - mn_tree_inv_end()            CPU1 - mmu_interval_notifier_remove()
> ----------------------------------- ------------------------------------
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
> still on a deferred list. Fix this by taking the appropriate lock when
> reading invalidate_seq to ensure proper synchronisation.
> 
> ...
>
> Fixes: 99cb252f5e68 ("mm/mmu_notifier: add an interval tree notifier")

Do you think fix this should be backported into older kernels?
