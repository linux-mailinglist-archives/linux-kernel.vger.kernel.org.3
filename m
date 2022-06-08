Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B69D543215
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 16:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240860AbiFHOAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 10:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240530AbiFHOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:00:39 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775F231D9D0;
        Wed,  8 Jun 2022 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654696838; x=1686232838;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hMOWQic/jVTuD2Wq8YgUFKqJpBQ/U8MDI3wleWZjJec=;
  b=AoRqAi3VteIn9LWS4COLyc1cfxGuLdycZDMksI5fCSolcwu9mIKSprWp
   EFeSRHquuzq06ybVLgfK+nuDKZtApWwEm5bjpZEEuLG1wgfaGt/4TonKK
   QaHLH0a+SS8lCr/jHc4gV0Ak2/Nrc3od3e/Cn8D4aXZzyy7V2OjnZz42J
   iIi5eOe/KQmHYGmU8Wlt2BCLE4kb57m+wsr7DrMfXWJA1osDXZZ4OBMms
   zeUsuiLgJ5b0nDPub2xMhaeXJBfeOpBLMnY4z/Xo0viiG+RZWOU+5XptF
   5qcQxxZmZHBuOnVlzhyCi7CF8aIl1zb1L9auoUFaw0DSfXWT2HQpzVrzb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="277739839"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="277739839"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 07:00:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="683344035"
Received: from kbrownfi-mobl2.amr.corp.intel.com (HELO [10.212.170.198]) ([10.212.170.198])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 07:00:36 -0700
Message-ID: <2e3286b4-a13b-1be0-2b6a-902eec54e960@intel.com>
Date:   Wed, 8 Jun 2022 07:00:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] crypto: x86/aes-ni: fix AVX detection
Content-Language: en-US
To:     Maxim Levitsky <mlevitsk@redhat.com>, linux-kernel@vger.kernel.org
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20211103124614.499580-1-mlevitsk@redhat.com>
 <622444d6-f98b-dae4-381e-192e5cb02621@intel.com>
 <3943020ac3540af8055c487e4810c63a422d65e7.camel@redhat.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <3943020ac3540af8055c487e4810c63a422d65e7.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/22 04:29, Maxim Levitsky wrote:
> filter_cpuid_features can be extended to filter known bogus CPUID depedencies,
> like case when AVX2 supported and AVX not supported in CPUID.
> If you agree, then it seems the best case to deal with this issue.

Yes, it should have been doing this all along.   Patches to fix that
would be very welcome.
