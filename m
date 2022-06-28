Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5838855E7B4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348245AbiF1PxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346284AbiF1PxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:53:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF5A333;
        Tue, 28 Jun 2022 08:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656431584; x=1687967584;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YNRS2j3hTEQ2v8S8S/DXdGWTlv0yIqKFJkVZbqJR1WM=;
  b=YJxdjUpnNaJtW+MD/SEZFLnY1WM7J5BZByZepePktGse5IyjsOvycT51
   tEtkjqGIBuFQprHyvGsWnX0D2joN0Vuewy+jEup7hfMwdgiglSIeZZmFt
   GfkBdUG+P+XtMMOmxoRre205wmGBNV1CX0Nt7+IMc8Y/TtzNvaoO3NM04
   0eURjoG6Upz8aM3CNHDjye8lgHjFoJCGtoow++LBnwkwWdPNOhmydlWVe
   cilRZ0jPToyg5SpsF+Uvyhora0PRHwD129mW64n/3yTkvy9GaMBPw8QX2
   Gb1TJrC/EpKgQsGtdz/zqikwsbOd4WIs/dvFcMgEWThAukWxq83LJbIO7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="281814469"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="281814469"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 08:53:04 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="587912493"
Received: from staibmic-mobl1.amr.corp.intel.com (HELO [10.209.67.166]) ([10.209.67.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 08:53:03 -0700
Message-ID: <2eff7546-5ab5-d4cd-43f6-d66b6490d725@intel.com>
Date:   Tue, 28 Jun 2022 08:52:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC v2] memmap: introduce cmdline parameter "memmap=nn[KMG]$"
 without start addr
Content-Language: en-US
To:     lizhe.67@bytedance.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com
Cc:     lizefan.x@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220628124529.15431-1-lizhe.67@bytedance.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220628124529.15431-1-lizhe.67@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 05:45, lizhe.67@bytedance.com wrote:
> From: Li Zhe <lizhe.67@bytedance.com>
> 
> In current kernel we can use memmap=nn[KMG]$ss[KMG] to reserve an
> area of memory for userspace usage through /dev/mem. We have to
> determine the start addr and length. In our scenario, we need
> reserve or alloc large continuous physical memory at least 256M in
> 512G's machine, and need reserve more memory in larger machine, at
> just boot phase for a userspace program. And these memories will not
> be freed to system before system reboot. The userspace program can
> use the memory through /dev/mem to store some data. Besides, a
> hardware will need the data stored by the userspace program to do
> it's job. Why we need continuous memory is that the hardware can
> only access memory without mmu.

That's still a rather anemic description.

I don't think we want this code in the kernel with that description, sorry.

If you'd like to come back with an actual description, naming the exact
hardware that you have *AND* explaining sane reasons for why the
hardware doesn't have a normal kernel driver (or interface) like every
other piece of hardware, then we can talk.  But, otherwise, this isn't
something that can go upstream.
