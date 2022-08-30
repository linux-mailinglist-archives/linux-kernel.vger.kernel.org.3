Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024795A693C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbiH3RGK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbiH3RGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:06:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3303D8168C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661879166; x=1693415166;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WGjrEl22Aq56liEypn1scjKGRY/wkDI6MWC1UBsr848=;
  b=CzGvE9rW4WaXT7TlLTKD76LUSE1Pb0yXgIBo7z9RSj3qJVmPkjqgX/lM
   hR5Am54Bxqpt5+jrK/6r+20oCOU04vN2IbFP37D4R1oPUc9kujQiebM+r
   eT5+lAlPTEMr8q1Qe/ljtBTwSfMllShMF9lWg0brFGc6AQm0QQB2k/ZqO
   LPDIYPgWJ3etBanCl6gpa6uM1DzoY9N/rnuM1Tzj/5Y86iAyghhaIGOmY
   Yn7hoY6Wk6a3h4A70jAdE1AGGDrB8aYYa73E84gMTvo53DSCRcJqmvA9Z
   R7qxCkIQopcqnBxgfAZswuBnQuXWDTnD4n5S5T9+8+jsR7wQA66dC2ism
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="356961281"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="356961281"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 10:05:33 -0700
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="737807762"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.198.157])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 10:05:33 -0700
Date:   Tue, 30 Aug 2022 10:08:49 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>
Cc:     Raj Ashok <ashok.raj@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        "Borislav Petkov" <bp@alien8.de>, "Ingo Molnar" <mingo@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH 0/2] Use the correct page tables for SVA under PTI
Message-ID: <20220830100849.63751271@jacob-builder>
In-Reply-To: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
References: <20220822201213.352289-1-jacob.jun.pan@linux.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu/Joerg,

Just wondering if you have any comments? Thanks.

On Mon, 22 Aug 2022 13:12:11 -0700, Jacob Pan
<jacob.jun.pan@linux.intel.com> wrote:

> Shared virtual addressing allows DMA to user virtual address, But the
> x86 IOMMU drivers are using the kernel copy of the process page tables
> when PTI is enabled. This patchset tightens the security intended by
> PTI by performing SVA binding with the appropriate process PGDs.
> 
> I have tested on Intel platform only, would appreciate itif someone
> could help with testing SVA-KPTI on an AMD system.
> 
> Jacob Pan (2):
>   x86: mm: Allow PTI helpers to be used outside x86/mm
>   iommu: Use the user PGD for SVA if PTI is enabled
> 
>  arch/x86/include/asm/pgtable.h | 5 +++++
>  drivers/iommu/amd/iommu_v2.c   | 4 +++-
>  drivers/iommu/intel/svm.c      | 5 ++++-
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 


Thanks,

Jacob
