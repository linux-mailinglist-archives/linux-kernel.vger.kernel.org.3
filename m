Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D7A52E6F6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346810AbiETIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbiETIJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:09:37 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DEF8DDEC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:09:36 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B62ED820; Fri, 20 May 2022 10:09:34 +0200 (CEST)
Date:   Fri, 20 May 2022 10:09:33 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        vasant.hegde@amd.com, jon.grimm@amd.com
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO
 page tables are in used
Message-ID: <YodMvV/8eii4KCLg@8bytes.org>
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org>
 <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suravee,

On Mon, May 16, 2022 at 07:27:51PM +0700, Suravee Suthikulpanit wrote:
> Due to the new restriction (please see the IOMMU spec Rev 3.06-PUB - Apr 2021
> https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf) where the use of
> DTE[Mode]=0 is not supported on systems that are SNP-enabled (i.e. EFR[SNPSup]=1),
> the IOMMU HW looks at the DTE[TV] bit to determine if it needs to handle the v1 page table.
> When the HW encounters DTE entry with TV=1, V=1, Mode=0, it would generate
> ILLEGAL_DEV_TABLE_ENTRY event.

Ah, that is the part I was missing, thanks.

> - I am still trying to see what is the best way to force Linux to not allow
> Mode=0 (i.e. iommu=pt mode). Any thoughts?

I think this needs a general approach. First start in the AMD IOMMU
driver:

	1) Do not set DTE.TV=1 bit iff SNP-Support is enabled
	2) Fail to allocate passthrough domains when SNP support is
	   enabled.

Then test how the IOMMU core layer handles that. In fact the IOMMU layer
needs to adjust its decisions so that:

	1) It uses translated-mode by default
	2) passthrough domains are disallowed and can not be chosen, not
	   on the kernel command line and not at runtime.

Ideally this needs some kind of arch-callback to set the appropriate
defaults.

> - Also, it seems that the current iommu v2 page table use case, where GVA->GPA=SPA
> will no longer be supported on system w/ SNPSup=1. Any thoughts?

Support for that is not upstream yet, it should be easy to disallow this
configuration and just use the v1 page-tables when SNP is active. This
can be handled entirely inside the AMD IOMMU driver.

Regards,

	Joerg
