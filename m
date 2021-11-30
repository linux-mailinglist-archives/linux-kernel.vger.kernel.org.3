Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD17463F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 21:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbhK3VBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:01:53 -0500
Received: from soltyk.jannau.net ([144.76.91.90]:50062 "EHLO soltyk.jannau.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343866AbhK3VAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:00:04 -0500
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 6F085261BA6; Tue, 30 Nov 2021 21:56:31 +0100 (CET)
Date:   Tue, 30 Nov 2021 21:56:31 +0100
From:   Janne Grunau <j@jannau.net>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Robin Murphy <robin.murphy@arm.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/4] iommu: M1 Pro/Max DART support
Message-ID: <20211130205631.GD28130@jannau.net>
References: <20211117211509.28066-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117211509.28066-1-sven@svenpeter.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hej,

On 2021-11-17 22:15:05 +0100, Sven Peter wrote:
> 
> This is a fairly brief series to add support for the DARTs present in the
> M1 Pro/Max. They have two differences that make them incompatible with
> those in the M1:
> 
>   - the physical addresses are shifted left by 4 bits and and have 2 more
>     bits inside the PTE entries
>   - the subpage protection feature is now mandatory. For Linux we can
>     just configure it to always allow access to the entire page.
> 
> Note that this needs a fix to the core pagetable code. Hector already
> sent a first version separately to the mailing list since the problem
> is (at least in theory) also present on other SoCs using the LPAE format
> with a large physical address space [1].
> 
> Sven
> 
> [1] https://lore.kernel.org/linux-iommu/a2b45243-7e0a-a2ac-4e14-5256a3e7abb4@arm.com/T/#t
> 
> Sven Peter (4):
>   dt-bindings: iommu: dart: add t6000 compatible
>   iommu/io-pgtable: Add DART subpage protection support
>   iommu/io-pgtable: Add DART PTE support for t6000
>   iommu: dart: Support t6000 variant
> 
>  .../devicetree/bindings/iommu/apple,dart.yaml |  4 +-
>  drivers/iommu/apple-dart.c                    | 19 ++++++++-
>  drivers/iommu/io-pgtable-arm.c                | 40 ++++++++++++++++++-
>  include/linux/io-pgtable.h                    |  2 +
>  4 files changed, 61 insertions(+), 4 deletions(-)

Whole series tested on M1 Max. Feel free to add
Tested-by: Janne Grunau <j@jannau.net>

best
Janne
