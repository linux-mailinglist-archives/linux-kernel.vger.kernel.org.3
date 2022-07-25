Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC4358041A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 20:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236540AbiGYSh0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236433AbiGYShR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 14:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6361F61D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 11:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7408360B8D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:37:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BED5C341C8;
        Mon, 25 Jul 2022 18:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1658774228;
        bh=4Wiq9Lnn7t8N7Hq87zFN59DfW7ymVLg6HgcOtVLTQfQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U29+o6jrPUXpJQUGJlHNswJaua64HHPjufTlSYWyAG42fPxw2nOflcBBCR88GILr3
         0YK0c/4s6lGn+KW7LjJO/8bED+WRioxjF5k3Hby1NGwjg1Pw9F+usDwdQEYd6pe4Fm
         5w0xxZZhcoizKDOreVP9a0tEW+2Vb2OjGtj5R+rM=
Date:   Mon, 25 Jul 2022 11:37:07 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     minchan@kernel.org, bhe@redhat.com, vbabka@suse.cz,
        mgorman@techsingularity.net, hannes@cmpxchg.org, mhocko@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gh21.hong@samsung.com, ytk.lee@samsung.com, jaewon31.kim@gmail.com
Subject: Re: [PATCH v2] page_alloc: fix invalid watemark check on a negative
 value
Message-Id: <20220725113707.e03007d0761423f642c15749@linux-foundation.org>
In-Reply-To: <20220725095212.25388-1-jaewon31.kim@samsung.com>
References: <CGME20220725095214epcas1p1cc2019c792560da07d673809a3fc7ef3@epcas1p1.samsung.com>
        <20220725095212.25388-1-jaewon31.kim@samsung.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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

On Mon, 25 Jul 2022 18:52:12 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> There was a report that a task is waiting at the
> throttle_direct_reclaim. The pgscan_direct_throttle in vmstat was
> increasing.
> 
> This is a bug where zone_watermark_fast returns true even when the free
> is very low. The commit f27ce0e14088 ("page_alloc: consider highatomic
> reserve in watermark fast") changed the watermark fast to consider
> highatomic reserve. But it did not handle a negative value case which
> can be happened when reserved_highatomic pageblock is bigger than the
> actual free.
> 
> If watermark is considered as ok for the negative value, allocating
> contexts for order-0 will consume all free pages without direct reclaim,
> and finally free page may become depleted except highatomic free.
> 
> Then allocating contexts may fall into throttle_direct_reclaim. This
> symptom may easily happen in a system where wmark min is low and other
> reclaimers like kswapd does not make free pages quickly.
> 
> Handle the negative case by using MIN.
> 

Thanks, I added cc:stable to this.
