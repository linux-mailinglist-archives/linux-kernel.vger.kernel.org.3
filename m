Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66C75517E6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbiFTL5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240729AbiFTL5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:57:41 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAF717E1A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 04:57:39 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 3500AB001DF; Mon, 20 Jun 2022 13:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1655726255; bh=+c4QcA9b5Gi5EsqVv56YKe33xdAr2lQIQbp1pqAYP4g=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jO9B1ux7ZEMOyzwGP7zGLGA1rrIbRCZsXlLmhW+4/yKCnEYVIPKCZ5dDIgomx2i5l
         DplGee1eJbR70onrjgaf6ycP3Zc9TxP/RI6dDmN2DitRZdkb5MVFRZvLVuWAO2EyhK
         L9MegfCaf2DVrlnH/yPER8zHdz9SCOhnbZJOrRrQrFNhhqojXz9hq2bm5tBcFHr+eu
         d+5sDtwtNamp2Cjc/Al1LaO/shmFNYjxAaJYn8dmrL0E3nT17RDnj+Cby80ZydmWmR
         GPSzZtB2JmoxNlPSoI03Ew5+1kw/e+bDcd3KM7mNLXT8QwZyOjJBF+k0ttyAQhMZUL
         RmXEpYmzqplAA==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 335F5B00192;
        Mon, 20 Jun 2022 13:57:35 +0200 (CEST)
Date:   Mon, 20 Jun 2022 13:57:35 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
In-Reply-To: <1b434d4c-2a19-9ac1-b2b9-b767b642ec0c@linux.alibaba.com>
Message-ID: <alpine.DEB.2.22.394.2206201354030.265427@gentwo.de>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com> <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal> <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com> <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com> <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de> <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com> <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de> <02298c0e-3293-9deb-f1ed-6d8862f7c349@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206131548420.295113@gentwo.de> <5085437c-adc9-b6a3-dbd8-91dc0856cf19@linux.alibaba.com> <alpine.DEB.2.22.394.2206171617560.638056@gentwo.de> <1b434d4c-2a19-9ac1-b2b9-b767b642ec0c@linux.alibaba.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jun 2022, Rongwei Wang wrote:

> > Well the cycle reduction is strange. Tests are not done in the same
> > environment? Maybe good to not use NUMA or bind to the same cpu
> It's the same environment. I can sure. And there are four nodes (32G per-node
> and 8 cores per-node) in my test environment. whether I need to test in one
> node? If right, I can try.

Ok in a NUMA environment the memory allocation is randomized on bootup.
You may get different numbers after you reboot the system. Try to switch
NUMA off. Use s a single node to get consistent numbers.

It maybe useful to figure out what memory structure causes the increase in
latency in a NUMA environment. If you can figure that out and properly
allocate the memory structure that causes the increases in latency then
you may be able to increase the performance of the allocator.

