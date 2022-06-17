Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790F354F90E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382271AbiFQOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiFQOTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 10:19:54 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3A3F42EDC
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 07:19:51 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id DA0A8B0022B; Fri, 17 Jun 2022 16:19:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1655475587; bh=8Ft/GfnSZAGB8iS96jW7jEYAJzsfaccke4alN1b5XdI=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Xuyu1U5rbjZHVjd8r4wDEFGdPrBHXa7b+gPMz+AIKyQWDWqv/fqBIOx0WPnDvbOiE
         /YAbib1CF8oQJN7kdtpUoGmF5raDoxruPWgNdY9hvAt0nBe6sAq6f0k7wKiW2frPCA
         cqa2KvGwZb+/MBdxSpSyF29yIMy5EFWVHbG4aP0wlO17pN5F2vbF6WO6tmQcqvX2IR
         aEJ9VSC4lKue0G212H/2B28q07H2YSiD9o1h3DY6fGZcgok9zAC7AQ6DqyUXkreX6J
         sAgf4NBjv2cW8mtaE1VHhe4yOxmB1V4TCEaiqMcmSqy6CRf9ydHcenf406GWxCpExL
         et8MRrY9AG9Cw==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id D7739B0007F;
        Fri, 17 Jun 2022 16:19:47 +0200 (CEST)
Date:   Fri, 17 Jun 2022 16:19:47 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
In-Reply-To: <5085437c-adc9-b6a3-dbd8-91dc0856cf19@linux.alibaba.com>
Message-ID: <alpine.DEB.2.22.394.2206171617560.638056@gentwo.de>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com> <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal> <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com> <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com> <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de> <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com> <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de> <02298c0e-3293-9deb-f1ed-6d8862f7c349@linux.alibaba.com>
 <alpine.DEB.2.22.394.2206131548420.295113@gentwo.de> <5085437c-adc9-b6a3-dbd8-91dc0856cf19@linux.alibaba.com>
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

On Fri, 17 Jun 2022, Rongwei Wang wrote:

> Christoph, I refer [1] to test some data below. The slub_test case is same to
> your provided. And here you the result of its test (the baseline is the data
> of upstream kernel, and fix is results of patched kernel).

Ah good.
> Single thread testing
>
> 1. Kmalloc: Repeatedly allocate then free test
>
>                    before (baseline)        fix
>                    kmalloc      kfree       kmalloc      kfree
> 10000 times 8      7 cycles     8 cycles    5 cycles     7 cycles
> 10000 times 16     4 cycles     8 cycles    3 cycles     6 cycles
> 10000 times 32     4 cycles     8 cycles    3 cycles     6 cycles

Well the cycle reduction is strange. Tests are not done in the same
environment? Maybe good to not use NUMA or bind to the same cpu

> 10000 times 64     3 cycles     8 cycles    3 cycles     6 cycles
> 10000 times 128    3 cycles     8 cycles    3 cycles     6 cycles
> 10000 times 256    12 cycles    8 cycles    11 cycles    7 cycles
> 10000 times 512    27 cycles    10 cycles   23 cycles    11 cycles
> 10000 times 1024   18 cycles    9 cycles    20 cycles    10 cycles
> 10000 times 2048   54 cycles    12 cycles   54 cycles    12 cycles
> 10000 times 4096   105 cycles   20 cycles   105 cycles   25 cycles
> 10000 times 8192   210 cycles   35 cycles   212 cycles   39 cycles
> 10000 times 16384  133 cycles   45 cycles   119 cycles   46 cycles


Seems to be different environments.

> According to the above data, It seems that no significant performance
> degradation in patched kernel. Plus, in concurrent allocs test, likes Kmalloc
> N*alloc N*free(1024), the data of 'fix' column is better than baseline (it
> looks less is better, if I am wrong, please let me know). And if you have
> other suggestions, I can try to test more data.

Well can you explain the cycle reduction?

