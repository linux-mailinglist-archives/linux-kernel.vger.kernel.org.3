Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D9C4A04A8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 00:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344659AbiA1XxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 18:53:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:46226 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351878AbiA1XwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 18:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643413920; x=1674949920;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=hfvER/Y5/Pa8WlFEj567GqBFmOXKBuevJD08dUwAxpQ=;
  b=BC9tQmgwgM432UzRISR1x2Lt9Ba0W33MGAbaUYZLJJd2oUE3WmT8pl05
   dOdz63C4ZhJmcFCUwIbo0SROAk/zilTlCRXG+ABhvNn0uoGU2EYkpDZhD
   QhyaZHWzo7kwneSV9acsfJk9akhFj2bmdFLnnO545AxnjyR8lx2v6afv5
   X2I3sBtd8MF+LfKEi78CJ40NtILapF5FjJTMBLZ6YWIj3dfYirvK8ikHw
   9I846Rd2ocPmNTWQu2nK+rstg+YJcJbwVGIA5gc4GuJFWDV/ytmZ8mGSl
   mJzggUs/7QcsCBGBGzJOzAfMI5ahahi1CrMhrn5+VQ3AxkgUdqMmvb2qr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246989638"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="246989638"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:51:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697255156"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 15:51:59 -0800
Message-ID: <f72b0e17-11bf-b12e-fe7a-d38b0833acdc@intel.com>
Date:   Fri, 28 Jan 2022 15:51:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.2
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-7-ira.weiny@intel.com>
 <9c4a8275-236d-67b6-07f9-5e46f66396c0@intel.com>
 <20220128231015.GK785175@iweiny-DESK2.sc.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 06/44] mm/pkeys: Add Kconfig options for PKS
In-Reply-To: <20220128231015.GK785175@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/22 15:10, Ira Weiny wrote:
> This issue is that because PKS users are in kernel only and are not part of the
> architecture specific code there needs to be 2 mechanisms within the Kconfig
> structure.  One to communicate an architectures support PKS such that the user
> who needs it can depend on that config as well as a second to allow that user
> to communicate back to the architecture to enable PKS.

I *think* the point here is to ensure that PKS isn't compiled in unless
it is supported *AND* needed.  You have to have architecture support
(ARCH_HAS_SUPERVISOR_PKEYS) to permit features that depend on PKS to be
enabled.  Then, once one ore more of *THOSE* is enabled,
ARCH_ENABLE_SUPERVISOR_PKEYS comes into play and actually compiles the
feature in.

In other words, there are two things that must happen before the code
gets compiled in:

1. Arch support
2. One or more features to use the arch support

