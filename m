Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028AE58A0A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 20:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240034AbiHDSli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 14:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbiHDSlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 14:41:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18CD61DB9
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 11:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659638496; x=1691174496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Rtb34Y8ymUuSf9K//6BaeaY14gW3/LRcO+rXWYrbGc=;
  b=FQkZQHWEPX2yWIJl2+kDsK9Wd6XIdxSUOxYUeev7a41muJC93eaK6/fZ
   ikPYAIYs5MI44Nc5QB0DP4fNQFKFa+N/qmtcL8m46HB83ueIdYXwMbGKp
   cG7y9Sg+wkhl7QMzfDSL7s0w8prrfJGYCxM+Mnr2scZJ4L5z34If+3jZ6
   kX+lg5jV9/ivW/9uR670354QP79Huuhsz2khp3Kr8pMG+W9kvVG/mg3Rw
   bvXCFT2EApF+cxPUx089HparrNOItXvDncBP0OnDFV2N0Bf+2BOg6wfm6
   dUqaup5/+zyT64rpx7qo+MyJknR5v5daMbUJWVPQBYD5eO7E/mtVAW8Z0
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="315897670"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="315897670"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 11:41:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="631701158"
Received: from lnavery-mobl1.amr.corp.intel.com (HELO [10.255.228.146]) ([10.255.228.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 11:41:35 -0700
Message-ID: <91ccae0b-6135-6163-f59b-4e99624090a5@intel.com>
Date:   Thu, 4 Aug 2022 11:41:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/acrn: Improve ACRN hypercalls
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20220804180358.32944-1-ubizjak@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220804180358.32944-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/22 11:03, Uros Bizjak wrote:
> As explained in section 6.47.5.2, "Specifying Registers for Local Variables"
> of the GCC info documentation, the correct way to specify register for
> input operands when calling Extended 'asm' is to define a local register
> variable and associate it with a specified register:
> 
> 	register unsigned long r8 asm ("r8") = hcall_id;

IIRC, that's what the ACRN folks proposed first.  But, it's more fragile
because you can't, for instance, put a printk() in that function between
the variable definition and assebly.
