Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1E4F4E39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588231AbiDFAO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572956AbiDER1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:27:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377A318378;
        Tue,  5 Apr 2022 10:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649179515; x=1680715515;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=tby6oKK3JVUxlZzYdf5ed1y/wZs9gYYk5yFKCDN1HZg=;
  b=Gt5QqY71asenE8KEihaKWCkItV1rvRRg1/1D95jskDMRPSd693UBpuA2
   6EeVKnqBeJruLKYP3T0+fn4F7HZOdfL0XNI1n2xN0Y/9z9peNXK4vYF+A
   ccIkAG0aaxyuk2JapMDhbBZ4oh+iuVsasutj3B96F9MSegOj+VvQ7k17K
   8JDY2ktQx2WQ1+AakrBZuEi+2epWqfsBK8pAZcy5TjyDV65Oln+yXYg++
   elUpY00wjPsmDQMAOgw8p/y68Jr4AgJAmp/2ZDjLpar2Kpq0UsFdKiCpz
   O/51nVpcOynjECVITQILcrLRC6/R2c+dhz74LE+rlGfcxlVZGp/S0hkKZ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="260805737"
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="260805737"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:25:14 -0700
X-IronPort-AV: E=Sophos;i="5.90,236,1643702400"; 
   d="scan'208";a="549147373"
Received: from nldesimo-desk1.amr.corp.intel.com (HELO [10.212.148.3]) ([10.212.148.3])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 10:25:13 -0700
Message-ID: <f8d92685-27dd-e7ef-ce0d-100a285aec4b@intel.com>
Date:   Tue, 5 Apr 2022 10:25:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, mingo@redhat.com, linux-sgx@vger.kernel.org,
        x86@kernel.org, seanjc@google.com, kai.huang@intel.com,
        cathy.zhang@intel.com, cedric.xing@intel.com,
        haitao.huang@intel.com, mark.shanahan@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
References: <cover.1648847675.git.reinette.chatre@intel.com>
 <b3a17e1ce7bcd14db3c28903e8a97f094998ae74.1648847675.git.reinette.chatre@intel.com>
 <Ykvrk4hYvBEnNOOl@kernel.org>
 <e118f4c6-7216-15f3-2bda-3a5851b0bcb1@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH V3 19/30] x86/sgx: Free up EPC pages directly to support
 large page ranges
In-Reply-To: <e118f4c6-7216-15f3-2bda-3a5851b0bcb1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/22 10:13, Reinette Chatre wrote:
>>> +void sgx_direct_reclaim(void)
>>> +{
>>> +	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
>>> +		sgx_reclaim_pages();
>>> +}
>> Please, instead open code this to both locations - not enough redundancy
>> to be worth of new function. Causes only unnecessary cross-referencing
>> when maintaining. Otherwise, I agree with the idea.
>>
> hmmm, that means the heart of the reclaimer (sgx_reclaim_pages()) would be
> made available for direct use from everywhere in the driver. I will look into this.

I like the change.  It's not about reducing code redundancy, it's about
*describing* what the code does.  Each location could have:

	/* Enter direct SGX reclaim: */
	if (sgx_should_reclaim(SGX_NR_LOW_PAGES))
		sgx_reclaim_pages();

Or, it could just be:

	sgx_direct_reclaim();

Which also provides a logical choke point to add comments, like:

/*
 * sgx_direct_reclaim() should be called in locations where SGX
 * memory resources might be low and might be needed in order
 * to make forward progress.
 */
void sgx_direct_reclaim(void)
{
	...
