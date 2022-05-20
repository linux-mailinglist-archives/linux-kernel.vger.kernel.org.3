Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65CF52E81B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 10:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347427AbiETIzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 04:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347096AbiETIzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 04:55:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 048C1994FC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 01:54:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D1291477;
        Fri, 20 May 2022 01:54:58 -0700 (PDT)
Received: from [10.57.82.55] (unknown [10.57.82.55])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 495CD3F66F;
        Fri, 20 May 2022 01:54:57 -0700 (PDT)
Message-ID: <794e13dd-8eae-481d-711d-b5462fdbfb18@arm.com>
Date:   Fri, 20 May 2022 09:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] iommu/amd: Set translation valid bit only when IO page
 tables are in used
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc:     iommu@lists.linux-foundation.org, jon.grimm@amd.com,
        linux-kernel@vger.kernel.org, vasant.hegde@amd.com
References: <20220509074815.11881-1-suravee.suthikulpanit@amd.com>
 <Yn5YIfzmerwAM30M@8bytes.org> <1dfaf07e-040e-848b-db7c-86a107fd5cb3@amd.com>
 <YodMvV/8eii4KCLg@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YodMvV/8eii4KCLg@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-20 09:09, Joerg Roedel wrote:
> Hi Suravee,
> 
> On Mon, May 16, 2022 at 07:27:51PM +0700, Suravee Suthikulpanit wrote:
>> Due to the new restriction (please see the IOMMU spec Rev 3.06-PUB - Apr 2021
>> https://www.amd.com/system/files/TechDocs/48882_IOMMU.pdf) where the use of
>> DTE[Mode]=0 is not supported on systems that are SNP-enabled (i.e. EFR[SNPSup]=1),
>> the IOMMU HW looks at the DTE[TV] bit to determine if it needs to handle the v1 page table.
>> When the HW encounters DTE entry with TV=1, V=1, Mode=0, it would generate
>> ILLEGAL_DEV_TABLE_ENTRY event.
> 
> Ah, that is the part I was missing, thanks.
> 
>> - I am still trying to see what is the best way to force Linux to not allow
>> Mode=0 (i.e. iommu=pt mode). Any thoughts?
> 
> I think this needs a general approach. First start in the AMD IOMMU
> driver:
> 
> 	1) Do not set DTE.TV=1 bit iff SNP-Support is enabled
> 	2) Fail to allocate passthrough domains when SNP support is
> 	   enabled.
> 
> Then test how the IOMMU core layer handles that. In fact the IOMMU layer
> needs to adjust its decisions so that:
> 
> 	1) It uses translated-mode by default
> 	2) passthrough domains are disallowed and can not be chosen, not
> 	   on the kernel command line and not at runtime.
> 
> Ideally this needs some kind of arch-callback to set the appropriate
> defaults.

The .def_domain type op already allows drivers to do exactly this sort 
of override. You could also conditionally reject 
IOMMU_DOMAIN_PASSTHROUGH in .domain_alloc for good measure, provided 
that (for now at least*) SNP is a global thing rather than per-instance.

Cheers,
Robin.

*Instance-aware .domain_alloc probably about 2 releases away at the 
current pace of landing the tree-wide prep ;)

>> - Also, it seems that the current iommu v2 page table use case, where GVA->GPA=SPA
>> will no longer be supported on system w/ SNPSup=1. Any thoughts?
> 
> Support for that is not upstream yet, it should be easy to disallow this
> configuration and just use the v1 page-tables when SNP is active. This
> can be handled entirely inside the AMD IOMMU driver.
> 
> Regards,
> 
> 	Joerg
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
