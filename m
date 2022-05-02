Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BCD5173BD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240809AbiEBQK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiEBQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:10:25 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4C61144
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651507616; x=1683043616;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7KvW+TU9RcNd/L37Pd/DZ8yozqIscYOfchJ7RfEHxHU=;
  b=niKyaDFH9b5iZERcdXcADWKI0Nis7V9N7ssWRJO1mGre7iH2XBVvJFUF
   hxfRc9WpfcZle+b2fj6CCK3mvNYCMtw96v+RO7PhPsW1KikaaMPaYttTF
   1i+NMhCsDrx34Oi83b3DtMxi49S1Qy0xv/o+/A/Dfq74rljjxGohzOIqN
   GUE+avhupDbuPKPfe0BjppWRznWJOimbyLim2uzYFaukiNudQBpsrjY6G
   2k7tiOqBZxSPNXX1gDKsUxVM/FtVy6tyRGwkywEqapig3hHqpBqL1q5I+
   j9VqaciOkUtw2RsbuiQSAW1ldA2V74NkfkzZIXjFhI4PtzOUB5KHBy01I
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="247799059"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="247799059"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:06:56 -0700
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="583769372"
Received: from wahmed-mobl.amr.corp.intel.com (HELO [10.209.71.202]) ([10.209.71.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:06:55 -0700
Message-ID: <c27a2132-8fbc-8c02-9c1b-b91336133d61@linux.intel.com>
Date:   Mon, 2 May 2022 09:06:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/3] x86/tdx: Add TDX Guest attestation interface
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
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Ym/MJlHrDoinrxnn@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Ym/MJlHrDoinrxnn@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/2/22 5:18 AM, Wander Lairson Costa wrote:
>> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
>> +				virt_to_phys(reportdata), 0, 0, NULL);
>> +	if (ret) {
>> +		pr_debug("TDREPORT TDCALL failed, status:%lx\n",
>> +				TDCALL_STATUS_CODE(ret));
> Should we use pr_err instead?

I expect user app will handle this error case and print debug info.
So we don't need to use pr_err.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
