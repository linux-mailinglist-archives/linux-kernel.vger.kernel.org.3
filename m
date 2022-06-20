Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AC2551FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242614AbiFTPEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiFTPEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:04:20 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE6B2659
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655735982; x=1687271982;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+0cVf/jOHrFvoq3mimyg8Cvm/6joXn5EE+jDGhKaQIg=;
  b=ZpcqZx/bvVFcluGs78jqC4TrDbCdI27XjWgf9TjTC9WRVd7kXUfGybye
   Yd1gNQ+wOpq+td9DwcEbNjPs8ThOQLC3+wP0ikKtcFyLUyLCYd/1mGov5
   BnRZVX7Rht0FRKUhfo6Bt7TaX2Fko/cx95y7z1PvpQv4VI1hDH2ZKg0Vw
   ZjO6gBZ4eND3DadhgZZvEJUQ59DuGOwwAAeWecoFGQTW2l1Dq9sgftOrR
   TSiD2BVdLHsiLVxa5HKXWaUuyBm/yB4vUNfXTUDI0JUOzdKtNaCSk3erf
   W8YIYkIunYiMmge3CPf+S4wZqEeRlejLavIJTqlCZ6naAJC9ClI994LtR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10384"; a="280966988"
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="280966988"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 07:37:38 -0700
X-IronPort-AV: E=Sophos;i="5.92,207,1650956400"; 
   d="scan'208";a="689490503"
Received: from jwtschan-mobl.amr.corp.intel.com (HELO [10.209.124.185]) ([10.209.124.185])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2022 07:37:37 -0700
Message-ID: <30de587c-4284-751b-c6cb-d665939daf3d@linux.intel.com>
Date:   Mon, 20 Jun 2022 07:37:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v7 0/5] Add TDX Guest Attestation support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220524040517.703581-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <d0931a48-ac87-c83e-1241-64819b87cf3c@linux.intel.com>
 <d90a10964ecee3269a26a48155733e10848ae471.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d90a10964ecee3269a26a48155733e10848ae471.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/20/22 5:46 AM, Kai Huang wrote:
> On Sun, 2022-06-19 at 17:36 -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi Dave/Boris/Thomas,
>>
>> On 5/23/22 9:05 PM, Kuppuswamy Sathyanarayanan wrote:
>>> Hi All,
>>
>> Gentle ping!
>>
>> Can you please let me know your comments on this patch set? This series
>> is so far reviewed by Kai, Wander, and Isaku. I have addressed all the
>> comments raised by them. So to progress further, your comments would be
>> appreciated.
>>
>>
> 
> To be precise I provided Acked-by to the first patch.  Sorry I was basically

Yes. I have added your Acked-by only for the first patch. I meant you and others
mentioned had reviewed this series before (which also includes your comment on
previous revisions), and your comments have been addressed.

> sick leave in the past two weeks so didn't fully review the rest.

Good to know you are back. Thanks for the review.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
