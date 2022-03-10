Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52F94D4FB4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiCJQtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:49:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbiCJQtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:49:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FA9E0AD7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646930901; x=1678466901;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=X3+zmRgSG8D741YzWGvezJvJbaSBg+0aX7D4WHq+ZgE=;
  b=F2Il/JXXsnLNgcbHexxhUTEq0BxumhuP0UMkY9JYBfCF1kjVDncNs5rY
   HoShbf1lXoba4gLD9FcbUCSsk2gkaTCaz5jk33yITkwFpuq2EGJy/CGPe
   YS3prOxLzohlMcd6r8Gmd9sDW7jWbvuet3GY3Iu1F3Z9Dt9N7vAwLijSp
   FM4V09BJSROFz8dKLGzXJsKWzAAeHHjfb0rYG0Qrk9EeAY16po83RtrcL
   UjerW6WecCaxoAsRumlvDQdFz3A1SBSW+QGhbz4rdheFYMMmcVSr8qe+V
   8FTNwV5vH4rb8DMj94GeT8CmlNPqrmJVsonmCRnIkqAj1pPaluqTtlAI3
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="341730528"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="341730528"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 08:45:52 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="688715724"
Received: from efrantz-mobl1.amr.corp.intel.com (HELO [10.212.252.101]) ([10.212.252.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 08:45:51 -0800
Message-ID: <286efdb9-7dbf-82f3-b172-29c575a3791b@intel.com>
Date:   Thu, 10 Mar 2022 08:45:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Bharata B Rao' <bharata@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "ananth.narayan@amd.com" <ananth.narayan@amd.com>
References: <20220310111545.10852-1-bharata@amd.com>
 <699fb763ac054833bc8c29c9814c63b2@AcuMS.aculab.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
In-Reply-To: <699fb763ac054833bc8c29c9814c63b2@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 06:32, David Laight wrote:
>> UAI allows software to store a tag in the upper 7 bits of a logical
>> address [63:57]. When enabled, the processor will suppress the
>> traditional canonical address checks on the addresses. More information
>> about UAI can be found in section 5.10 of 'AMD64 Architecture
>> Programmer's Manual, Vol 2: System Programming' which is available from
>>
>> https://bugzilla.kernel.org/attachment.cgi?id=300549
> Is that really allowing bit 63 to be used?
> That is normally the user-kernel bit.
> I can't help feeling that will just badly break things.

Yeah, this does seem worrisome.  The LAM approach[1] retains
canonicality checking for bit 63.


1.
https://www.intel.com/content/www/us/en/develop/download/intel-architecture-instruction-set-extensions-programming-reference.html

