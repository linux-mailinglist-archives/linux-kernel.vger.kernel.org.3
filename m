Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4D4D87F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 16:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236711AbiCNPWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 11:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbiCNPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 11:22:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2EB13F66
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 08:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647271265; x=1678807265;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=U3CvAktVdU1usYTq7NAeaK3m9HJMxau0P6laS9k8Lps=;
  b=dKNjrhVL0AP5WqCM1phAFbKQOGCBqdMrhZup7XiTXr/Q7REZqw4EeseU
   zRylSYgWlRNUbn1neXaW3WOKDu8jvJFFpC1XQY17evKblf6YcsqxWZ+U6
   dLOB4WOC9pfdFqXg1cXVn4cGSCF+WXAu5+hiM8xZjSq35jIurXl7tE7LK
   8pPT4IrwdwYyuC6qBLmM5Mz2rhvVWBGkjR2KBnBuetHSPDNTD3mjHxtj+
   iu3NVVHfr2zWvzqSNgF6vRrY8hfqCvt0i8lzWUXONAgJo8AcLZpaN4vD7
   29+M4HfJcr6g4R8CQbXrwglotsqXQTXDXUyn/RUIZ3y4mtDGlKpb2rBPp
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="236003299"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="236003299"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 08:21:04 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515467811"
Received: from zborja-mobl1.amr.corp.intel.com (HELO [10.212.239.199]) ([10.212.239.199])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 08:21:04 -0700
Message-ID: <6b63d2ad-9b21-3fd6-37b4-31d7ad804c30@intel.com>
Date:   Mon, 14 Mar 2022 08:20:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Abhishek Goel <huntbag@linux.vnet.ibm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220310120749.23077-1-osalvador@suse.de>
 <87mthxb514.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <YisK2PEkKAqtZPfp@localhost.localdomain>
 <87czip73b4.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <Yi9bhXSADpNt6WEC@localhost.localdomain>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v2] mm: Only re-generate demotion targets when a numa node
 changes its N_CPU state
In-Reply-To: <Yi9bhXSADpNt6WEC@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/22 08:13, Oscar Salvador wrote:
> On Mon, Mar 14, 2022 at 09:03:59AM +0800, Huang, Ying wrote:
>> Oscar Salvador <osalvador@suse.de> writes:
>> On host machine, PMEM is always exposed via memory hotplug.  But later
>> on, we found that for guest system it's possible for PMEM to be exposed
>> as normal memory.
> Could you please elaborate on that? How is it done? I would love to hear the
> details.

Qemu, for instance, has a "mem-path" argument.  It's typically used for
using hugetlbfs as guest memory.  But, there's nothing stopping you from
pointing it to a DAX device or a file on a DAX filesystem that's backed
by pmem.


