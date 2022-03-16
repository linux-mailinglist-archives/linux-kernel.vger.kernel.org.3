Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA54DBA8E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 23:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358208AbiCPWOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 18:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353389AbiCPWOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 18:14:41 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6194712AB3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 15:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647468806; x=1679004806;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0cCDRGL56U2ZN/QvIzCx3LdMzUiOMFKhXWR+5PoDbf0=;
  b=a8xdJ2P3BpZM89UrKyXCwL4wd6YZkZP6Fu3YKkK1m/iqcmicN3iyD39b
   kS//JnzPq0e+QX1OJ3qzMVSv0sSa766irDQW9zxmH7GA1ir7PfY2RQ9kU
   QJn9bE11k493dGCx7fnDshHwPSsAatSKs4TJKVCrx8yN+dXYXFIyqu5jn
   6QOVorz+OqwvCkPQuzB6yVsG+8GuW5kl5+2p//YB5OudIsUg7MEV535xC
   8nItqf9zPJ2tXd4qYXuagRvazeHT7OIFbt4GxB2FDbrukMrb1gHckH9TX
   p1Z/zMZmgKNIcfPFAdyrXCnPXPmrmqJVobRO8fOYOqKYIQd/zqiYVDTol
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317443964"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317443964"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:13:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="783632663"
Received: from pwblakex-mobl1.amr.corp.intel.com (HELO [10.212.129.47]) ([10.212.129.47])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 15:13:24 -0700
Message-ID: <f60f4310-8a03-2fdb-d495-be2658f08abe@intel.com>
Date:   Wed, 16 Mar 2022 15:13:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv6 29/30] ACPICA: Avoid cache flush inside virtual machines
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
 <20220316020856.24435-30-kirill.shutemov@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220316020856.24435-30-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/15/22 19:08, Kirill A. Shutemov wrote:
> While running inside virtual machine, the kernel can bypass cache
> flushing. Changing sleep state in a virtual machine doesn't affect the
> host system sleep state and cannot lead to data loss.
> 
> Before entering sleep states, the ACPI code flushes caches to prevent
> data loss using the WBINVD instruction.  This mechanism is required on
> bare metal.
> 
> But, any use WBINVD inside of a guest is worthless.  Changing sleep
> state in a virtual machine doesn't affect the host system sleep state
> and cannot lead to data loss, so most hypervisors simply ignore it.
> Despite this, the ACPI code calls WBINVD unconditionally anyway.
> It's useless, but also normally harmless.
> 
> In TDX guests, though, WBINVD stops being harmless; it triggers a
> virtualization exception (#VE).  If the ACPI cache-flushing WBINVD
> were left in place, TDX guests would need handling to recover from
> the exception.
> 
> Avoid using WBINVD whenever running under a hypervisor.  This both
> removes the useless WBINVDs and saves TDX from implementing WBINVD
> handling.

Looks good.  Did you have more acks on this earlier that got removed?  I
thought I remembered more acks on earlier versions.

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
