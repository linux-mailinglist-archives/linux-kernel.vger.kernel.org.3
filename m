Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39EF518803
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiECPN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiECPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:13:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115AE3B56C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651590588; x=1683126588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IACxIDHwXqlTIFLmAExQlUxosyzk99ozoP6vJrNh0dU=;
  b=WjpduO+YShmTaznUL0ZYjYUVAbqfnvzptbOyVKmEm9cFK9zBUKKJrpzS
   sjWORaWDIwm8SSSWA8/dmYEJYihxlT6NO8hEdGIV3EiUfukaYjX4RSzd5
   agMltmycERc+Fi71o9XdxfgmlZ4TYDwx2P5yZpH0pODtcmhaX/wCfg6m6
   y8TaRgzCMLIoDYLrvhjiO3IAk3St/Ziw5foWRFqKmM/rPiqjnU5sCm2s8
   n88cZ4N/meTx3wbnf+JEVMkuk7U8lnLYALGB7dCuLoPN2hCoW6ElvRHzz
   UuVG47FdbiJtRlb++vDDnvs/vOH7PjN3Pi2Vr2GNGCzcKA6RRmSE8w4E9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267654839"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267654839"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:09:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="562240918"
Received: from kputnam-mobl1.amr.corp.intel.com (HELO [10.209.19.155]) ([10.209.19.155])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 08:09:46 -0700
Message-ID: <cd48825b-7197-fc04-51e6-04bd8502d286@linux.intel.com>
Date:   Tue, 3 May 2022 08:09:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Wander Costa <wander@redhat.com>
Cc:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        open list <linux-kernel@vger.kernel.org>
References: <20220501183500.2242828-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220501183500.2242828-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <5473f606bd8e60dd7b8d58a540285d126a1361bd.camel@intel.com>
 <e5aed619-20ce-7eb3-22a3-64b51de9cce3@linux.intel.com>
 <b8eadd3079101a2cf93ee87d36dbedf93d8a2725.camel@intel.com>
 <e673ea3d-ae4f-39ed-33a5-c6480e58c6d8@linux.intel.com>
 <CAAq0SU=TPHQ4q8Dj583m0yfVytygN81BTEe8vU5GCOoFau+LWw@mail.gmail.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <CAAq0SU=TPHQ4q8Dj583m0yfVytygN81BTEe8vU5GCOoFau+LWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/3/22 7:38 AM, Wander Costa wrote:
>> I don't want to pollute the dmesg logs if possible. For IOCTL use case,
>> the return value can be used to understand the failure reason from user
>> code. But for initcall failure, pr_err message is required to understand
>> the failure reason.
> How often is this call expected to fail?

In general, it should not fail (so very low fail frequency). But the
point is, we can easily understand this failure from user end. So we
don't need to print more in non-debug environment.

> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
