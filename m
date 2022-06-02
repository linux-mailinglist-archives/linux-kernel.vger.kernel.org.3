Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA0053BB71
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiFBPOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiFBPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:14:46 -0400
Received: from gentwo.de (gentwo.de [IPv6:2a02:c206:2048:5042::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF574156447
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 08:14:43 -0700 (PDT)
Received: by gentwo.de (Postfix, from userid 1001)
        id E7CB4B00142; Thu,  2 Jun 2022 17:14:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1654182881; bh=hvAa6ofYWFV4vL+MuhdmzPAGvRtWimk/1jDhChMw+d0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=JZykwXFzjruFfTKkX3UXi5/LSC3/9+ffdOnwVbFsJ5PT+5Rma/6SAwgxKYF253WD/
         o4GQZBvAK2C2YH8NCmGUWCb0LHCVVeAIIulr9Ok0cx7UKLeL3GfWf+j4KLvlRATjzX
         pJJMnP/PLp3qFQdduh1gPI1o+52T8rkhnQY+E1p4K7ixZiIhATFOhxxXQQMbsIYV/G
         JfCCIDTJXyxTYbcnVY3Tgj2NRbIFb+lzsEaDvcUaOR26sdoyoOhLMx8n7qRav+mror
         Nlm2lKYYjDzmGU+cyP0kIEnGS7xg323pzbsZRtQ/XAVWTpqnuSl52LrdNT0Iq764WB
         j3n8cekSReFhw==
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id E6966B0013B;
        Thu,  2 Jun 2022 17:14:41 +0200 (CEST)
Date:   Thu, 2 Jun 2022 17:14:41 +0200 (CEST)
From:   Christoph Lameter <cl@gentwo.de>
To:     David Rientjes <rientjes@google.com>
cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Rongwei Wang <rongwei.wang@linux.alibaba.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, iamjoonsoo.kim@lge.com,
        penberg@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mm/slub: fix the race between validate_slab and
 slab_free
In-Reply-To: <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com>
Message-ID: <alpine.DEB.2.22.394.2206021712530.2924@gentwo.de>
References: <20220529081535.69275-1-rongwei.wang@linux.alibaba.com> <YpNa4tB/jfW3MDyi@n2.us-central1-a.c.spheric-algebra-350919.internal> <ac9ba68f-9ee2-1611-9ff8-b486ed9c4df0@google.com>
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

On Mon, 30 May 2022, David Rientjes wrote:

> > Unconditionally taking n->list_lock will degrade performance.
>
> This is a good point, it would be useful to gather some benchmarks for
> workloads that are known to thrash some caches and would hit this path
> such as netperf TCP_RR.

Its obvious that adding new spinlocks to some of the hottest functions in
the kernel will degrade performance. This goes against the basic design of
these functions to be as efficient as possible.

