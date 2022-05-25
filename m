Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9A95336BF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244124AbiEYG0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiEYG0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:26:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137A2E02C;
        Tue, 24 May 2022 23:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653460002; x=1684996002;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lbi++CXcaekGLCTBDHq57kBFex4czpZ+/tgqoBHU1dU=;
  b=LOXMuG+Gx8x7J8nv52VrS9z72EXRR3T+7vxHBz32MprbCtwi8iQ8z0Ou
   B73ByZ+AHcvfAmSev+n/8+UAztB8yzFGJskxx+R4dzYC1ibXpb4OVnysT
   AP5yNW2EFcrCpw3szKZ32cwg/XK/D31dXfCLbEfrKDxQ241xYVi2Rsjfw
   Y1MicZRM2bjzKJ/TEQewVGXaqcYT47DsJWFsaehqAL0LceT+NsqtXZiVB
   3r8GfmCRG7napTYcDjs91V62HCnwzp/vNt5XOPbYNwPLkXk3Y0/ydwzRg
   LDNatSuJ1EglCsUKi3Z+zavLWrOQt1EE414j2xlPjtdXYeQz8IY5yPWW0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="271304647"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="271304647"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 23:26:41 -0700
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="601683714"
Received: from jwang96-mobl.ccr.corp.intel.com (HELO [10.255.29.139]) ([10.255.29.139])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 23:26:38 -0700
Message-ID: <63369db0-cf7f-aa53-bf9f-de2b0b2289ac@linux.intel.com>
Date:   Wed, 25 May 2022 14:26:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Cc:     baolu.lu@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Content-Language: en-US
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>
References: <20220525013147.2215355-1-nobuhiro1.iwamatsu@toshiba.co.jp>
 <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/25 09:31, Nobuhiro Iwamatsu wrote:
> +static const struct iommu_ops visconti_atu_ops = {
> +	.domain_alloc = visconti_atu_domain_alloc,
> +	.probe_device = visconti_atu_probe_device,
> +	.release_device = visconti_atu_release_device,
> +	.device_group = generic_device_group,
> +	.of_xlate = visconti_atu_of_xlate,
> +	.pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
> +	.default_domain_ops = &(const struct iommu_domain_ops) {
> +		.attach_dev = visconti_atu_attach_device,
> +		.detach_dev = visconti_atu_detach_device,

The detach_dev callback is about to be deprecated. The new drivers
should implement the default domain and blocking domain instead.

> +		.map = visconti_atu_map,
> +		.unmap = visconti_atu_unmap,
> +		.iova_to_phys = visconti_atu_iova_to_phys,
> +		.free = visconti_atu_domain_free,
> +	}
> +};

Best regards,
baolu
