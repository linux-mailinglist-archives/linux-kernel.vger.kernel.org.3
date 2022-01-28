Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586A84A03DB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351759AbiA1WoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:44:17 -0500
Received: from mga06.intel.com ([134.134.136.31]:39221 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344236AbiA1WoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:44:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643409852; x=1674945852;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=o0hjxthhhxBCb83EUCWwEsDk1eXQKwyFRTUgSJyDeXg=;
  b=O1WRmTybbMriKLPH/pAhco0o92QbIfQmjkX8tsiZ/7IBg4avbq4ZaF0O
   o06dff14YaKqmQxp72cwbzFSsBS5/F/Uu19B8kYjQZSFfQ1Vfw8S3nRZT
   QhEVYDoFH+TUbgV4SXOhdhWjy6GEU/PQlYWJr9iXVnuJwBee9PkqMsmvD
   m8iaPLw/iwfPkPWzs8WOUN6gnlz9GTx6hkeUyRspfc3l2J08/5lG3nD++
   DigKCoPEWj/s/XF1C4K0eKX9DEfFrPQ7E7/b0xnyVjTR/Z5LQz61FBAM+
   OQ+xWnflgTvClI3cwv/38s94H5Y+645gdx1vQCBDzdcAvQtAl2IGzevU0
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="307940309"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="307940309"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:43:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697239820"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:43:55 -0800
Message-ID: <7bb7d2be-9fa0-1b0d-17d1-adb7d58d5389@intel.com>
Date:   Fri, 28 Jan 2022 14:43:54 -0800
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
 <20220127175505.851391-4-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 03/44] x86/pkeys: Create pkeys_common.h
In-Reply-To: <20220127175505.851391-4-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Protection Keys User (PKU) and Protection Keys Supervisor (PKS) work in
> similar fashions and can share common defines.  Specifically PKS and PKU
> each have:
> 
> 	1. A single control register
> 	2. The same number of keys
> 	3. The same number of bits in the register per key
> 	4. Access and Write disable in the same bit locations
> 
> Given the above, share all the macros that synthesize and manipulate
> register values between the two features.  Share these defines by moving
> them into a new header, change their names to reflect the common use,
> and include the header where needed.

I'd probably include *one* more sentence to prime the reader for the
pattern they are about to see.  Perhaps:

	This mostly takes the form of converting names from the PKU-
	specific "PKRU" to the U/S-agnostic "PKR".

> Also while editing the code remove the use of 'we' from comments being
> touched.
> 
> NOTE the checkpatch errors are ignored for the init_pkru_value to
> align the values in the code.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Either way, this looks fine:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
