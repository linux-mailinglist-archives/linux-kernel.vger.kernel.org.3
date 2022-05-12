Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A83524293
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239924AbiELCUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbiELCUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:20:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D58453B6E
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:20:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3654160C7D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 02:20:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478C9C34113;
        Thu, 12 May 2022 02:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652322001;
        bh=JfwZ2pwW5nLhYNwObsjPgvyS/UJ8orNHcTY7KYaw6sA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cHpUR9Lw7xgMxAuGTStnfVwconAUReWk29VSvUL9d2P/lW6z8GT3yZUm8pfV8IFrE
         r3E9xK4S/iEMQY7PR6fBC7j5bWPOKgg369M3bT5xzYs/X7RfkoyzzWtbPRUVfK8ICu
         X1H/OCcuhNb3UoITPP27qQvN9eYeik2vUO0gQ/T0=
Date:   Wed, 11 May 2022 19:20:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
Cc:     linmiaohe@huawei.com, aquini@redhat.com, ddutile@redhat.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mgorman@techsingularity.net, vvghjk1234@gmail.com
Subject: Re: [PATCH] mm, compaction: fast_find_migrateblock() should return
 pfn in the target zone
Message-Id: <20220511192000.d4851d55c5560e720e1e2914@linux-foundation.org>
In-Reply-To: <20220512014736.16376-1-yamamoto.rei@jp.fujitsu.com>
References: <07e0ceb8-a637-b011-bbf6-ba760a0b12e4@huawei.com>
        <20220512014736.16376-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 10:47:36 +0900 Rei Yamamoto <yamamoto.rei@jp.fujitsu.com> wrote:

> ...
>
> > Sorry, I think you're right. And could you please add the runtime effect of this issue?
> >
> > Anyway, this patch looks good to me now. Thanks!
> 
> Thank you for your review.
> The runtime effect is that compaction become unintended behavior.
> For example, pages not in the target zone are added to cc->migratepages list in isolate_migratepages_block().
> As a result, pages migrate between nodes unintentionally.

Thanks.   I updated the changelog thusly:

: At present, pages not in the target zone are added to cc->migratepages
: list in isolate_migratepages_block().  As a result, pages may migrate
: between nodes unintentionally.
: 
: Avoid returning a pfn outside the target zone in the case that it is
: not aligned with a pageblock boundary.  Otherwise
: isolate_migratepages_block() will handle pages not in the target zone.

