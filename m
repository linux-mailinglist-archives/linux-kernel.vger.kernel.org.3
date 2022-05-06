Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F51D51DC96
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443196AbiEFPzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443087AbiEFPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:55:33 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A752659BAD
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 08:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651852309; x=1683388309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lpMrnrVeRh86bcZ58hSXUVL3BFcGtLy2Tkcjd1zhcIM=;
  b=l+z03LCY+15hkp3XgISqnUIYC2OHau4NrwCiRki7UpqFHptGJ/ct1kSA
   SDMdJLvkY+CZAJx5M79heL2FkgbiRGt/0X00rkcZRrF95yWnKxeRddsgF
   sK2oIo7HknVQIasr8Qf5uLk5kiMNKmbs9eRpc0V/GYaXtz4NZKe+Q1euF
   jZZm2Va9LGoB3eAbPofl/0GkgP/Tic318DBBnXO/3/Hi+5fNfqsxw540g
   K0o+pN3xl+xmofvgCQqmoM5CUdehemnZwf9VLeOhfDiA7GZTdFb4LMOaZ
   Mta/BarQdwrB2pOZY35FS8JGSy775M5Jr3b/CHbYBx1HfxXurl1y51hXI
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="267339777"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="267339777"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:51:44 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="812436754"
Received: from nnwaiwux-mobl.amr.corp.intel.com (HELO [10.212.56.26]) ([10.212.56.26])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 08:51:42 -0700
Message-ID: <1a806ced-4bb9-c18f-e614-75e9d9722d08@intel.com>
Date:   Fri, 6 May 2022 08:52:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/3] x86: Remove vendor checks from
 prefer_mwait_c1_over_halt
Content-Language: en-US
To:     Wyes Karny <wyes.karny@amd.com>, linux-kernel@vger.kernel.org
Cc:     Lewis.Carroll@amd.com, Mario.Limonciello@amd.com,
        gautham.shenoy@amd.com, Ananth.Narayan@amd.com, bharata@amd.com,
        len.brown@intel.com, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, chang.seok.bae@intel.com,
        keescook@chromium.org, metze@samba.org, zhengqi.arch@bytedance.com,
        mark.rutland@arm.com, puwen@hygon.cn, rafael.j.wysocki@intel.com,
        andrew.cooper3@citrix.com, jing2.liu@intel.com,
        jmattson@google.com, pawan.kumar.gupta@linux.intel.com
References: <20220505104856.452311-1-wyes.karny@amd.com>
 <20220505110140.453184-1-wyes.karny@amd.com>
 <0b501f18-a6b8-1d9b-e72a-ea6cb33720a2@intel.com>
 <fa4e26df-d2e7-7b13-a961-4f741b319e79@amd.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <fa4e26df-d2e7-7b13-a961-4f741b319e79@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/22 02:42, Wyes Karny wrote:
> 
> So, if CPUID.05H:ECX[0] = 0, MWAIT extensions are not available (not allowed) and hence 
> it is safe to use MWAIT with EAX=0,ECX=0. Otherwise, we have to check CPUID.05H:EDX[bit 7:4]
> to get the number of C1 substates and this should be greater than equal to 1.

Ahh, I misread the comment.  I was confusing the CPUID leaf ECX data
with the use of ECX hints to MWAIT.

Could you add maybe a sentence or two more in that comment to help
clarify the situation?

