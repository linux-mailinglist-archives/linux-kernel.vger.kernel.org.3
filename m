Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DDC4C7E80
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 00:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiB1Xi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 18:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiB1XiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 18:38:21 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1875FB53
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 15:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646091461; x=1677627461;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U/t/NO7v7v04FSloHWhwgLX+nBzRWnrhid4LK4Wglb4=;
  b=GbbFIj/bVobtXVvmHwQU8eo12hp6KW0cALGGteAvencoZAfg8HvjhNU7
   YqTKT1t1ik+eUHZEg1cKwsYn3hM9bHBzXjCzQxgTER0cgS6uN4TkQg+lg
   EKd/pXiRA+BtftoHwQj0N0uRugLNlT7FfeM+BpMWqLlHOjUHh//GhNP+m
   74HXDsDnF+6v9m7F1xVvZtfUvdrGUDqgo8VJQSq8YDqNmUCwd+HaSJHkn
   Xmp1oQT4Lj9ZKW8MGje7g2A9POEpRp4ASvJOHUpdYXHBJqqRt3XBCPLsO
   dDy68jAvgx9YZ7zcmXJVQW31ZaJ943eKaNL+Di3okw5u67lacL9Z97kBE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="251844962"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="251844962"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 15:37:40 -0800
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="550462413"
Received: from simpleku-mobl.amr.corp.intel.com (HELO [10.209.11.92]) ([10.209.11.92])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 15:37:38 -0800
Message-ID: <0f558d9b-a4d8-094b-f3d2-4d9fda945cd9@intel.com>
Date:   Mon, 28 Feb 2022 15:37:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCHv4 10/30] x86/tdx: Handle CPUID via #VE
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-11-kirill.shutemov@linux.intel.com>
 <51b6613d-eabd-941d-19b2-95b33ec27e99@intel.com>
 <20220227010733.abapkmyaroglcafl@black.fi.intel.com>
 <7a8c4e5e-c0ba-ee8e-a912-c71f89b4d4f2@intel.com>
 <20220228225336.k3lxk5qqm4vpaocv@black.fi.intel.com>
 <76b54855-d2b6-e224-ccb4-3f6c4cd1f7e7@intel.com>
 <20220228233125.z35h5f7lpvspfohv@black.fi.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220228233125.z35h5f7lpvspfohv@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 15:31, Kirill A. Shutemov wrote:
>> Does this, in practice, keep TDX guests from detecting any features that
>> it supports today?
> I scanned through the list of CPUID that probed via #VE during the boot
> and they are related to cache/TLB hierarchy enumeration, thermal and
> topology. Without cache/TLB enumeration we may miss some optimization.
> Topology can be problematic, we may miss ability to communicate the
> configuration, I donno.
> 
> Shouldn't be a show-stopper.

I can live with that for an initial TDX guest series.  Does that bother
anyone else?
