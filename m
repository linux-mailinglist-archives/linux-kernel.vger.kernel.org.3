Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D0F5B0461
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 14:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiIGMxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiIGMwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 08:52:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12B2BB913
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 05:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=nmR1IiZKgR22rMieRBMYuwwKUcg5yhMaOI/O5H5C9XI=; b=JHOSeaoeI1J4BUNSc93Zoij/tz
        MU6N5PLFpGlHrMm4VWZhjzlNcewvbjSduvBnKJ8I24LMDcsftiGJE3e0HXXO4yJXiwSn5HSNiq2sR
        6t2ZzeR/LootwwGwU3OfbcyqGLb252oOrlggrjNhj1bkZTx1REhSi10s19Prvg3tXhl35B9XjaAXD
        2IUwa52cwDCCfY0uq5GPT8v/RQEAYSMmmtkG3eUrwFZTSjfVQPwFMae+xEVsEWcj3ipyi867+x5nX
        jtHMrj6+jDKDzpuWbrYsTAJw5MnHMVSke/EFnFBZ2ACl2caicyDYx6IhMFjALZHpMiKQkSbN7YNI3
        Fbu+Kg9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVuXA-00BMUu-0R; Wed, 07 Sep 2022 12:52:00 +0000
Date:   Wed, 7 Sep 2022 13:51:59 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com
Subject: Re: [PATCHv2] mm: introduce __GFP_TRACKLEAK to track in-kernel
 allocation
Message-ID: <YxiT7zIH2s7MXcBy@casper.infradead.org>
References: <1662544357-26649-1-git-send-email-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1662544357-26649-1-git-send-email-zhaoyang.huang@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 05:52:37PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> Kthread and drivers could fetch memory via alloc_pages directly which make them
> hard to debug when leaking. Solve this by introducing __GFP_TRACELEAK and reuse
> kmemleak mechanism which unified most of kernel cosuming pages into kmemleak.

As I said in my response to v1, this needs (a) documentation and (b) tests.
