Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0128589238
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238097AbiHCSYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiHCSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:24:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4FF1A81B
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659551070; x=1691087070;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7MIs88H3kyaIudtvk+y+X2Vp/M2JMQXQ5EcsqEQqpsM=;
  b=lFkSXGl2VynccmG8cfTEK4WLFCflGcLaPxBDqJIC12s45FZwfEKpaFcT
   13w8ke/3L8DMoEYPgfSJ1+29gIGd02Anldtz9ydf6h6fWLtX6pW+AKBTS
   zN4Yl98n2osnDq66fNkGAom/gKsAcjyDt5rhk4qBg1iUI3NCfAO+7QWMK
   2MZxbU3hizz/nj52Ang4jCLZSt496mC0G0sDwZSE8IBXgOC+OkPvl4ccS
   y1bgAFLq7Haiu/r0/GxF5/ycZHvii7pgtwJBwoKBP3cp2Lzoe1HOYEng8
   MyvZa43fhZWx2lOv4ecM37TTTVq0VB9M6EZH7MMDFw8wxGqhK4gg82+I9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="289757185"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="289757185"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 11:24:30 -0700
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="631255924"
Received: from buichris-mobl.amr.corp.intel.com (HELO [10.209.124.150]) ([10.209.124.150])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 11:24:29 -0700
Message-ID: <e52341be-076e-92d1-a649-421dac5a4f5d@intel.com>
Date:   Wed, 3 Aug 2022 11:24:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1.1 1/2] x86/sev: Use per-CPU PSC structure in prep for
 unaccepted memory support
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <1b50311c-448b-96aa-1d96-f4bfed409c1f@amd.com>
 <cover.1659550264.git.thomas.lendacky@amd.com>
 <2a2adc3570ae9c24d03fff877c4fe79ed43605e0.1659550264.git.thomas.lendacky@amd.com>
 <d5902382-70f4-be07-99f6-80d17cdfdcaa@intel.com>
 <9f47ed0f-99cc-a237-f09b-45291feffcd3@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <9f47ed0f-99cc-a237-f09b-45291feffcd3@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/22 11:21, Tom Lendacky wrote:
>> Would it be simpler to just do a spin_trylock_irqsave()?  You fall back
>> to early_set_pages_state() whenever you can't acquire the lock.
> 
> I was looking at that and can definitely go that route if this approach
> is preferred.

I prefer it for sure.

This whole iteration does look good to me versus the per-cpu version, so
I say go ahead with doing this for v2 once you wait a bit for any more
feedback.
