Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B3056A879
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiGGQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236413AbiGGQnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:43:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1121570F;
        Thu,  7 Jul 2022 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657212220; x=1688748220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qRe5FE3ajVPGJtkZND3oU10bPFiWLZfh5hGmh1fXKJI=;
  b=I9itfJ/okOajXyPRqJF5bMQ8INPPRfuQp0yuR422MI8ZG92F6qymq8XA
   d3kcvZzW7mWeqnN3MU6wkDBv11y6YCZljMwl/YzZr7gJ7FuwZHxYKEBZH
   WcN7AlSNZwcsHfJQnVBFGyLhkbTU3NcPRLTdqXHwWsSg1ha/05t0QunAw
   CbDJzttledQhv/rGV8AOmnRgGgLgvZ/ND/OKTz6ugrofO40nWhWQEkUMQ
   aNraNXzpdWuiQvM2Zn5BaWYtJk/DYP0myBvmx+xSddKN+pd4XN0S3mO4c
   FhYP9r3Nt+9oJxZjme5RpMYpWgCPGt9j/h2A4UE1/FiMBa8GhFSR3Ep8h
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="370385488"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="370385488"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 09:43:39 -0700
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="620864809"
Received: from nmajidi-mobl.amr.corp.intel.com (HELO [10.251.17.238]) ([10.251.17.238])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 09:43:38 -0700
Message-ID: <be65d342-0d4d-473c-2ba8-bc58b708bfac@intel.com>
Date:   Thu, 7 Jul 2022 09:43:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/4] mm: rmap: Extend tlbbatch APIs to fit new platforms
Content-Language: en-US
To:     Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, catalin.marinas@arm.com, will@kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, arnd@arndb.de, linux-kernel@vger.kernel.org,
        darren@os.amperecomputing.com, yangyicong@hisilicon.com,
        huzhanyuan@oppo.com, lipeifeng@oppo.com, zhangshiming@oppo.com,
        guojian@oppo.com, realmz6@gmail.com,
        Barry Song <v-songbaohua@oppo.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Nadav Amit <namit@vmware.com>,
        Mel Gorman <mgorman@suse.de>
References: <20220707125242.425242-1-21cnbao@gmail.com>
 <20220707125242.425242-4-21cnbao@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220707125242.425242-4-21cnbao@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/22 05:52, Barry Song wrote:
>  static inline void arch_tlbbatch_add_mm(struct arch_tlbflush_unmap_batch *batch,
> -					struct mm_struct *mm)
> +					struct mm_struct *mm,
> +					struct vm_area_struct *vma,
> +					unsigned long uaddr)
>  {

It's not a huge deal, but could we pass 'vma' _instead_ of 'mm'?  The
implementations could then just use vma->vm_mm instead of the passed-in mm.
