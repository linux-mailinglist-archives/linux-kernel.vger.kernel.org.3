Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1868525688
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358438AbiELUtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbiELUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630A42685FE
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 13:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0626561E7B
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 20:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DAE5C385B8;
        Thu, 12 May 2022 20:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652388586;
        bh=91VwTcfIVQV9Sz36/J5iHoSXXfz2kqY+YsPiS9hgpKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kWHMC6thcR1FBN59YemuXc54h/x9NO4z9+BWWzBZNTMnXLhaooqT+XMZQsOXdkBWz
         teoLtuDKR3/Cs+bZDFjyv7kWH0nYCtOpoO/rlZ6UM4nTnSGTn85Smh2LhB8sixw+ZH
         Xt2TZu8t4U23f4TpogUiMt+bh4J6jXbiaYDs7TxI=
Date:   Thu, 12 May 2022 13:49:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     linmiaohe@huawei.com, aquini@redhat.com, ddutile@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, vvghjk1234@gmail.com
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return
 pfn in the target zone
Message-Id: <20220512134945.fe74df5e322b98ae4046ce15@linux-foundation.org>
In-Reply-To: <20220512042733.17976-1-yamamoto.rei@jp.fujitsu.com>
References: <4cf33f9c-89bc-f845-10d7-2aa62a20f5e5@huawei.com>
        <20220512042733.17976-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 13:27:33 +0900 Rei Yamamoto <yamamoto.rei@jp.fujitsu.com> wrote:

> >> Thank you for your review.
> >> The runtime effect is that compaction become unintended behavior.
> >> For example, pages not in the target zone are added to cc->migratepages list in isolate_migratepages_block().
> >> As a result, pages migrate between nodes unintentionally.
> >
> > Many thanks for clarifying. :) Is this worth a Fixes tag or even CC stable?
> >
> > Thanks!
> 
> Thank you for your reply.
> 
> If add a Fixes tag, I think the following commit:
>   Fixes: 70b4459 ("mm, compaction: use free lists to quickly locate a migration source")
> 
> Andrew, how do you think about this? 

Thanks, I added that and also a paragraph describing the effect of the bug:

https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-compaction-fast_find_migrateblock-should-return-pfn-in-the-target-zone.patch

I assume this problem isn't sufficiently serious to require a -stable
backport of the fix?


