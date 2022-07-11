Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4957047D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbiGKNkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiGKNkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:40:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B1641D18
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:40:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7943968AA6; Mon, 11 Jul 2022 15:40:00 +0200 (CEST)
Date:   Mon, 11 Jul 2022 15:40:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ben Dooks <ben.dooks@sifive.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, iommu@lists.linux-foundation.org,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] swiotlb: ensure io_tlb_default_mem spinlock always
 initialised
Message-ID: <20220711134000.GA18865@lst.de>
References: <20220708170811.270589-1-ben.dooks@sifive.com> <fdf5d34e-7668-c05c-9098-30e34939c88a@arm.com> <683344bd-dc9b-0bb5-9377-b3e9ab410a74@sifive.com> <e6c43ef0-870b-5fe6-141e-0a3d566b030e@arm.com> <20220711102134.GB4639@lst.de> <4fa8b709-c883-54dc-c302-20c9e55ae93a@sifive.com> <20220711103921.GA6542@lst.de> <43426798-44df-c2c7-1f46-0b79201cb620@sifive.com> <ac4944b8-5d15-4761-6315-7dba6eaee0e7@arm.com> <265d7b6b-a0a4-ecaf-10bd-15e1ea416a06@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <265d7b6b-a0a4-ecaf-10bd-15e1ea416a06@sifive.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 01:54:11PM +0100, Ben Dooks wrote:
> I need to go back and check through what we did to get some that worked
> for us, and then come back and try and make some idea of how that is
> best done with upstream kernel.
>
> It might be possible for the PCIe controller to do some sort of very
> simple IOMMU for the case where we might have somehow an PCI device
> added to the system, but that is a very rare use-case I expect and
> if someone does it they can do the effort of updating the PCIe code
> and everything else that goes with it.

Unfortunately there also are plenty of PCIe devices with addressing
limitation even if the PCIe spec explicitly forbits that.  40, 44 or
48 bit limitations seems to be more common than 32-bits, though.
