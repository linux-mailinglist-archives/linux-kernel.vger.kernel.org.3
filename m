Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C7508972
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378578AbiDTNlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiDTNlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:41:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01DD43388
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650461945; x=1681997945;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=5rhMhH6TF5DbIecBIgZYcaxM4JlyAMgHd4dTkECw8NI=;
  b=XMJ0v7b4GiqZ19dwziwTmwnd4cr4wtB+G0aUWmv16QTRRqRSlH7gAAN9
   krceCJg3i7fAhBbYylEJSxVcIbZYfcGzsVrZA+vE6BOiZ+44nDaSS/RHR
   ohqI9sFveoQHF18Gybs9vWGJT+nqgmgUBrF7OXt14UAiwH7PvLx0z/emE
   eOANIUGQMK41l0SaVvUgjFTFe1rBoymNDdufr7JghUWNl4FRW4F86VcJT
   eRFQMxEG2RXns0u8YyKFJb76VwqtK+eMdGGD5ziJmuDBFSZgRp7PoMo8x
   mDLLmJeKcgRHp5s2KKq9Tcl8iz+ulQbnASymLItkKncwQWLwc+zxnyy7f
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="251333061"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="251333061"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 06:39:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="562109991"
Received: from mileskin-mobl.amr.corp.intel.com (HELO [10.213.184.8]) ([10.213.184.8])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 06:39:03 -0700
Message-ID: <3720f7d9-a4f3-214c-1dea-f8ffc837c1da@intel.com>
Date:   Wed, 20 Apr 2022 06:39:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:HWPOISON MEMORY FAILURE HANDLING" <linux-mm@kvack.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
References: <20220420210009.65666-1-qiuxu.zhuo@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH 1/1] x86/mm: Forbid the zero page once it has
 uncorrectable errors
In-Reply-To: <20220420210009.65666-1-qiuxu.zhuo@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 14:00, Qiuxu Zhuo wrote:
> Accessing to the zero page with uncorrectable errors causes unexpected
> machine checks. So forbid the zero page from being used by user-space
> processes once it has uncorrectable errors. Processes that have already
> mapped the zero page with uncorrectable errors will get killed once they
> access to it. New processes will not use the zero page.

There are lots of pages which are entirely fatal if they have
uncorrectable errors.  On my laptop, if there were an error, there is a
0.00000596% chance it will be in the zero page.

Why is this worth special casing this one page?
