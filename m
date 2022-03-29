Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF24C4EB614
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237673AbiC2Wg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 18:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbiC2Wg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 18:36:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21BE1F686C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648593283; x=1680129283;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=CeCGP8l6wcfntguGcvUHng56/zPfN8nAI7+geuG9AH4=;
  b=P+TkJOKmIWid1j+4v04VUSLhG/cpkocjKaFoJhQmsGj6eBqOK+8UbZ04
   8FwOnyoH3kwD50U6xYb3btW2LZXk7yfMJN/EjtJ3tKks4Xqnv7d+lz14k
   BuvhywUyumrs+2IJFHXblBsHgbVPYhqDjQvW046aqqhKRENkELaXlD06F
   kesUvslJl7Nv/orNzCbv6+Lv8zXNH3eaKQWoRW3Dt8OtoxoyEJkChkdOQ
   QxPElLfp6YKRF+LTW5okJWyMaupaOW8/YoplXleLSsh4v3RFUh1LWiFIy
   kls95X4RTKXs0orbjwU64ZLQ7VmTQK5Ld3ptHijaEmeEtCeHoFXx9ZVmW
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="345826526"
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="345826526"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:34:43 -0700
X-IronPort-AV: E=Sophos;i="5.90,220,1643702400"; 
   d="scan'208";a="605072928"
Received: from acstuden-mobl.amr.corp.intel.com (HELO [10.209.45.17]) ([10.209.45.17])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 15:34:43 -0700
Message-ID: <1ec9dd62-7299-1662-3907-bf73ea56fa7d@intel.com>
Date:   Tue, 29 Mar 2022 15:34:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Matthias Welwarsky <matthias.welwarsky@sysgo.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
References: <3422754.iIbC2pHGDl@linux-3513> <Yj49F1pnehy3ga5U@zn.tnic>
 <d9d0405e-b118-b028-d26f-fbb8de4e7a0e@intel.com> <Yj7Oi9g/B54xAcmF@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: x86, possible bug in __memmove() alternatives patching
In-Reply-To: <Yj7Oi9g/B54xAcmF@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/22 01:27, Borislav Petkov wrote:
> So, more to the point, it is about this chunk:
> 
>         /*
>          * If fast string is not enabled in IA32_MISC_ENABLE for any reason,
>          * clear the fast string and enhanced fast string CPU capabilities.
>          */
>         if (c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xd)) {
>                 rdmsrl(MSR_IA32_MISC_ENABLE, misc_enable);
>                 if (!(misc_enable & MSR_IA32_MISC_ENABLE_FAST_STRING)) {
>                         pr_info("Disabled fast string operations\n");
>                         setup_clear_cpu_cap(X86_FEATURE_REP_GOOD);
>                         setup_clear_cpu_cap(X86_FEATURE_ERMS);
>                 }
>         }
> 
> we already check whether fast strings was disabled, regardless of HV or
> not. Question is, should we clear X86_FEATURE_FSRM there too. I wanna
> say yes.

I don't think it would hurt to clear it.

> Or is it that, *if* MSR_IA32_MISC_ENABLE_FAST_STRING is clear, the FSRM
> CPUID bit was not set either so nothing to clear...

I don't think there's really any direct connection between the CPUID bit
and MSR_IA32_MISC_ENABLE_FAST_STRING.  The CPUID bit definitely doesn't
appear to be cleared by the CPU if MSR_IA32_MISC_ENABLE_FAST_STRING is
clear.
