Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2190C54991A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbiFMQF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242635AbiFMQDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 12:03:04 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF3D19F044
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 06:50:50 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id 218AAB0038E; Mon, 13 Jun 2022 15:50:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1655128246; bh=P+2Eu0qhpYq7wlVABAoxSztYDseAwAfN1SZ+KJbEPI0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JSj5kCpwzNiybmfkJ9cFZFwFT/DLgMR/bHnf/I5OvjlhgCZtoN5aO84Qy6tAlA4FH
         /Euln5mYy8576zUa1anqLY2ywdFNGWn3N55zp8/PA7ugxgkJVOWabwrB9/sjNvJCKY
         Eb6nNfkUuDajbXroIBpmrO6QTFdoxmJSxJqOlkyT2KzDP79KFVE8/1yFtcaeI2jPSk
         Bx2S6/7TWrv59Litco30Rdhnl/+2IEateCvBF1Co0JP/F04DFU8FWVGAWDBqkdYCJx
         j06wuSCw9JewarHKp2BFaS2DkO9VEcauh+lqC+3jJ3s7tV2hNMIo2X7GWRKKiQmbhW
         tjTanhk0kLyWg==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 1F532B0034A;
        Mon, 13 Jun 2022 15:50:46 +0200 (CEST)
Date:   Mon, 13 Jun 2022 15:50:46 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     Rongwei Wang <rongwei.wang@linux.alibaba.com>
cc:     David Rientjes <rientjes@google.com>, songmuchun@bytedance.com,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, akpm@linux-foundation.org,
        vbabka@suse.cz, roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
In-Reply-To: <02298c0e-3293-9deb-f1ed-6d8862f7c349@linux.alibaba.com>
Message-ID: <alpine.DEB.2.22.394.2206131548420.295113@gentwo.de>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com> <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal> <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com> <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
 <9794df4f-3ffe-4e99-0810-a1346b139ce8@linux.alibaba.com> <alpine.DEB.2.22.394.2206071411460.375438@gentwo.de> <29723aaa-5e28-51d3-7f87-9edf0f7b9c33@linux.alibaba.com> <alpine.DEB.2.22.394.2206081417370.465021@gentwo.de>
 <02298c0e-3293-9deb-f1ed-6d8862f7c349@linux.alibaba.com>
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

On Sat, 11 Jun 2022, Rongwei Wang wrote:

> > Ok so the idea is to take the lock only if kmem_cache_debug. That looks
> > ok. But it still adds a number of new branches etc to the free loop.
> >
> > Some performance tests would be useful.
> Hi Christoph
>
> Thanks for your time!
> Do you have some advice in benchmarks that need me to test? And I find that
> hackbench and lkp was used frequently in mm/slub.c commits[1,2]. But I have no
> idea how to use these two benchmarks test to cover the above changes. Can you
> give some examples? Thanks very much!


Hi Rongwei,

Well run hackbench with an without the change.

There are also synthetic benchmarks available  at
https://gentwo.org/christoph/slub/tests/

These measure the cycles that slab operations take. However, they are a
bit old and I think Pekka may have a newer version of these
patches.

Greetings,
	Christoph

