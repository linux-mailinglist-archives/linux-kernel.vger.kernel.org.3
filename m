Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D0E4A040F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244564AbiA1XFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:05:47 -0500
Received: from mga07.intel.com ([134.134.136.100]:45265 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241816AbiA1XFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:05:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643411141; x=1674947141;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=AIvUvS81DfKAf+cWFUoQoNAn7ZSmlY1td647YN0yrAw=;
  b=dGj07XLdCfxPp28xQAWqqXnG+pTreZRtZT7IeHRitYer8RFxunz+TTQd
   270w+QBIrucFgf5LPCZ5pmbDk70VdWxB5ymdTexL/7iFn4G+RH7uif2z2
   Q9He5XxQakHX7R2EGm5szg9ZEd6553iXnQzv5X/TwYNYZzNi+VSDoL1Zz
   BNATnlNSsxZGIxTMCUWnagsuYRpvQObeoRGsEl28FMISXKokQBTtrAcyl
   cSV+Cikya5CxjMgrjWphUurCJ3N+31z5rk2EOfhLqdvV4MQeu3Oyb9JEg
   HOWU/EysoL8isVcjrcG8ByMk+1ZAqI29U75zhx2fOHnGvVRwOR6OMWuvk
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="310525683"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="310525683"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:05:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697244952"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:05:39 -0800
Message-ID: <63950211-4244-3f85-0fb3-eb5a38d4ed50@intel.com>
Date:   Fri, 28 Jan 2022 15:05:36 -0800
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
 <20220127175505.851391-8-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 07/44] x86/pkeys: Add PKS CPU feature bit
In-Reply-To: <20220127175505.851391-8-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
> specific, manipulation of permission restrictions on supervisor page

Nit: should be "hardware-thread-specific".

> mappings.  It uses the same mechanism of Protection Keys as those on
> User mappings but applies that mechanism to supervisor mappings using a
> supervisor specific MSR.

"supervisor-specific"

	Memory Protection Keys (pkeys) provides a mechanism for
	enforcing page-based protections, but without requiring
	modification of the page tables when an application changes
	protection domains.

	The kernel currently supports the pkeys for userspace (PKU)
	architecture.  That architecture has been extended to
	additionally support supervisor mappings.  The supervisor
	support is referred to as PKS.

I probably wouldn't mention the MSR unless you want to say:

	The main difference between PKU and PKS is that PKS does not
	introduce any new instructions to write to its register.  The
	register is exposed as a normal MSR and is accessed with the
	normal MSR instructions.


> The CPU indicates support for PKS in bit 31 of the ECX register after a
> cpuid instruction.

I'd just remove this sentence.  We don't need to rehash each tiny morsel
of the architecture in a commit message.
