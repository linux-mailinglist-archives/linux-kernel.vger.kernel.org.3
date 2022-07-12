Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D340957164F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232441AbiGLJ7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGLJ66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:58:58 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1ED62529E;
        Tue, 12 Jul 2022 02:58:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657619911; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=N8Wwh5ZrxfDe+GMBeGfpPZ3e1nuPgwR/Ify54BgR/Yfuw59X3b4hF88u7M5kFxD6JtdN7DccyjsoC3jHAdFWdgVyKs7RVH5GuAOcRvy6t81XuUX+Y519PMYa4Vekry9GKbkm6Kv5DGvql91k2q5sQRG7+P2Oq2otk5Mtjo4DcNA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657619911; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=oYmnSNasXsz26eSg9mhjVYwcpWPPoFUecXawM5smvMI=; 
        b=MzX9q3FPWhevfCqNo9ft00EODGHInwZJvoozx7vsSY6Gfb0tp+RNI2/BYX0QMYjm4VoG9OcW6ui3zOmBjlh+kOBAyBzlyuQUViE9RuIX1H51jBvQmh8S13h+8+6gDP0yBK27K1+nY0LgjuXoJjwqxkZ7xBBPhapQvei/GTYlnKs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657619911;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=oYmnSNasXsz26eSg9mhjVYwcpWPPoFUecXawM5smvMI=;
        b=mKhuxwbrK9EMCJnF4zTdx0uxUgK8wH1F7Xd/+pDIdxpnyLBwQikRq8VQ47b/dbvN
        sQcsiMof1gsZvHJJMLSB62FG0KgoJN0N+rMygSmQA5ch3Q83q+uk/NroA5OD1AHKBkB
        q2bqkah1dvzWqGHOLbk+Oqd1XBeiBUU8hQemu1xM=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1657619909505764.9703126327654; Tue, 12 Jul 2022 02:58:29 -0700 (PDT)
Date:   Tue, 12 Jul 2022 17:58:29 +0800
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
Message-ID: <181f1d88b64.e2eb2601586551.453778983551010212@linux.beauty>
In-Reply-To: <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty>
 <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com> <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty> <CAK8P3a30o1RLifV1TMqDJ26vLhVdOzz3wP6yPrayLV2GPxUtwQ@mail.gmail.com>
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
 ---- On Tue, 12 Jul 2022 15:50:46 +0800  Arnd Bergmann <arnd@arndb.de> wrote --- 
 > On Tue, Jul 12, 2022 at 2:26 AM Li Chen <me@linux.beauty> wrote:
 > >  ---- On Mon, 11 Jul 2022 21:28:10 +0800  Arnd Bergmann <arnd@arndb.de> wrote ---
 > >  > On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:
 > >  > >
 > >  > > From: Li Chen <lchen@ambarella.com>
 > >  > >
 > >  > > This sample driver shows how to build struct pages support to no-map rmem.
 > >  > >
 > >  > > Signed-off-by: Li Chen <lchen@ambarella.com>
 > >  >
 > >  > Not sure what a sample driver helps here if there are no actual users in-tree.
 > >  >
 > >  > It would make more sense to merge the driver that wants to actually use this
 > >  > first, and then add the additional feature.
 > >
 > > Totally agree, but we plan to start rewriting our video driver in a long time, it
 > > has many legacy codes and I need to rewrite a lot of codes to migrate to v4l2.
 > > That's why I also submit a sample driver here: to make the review progress
 > > easier and don't need reviewers to read video driver codes.
 > 
 > The problem is that this patch may not be the right solution for your new
 > driver either.  As Christoph also commented, what you do here is rather
 > unusual, and without seeing the video driver first, we have no way of
 > knowing whether there is something the driver should be doing
 > differently to solve the original problem.

Ok, I will update the patch series after rewriting and upstreaming our video driver.

 > 
 > >  > > +/*
 > >  > > + * dts example
 > >  > > + * rmem: rmem@1 {
 > >  > > + *                     compatible = "shared-dma-pool";
 > >  > > + *                     no-map;
 > >  > > + *                     size = <0x0 0x20000000>;
 > >  > > + *             };
 > >  > > + * perf {
 > >  > > + *             compatible = "example,rmem";
 > >  > > + *             memory-region = <&rmem>;
 > >  > > + *     };
 > >  >
 > >  > The problem here is that the DT is meant to describe the platform in an OS
 > >  > independent way, so having a binding that just corresponds to a user space
 > >  > interface is not a good abstraction.
 > >
 > > Gotcha, but IMO dts + rmem is the only choice for our use case. In our real
 > > case, we use reg instead of size to specify the physical address, so
 > > memremap cannot be used.
 > 
 > Does your hardware require a fixed address for the buffer? If it can be
 > anywhere in memory (or at least within a certain range) but just has to
 > be physically contiguous, the normal way would be to use a CMA area
 > to allocate from, which gives you 'struct page' backed pages.

The limitation is our DSP can only access 32bit memory, but total dram is > 4G, so I cannot use
"size = <...>" in our real case (it might get memory above 4G). I'm not sure if other vendors' DSP also has
this limitation, if so, how do they deal with it if throughput matters.

Regards,
Li
