Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21C3513B2E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350719AbiD1SIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240271AbiD1SIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:08:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D92EA94E8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651169092; x=1682705092;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5d2BQCSncgZPjLPNMBnWwYJMHtGtOAvWl//iQAH/zkc=;
  b=LNHDKIjdMxwLy9cHv9HguUVgQAZhRBEaMnyVcxQl0o66uMUxxRRCBG7H
   gceNGZ326O1KiaBFGPL7dT1YYXq/d/I8qBEgDIGax90mC58eBOlClG4+P
   RRTT3UcShXNJzNQJHK6GgfFK7DjmjWaOZ4zcO4psxiY/parEXtX6Sxm4y
   U0cD0NaW5Bd2RlKl6hejlszgfv/AqvOV8V0xQU4tT/ozf13Hf0eHKncBV
   oq+ZJMmbqGcuiEUrEn8PfoeYYS34XDCI32xh9oWTLwo+Kpan/tcfrYd9n
   ec2D7xG8yBQzotmUcvdcv0I6YvGplfgjr+vb0nH5nnjHl10PK8wi1+pMK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="352804734"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="352804734"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:04:45 -0700
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="559803305"
Received: from mpoursae-mobl2.amr.corp.intel.com (HELO [10.212.0.84]) ([10.212.0.84])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:04:43 -0700
Message-ID: <9a484750-cf67-289c-78d1-2e1b764441e8@intel.com>
Date:   Thu, 28 Apr 2022 11:04:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
References: <20220422233418.1203092-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220422233418.1203092-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <YmrSqEBHXZvWs4a0@fedora>
 <c771664d-893b-a41e-079f-74673517b3bb@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <c771664d-893b-a41e-079f-74673517b3bb@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/22 10:56, Sathyanarayanan Kuppuswamy wrote:
> On 4/28/22 10:45 AM, Wander Lairson Costa wrote:
>> On Fri, Apr 22, 2022 at 04:34:16PM -0700, Kuppuswamy Sathyanarayanan
>> wrote:
>>> +static long tdx_get_tdreport(void __user *argp)
>>> +{
>>> +    void *report_buf = NULL, *tdreport_buf = NULL;
>>> +    long ret = 0, err;
>>> +
>>> +    /* Allocate space for report data */
>>> +    report_buf = kmalloc(TDX_REPORT_DATA_LEN, GFP_KERNEL);
>>> +    if (!report_buf)
>>> +        return -ENOMEM;
>>> +
>>> +    /*
>>> +     * Allocate space for TDREPORT buffer (1024-byte aligned).
>>> +     * Full page alignment is more than enough.
>>> +     */
>>> +    tdreport_buf = (void *)get_zeroed_page(GFP_KERNEL);
>>
>> Maybe we should add BUILD_BUG_ON(TDX_TDREPORT_LEN > PAGE_SIZE)
> 
> Currently, it is a constant value < PAGE_SIZE. But I can add the
> BUILD_BUG_ON check for it.

That's kinda silly.  If it might ever be bigger than a page, you just do:

	tdreport_buf = alloc_pages();

But, seriously, TDX_TDREPORT_LEN is part of the ABI and can't change.
kmalloc() would work too since TDX_TDREPORT_LEN is a power of 2.

