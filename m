Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2B588504
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235302AbiHCAG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiHCAGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:06:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2CC632B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 17:06:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D85B460FFD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B70C433D6;
        Wed,  3 Aug 2022 00:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1659485182;
        bh=A1bEjUNDmXZlf1s9hKSqB6phav6SahGBSJ7Yyt9K64I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FzVMKbgJ599Pvr5ubPMjuQ6eKyGQP/XjKFtDfYDOuhukdpudTASqNjQl3kr3YHCUn
         cftT5Xw6qPAQpPjx7ovTBuuuDscsjp5lwiiOMjIignmhK+JMVFzyIz0C9fXJ1Qf7Tp
         /38vBOljMUUsIY6N0AeYIpapU5nPixHhKbR2sW6w=
Date:   Tue, 2 Aug 2022 17:06:19 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: vmscan: fix extreme overreclaim and swap floods
Message-Id: <20220802170619.250e1a0b475222a82e7077b3@linux-foundation.org>
In-Reply-To: <20220802162811.39216-1-hannes@cmpxchg.org>
References: <20220802162811.39216-1-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  2 Aug 2022 12:28:11 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Change the code such that only one SWAP_CLUSTER_MAX-sized nudge toward
> the larger LRU lists is made before bailing out on a met reclaim goal.

It seems rash to jam this into 5.20-rc1 at this stage.  I'm thinking
5.21-rc1 with a cc:stable?

