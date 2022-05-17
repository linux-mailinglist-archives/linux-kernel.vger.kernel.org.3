Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D133052AEB8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 01:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiEQXjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 19:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiEQXjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 19:39:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9202E527DF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 16:39:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AF0FB81D63
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70938C385B8;
        Tue, 17 May 2022 23:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652830748;
        bh=JEWdfhbC5CbWSi17hxZuBVoj601BdghMmPGpjgottKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MjeauKwgia4b2KAd9VrN1ZKzelXPYmVvRqOQKfHOfWBf/zSiTNHV+qvACr/8++N94
         i5Hcame/r39FW5rqsjTWcFaJb2fzcM6g/5Y02n0Xoo5Em8TcypXr/WHPZy80qsDxjX
         lxNll3G/mRyfWRzhB4hMql3m5y5pgAi6gFjAy5Jc=
Date:   Tue, 17 May 2022 16:39:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     David Hildenbrand <david@redhat.com>, <willy@infradead.org>,
        <vbabka@suse.cz>, <dhowells@redhat.com>, <neilb@suse.de>,
        <apopple@nvidia.com>, <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 06/15] mm/swap: remove buggy cache->nr check in
 refill_swap_slots_cache
Message-Id: <20220517163907.223f16f071b57b9e3d062ff8@linux-foundation.org>
In-Reply-To: <8b03aa8a-5023-6915-64c6-f6f298f19f36@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
        <20220509131416.17553-7-linmiaohe@huawei.com>
        <fd5c6a00-ea0e-b5d8-999f-d7b65c193ae4@redhat.com>
        <8b03aa8a-5023-6915-64c6-f6f298f19f36@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2022 10:00:43 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:

> On 2022/5/12 21:37, David Hildenbrand wrote:
> > On 09.05.22 15:14, Miaohe Lin wrote:
> >> refill_swap_slots_cache is always called when cache->nr is 0. And if
> >> cache->nr != 0, we should return cache->nr instead of 0. So remove
> >> such buggy and confusing check.
> > 
> > Not sure about the "cache->nr != 0, we should return cache->nr instead
> > of 0" part, I'd just drop that from the patch description. We'd actually
> > end up overwriting cache->nr after your change, which doesn't sound
> > right and also different to what you describe here.
> 
> Will do.

I've updated the changleog to simply

: refill_swap_slots_cache is always called when cache->nr is 0.  So remove
: such buggy and confusing check.
