Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07074EB032
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiC2P0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238507AbiC2P0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:26:14 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3531E6660A;
        Tue, 29 Mar 2022 08:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648567471; x=1680103471;
  h=message-id:date:mime-version:to:references:from:subject:
   in-reply-to:content-transfer-encoding;
  bh=EXfw2h4ApJqsKLt0jwN7JfP5ypNKmGZfOtuabYM0CYw=;
  b=TOUhQ3B958jMAsvgCQ1pYN+eFE0E3jWlLDc6jwW4K6fCb+3rqX+IQ0iD
   7xoLR3HWhgUyKeCQoFjmJnU+SkkXpdygJuQUN3RKwVDO+/+d3qtAchI+C
   K0UM4t47gWf4qkkW3jF3eBVZRfR5pw7IFCIwpmnSxRZkaCDbMFe2AP6y3
   dxp4mkqatdU0pQwErDvrk9MiYlowmIH0YGoi1JrhEujTf+eChvW86Q5SW
   uXBdha7/8tlbwfTMjhAcN8VuZ6kfKKE1/Pg/Hb0vz5tCI1e+WaeC8XPMC
   U5b2CtnjnOAzGw835Xlkmgq2gl54XF8+pzosxi3D76Ivd4fAkCggdWnZf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="239872159"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="239872159"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 08:24:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="604840564"
Received: from acstuden-mobl.amr.corp.intel.com (HELO [10.209.45.17]) ([10.209.45.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 08:24:30 -0700
Message-ID: <b3998af9-24bc-6191-a8ed-de747e895799@intel.com>
Date:   Tue, 29 Mar 2022 08:24:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Alex Deucher <alexander.deucher@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, hpa@zytor.com, x86@kernel.org,
        dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com,
        tglx@linutronix.de, joro@8bytes.org, suravee.suthikulpanit@amd.com,
        will@kernel.org, iommu@lists.linux-foundation.org,
        robin.murphy@arm.com, vasant.hegde@amd.com
References: <20220328172829.718235-1-alexander.deucher@amd.com>
 <20220328172829.718235-2-alexander.deucher@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V3 1/2] Documentation: x86: Add documentation for AMD
 IOMMU
In-Reply-To: <20220328172829.718235-2-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/22 10:28, Alex Deucher wrote:
> +How is IOVA generated?
> +----------------------
> +
> +Well behaved drivers call dma_map_*() calls before sending command to device
> +that needs to perform DMA. Once DMA is completed and mapping is no longer
> +required, driver performs dma_unmap_*() calls to unmap the region.
> +
> +Fault reporting
> +---------------
> +
> +When errors are reported, the IOMMU signals via an interrupt. The fault
> +reason and device that caused it is printed on the console.

Just scanning this, it looks *awfully* generic.  Is anything in here
AMD-specific?  Should this be in an AMD-specific file?
