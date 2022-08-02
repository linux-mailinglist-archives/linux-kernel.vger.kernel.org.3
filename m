Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C44587596
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 04:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235748AbiHBClX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 22:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234368AbiHBClV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 22:41:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78429EE1E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 19:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659408080; x=1690944080;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tQKEOfP6dnvEAM+lcqvNksL5QRSQPohIcCdBcd2dybo=;
  b=ZGqqERLYhpH1kdXoknoeYjg7bwiunPXaWvat/JPF1qZeTEcXxMmGWnzS
   tYSjhjdGvT4nIXsyZcWfyXhAKRHAMswYRGFrpWjjk4CL8n4x+raPGztOm
   9e9urdI6PC2hW30ESw/PuinXHjMGnfQzN7reCD7wPvSVXNkDqgycfdqlU
   G6Vy8rukYf/M7XDSV30H1p7tipgON7Ge9m81rjq/iA0QMDA6GhJdjDEC+
   ZWUyUWwUnftb7WdkLIDxG7zDfa6pKyEgDc5ua4KPsDjzSgT/MKNoszoCj
   k7X0QYZKHkCRLPC56nUeQFoE2Wcv/eUx//jW9mwYbJUBswByE0yhyqwii
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="288061039"
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="288061039"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 19:41:20 -0700
X-IronPort-AV: E=Sophos;i="5.93,209,1654585200"; 
   d="scan'208";a="661430886"
Received: from jspotts-mobl1.amr.corp.intel.com (HELO [10.209.92.196]) ([10.209.92.196])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 19:41:19 -0700
Message-ID: <e8342722-20f8-a566-59c5-8e8f7f271d98@intel.com>
Date:   Mon, 1 Aug 2022 19:41:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 0/8] x86_64: Harden compressed kernel, part 1
Content-Language: en-US
To:     Evgeniy Baskov <baskov@ispras.ru>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
References: <cover.1659369873.git.baskov@ispras.ru>
 <e6e7fef1-0dff-ef72-8a17-8ecec89994ca@intel.com>
 <893da11995f93a7ea8f7485d17bf356a@ispras.ru>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <893da11995f93a7ea8f7485d17bf356a@ispras.ru>
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

On 8/1/22 17:25, Evgeniy Baskov wrote:
> On 2022-08-01 19:48, Dave Hansen wrote:
>> On 8/1/22 09:38, Evgeniy Baskov wrote:
>>> This is the first half of changes aimed to increase security of early
>>> boot code of compressed kernel for x86_64 by enforcing memory protection
>>> on page table level.
>>
>> Could you share a little more background here?  Hardening is good, but
>> you _can_ have too much of a good thing.
>>
>> Is this part of the boot cycle becoming a target for attackers in
>> trusted boot environments?  Do emerging confidential computing
>> technologies like SEV and TDX cause increased reliance on compressed
>> kernel security?
>>
>> In other words, why is *THIS* important versus all the other patches
>> floating around out there?
> 
> Now compressed kernel code becomes larger, partially because of adding
> SEV and TDX, so it worth adding memory protection here.
...

Is it fair to say that the problems here are on the potential,
theoretical side rather than driven by practical, known issues that our
users face?

