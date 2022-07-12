Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B06C570EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 02:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiGLA0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 20:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiGLA0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 20:26:30 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F22DA85;
        Mon, 11 Jul 2022 17:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657585576; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=mtb8jFe3/4+KkVb5dM6qz1JRAB7qefaldXT89p6pXK6rdhAIRyC5ZqAWeOEKLZ1IWKCuEgkZi2zBDUe12Nhfr/JdzYaBcjAFKVPqdnTntFyAB6XUgp3BQxG8saRVwkU4Lih2mFTYKjRBmKYTu+dhShXWYpPOt2KUY3j8OHAdaWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657585576; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=jFBczO4Z9TfDcxdB0ArqJHoDxH8ici/TI/3XLJb7X3M=; 
        b=cdZcTbIsOwFaXI2jkalL2uFsW/IBksDLq9RALhunhNE69mFkn9TliQ7HZ2QNcanWnH/JzCon1YZK5cvBziPhu5Cqn72ZPd7q4640LwIRQNaXeTbBXOII0RXZkOiRh3qoxftIyFp4r905dQntTSvMQEMi0gsD0kAz7sp9dJGUS/Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657585576;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=jFBczO4Z9TfDcxdB0ArqJHoDxH8ici/TI/3XLJb7X3M=;
        b=Qxdai5D/7eund7w0ApVgHQPm3iT1PEKhQUQr/EKe6+bZWVe6dGmw46m7vQzLluIt
        KqVJkuBBUm+pEf0bNY/sg1MtjYSuEEev22U45PkSvtEbg4YwgfUVkOrqR0rfLZFGusa
        3/CwneaPhUp564pkpdxcZkMdvtNdwWP9q9ZmqKFI=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1657585575627718.8384328597048; Mon, 11 Jul 2022 17:26:15 -0700 (PDT)
Date:   Tue, 12 Jul 2022 08:26:15 +0800
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
Message-ID: <181efcca6ae.de84203d522625.7740936811073442334@linux.beauty>
In-Reply-To: <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
References: <20220711122459.13773-1-me@linux.beauty> <20220711122459.13773-5-me@linux.beauty> <CAK8P3a2Mr0ZMXGDx6htYEbBBtm4mubk-meSASJjPRK1j1O-hEA@mail.gmail.com>
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
 ---- On Mon, 11 Jul 2022 21:28:10 +0800  Arnd Bergmann <arnd@arndb.de> wrote --- 
 > On Mon, Jul 11, 2022 at 2:24 PM Li Chen <me@linux.beauty> wrote:
 > >
 > > From: Li Chen <lchen@ambarella.com>
 > >
 > > This sample driver shows how to build struct pages support to no-map rmem.
 > >
 > > Signed-off-by: Li Chen <lchen@ambarella.com>
 > 
 > Not sure what a sample driver helps here if there are no actual users in-tree.
 > 
 > It would make more sense to merge the driver that wants to actually use this
 > first, and then add the additional feature.

Totally agree, but we plan to start rewriting our video driver in a long time, it has many legacy codes and I need to rewrite a lot of codes to migrate to v4l2.
That's why I also submit a sample driver here: to make the review progress easier and don't need reviewers to read video driver codes.

 > > +/*
 > > + * dts example
 > > + * rmem: rmem@1 {
 > > + *                     compatible = "shared-dma-pool";
 > > + *                     no-map;
 > > + *                     size = <0x0 0x20000000>;
 > > + *             };
 > > + * perf {
 > > + *             compatible = "example,rmem";
 > > + *             memory-region = <&rmem>;
 > > + *     };
 > 
 > The problem here is that the DT is meant to describe the platform in an OS
 > independent way, so having a binding that just corresponds to a user space
 > interface is not a good abstraction.

Gotcha, but IMO dts + rmem is the only choice for our use case. In our real case, we use reg instead of size to specify the physical address, so memremap cannot be used.

 > 
 > > +       vaddr = reserved_mem_memremap_pages(dev, rmem);
 > > +       if (IS_ERR_OR_NULL(vaddr))
 > > +               return PTR_ERR(vaddr);
 > 
 >  Using IS_ERR_OR_NULL() is usually an indication of a bad interface.
 > 
 > For the reserved_mem_memremap_pages(), you should decide whether to return
 > NULL on error or an error pointer, but not both.

Thanks, will fix in v2.

 > 
 >        Arnd
 > 
