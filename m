Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5CBD4A04B9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351887AbiA2ACI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:02:08 -0500
Received: from mga12.intel.com ([192.55.52.136]:58615 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344625AbiA2ACH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643414527; x=1674950527;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=Mc4ka8vlyW5p2Ltj4X/A+Aec2Y189wBh/vWNoLnqt9g=;
  b=kQAqCsLI6CUFmyQtXfZ5PsMlh7ynClWSeSzERwWVvJ+OFRkZ2kVODnvU
   5LpsvsFDFCg3TwexUH8vNWJczVYLWORiG+p6DFrE26eFiRZSfc/jUai3F
   dC9zilL4020WslPEVocEZdQ/GKP+dIzKrSLCZAmtDftSeNbZWj53fzvX/
   2c1Nz4xfLXW8ydUUvXm4voQ3RqpHtgOYrluVq4lS44peIaaQMYK4asm1c
   53/NMtEVglSArm5/R150ZjBmTGz/6wUogEQK2kMLD8s86Ce7+/nTlhnZU
   epTLIOYQwA07CZJfH/Wo+ZAx0N3YlL7JXNsxmFG2naQ0f7yJpC3Kw5nlL
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="227197235"
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="227197235"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:02:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,325,1635231600"; 
   d="scan'208";a="697257536"
Received: from zhenkuny-mobl2.amr.corp.intel.com (HELO [10.209.84.59]) ([10.209.84.59])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 16:02:06 -0800
Message-ID: <f2d05862-9750-fd19-42c0-29aa06bdeb13@intel.com>
Date:   Fri, 28 Jan 2022 16:02:05 -0800
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
 <20220127175505.851391-12-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V8 11/44] mm/pkeys: Define static PKS key array and
 default values
In-Reply-To: <20220127175505.851391-12-ira.weiny@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/22 09:54, ira.weiny@intel.com wrote:
> +#define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		| \
> +			PKR_AD_KEY(1)	| \
> +			PKR_AD_KEY(2)	| PKR_AD_KEY(3)		| \
> +			PKR_AD_KEY(4)	| PKR_AD_KEY(5)		| \
> +			PKR_AD_KEY(6)	| PKR_AD_KEY(7)		| \
> +			PKR_AD_KEY(8)	| PKR_AD_KEY(9)		| \
> +			PKR_AD_KEY(10)	| PKR_AD_KEY(11)	| \
> +			PKR_AD_KEY(12)	| PKR_AD_KEY(13)	| \
> +			PKR_AD_KEY(14)	| PKR_AD_KEY(15))

Considering how this is going to get used, let's just make this
one-key-per-line:

#define PKS_INIT_VALUE (PKR_RW_KEY(PKS_KEY_DEFAULT)		| \
			PKR_AD_KEY(1)	| \
			PKR_AD_KEY(2)	| \
			PKR_AD_KEY(3)	| \
			...

