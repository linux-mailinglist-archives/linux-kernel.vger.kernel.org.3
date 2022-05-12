Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B315253E1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357172AbiELRk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357164AbiELRkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:40:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A0E26C4CF
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652377222; x=1683913222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bQdeZOucoJbqYuT7kPG2s5fmlDJK3T7fnukLOSrfHWs=;
  b=l+2Nu3XTnj25DcabQ6wexItQv6p6KWdqE22Njp8zrsqpbodpcj7JpKMP
   YiPkGEmHmx5Gd/WaVgeRCxFWJAq/6w98kmW9YDSWd1hEbVkf86Z9rHC0R
   iZHNxfB5iqlZ8VqdstxESKZ7og45ldGnS8lgJyB57LW+5VJDdF1qx8S8O
   b7J/nUFbcA49LUV/A3uPipnw1phHwrFVDOXamJrKg3P3O2fvU32qy/hgh
   AwsIj5dSbY21nFPKVEwBeKIJJ/bOpNuvV0emjKm5C4aRqZ2ZZrxZSp92s
   QnGsbqDTjfl00dwHmP2N1FNsweJgm44j2B6Lo8Vuz30ke9T1ao0R7EtLX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270217399"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="270217399"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:22:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="572617956"
Received: from wdwickar-mobl1.amr.corp.intel.com (HELO [10.252.130.245]) ([10.252.130.245])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 10:22:48 -0700
Message-ID: <20bada85-9203-57f4-2502-57a6fd11f3ea@intel.com>
Date:   Thu, 12 May 2022 10:22:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [RFCv2 00/10] Linear Address Masking enabling
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
 <20220511064943.GR76023@worktop.programming.kicks-ass.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220511064943.GR76023@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/22 23:49, Peter Zijlstra wrote:
>> The feature competes for bits with 5-level paging: LAM_U48 makes it
>> impossible to map anything about 47-bits. The patchset made these
>> capability mutually exclusive: whatever used first wins. LAM_U57 can be
>> combined with mappings above 47-bits.
> So aren't we creating a problem with LAM_U48 where programs relying on
> it are of limited sustainability?

I think allowing apps to say, "It's LAM_U48 or bust!" is a mistake.
It's OK for a debugging build that runs on one kind of hardware.  But,
if we want LAM-using binaries to be portable, we have to do something
different.

One of the stated reasons for adding LAM hardware is that folks want to
use sanitizers outside of debugging environments.  To me, that means
that LAM is something that the same binary might run with or without.

It's totally fine with me if the kernel only initially supports LAM_U57.
 But, I'd ideally like to make sure that the ABI can support LAM_U57,
LAM_U48, AMD's UAI (in whatever form it settles), or other masks.
