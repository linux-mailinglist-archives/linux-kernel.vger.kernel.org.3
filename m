Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB48B4D4CDE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241693AbiCJPYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 10:24:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244699AbiCJPYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 10:24:03 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA5CC086F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 07:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646925781; x=1678461781;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=X65sOg9tpfwezm9F7oPR3l1yoJm0wZybxcJ2SYM0o5E=;
  b=UQpT2f3VQlQaRHImne6qFArLOl16RZ7WyfvZ7IqoHXncfmnrTdG1eCCk
   Fu6vRaM1AAz06/Mx+Wg2NxJ7OHQncLfIa0MsCXYjrrUueZlqFxFmWnLTo
   PP38jGvCqmlEqQCUISXjbzLuMVCeVNj94vNa9dU7V5v1fJof41GDWGvk0
   Vf544FF5rJsWjGX4tnP//fzJrax0K721lm/dlDiB8taiNw6mCjRlunq5O
   ysqzLDt7M0MBauxPKLpLvI6hznMXia9hw1obKYb9cItCO1MTabyYPhrxE
   wUFKpEjRI+V9uzUq5VxRrmCPJ4MvhyyQV7diyJQpbpflVjZGbJ3vSW0oF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="318499356"
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="318499356"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 07:22:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,171,1643702400"; 
   d="scan'208";a="688688356"
Received: from efrantz-mobl1.amr.corp.intel.com (HELO [10.212.252.101]) ([10.212.252.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 07:22:39 -0800
Message-ID: <2b26fc5b-d709-f2e1-0c8f-a6a548008216@intel.com>
Date:   Thu, 10 Mar 2022 07:22:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Bharata B Rao <bharata@amd.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org,
        kirill.shutemov@linux.intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        catalin.marinas@arm.com, will@kernel.org, shuah@kernel.org,
        oleg@redhat.com, ananth.narayan@amd.com
References: <20220310111545.10852-1-bharata@amd.com>
 <81b6f618-05bc-f7d0-5461-4c3f0ca42d3f@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [RFC PATCH v0 0/6] x86/AMD: Userspace address tagging
In-Reply-To: <81b6f618-05bc-f7d0-5461-4c3f0ca42d3f@intel.com>
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

On 3/10/22 07:16, Dave Hansen wrote:
> I'd also highly suggest going over Kirill's patch set in detail.  There
> are things like this:
> 
>> https://lore.kernel.org/linux-mm/20210205151631.43511-10-kirill.shutemov@linux.intel.com/
> which seem pretty sane to me but which are (I think) missing in this set.

Oh silly me, that's just for LAM_U48 which ignores more bits than
LAM_U57 or UAI.

Either way, I know you've looked at Kirill's set, but please do go over
it in detail to make sure there's nothing else you need to lift out of
there.
