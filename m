Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300C14C71F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 17:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238022AbiB1QwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 11:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiB1QwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 11:52:09 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4701685BE3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 08:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646067090; x=1677603090;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=JVHgOaqEAHLfUif8xihCvc1RrqNb4vLpIVTphrUcEHY=;
  b=fevIJdCg4+wQcCr7hR7wCnsisIvmgVvsNSmtCH96Z/Hbeg20LZQ9UI7X
   37eek5HClG8bpYWS4kOtSByFDJirIMFU0u75bHyHDd9OgiFjjnnoP0G5R
   ow5aHlkBXbGQHRwNM+6RuuqWY98AWXb3E+qTyVJlzv9VEPYxQKOEyiQ/d
   rjhhf9sNLfJceQ0cvB0CtNFTDQ5Xph8k9wjL+CzB/SJDszmtjMyKVf1BU
   /0rsXhC1Z44licQxWC1BB+gkLkLjwotob7QYWIjl4tUy9es4G75WI4dqJ
   31OfouL8lbYOfEcC+M54JyN2gaJZEZ7JH53QWEpynGJkkoDd5pwkJg+ad
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="250511941"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="250511941"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:51:25 -0800
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="550314170"
Received: from eliasbro-mobl.amr.corp.intel.com (HELO [10.212.174.65]) ([10.212.174.65])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 08:51:23 -0800
Message-ID: <080f9306-8c72-c7bd-010a-f0ed32c4b692@intel.com>
Date:   Mon, 28 Feb 2022 08:51:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, peterz@infradead.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, knsathya@kernel.org, pbonzini@redhat.com,
        sdeep@vmware.com, seanjc@google.com, tony.luck@intel.com,
        vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>
References: <20220224155630.52734-1-kirill.shutemov@linux.intel.com>
 <20220224155630.52734-2-kirill.shutemov@linux.intel.com>
 <20220227220130.23yjme7jucxo266l@treble>
 <20220228162056.gul22bjr4w6zjslq@black.fi.intel.com>
 <20220228164007.nfrg7xvrl4blzzrm@treble>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCHv4 01/30] x86/mm: Fix warning on build with
 X86_MEM_ENCRYPT=y
In-Reply-To: <20220228164007.nfrg7xvrl4blzzrm@treble>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/22 08:40, Josh Poimboeuf wrote:
>> maintainer-tip.rst seems disagree with you:
>>
>>    A Fixes tag should be added even for changes which do not need to be
>>    backported to stable kernels, i.e. when addressing a recently introduced
>>    issue which only affects tip or the current head of mainline.
>>
>> I will leave it as is.
> How does that disagree with me?
> 
> The "Fixes" tag is for bug fixes.  If it's not possible to trigger the
> warning and there's no user impact, it's not a bug.

Does having Fixes: *break* anything?

If not, I think I'd generally rather have the metadata with more
information as opposed to less information.
