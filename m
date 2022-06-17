Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39D454F9D2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382965AbiFQPC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382684AbiFQPCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:02:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93FF6348;
        Fri, 17 Jun 2022 08:02:49 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25HF2Z2X078958;
        Fri, 17 Jun 2022 10:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655478155;
        bh=XbiXWl1XRYyu2fHf9HKjD4wzu1Kv0x9mmlHZ/T7l6iI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Th7PMKT2h4eyCqkpTMmRj5r+8rCqkw3mdlBHTQSqpqCJwvr0rVVTDTGilCmM6QfnQ
         XIHRD/xDgLXhQajOxZZ+hVDxafPYBjEmbKgtXLUGRSTrJb0pMvkngWLZRkEEnEJ9IU
         ZqaocicGgs6fySeBtLQ0LT+OV2pySqj69EDvkjxQ=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25HF2ZLk105696
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 10:02:35 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 10:02:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 10:02:35 -0500
Received: from ubuntu (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with SMTP id 25HF2SBF124766;
        Fri, 17 Jun 2022 10:02:30 -0500
Date:   Fri, 17 Jun 2022 08:02:27 -0700
From:   Matt Ranostay <mranostay@ti.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2] arm64: dts: ti: k3-j721s2: fix overlapping GICD
 memory region
Message-ID: <YqyXg2//cglzV7eF@ubuntu>
References: <20220617140207.444298-1-mranostay@ti.com>
 <87tu8j2x9u.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87tu8j2x9u.wl-maz@kernel.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 03:13:33PM +0100, Marc Zyngier wrote:
> On Fri, 17 Jun 2022 15:02:07 +0100,
> Matt Ranostay <mranostay@ti.com> wrote:
> > 
> > GICD region was overlapping with GICR causing the latter to not map
> > successfully, and in turn the gic-v3 driver would fail to initialize.
> > 
> > This issue was hidden till commit 2b2cd74a06c3 ("irqchip/gic-v3: Claim iomem resources")
> > replaced of_iomap() calls with of_io_request_and_map() that internally
> > called request_mem_region().
> 
> Please correctly wrap long lines in the commit message.
> 
> > 
> > Respective console output before this patchset:
> > 
> > [    0.000000] GICv3: /bus@100000/interrupt-controller@1800000: couldn't map region 0
> > 
> > Fixes: 2b2cd74a06c3 ("irqchip/gic-v3: Claim iomem resources")
> 
> No, that's the wrong target for this. Your patch fixes the *original*
> submission of the DT, and this should carry a:
> 
> Fixes: b8545f9d3a54 ("arm64: dts: ti: Add initial support for J721S2 SoC")
>

Ah right. Not sure I was thinking there.. will fix in v3.

- Matt


> Please also consider adding a
> 
> Cc: stable@vger.kernel.org
> 
> Thanks,
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
