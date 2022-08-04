Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADF0589A47
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 12:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237860AbiHDKH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 06:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbiHDKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 06:07:54 -0400
Received: from sender4-op-o18.zoho.com (sender4-op-o18.zoho.com [136.143.188.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC2C17AA8;
        Thu,  4 Aug 2022 03:07:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659607643; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=K3qQct6hiCA/qe/3eqqnDutSYrR9u7uP3HOb7EIP8GEJqUAitwA91frWueKA3Mr9XKptJ6bpo6FhLheBB04Zgi+2fmlAtBxoD4y1q05l6/fk9IYKpTJnf687Gz8wLe9OWSaSwcQCg6cRz71LAILzPbIpeKu+HX/RA5ornVRRr54=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1659607643; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=BHejHdt53IEYuzqZbZN4EusFHlxvwpJaRPIFVXZsQ/w=; 
        b=oA7dFRe5t/efFEy7oUCXGA+CSU5zAU+r4dZ5zGXI+ICM+7SHvMdFHQzrSlsCjYgx/6XvF4nQZ4ym2jGNiDAMSDeeqsGRRZAfL+IAiUq8TyqdbM817KrnAkY2/pxmJnZL9H8A0vSeLfrVX0ysZe2oWvbr51v/R+zujEzsPW5ZG+I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659607643;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=BHejHdt53IEYuzqZbZN4EusFHlxvwpJaRPIFVXZsQ/w=;
        b=XpS5AYaon+tYseVZnl44dhmDfl317SyeYKksKDmAij+hF8ZNQHj7flbeunxif3lN
        f6DW50VFI4RnnL8davV2RenrhkQSR5Gxncnl1EAkDY0+LBzAHCALXqVnc2obmYGgTdK
        8uJM9nU2fj1HhZcAFqV6c9gbGAaql7cqIK/jma54=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1659607640663544.5780582971333; Thu, 4 Aug 2022 03:07:20 -0700 (PDT)
Date:   Thu, 04 Aug 2022 19:07:20 +0900
From:   Li Chen <me@linux.beauty>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Catalin Marinas" <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Frank Rowand" <frowand.list@gmail.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Li Chen" <lchen@ambarella.com>,
        "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "DTML" <devicetree@vger.kernel.org>,
        "Linux-MM" <linux-mm@kvack.org>
Message-ID: <1826852ea3a.10a917cc826728.6077661125986568031@linux.beauty>
In-Reply-To: <CAK8P3a0zSGqj3YEi+i9yfSLk8-aJtyiY6Bj069cxCdErk81+cw@mail.gmail.com>
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
 <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
 <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com> <18267b7a61f.12b26bd91245310.4476663913461696630@linux.beauty> <CAK8P3a0zSGqj3YEi+i9yfSLk8-aJtyiY6Bj069cxCdErk81+cw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sample/reserved_mem: Introduce a sample of struct
 page and dio support to no-map rmem
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


 ---- On Thu, 04 Aug 2022 17:24:20 +0900  Arnd Bergmann  wrote --- 
 > On Thu, Aug 4, 2022 at 9:17 AM Li Chen me@linux.beauty> wrote:
 > > ---- On Tue, 12 Jul 2022 16:50:46 +0900  Arnd Bergmann  wrote ---
 > >  > Does your hardware require a fixed address for the buffer? If it can be
 > >  > anywhere in memory (or at least within a certain range) but just has to
 > >  > be physically contiguous, the normal way would be to use a CMA area
 > >  > to allocate from, which gives you 'struct page' backed pages.
 > >
 > > CMA does support Direct I/O, but it has its own issue:
 > > It does not guarantee that the memory previously borrowed by the OS will be returned to the device.
 > >
 > > We've been plagued by examples like this in the past:
 > > Many other kernel modules/subsystems have already allocated much memory from both non-CMA and CMA memory,
 > > When our DSP driver got probed then, cma_alloc will fail in that non-CMA system memory is not enough
 > > for CMA memory to migrate.
 > 
 > This part should at least be possible to solve by declaring the amount
 > and location of
 > CMA areas in the right way. It's not great to fine-tune the DT for a
 > particular kernel's
 > use, but if you know which other drivers require CMA type allocations
 > you can find a lower
 > bound that should suffice.

That's the problem, haha. End users(customers) may modprobe many other modules and modprobe our
driver in the end. We cannot decide the probe order for end users.

Apart from our cases, I heard there are some other cases where cma_alloc failed even non-cma system memory has
enough memory because pages in CMA memory are pinned and cannot move out of CMA. There are some fixes like
1. move these memory out of CMA before pinned
2. only allow non-long-time pinned memory allocation from CMA.

But these two solutions are not merged into the mainline yet.

 > 
 > Most coherent allocations tend to be long-lived and only for very
 > small memory regions.
 > If you have another driver that uses large or periodic
 > dma_alloc_coherent() type allocations,
 > you can consider either giving that device its own CMA area, or fixing
 > it to use streaming
 > mappings.

Device-wise CMA also suffers from the problems I mentioned, other modules/subsystems may have already
alloc from this CMA area and refuse to return it back.

Regards,
Li
