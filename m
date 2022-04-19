Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DCC506FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 16:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345496AbiDSOQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 10:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343600AbiDSOP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 10:15:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E8F396BE;
        Tue, 19 Apr 2022 07:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650377595; x=1681913595;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=W+EH5yEIBiFrtUXyttaddEsTcopm5wfnex1IrAICx30=;
  b=Pw7yl65stjlwQ8KsdmOTaT2HKShI/NSc927cylHkLJuHG5RTNLe6DyaY
   /jgsCrzKdDRgMiqob2wApUlzhgDvc3M5ygnhMkLSc7UAdrQU08/vxCCYO
   1x8O8n0zqbMdpaMPfTaESqg3H/fi2HUdQuG0sbVR2HydhsRjd9+6f27jn
   3nYb0CwtLojhzHXsd1AUlqcdp5BSQWoKmxMz565uCpqEbK6LuXsgvO9KZ
   rL6SxH2cT4S4G/HLEKVWmccNXS0cbQVrfhiEL6FgpWzh90vGyonxiSEJT
   MvXZSokqUU+e4LZZxg8LxZnAdW4J8wVJqZn2YwpDer8rn1VkMeqsGLkih
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245665434"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="245665434"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:13:13 -0700
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="657653286"
Received: from aislaslo-mobl.amr.corp.intel.com (HELO [10.212.57.245]) ([10.212.57.245])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 07:13:12 -0700
Message-ID: <975b5050-2108-9ace-cc71-46f17db0a731@intel.com>
Date:   Tue, 19 Apr 2022 07:13:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
In-Reply-To: <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/22 00:47, Kai Huang wrote:
>>From security's perspective, attestation is an essential part of TDX.  That
> being said, w/o attestation support in TD guest, I guess nobody will seriously
> use TD guest.

Are you saying you can't think of a single threat model where there's a
benefit to running a TDX guest without attestation?  Will TDX only be
used in environments where secrets are provisioned to guests on the
basis of attestation?

>>From this perspective, I am not sure what's the value of having a dedicated
> INTEL_TDX_ATTESTATION Kconfig.  The attestation support code should be turned on
> unconditionally when CONFIG_INTEL_TDX_GUEST is on.  The code can also be just
> under arch/x86/coco/tdx/ I guess?

How much code are we talking about?  What's the difference in the size
of the binaries with this compiled in?
