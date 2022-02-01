Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E11544A62CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241639AbiBARpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:45:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:56467 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241613AbiBARpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643737504; x=1675273504;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=0W+LBJSksi1B6Xpl46q7uycB5XXDwTeHQkfAqhzpMEs=;
  b=Cdq9IVRDXcGTxaOwqfUjwUbx9XFJ5gIHHKTiYKPFCn4AzvGS3Hi3DjzL
   0KiiqTRK0Kxbdfbc547e+NnTvcCCzZkJkYsJbnqmU37AaPiL1qWdlyNXx
   7NleMaiiNlOR/S70O2PewR84hKdzZcr/d+nYqukeKtUZmrmFy62xVgQUy
   bAyvgCfRFHPpe2FDfoNIu8TVJS2MxpwYhFr4+mVxi0jN0ttYm9kh9gY+E
   wLL/kSjQxE324iwZSh0qaKOdnl2oJXDa8GI08ET07j1gIhHoiUg1yL7y2
   1MGFoZdUy9iLvD+8sBWa1NVE2fFH71hpiJiDNCokUlOS4KaymxDNxA5vJ
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247517814"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="247517814"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:45:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="583112150"
Received: from kssimha-mobl1.amr.corp.intel.com (HELO [10.212.228.15]) ([10.212.228.15])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:45:03 -0800
Message-ID: <00b87c5f-b4ed-7593-827c-0e1114b8b456@intel.com>
Date:   Tue, 1 Feb 2022 09:45:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     ira.weiny@intel.com, Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
References: <20220127175505.851391-1-ira.weiny@intel.com>
 <20220127175505.851391-20-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 19/44] mm/pkeys: PKS Testing, add pks_mk_*() tests
In-Reply-To: <20220127175505.851391-20-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
>  bool pks_test_callback(void)
>  {
> -	return false;
> +	bool armed = (test_armed_key != 0);
> +
> +	if (armed) {
> +		pks_mk_readwrite(test_armed_key);
> +		fault_cnt++;
> +	}
> +
> +	return armed;
> +}

Where's the locking for all this?  I don't think we need anything fancy,
but is there anything preventing the test from being started from
multiple threads at the same time?  I think a simple global test mutex
would probably suffice.

Also, pks_test_callback() needs at least a comment or two about what
it's doing.

Does this work if you have a test armed and then you get an unrelated
PKS fault on another CPU?  I think this will disarm the test from the
unrelated thread.
