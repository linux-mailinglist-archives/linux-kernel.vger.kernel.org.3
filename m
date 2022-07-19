Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2117557A5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiGSRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiGSRx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:53:27 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C06E558CB;
        Tue, 19 Jul 2022 10:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658253206; x=1689789206;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2QpaWwyMGOI/87FV5yJoVCYewK4j2LMWRbyQ9ggcnqY=;
  b=Wez1ecgTptQXbFkRTSfxqrszlftCGgkQQLGJSY7WBIrw/s6zTa0hdZzs
   8ZGLQG6P68RzIFDewNR0XAQRbbhxYA+tcsiUqc3bCFJCPRZqUZugUkV5g
   FXNr2tLFcHX81qLC6LwJh4n+0Vg6XX/FUYrAElnLzdGQU3Z7kfTNFvQBN
   a7rnatjLp+d4P/x9d9ThJWabYCbc3c+ZNXg/obeY+uLx7PtJHdJjgdjA0
   0gATnyIx/vajxGcTebktMqng3HsvpY2HnQ+tCzuzleft7b12Lhne0q4bw
   WxDdMcF8Q4Rhh0SSoOvRfcox4n0yOrci6oZSigLR9EikPIHHzkoXCouFk
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="372859099"
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="372859099"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 10:53:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,284,1650956400"; 
   d="scan'208";a="687198943"
Received: from twliston-mobl1.amr.corp.intel.com (HELO [10.212.132.190]) ([10.212.132.190])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 10:53:25 -0700
Message-ID: <93960610-d7ff-8c7f-16ae-61191e6ed377@intel.com>
Date:   Tue, 19 Jul 2022 10:53:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] x86/sgx: Allow enclaves to use Asynchrounous Exit
 Notification
Content-Language: en-US
To:     Haitao Huang <haitao.huang@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-sgx@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>
References: <20220705183648.3739111-1-dave.hansen@linux.intel.com>
 <op.1pasmtstwjvjmi@hhuan26-mobl1.mshome.net>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <op.1pasmtstwjvjmi@hhuan26-mobl1.mshome.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 06:19, Haitao Huang wrote:
> 
> I think you need add this change in arch/x86/kernel/cpu/sgx/ioctl.c,
> inside sgx_encl_create function:
> 
> -    encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |
> SGX_ATTR_KSS;
> +    encl->attributes_mask = SGX_ATTR_DEBUG | SGX_ATTR_MODE64BIT |
> SGX_ATTR_KSS | SGX_ATTR_ASYNC_EXIT_NOTIFY;
> 
> Otherwise, EINIT ioctl fails with this new attribute set in enclave secs.

Makes sense.  I'll add it there.

I also just realized we need to update arch/x86/kvm/cpuid.c as well.  It
keeps a complete list of guest-available SGX attributes.

