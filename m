Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AF05A89C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 02:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiIAAWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 20:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIAAWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:22:37 -0400
X-Greylist: delayed 452 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 31 Aug 2022 17:22:35 PDT
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71A1DDAAF
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 17:22:35 -0700 (PDT)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id 22D3326EF4A; Thu,  1 Sep 2022 02:22:34 +0200 (CEST)
Date:   Thu, 1 Sep 2022 02:22:34 +0200
From:   Janne Grunau <j@jannau.net>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     iommu@lists.linux-foundation.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        asahi@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        Hector Martin <marcan@marcan.st>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] iommu/io-pgtable-dart: Add DART PTE support for
 t6000
Message-ID: <20220901002234.GD10102@jannau.net>
References: <20220621071848.14834-1-j@jannau.net>
 <20220621071848.14834-5-j@jannau.net>
 <2df8c1d1-fb83-5b92-d32a-6b8ba988844c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2df8c1d1-fb83-5b92-d32a-6b8ba988844c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-27 16:13:20 +0100, Robin Murphy wrote:
> On 2022-06-21 08:18, Janne Grunau wrote:
> > From: Sven Peter <sven@svenpeter.dev>
> > 
> > The DARTs present in the M1 Pro/Max/Ultra SoC use a diffent PTE format.
> > They support a 42bit physical address space by shifting the paddr and
> > extending its mask inside the PTE.
> > They also come with mandatory sub-page protection now which we just
> > configure to always allow access to the entire page. This feature is
> > already present but optional on the previous DARTs which allows to
> > unconditionally configure it.
> > 
> > Signed-off-by: Sven Peter <sven@svenpeter.dev>
> > Co-developed-by: Janne Grunau <j@jannau.net>
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > 
> > ---
> > 
> > Changes in v3:
> > - apply change to io-pgtable-dart.c
> > - handle pte <> paddr conversion based on the pte format instead of
> >    the output address size
> > 
> > Changes in v2:
> > - add APPLE_DART2 PTE format
> > 
> >   drivers/iommu/io-pgtable-dart.c | 51 +++++++++++++++++++++++++++------
> >   drivers/iommu/io-pgtable.c      |  1 +
> >   include/linux/io-pgtable.h      |  1 +
> >   3 files changed, 45 insertions(+), 8 deletions(-)
> > 
> [...]
> > @@ -536,7 +571,7 @@ apple_dart_alloc_pgtable(struct io_pgtable_cfg *cfg, void *cookie)
> >   	if (!cfg->coherent_walk)
> >   		return NULL;
> > -	if (cfg->oas > 36)
> > +	if (cfg->oas != 36 && cfg->oas != 42)
> >   		return NULL;
> 
> Wouldn't it make sense to tie this to the format? Maybe 36-bit OAS is still
> valid with v2, but presumably 42-bit with v1 definitely isn't.

The format is not know inside the alloc call unless I add per format 
alloc wrapper. I think we can trust the caller for now.

Janne

