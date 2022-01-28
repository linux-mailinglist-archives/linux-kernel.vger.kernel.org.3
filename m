Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073634A03E6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 23:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiA1Wrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 17:47:35 -0500
Received: from mga14.intel.com ([192.55.52.115]:1058 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233224AbiA1Wre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 17:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643410054; x=1674946054;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=puBJdiiCxb8KkFAwy0gM54yEdSt0bDhr/dNhQPUlv7A=;
  b=LxeAae5kcoY4Ceju1cBIDk/j+uNdCkZO3yyLgyazDfc67WbeyTTktzOA
   an1RAiANcw7xRHpAL3N3iQUX+YBvtoTm80DhAQwz0R0XlDya6Abtlh/8j
   koM1YfKxJyKxsir0Eeo9MXSJByml9qF2WgcEI+T42Qs/Yh+T60HlSBwgQ
   4OZ7bt7/2KJGBIMAV1V+brugAt+DAwNw4TeJYdp0HHqkROkbjPJR+5Z7X
   nIfp/zIN+InNZuCgtOT0pnVN2rdzogS3XesZKWlwqi6kkWHkOmD/oUO+r
   Z9PTwj417+MpMQu0Mg8cEkDHkrE/s9Q8t7isdrrN7z30khJQDPcFC0xFt
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="247431726"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="247431726"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:47:34 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697240823"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 14:47:33 -0800
Message-ID: <8967ea5a-99bf-8990-6ee1-8e0d32031f16@intel.com>
Date:   Fri, 28 Jan 2022 14:47:30 -0800
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
 <20220127175505.851391-5-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 04/44] x86/pkeys: Add additional PKEY helper macros
In-Reply-To: <20220127175505.851391-5-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> +#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
> +#define PKR_WD_KEY(pkey)	(PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))

I don't _hate_ this, but naming here is wonky for me.  PKR_WD_KEY reads
to me as "pkey register write-disable key", as in, please write-disable
this key, or maybe "make a write-disable key".

It's generating a mask, so I'd probably name it:

#define PKR_WD_MASK(pkey)	(PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))

Which says, "generate a write-disabled mask for this pkey".
