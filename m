Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A465717B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiGLK4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbiGLK4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:56:14 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA9AE54E;
        Tue, 12 Jul 2022 03:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657623350; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NesB+pgNfxQce8Q3B1kMWPE9IL4UaavFicShfBxDFet9aF74U8kRb82jonZ3bs+4FvuLgAKU9+8jejGXqQzpBHQcmaiEsLiwNMdBmqKiP3xvEIFygJ0UBJnoRhkcRiHE6oH7w4SSiq/M1XX0CoV6d6WeEiMAjxeKHgrQPupaI5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657623350; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=tFSe8DXlfnP6rHVBGRr8qpDTToiIeu8mAIvR+SIfcvs=; 
        b=WpIBPNEcOfsLcMZzFn2MWXCUqTxRahZaFWyPQd4agadCJQDTNS7wzR+DxgM/o/wcjEf6LPmFWqLgjWcUusfScsh/KM3YGc4VORFs0DrnA0v4ZEsdUDYk5UuvTHVDMRJ4+dAW/tli8Li1rlhAcjYYTvX3OWddcvD1o//zPVAtSbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657623350;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=tFSe8DXlfnP6rHVBGRr8qpDTToiIeu8mAIvR+SIfcvs=;
        b=K9L+GTzW7q5PPB0CK2GhHx8xFcFfkcRU2cAR9moGiynNvzWaw9rXMqet08cIl0FC
        fuGdtYBHr9454wBiW7TdTYuNPdJ6pXlM/mcW6U9rkYt9qM/kV+ofw/8NgmtBgIeLhfj
        /CmN+dKnhILe3EByBAGfdjGzWS2mWfmYT1ZwQKRE=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1657623348256160.91761174332316; Tue, 12 Jul 2022 03:55:48 -0700 (PDT)
Date:   Tue, 12 Jul 2022 18:55:48 +0800
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
Message-ID: <181f20d0403.121f433c8600165.2068876337784123868@linux.beauty>
In-Reply-To: <CAK8P3a3gX-JMh6E2X3rH+U37zhkA6b0+AJDtXCJfdZiMocxLjg@mail.gmail.com>
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
 <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
 <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com> <181f1d88b64.e2eb2601586551.453778983551010212@linux.beauty> <CAK8P3a3gX-JMh6E2X3rH+U37zhkA6b0+AJDtXCJfdZiMocxLjg@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,
 ---- On Tue, 12 Jul 2022 18:08:10 +0800  Arnd Bergmann <arnd@arndb.de> wrote --- 
 > On Tue, Jul 12, 2022 at 11:58 AM Li Chen <me@linux.beauty> wrote:
 > >  > On Tue, Jul 12, 2022 at 2:26 AM Li Chen <me@linux.beauty> wrote:
 > >  > >  ---- On Mon, 11 Jul 2022 21:28:10 +0800  Arnd Bergmann <arnd@arndb.de> wrote ---
 > >  > >  > On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:
 > >  > >  > The problem here is that the DT is meant to describe the platform in an OS
 > >  > >  > independent way, so having a binding that just corresponds to a user space
 > >  > >  > interface is not a good abstraction.
 > >  > >
 > >  > > Gotcha, but IMO dts + rmem is the only choice for our use case. In our real
 > >  > > case, we use reg instead of size to specify the physical address, so
 > >  > > memremap cannot be used.
 > >  >
 > >  > Does your hardware require a fixed address for the buffer? If it can be
 > >  > anywhere in memory (or at least within a certain range) but just has to
 > >  > be physically contiguous, the normal way would be to use a CMA area
 > >  > to allocate from, which gives you 'struct page' backed pages.
 > >
 > > The limitation is our DSP can only access 32bit memory, but total dram is > 4G, so I cannot use
 > > "size = <...>" in our real case (it might get memory above 4G). I'm not sure if other vendors' DSP also has
 > > this limitation, if so, how do they deal with it if throughput matters.
 > 
 > This is a common limitation that gets handled automatically by setting
 > the dma_mask of the device through the dma-ranges property in DT.
 > When the driver does dma_alloc_coherent() or similar to gets its buffer,
 > it will then allocate pages below this boundary.
 
Thanks for the tip! I wasn't aware that dma-ranges can be used by devices other than PCIe controllers.

 > If you need a large contiguous memory area, then using CMA allows
 > you to specify a region of memory that is kept reserved for DMA
 > allocations, so a call to dma_alloc_coherent() on your device will
 > get contiguous pages from that area, and move other data in those
 > pages elsewhere if necessary. non-movable data is allocated from
 > pages outside of the CMA reserved area in this case.

We need a large memory pool, around 2G. I will try CMA and dma-ranges later!

Regards,
Li
