Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87326585594
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiG2T2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiG2T2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:28:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6A561D84
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 12:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659122927; x=1690658927;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KPrt4ye94Mpif9m7Bl520c3ncRvYpxPg/WnxveBXG6M=;
  b=HqUXklZrkb1HouVcL4o4E4kv+IWyN3Je2/7+UBkAUmvULcG0LewZDguz
   HugjjQb0aA/SRUJ8vtVpaf6KuYyips0XEA7G7gGj2Gu+MVdIpVZ3Hf/Rv
   52584zjz1Gcb1yOA//4lGkTG//wHg5Joo2Vl8kqihnmMQIEwEjeh9wtHt
   sDbxo5wAdTk5YKZiMByxGmp4pyootJfweAdHb1+kLyNmotDuSdpLupymy
   7ozwDW7o+lB4onaMUhXpiquqOgKKEiMLg4c6e/pJvZ3WPrN2AaVYLaBi8
   cWVFmL90M1ZHnov8A2Rvzk9p1hgkoXejLC2IjWRm7j6AivKPGEWIebLfu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="288847183"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="288847183"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 12:28:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="669369843"
Received: from svdas-mobl.amr.corp.intel.com (HELO [10.209.20.175]) ([10.209.20.175])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 12:28:45 -0700
Message-ID: <70a5c939-16a6-d5e0-2e38-ac7adbed5fc1@intel.com>
Date:   Fri, 29 Jul 2022 12:28:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/2] x86/sev: Use per-CPU PSC structure in prep for
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
References: <20220614120231.48165-1-kirill.shutemov@linux.intel.com>
 <cover.1659103274.git.thomas.lendacky@amd.com>
 <658c455c40e8950cb046dd885dd19dc1c52d060a.1659103274.git.thomas.lendacky@amd.com>
 <d27e42a8-b2af-f922-4cea-b1ddaa2a0af0@intel.com>
 <9da5204f-5c8f-b47b-bcc6-d68ca63db08d@amd.com>
 <377f6c30-bdfc-55a4-bda7-f29c60c53300@intel.com>
 <efde397b-35fc-c47b-b21e-898fa2ec6920@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <efde397b-35fc-c47b-b21e-898fa2ec6920@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/22 12:22, Tom Lendacky wrote:
>> I think this tidbit from the changelog threw me off:
>>
>>> Protect the use of the per-CPU structure by disabling interrupts during
>>> memory acceptance.
>>
>> Could you please revise that to accurately capture the impact of this
>> change?
> 
> Is s/memory acceptance/page state changes/ enough of what you are
> looking for or something more?

That, plus a reminder of when "page state changes" are performed would
be nice.  How frequent are they?  Are they performance sensitive?
That'll help us decide if the design here is appropriate or not.
