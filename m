Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7324DBA65
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358192AbiCPVyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358191AbiCPVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:54:35 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DAD17E13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647467600; x=1679003600;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=ZBvNSyNnJfp8swTdpJ4JUC9lx8yTTADzEzQmLT7lcjI=;
  b=ZC4gw21/JmsVQel3ZCrCNI92l7KAf+Jf3XBzMjmLKrCeSCZLblteEsDU
   xTx1KYpVIdWzFmPfVrZafseZWexFEdlETBwiqS4XqZNkXw6Nfilcqyq0/
   mI8wa3WT8tSUsEkLoogQAXRGdviIrImEoVienuEfvnTGKSIoSytBOHPXy
   qQwtyusMk6kVAdcOmi9+aabUm3HN/5gCZxaqAXxiPiNGwTMGgang1dA6h
   kZGAt3gOoiuRmx86aVEderjmXkEcx7ZgTR9l5PoQG3stRTNZpud/L9QBz
   RQ/hDM1JHHwzWOtxVKsEzQxbm+8nN3VnnQywH8jdo7CQUsDKN4zxExJbN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="343156649"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="343156649"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:53:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="783628316"
Received: from pwblakex-mobl1.amr.corp.intel.com (HELO [10.212.129.47]) ([10.212.129.47])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:53:18 -0700
Message-ID: <b1c1c4f1-8e5d-3c5a-8433-e101bbf79600@intel.com>
Date:   Wed, 16 Mar 2022 14:53:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-12-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv6 11/30] x86/tdx: Handle in-kernel MMIO
In-Reply-To: <20220316020856.24435-12-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 19:08, Kirill A. Shutemov wrote:
> In other words, even if all of the work was done to paravirtualize all
> x86 MMIO users and virtio, this approach would still be needed. There
> is essentially no way to get rid of this code.
...
> == Patching TDX drivers ==
...> This approach will be adopted in the future, removing the bulk of
> MMIO #VEs. The #VE-based MMIO will remain serving non-virtio use cases.

I still don't like this very much, but I can't argue with my own logic. :)

BTW, TDX folks...  I expect you to, today, start coming up with a
comprehensive list of the MMIO-induced #VE's and the reasoning why they
should or should not be paravirtualized.  You're going to get grumpy
maintainers if this is done haphazardly as one-offs when users hit
performance issues.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
