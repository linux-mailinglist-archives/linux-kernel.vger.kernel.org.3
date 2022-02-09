Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28E64AF122
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 13:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiBIMNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 07:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbiBIMNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 07:13:24 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437C8E01927B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 03:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644407878; x=1675943878;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8IZ/Rh6FmqlwMDzbGpDcbVjCxbVIT0IalMt8i72Hz/I=;
  b=BTgaeIOOTFto4x3JzE+a4Tsz/PU/e57Rks2o0R+jaSOKSnv9uXXmqs9v
   lIAWTnKVd/gKrm0INn1NkirmpXEdX5RSG0Y8Q1hiJnmM3m8/MHoHrh0tf
   89PsrrAUUrgf5ulEcggxzG/4NE03KV1zW7/VcVPXT+qCorRUtftOTwbyd
   UsM35k+fId0HeESetrumvjdEEth2Lfem5YSM8bXpLmQQRWPj8ctPQhQ/O
   joQWhvCwG2QLtT9gkr0npfoDAEW0ykBclozmlDAxqzuw+OJTh9Z0JXfYf
   nImsT+pbi2xXuSxG+b98PG/Fcga2V/zZ5kLR/ev4+ND9DPTj8/l+YJ6m7
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248946666"
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="248946666"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:57:57 -0800
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="541062729"
Received: from smile.fi.intel.com ([10.237.72.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 03:57:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.95)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1nHlaj-002bKV-N1;
        Wed, 09 Feb 2022 13:56:57 +0200
Date:   Wed, 9 Feb 2022 13:56:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 1/1] iommu/vt-d: Move intel_iommu_ops to header file
Message-ID: <YgOsCS/gbfCppMY7@smile.fi.intel.com>
References: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141240.8253-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 04:12:40PM +0200, Andy Shevchenko wrote:
> Compiler is not happy about hidden declaration of intel_iommu_ops.
> 
> .../iommu.c:414:24: warning: symbol 'intel_iommu_ops' was not declared. Should it be static?
> 
> Move declaration to header file to make compiler happy.

Note, with this change we are closer to have a clean build with the
CONFIG_WERROR=y when `make W=1`.

-- 
With Best Regards,
Andy Shevchenko


