Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E309F50CBAB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbiDWPW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233392AbiDWPWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:22:49 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF48522DA
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 08:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650727192; x=1682263192;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=i8eWzr/4uekI1U0JfCoaPpapRCBU7hNQjLGinbAYv3Q=;
  b=j6+4Ihz5aIEaUYoo6a2RTfgESZ4Md7ZFrU8YhRRvZQzxQ0mpKoimmRp9
   o346xoa484a2vE6vyKDLXl7namrkr8B6dPb+vmzstXRhyBaW37wgUVt57
   MQ6wK9z9n2RZPwKtgFdk6BVxa5HGi0tbUMMrkEeLXrapqTrd8ByCGfLMA
   /9QJkjanPRTCxDUpkhNkGtSGlGY0IxcGqvb6fmp9/cC2FbN2tFIYJTo7t
   S7eioCO6VLKRgBDMdAliCKjnzkVWQc3qd/3gxWikpyw0rd7o6WOyhAjtE
   1y5MIbeOPLQ6wFaeVh6Of2ZGH0U88n5wjbu++bBOEGSCRMCGnbIOFRUBL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="263752967"
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="263752967"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 08:19:52 -0700
X-IronPort-AV: E=Sophos;i="5.90,284,1643702400"; 
   d="scan'208";a="674098907"
Received: from aescapa-mobl1.amr.corp.intel.com (HELO [10.212.100.233]) ([10.212.100.233])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 08:19:51 -0700
Message-ID: <4cce3734-03e0-ff62-b13e-cd8405d3a8b7@intel.com>
Date:   Sat, 23 Apr 2022 08:20:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [patch 3/3] x86/fpu/xsave: Optimize XSAVEC/S when XGETBV1 is
 supported
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20220404103741.809025935@linutronix.de>
 <20220404104820.713066297@linutronix.de>
 <a93e6d3f-e8b9-2fab-1139-a8ba3dc4820b@intel.com> <87ee1t9oka.ffs@tglx>
 <878rs0vkd2.ffs@tglx> <60e5a4d1-df7c-d3bd-2730-e528cd75c351@amd.com>
 <87bkws6hmc.ffs@tglx>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <87bkws6hmc.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 12:30, Thomas Gleixner wrote:
> So I just go and add the XSAVEC support alone as that's actually
> something which _is_ beneficial for guests.

Yeah, agreed.

When I went to test these patches, a bit loop with XSAVEC was ~10%
faster that XSAVEOPT.  This system has XSAVES, so wouldn't have been
using XSAVEOPT in the first place in the kernel.  But, this is at least
one more data point in favor of XSAVEC.
