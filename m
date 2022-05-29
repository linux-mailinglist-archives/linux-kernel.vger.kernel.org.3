Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640D1536EFF
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 03:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbiE2BKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 21:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiE2BKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 21:10:51 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE645B8AF;
        Sat, 28 May 2022 18:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653786650; x=1685322650;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M1FBflrhPBegpxmSR33l7oZ4bUcLf85OUp0h8DXBHfQ=;
  b=CB3IxajRPHJ/SCJ/z8JVrIq7Sm73FnQan7K+vnb/t41/VlOmo4zdMQr5
   D9P1eUpMelnHpuEF4sFssVvmeIHzRHTS5wZN43FDVmRtgt2fPgwDc+NYe
   ZhLWpuSKh4s/PI01aEckpm5VsLAl+NKg/WF9m6c9Q9yvIXAeKJH/OAnRZ
   eL0l+0ahqc/uDyA6O/+eW3q+XJ9uhb0A68ERr2BNtu7Uv36hX0Ykmy33o
   tGqRK/dRLwgPHSuYySAO0S5g8KHAefctTF3cM+ni/lYZY3dxvjhy+tVPS
   sxw5XQrIA3CqKgxtFgF1RRzRCcG85zptf5RsSGYelgAEF7TD4X2L1VmO9
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10361"; a="262350465"
X-IronPort-AV: E=Sophos;i="5.91,259,1647327600"; 
   d="scan'208";a="262350465"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 18:10:49 -0700
X-IronPort-AV: E=Sophos;i="5.91,259,1647327600"; 
   d="scan'208";a="575408466"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.70.91]) ([10.209.70.91])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2022 18:10:49 -0700
Message-ID: <ff750d43-fda1-7330-f9ec-3a03bb0e10da@linux.intel.com>
Date:   Sat, 28 May 2022 18:10:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] x86: Optimize memchr() for x86-64
Content-Language: en-US
To:     Yu-Jen Chang <arthurchang09@gmail.com>, jdike@linux.intel.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        linux-um@lists.infradead.org, jserv@ccns.ncku.edu.tw
References: <20220528081236.3020-1-arthurchang09@gmail.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20220528081236.3020-1-arthurchang09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/28/2022 1:12 AM, Yu-Jen Chang wrote:
> *** BLURB HERE ***
> These patch series add an optimized "memchr()" for x86-64 and
> USER-MODE LINUX (UML).
>   
> There exists an assemebly implementation for x86-32. However,
> for x86-64, there isn't any optimized version. We implement word-wise
> comparison so that 8 characters can be compared at the same time on
> x86-64 CPU. The optimized “memchr()” is nearly 4x faster than the
> orginal implementation for long strings.
>
> We test the optimized “memchr()” in UML and also recompile the 5.18
> Kernel with the optimized “memchr()”. They run correctly.
>
> In this patch we add a new file "string_64.c", which only contains
> "memchr()". We can add more optimized string functions in it in the
> future.

Are there any workloads that care? From a quick grep I don't see any 
that look performance critical.

It would be good to describe what you optimized it for. For example 
optimization for small input strings is quite different than large 
strings. I don't know what is more common in the kernel.

I assume you ran it through some existing test suites for memchr (like 
glibc etc.) for correctness testing?

(bugs in optimized string functions are often subtle, it might be also 
worth trying some randomized testing comparing against a known reference)

-Andi

