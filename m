Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE0052929F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347945AbiEPVNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349419AbiEPVM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:12:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4342F102E
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652735186; x=1684271186;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ygp3oXCRuQhQlvfoUeEq342dl+zO8N9KolCKY7QcuiY=;
  b=hfhtGe5OTDCgWjKQ2qMGIK5nA+9IRnjt5r1t/xZuJTZWH0Z21X3PHrq5
   wgUFI1sV5QcDmrwxO+EupXkLyeGyFlCUFn1kTAFy8ypBGP2jhJbfhwmn4
   2XB5YTMZRXSATPCFb70YKZ9nig8LVjhqhAiAPxwtwtrlV7CNcDLtqzXXg
   f09NP1vYpdKzSQd2EghQe/r17Ex6bavDbiRHAEuTyBhTHi9P6NE7epHfp
   SHUCLqwiI3jHXYFLncwpSe0HntRxvVUn+psFNud4cqGRjlJN9ZFFs88Sg
   mG7kK++PJVsD2UwTi3Cr9XzIjqiyLhNCtOAQX68jM9HvSI4VeTxfQx/W2
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="251479352"
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="251479352"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 14:06:25 -0700
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="596722329"
Received: from skechkar-mobl.ger.corp.intel.com (HELO [10.255.228.165]) ([10.255.228.165])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2022 14:06:25 -0700
Message-ID: <546a73c4-9ffa-0d37-a5af-ea7902dc1931@linux.intel.com>
Date:   Mon, 16 May 2022 14:06:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH v6 1/5] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220512221952.3647598-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220512221952.3647598-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YoKTDAeQPs5nQkg3@ovpn-116-50.gru2.redhat.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YoKTDAeQPs5nQkg3@ovpn-116-50.gru2.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/16/22 11:08 AM, Wander Lairson Costa wrote:
>> +
>> +static int __init tdx_attestation_init(void)
>> +{
>> +	long ret;
> nit: the type of ret should be int

Agree. I will fix it in next version.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
