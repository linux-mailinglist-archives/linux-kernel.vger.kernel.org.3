Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56640507E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 03:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbiDTB3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 21:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbiDTB33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:29:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378AD23BC4;
        Tue, 19 Apr 2022 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650418005; x=1681954005;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mbBwslPLaoBfylvW/dhJ1OLBSlP7qYZg3Cvd31qjORE=;
  b=CGW8trYZ7koQ47kn2LlAg7TkxqunsCuFhU7JYFAjDdaBz3in7He7YYGz
   GfOlp5+lHQFlk7N5slDxiYDdAxRp63TkJ3qY9FEpw4YlnMnzjCaZDCS7v
   JZK41CI20P4OcnG+l7T9NLi4Aj9nmjGmO34zstVUtvjgdhgCnxM85BdDq
   +nLSwP4XsnxvX66ICG+Qug2ELP6OMSThtW9I5szLe1dnx/GvRUESjIKCA
   LWwTwJyAtTMCqvxFYUcXYTpuG/oV1aFqS6ZrxPxm2ECY3NEnwGI2B2wU+
   fAg4sn9OO2E1qpsXkqBx2Y10KqpM8lyNqnjqRejlxypsFR6umooMUV2RA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="244495224"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="244495224"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 18:26:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="561918375"
Received: from ktuv-desk2.amr.corp.intel.com (HELO [10.212.227.192]) ([10.212.227.192])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 18:26:43 -0700
Message-ID: <dd4a2b16-397e-8866-0fd5-b5c5dfd453ab@linux.intel.com>
Date:   Tue, 19 Apr 2022 18:26:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v3 4/4] platform/x86: intel_tdx_attest: Add TDX Guest
 attestation interface driver
Content-Language: en-US
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
 <20220420012032.GA2224031@ls.amr.corp.intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220420012032.GA2224031@ls.amr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/22 6:20 PM, Isaku Yamahata wrote:
> If timeout occurs, the state of adev->tdquote_buf is unknown.  It's not safe
> to continue to using adev->tdquote_buf.  VMM would continue to processing
> getquote request with this buffer.  What if TDX_CMD_GEN_QUOTE is issued again,
> and tdquote_buf is re-used?

This part is not clearly discussed in the specification. May be spec
should define some reasonable timeout and teardown details.

Regarding not using this buffer again, what happens if we de-allocate
it on timeout and the host still updates it?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
