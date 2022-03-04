Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 018A74CD841
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240511AbiCDPsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCDPsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:48:33 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1454C793
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 07:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646408865; x=1677944865;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+DAHh/nBkswlckD+VfCIc7Of9xtKftEyvJuWfkqhNQQ=;
  b=CEuGFyIITIcCOdXaZlN3m5a2jXL87aUQ2taWgi9NRay+FovlEa9EQ3nm
   yamUdC4WAEKRfgRi0m1czcL4/LQG/5R1l7EKKDOxWCJ/foU35iFm61ZD1
   P2EYD1opsyqyidPKI4T/c1ZX9fpqbYFUggzScpDLfmYEQhioQjbg5CfnR
   TxSmHcZxK0oc+y6CEWu0OEemXidzdAuK5zqxNxjuu+VMHfNNZ3ocRD27i
   Hg+NNPs6eav2cVyIkRTIluL4pdKAmuCAqeeMONI7IP8PGvnpPhD48wQUk
   QqR+i+Fl+fqMgDZJw4sDNoFI+9DD5SNwMqXEOwizN+KhA3K5QON1EWF5E
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="278691157"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="278691157"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 07:47:45 -0800
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; 
   d="scan'208";a="640616363"
Received: from eabada-mobl2.amr.corp.intel.com (HELO [10.209.6.252]) ([10.209.6.252])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2022 07:47:44 -0800
Message-ID: <4de457b3-eec9-5415-7e7f-0d5abd4ca08b@intel.com>
Date:   Fri, 4 Mar 2022 07:47:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv5 01/30] x86/tdx: Detect running as a TDX guest in early
 boot
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20220302142806.51844-1-kirill.shutemov@linux.intel.com>
 <20220302142806.51844-2-kirill.shutemov@linux.intel.com>
 <YiIzgg3Ql81He0X9@nazgul.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <YiIzgg3Ql81He0X9@nazgul.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/22 07:43, Borislav Petkov wrote:
> On Wed, Mar 02, 2022 at 05:27:37PM +0300, Kirill A. Shutemov wrote:
>> +void __init tdx_early_init(void)
>> +{
>> +	u32 eax, sig[3];
>> +
>> +	cpuid_count(TDX_CPUID_LEAF_ID, 0, &eax, &sig[0], &sig[2],  &sig[1]);
>> +
>> +	BUILD_BUG_ON(sizeof(sig) != sizeof(TDX_IDENT) - 1);
> That's new.
> 
> Is that pure paranoia or what are you protecting here against?

Pure reviewer paranoia. :)

  https://lore.kernel.org/all/YhN5edJQ+LkVc0us@grain/

