Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B90559A58
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 15:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiFXN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 09:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbiFXN2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 09:28:17 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670E2B7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 06:28:14 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 52E59672; Fri, 24 Jun 2022 15:28:12 +0200 (CEST)
Date:   Fri, 24 Jun 2022 15:28:08 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, hch@lst.de, john.garry@huawei.com
Subject: Re: [PATCH v2] iommu/dma: Add config for PCI SAC address trick
Message-ID: <YrW76PPKadbZuN/3@8bytes.org>
References: <3f06994f9f370f9d35b2630ab75171ecd2065621.1654782107.git.robin.murphy@arm.com>
 <YrMSJ6AGwn3PxSIH@8bytes.org>
 <b9439692-c72b-b856-c7c0-e60a863f3e74@arm.com>
 <YrRPfhXvdPo0Y6Cx@8bytes.org>
 <653fba02-7eef-5f0d-66dd-7599af84db86@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <653fba02-7eef-5f0d-66dd-7599af84db86@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 23, 2022 at 12:41:00PM +0100, Robin Murphy wrote:
> On 2022-06-23 12:33, Joerg Roedel wrote:
> > On Wed, Jun 22, 2022 at 02:12:39PM +0100, Robin Murphy wrote:
> > > Thanks for your bravery!
> > 
> > It already starts, with that patch I am getting:
> > 
> > 	xhci_hcd 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x000f address=0xff00ffffffefe000 flags=0x0000]
> > 
> > In my kernel log. The device is an AMD XHCI controller and seems to
> > funciton normally after boot. The message disappears with
> > iommu.forcedac=0.
> > 
> > Need to look more into that...
> 
> Given how amd_iommu_domain_alloc() sets the domain aperture, presumably the
> DMA address allocated was 0xffffffffffefe000? Odd that it gets bits punched
> out in the middle rather than simply truncated off the top as I would have
> expected :/

So even more weird, as a workaround I changed the AMD IOMMU driver to
allocate a 4-level page-table and limit the DMA aperture to 48 bits. I
still get the same message.

