Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C1B50704E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353361AbiDSO3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353323AbiDSO3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:29:23 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541F3377C8;
        Tue, 19 Apr 2022 07:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650378389; x=1681914389;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6ZehDyhn6H9IPo7sJc5toahw5KCrc55KbG4HpfjT9p4=;
  b=hH0foKhnbIfNruIimz5q1Det54aL8kQYecUgjg9jKSijulCPwyb5vtIx
   ebhNDhp+WkshRBz9PZK60AJLGE7xj2BDgxNUp35GMtLGMAaLi2L/4zChd
   gA0iJ6tHOYn/qeWg2UQJTEzzkbL7P/EEdvj8peICDzSeTjCj9wKwzbFVI
   O5YkFUjGQ7oc6j+YLv4wG2hip++2yUJLejW0QC4wP6Xum643kJF729EuF
   lkFgzWA2ccVC/vJvbVPy0phEb+C4yNlpSCkOgXMXBlMceUWr+Rd0sTj4s
   QX0ZYWJC1/Kkx5VgdGBizPzivVXOWBketkzAhjqsNGqW38lmxyjhR67ae
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261378586"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="261378586"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:26:12 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="554749722"
Received: from chferrer-mobl.amr.corp.intel.com (HELO [10.209.37.31]) ([10.209.37.31])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:26:11 -0700
Message-ID: <c76f77af-47cb-20a9-3187-8241284c6921@linux.intel.com>
Date:   Tue, 19 Apr 2022 07:26:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
 <975b5050-2108-9ace-cc71-46f17db0a731@intel.com>
 <4875ea9c-593a-e669-889a-1e809a50a570@linux.intel.com>
 <72205a7a-faf2-4322-02cd-303ee8252abb@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <72205a7a-faf2-4322-02cd-303ee8252abb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 7:24 AM, Dave Hansen wrote:
>> Current driver size is ~300 lines. It adds ~500 bytes to the kernel
>> binary if it is built-in.
> That doesn't sound like good use of a Kconfig option to me.  Just
> explain in the cover letter:
> 
> 	Any distribution enabling TDX is also expected to need
> 	attestation.  The compiled size is quite small (500 bytes).

Ok. I will add it.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
