Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF984A795B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 21:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbiBBU0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 15:26:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:62073 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241602AbiBBU0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 15:26:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643833607; x=1675369607;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=6sKq2MjxIt1l7/Gwb7wKTBHSzTyoMFcVetlwwPR3+iY=;
  b=QXoK4beEAg7W+jpO5ne25UIgWAy8kjQtanaC+DE7CCO7eIv18ZbhG9Tg
   P0IsJ/HN/l356Jcw+sqBBA2Vy1X6h5RVdezyDWl8mWktctXmXFr4UHJws
   azDcvl07FCfB83KvwtFtC+/pC5vj8wv4jWDLwjgJT6u+YkeoIS+h3q8ux
   DVHvoWFIcXalXhfGVjl9O7CHKKmoQjMi8bBoSm2DYK8btl9JQKk5zn/W+
   HbtYPFDQV199E3D0BcSD3OuMBEzgumiRzvHBEfwEiYrsBYi5GNsGpy0qS
   P9GTUqh77T4eXn5NFASP/5UVA18MXfh1BCow0Gr14h0gMKcFvkeB8DxJZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="247780989"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="247780989"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:26:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="699043634"
Received: from akashch1-mobl10.amr.corp.intel.com (HELO [10.212.210.91]) ([10.212.210.91])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 12:26:47 -0800
Message-ID: <eff862e2-bfaa-9e12-42b5-a12467d72a22@intel.com>
Date:   Wed, 2 Feb 2022 12:26:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-5-ira.weiny@intel.com>
 <8967ea5a-99bf-8990-6ee1-8e0d32031f16@intel.com>
 <20220202202159.GU785175@iweiny-DESK2.sc.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 04/44] x86/pkeys: Add additional PKEY helper macros
In-Reply-To: <20220202202159.GU785175@iweiny-DESK2.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/22 12:21, Ira Weiny wrote:
> On Fri, Jan 28, 2022 at 02:47:30PM -0800, Dave Hansen wrote:
>> #define PKR_WD_MASK(pkey)	(PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
>>
>> Which says, "generate a write-disabled mask for this pkey".
> 
> I think the confusion comes from me having used these as mask values rather
> than what PKR_AD_KEY() was intended to be used for.
> 
> In the previous patch PKR_AD_KEY() is used to set up the default user pkey
> value...
> 
> u32 init_pkru_value = PKR_AD_KEY( 1) | PKR_AD_KEY( 2) | PKR_AD_KEY( 3) |
> 		      PKR_AD_KEY( 4) | PKR_AD_KEY( 5) | PKR_AD_KEY( 6) |
> 		      PKR_AD_KEY( 7) | PKR_AD_KEY( 8) | PKR_AD_KEY( 9) |
> 		      PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) |
> 		      PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15);
> 

Hah, I'm complaining about my own code.

> u32 init_pkru_value = PKR_AD_MASK( 1) | PKR_AD_MASK( 2) | PKR_AD_MASK( 3) |
> 		      PKR_AD_MASK( 4) | PKR_AD_MASK( 5) | PKR_AD_MASK( 6) |
> 		      PKR_AD_MASK( 7) | PKR_AD_MASK( 8) | PKR_AD_MASK( 9) |
> 		      PKR_AD_MASK(10) | PKR_AD_MASK(11) | PKR_AD_MASK(12) |
> 		      PKR_AD_MASK(13) | PKR_AD_MASK(14) | PKR_AD_MASK(15);
> 
> It seems odd to me.  Does it seem odd to you?

Looks OK to me.  It's build a "value" out of a bunch of individual masks.

> Looking at the final code I think I'm going to just drop the usages in this
> patch and add PKR_WD_KEY() where it is used first.
> 
> Also, how about PKR_KEY_INIT_{AD|WD|RW}() as a name?

For the PKR_AD_KEY() macro?
