Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F073A4E7EF2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 05:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiCZErE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 00:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiCZErB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 00:47:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56523205E2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 21:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648269926; x=1679805926;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=WkqhRloa6zdmS38sBFcU8W77ESxORgQffG9pQv+1Hbs=;
  b=OCLAMEWSia4McweRHy5M4rBtpyoDNz8Am2pXuwXaOZXTYl4MWZO9DBAs
   F2PEBrENChuZXcTlsk0K7R3w1ltZgLupcRnOVJZO7Jr37pSSQ+wDmtY8L
   lKwRnUXULFmg4j3s7rXr8Tmp6qRcQ7fFyh2dc0h7JwvOz0yhHqv1Y45+U
   XtjqDpr3t4Qkr9K7tx8jtADb0up8aXXQNI1Ypaaz4zGQnLfRmZCHYsgn8
   KRvmN1uHwo1BfTkciARm/JA6ycHDlaKvcm1dSsHh2dy6HDd93XHYjrnrn
   j+gaC0wiLTG6R9kq20mXGpXXZkuXN3/utIG+Uj/pR9Vqo9Q8DLIGkWDOA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="283637346"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="283637346"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 21:45:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="718429718"
Received: from blphilo-mobl.amr.corp.intel.com (HELO [10.255.231.82]) ([10.255.231.82])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 21:45:25 -0700
Message-ID: <d9d0405e-b118-b028-d26f-fbb8de4e7a0e@intel.com>
Date:   Fri, 25 Mar 2022 21:45:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Matthias Welwarsky <matthias.welwarsky@sysgo.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
References: <3422754.iIbC2pHGDl@linux-3513> <Yj49F1pnehy3ga5U@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: x86, possible bug in __memmove() alternatives patching
In-Reply-To: <Yj49F1pnehy3ga5U@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 15:07, Borislav Petkov wrote:
> I know it's is probably a very rare case and Intel recommends having fast 
> string ops enabled, hence the question: would this be considered a bug in the 
> kernel that should be fixed? A potential fix could be to clear FSRM together 
> with ERMS depending on IA32_MISC_ENABLE.

I'd consider it a bug in the hypervisor, personally. ;)

But, we do try to make the kernel work even the face of funky
hypervisors that do things that never occur on real hardware.  If a nice
patch to fix this up showed up, I'd definitely take a look.
