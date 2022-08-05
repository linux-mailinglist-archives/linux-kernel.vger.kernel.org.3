Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8365F58B130
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbiHEVfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiHEVfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:35:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DAE1BEB1
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 14:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659735337; x=1691271337;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NI2IRvyfOoWq4JSbf+Tm9Tq9Lq/erdU7EpivOdyuVNA=;
  b=W8MCIZH59tmrhS/IV7irU1Jzpuk1oqQTXbKDY8u21WFEDkW6k69cPUCL
   OdHhSwNegyibbs8tTKbb8vGXnwTBEcP3dWEl2He30nx5MU7Smrl1EhPy0
   +ExZGGIDG1DE6+YpKNFld/U3UK+wI2jGKbMPyp8mynOHCy4KSQ0FtVr4Y
   qJ7m4aj1Oi0vc/9f1WVcM2ijpf8eBecU0qneRdXWjCcrNsnIvZxET1tlB
   zNI3lcGaY9y3cExgWyeMZ/91VIvj3HrE3s3jtRoncWGDj7g4jWCVfGBie
   +TbwE7ggd9VJOByXUBNi4cuS2NqbaaEEezRb3aG/dehkzaffmBXD8zsNI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="277220814"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="277220814"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 14:35:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="931369220"
Received: from shihhanw-mobl1.amr.corp.intel.com (HELO [10.212.148.224]) ([10.212.148.224])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 14:35:35 -0700
Message-ID: <3075adc7-e02e-fcd4-44ef-c4228293f460@linux.intel.com>
Date:   Fri, 5 Aug 2022 14:35:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v10 1/2] x86/tdx: Add TDX Guest attestation interface
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
References: <20220804003323.1441376-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yu1z0KcU5C2AJO6S@fedora>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Yu1z0KcU5C2AJO6S@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/22 12:47 PM, Wander Lairson Costa wrote:
> On Wed, Aug 03, 2022 at 05:33:22PM -0700, Kuppuswamy Sathyanarayanan wrote:
>> +/**
>> + * struct tdx_report_req: Get TDREPORT using REPORTDATA as input.
>> + *
>> + * @subtype        : Subtype of TDREPORT (fixed as 0 by TDX Module
>> + *                   specification, but added a parameter to handle
>> + *                   future extension).
>> + * @reportdata     : User-defined REPORTDATA to be included into
>> + *                   TDREPORT. Typically it can be some nonce
>> + *                   provided by attestation service, so the
>> + *                   generated TDREPORT can be uniquely verified.
>> + * @rpd_len        : Length of the REPORTDATA (fixed as 64 bytes by
>> + *                   the TDX Module specification, but parameter is
>> + *                   added to handle future extension).
>> + * @tdreport       : TDREPORT output from TDCALL[TDG.MR.REPORT].
>> + * @tdr_len        : Length of the TDREPORT (fixed as 1024 bytes by
>> + *                   the TDX Module specification, but a parameter
>> + *                   is added to accommodate future extension).
>> + *
>> + * Used in TDX_CMD_GET_REPORT IOCTL request.
>> + */
>> +struct tdx_report_req {
>> +	__u8  subtype;
>> +	__u64 reportdata;
>> +	__u32 rpd_len;
>> +	__u64 tdreport;
>> +	__u32 tdr_len;
>> +};
> 
> Any reason why reportdata and tdreport aren't "void *"?

It is the recommended way to pass the pointers.

https://docs.kernel.org/driver-api/ioctl.html

> 
>> +
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
