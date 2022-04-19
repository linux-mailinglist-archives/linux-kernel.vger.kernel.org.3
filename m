Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39D3507060
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353289AbiDSO3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349562AbiDSO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:27:27 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB5835A86;
        Tue, 19 Apr 2022 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650378285; x=1681914285;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=S/AnCfZB2POHJ489DdjypzBOnhx3vZSBUI8TEc0qIJI=;
  b=CqPZLWOe+A78Wk+FwsEcLBVERF48br7drCngxW6KoCRdoVhqGzDLhbtb
   PG/eI5Gs6TVWfli+/eZ2Tdrr5rn7VD4CTH/THi54vaftjOLagxXJ31Tk0
   XS5NySOFQtHcTcoQ6GaOc+C9cwLb1hN61UHVtXJHLkBubYaLJ+co1J5c0
   rbIy9SGIrmCFO00zISvMOf6lsE4rrBt0Bw0aI4qNSLEBFT05+8KrV0sHc
   Iaxv4o3sDiLV7AjuRq0azNksRXAK4Ag0cGNjl2VY7PB4dcdrqu4Qglqa9
   QqeI7/YxNXGwgJkgsbpN5cL1SEVBg6eli7lpvvALPYV3R85vSqEe020NC
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324219231"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="324219231"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:24:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="657656324"
Received: from aislaslo-mobl.amr.corp.intel.com (HELO [10.212.57.245]) ([10.212.57.245])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:24:43 -0700
Message-ID: <72205a7a-faf2-4322-02cd-303ee8252abb@intel.com>
Date:   Tue, 19 Apr 2022 07:24:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
 <975b5050-2108-9ace-cc71-46f17db0a731@intel.com>
 <4875ea9c-593a-e669-889a-1e809a50a570@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
In-Reply-To: <4875ea9c-593a-e669-889a-1e809a50a570@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 07:19, Sathyanarayanan Kuppuswamy wrote:
> On 4/19/22 7:13 AM, Dave Hansen wrote:
>>> >From this perspective, I am not sure what's the value of having a
>>> dedicated
>>> INTEL_TDX_ATTESTATION Kconfig.  The attestation support code should
>>> be turned on
>>> unconditionally when CONFIG_INTEL_TDX_GUEST is on.  The code can also
>>> be just
>>> under arch/x86/coco/tdx/ I guess?
>> How much code are we talking about?  What's the difference in the size
>> of the binaries with this compiled in?
> 
> Current driver size is ~300 lines. It adds ~500 bytes to the kernel
> binary if it is built-in.

That doesn't sound like good use of a Kconfig option to me.  Just
explain in the cover letter:

	Any distribution enabling TDX is also expected to need
	attestation.  The compiled size is quite small (500 bytes).
