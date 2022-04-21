Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7FD50A372
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389703AbiDUO5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244846AbiDUO5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:57:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D432EDE92;
        Thu, 21 Apr 2022 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650552858; x=1682088858;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iQmB5ja8PgXHg6G0hsJMOXs/dAiqirnOlEX5HAvHqjo=;
  b=hS4L/SBCyM+084LKYuhJWuNCRGc97jhhsIllCz5WeHfWYfihnoUaTjch
   md4uWd2q5tRULQ2j4XJgYDIDw9vdMjnXcBzGJr1ezSWorsaVr/e9Msh/N
   V0MUckhBPhirznUwbyK+NY7f8OHwEEV7hSP1ksMbpDXHhrcMDUHzPFcgF
   xoLE9FindwV3AkpzdPfPq92ynA0/4xHbQHUOioDrm6uON2okmUbrS2rak
   N7KHHDZ52sKZch+as9ShlfcIdMznczeGr96rDuMZ5vyl+Vx25MD0rd/BW
   n1oqg3fATpakT9o66Cb7a6j+M9U549/SSjU5EQ7xNnlc97aHvhpqBoi+V
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="350810975"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="350810975"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:54:18 -0700
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="511098485"
Received: from testes-mobl1.amr.corp.intel.com (HELO [10.212.210.35]) ([10.212.210.35])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 07:54:17 -0700
Message-ID: <0e082bb7-ccb4-c08f-3043-6d7db136fcd0@linux.intel.com>
Date:   Thu, 21 Apr 2022 07:54:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Kai Huang <kai.huang@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <20220415220109.282834-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220415220109.282834-5-sathyanarayanan.kuppuswamy@linux.intel.com>
 <bd83067542a3519ee4c91f9d50e9bd4fac27e4bb.camel@intel.com>
 <Yl5vGIfUFp4TfTWk@zn.tnic>
 <9198cc36-67d6-9365-5d18-f23ba4075151@linux.intel.com>
 <YmCCdtF10dYZOQ2a@zn.tnic>
 <088a3cbc-5d83-ca47-f544-087f0d59e331@linux.intel.com>
 <YmEfgn7fMcZ2oCnr@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <YmEfgn7fMcZ2oCnr@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 2:10 AM, Borislav Petkov wrote:
> Well, since this is not really a driver but the attestation part of TDX,
> then arch/x86/coco/tdx/ sounds like the place.

Ok. I will move it to arch/x86/coco/tdx/attest.c

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
