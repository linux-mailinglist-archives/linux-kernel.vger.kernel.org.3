Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E58758A10D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238773AbiHDTEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbiHDTEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:04:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D5B6D56D
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659639860; x=1691175860;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zeb314LA7OHiqwgRSF20NPO4aqmgQgIU8MCpZ86Aap4=;
  b=ebEnk0CnjVLeS6AvNn6u0YCpN4GtqebTv6I1ocZSlrnc2g+jLOVs0x9Y
   M7V1YPSCySseIaHkLpDWvEbdCHiJMDYfQ1kBtfqyP1oeKyLN5XeBhs193
   OXDSDW61wiSqTR+jI87bKJ7V+ucayXftMDOjhAxgF8E/ZgGMyh6YgIjyI
   x3tFqcqoWB2mf0XXaC+//7LPwDpDC8gectBVK4nxAWWvvksONPGNliceR
   JXMLMjZs0B/PHc9cKwn8jBwfzL7ewQyzGlGaxBvO+0TDCywS1OTYLIzOR
   Z+pHHe7XJW1pE8ZZ431OYHcT3qKDSKC7Pdb/QNcUDa29/39h6J+w+rLDT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="270404358"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="270404358"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 12:03:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="631709547"
Received: from lnavery-mobl1.amr.corp.intel.com (HELO [10.255.228.146]) ([10.255.228.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 12:03:56 -0700
Message-ID: <6c516a7c-ac97-e0b1-b056-06a17d1b7420@intel.com>
Date:   Thu, 4 Aug 2022 12:03:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/acrn: Improve ACRN hypercalls
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220804180358.32944-1-ubizjak@gmail.com>
 <91ccae0b-6135-6163-f59b-4e99624090a5@intel.com>
 <CAFULd4YRzEXL1+cvBPT1hmfq=ZLwtrexHt+vDABnA2QMiVMBpg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAFULd4YRzEXL1+cvBPT1hmfq=ZLwtrexHt+vDABnA2QMiVMBpg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 11:56, Uros Bizjak wrote:
> The %r8 is not preserved across function calls, so your statement
> above is correct. But as long as there is no function call *between*
> the variable definition and the assembly, the approach with the local
> register variable works without any problems. It is even something GCC
> itself has used in its library for years.

I'm glad it's workout out for GCC.  But, the kernel is not GCC.  I
specifically asked for the ACRN code to be the way that it is today and
your argument is not making me reconsider it in the slightest.

So, thanks for the patch, but I don't think we should apply it.
