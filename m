Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 651194A03F7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiA1Wyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:54:33 -0500
Received: from mga01.intel.com ([192.55.52.88]:54548 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbiA1Wyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:54:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643410471; x=1674946471;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=XgOU541FlQhjL0uDJrwp7c1SOOpkxJu4iUoVA5Mh7mM=;
  b=Ig/+C2BWyv7kMEHekli7Nf6WQJkr4yrD3i33JomyaO0NgOl2cxrmWYuq
   bOIoa05EZmX58hl8EMOHJ7nwkoeg0htc6nOwIV9BI8oquHWZTV2mqeOh6
   GJZJuBnvVg/qQKucK22c7H0m+VobH9RlX6YUky21C9R1ZywGwsephbZtu
   zmbkSxPuHQobs+7Lw5aZW+Vma7yrys/lOJawq1/RGHGE5P8oj2C4EWpnx
   h3XFSabGtUurdBcy0+v6ae9IGQX5syiW+sSNoEOXIjgaREjoxelkVbiCG
   4kMSvaK8vY3sNbvZmtmHN+T826yu3lMuy4tGxGteD+N+1viqsodUsAll7
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="271673594"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="271673594"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:54:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697242453"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:54:30 -0800
Message-ID: <9c4a8275-236d-67b6-07f9-5e46f66396c0@intel.com>
Date:   Fri, 28 Jan 2022 14:54:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-7-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
In-Reply-To: <20220127175505.851391-7-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Protection Key Supervisor, PKS, is a feature used by kernel code only.
> As such if no kernel users are configured the PKS code is unnecessary
> overhead.
> 
> Define a Kconfig structure which allows kernel code to detect PKS
> support by an architecture and then subsequently enable that support
> within the architecture.
> 
> ARCH_HAS_SUPERVISOR_PKEYS indicates to kernel consumers that an
> architecture supports pkeys.  PKS users can then select
> ARCH_ENABLE_SUPERVISOR_PKEYS to turn on the support within the
> architecture.
> 
> If ARCH_ENABLE_SUPERVISOR_PKEYS is not selected architectures avoid the
> PKS overhead.
> 
> ARCH_ENABLE_SUPERVISOR_PKEYS remains off until the first kernel use case
> sets it.

This is heavy on the "what" and weak on the "why".

Why isn't this an x86-specific Kconfig?  Why do we need two Kconfigs?
Good old user pkeys only has one:

	config ARCH_HAS_PKEYS
	        bool

and it's in arch-generic code because there are ppc and x86
implementations *and* the pkey support touches generic code.

This might become evident later in the series, but it's clear as mud as
it stands.
