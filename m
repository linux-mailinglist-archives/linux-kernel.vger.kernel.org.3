Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 966025209EE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiEJAV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbiEJAVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:21:12 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AA1170F17
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 17:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652141834; x=1683677834;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a8IXJEjfdoFWo9cZvtCHD4lzXZbfvKNjZNtuqD2Q3mo=;
  b=bTxzhaBxusB3xVhdStf985wMNz+/CJXS/I38NzcoSRKZ2Nysb/pV0T6a
   Co6Y4FVpZgenOvH0bzTCxRAYImI6br/7FipfwGMQ0OQFf4/Pb3a/RNmMI
   H4PUlmt9grjhfkCr2IDeU4JxQv2FLluU4my3fGLx2w3ao5iO224oDWuVc
   dv8uobA8W1/QYr8MygY91blw9AVF5XV6+G5dyQ/wDHNhgoh8KAWaLHWWh
   WX7CJMklfHhCTEgIyH2qpRxDgUcCEIkzvqG3g1nj7sWbsrdnoDcAZeoS3
   03Tm2RxuGLtVSfVGJFw5yNQsK8wFxE1VBhB/zFxE1b/DCPYQnaBqNEvhO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="249109273"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="249109273"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 17:17:13 -0700
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="602207049"
Received: from akothari-mobl1.amr.corp.intel.com (HELO [10.209.16.133]) ([10.209.16.133])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 17:17:12 -0700
Message-ID: <261b8dc3-eb78-1c24-48f7-de6505e14c76@linux.intel.com>
Date:   Mon, 9 May 2022 17:17:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH v5 3/3] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220503012721.ok7fbvxmnvsr6qny@box.shutemov.name>
 <58d07b2d-cef5-17ed-9c57-e12fe5665e04@intel.com>
 <40ccd0f0-35a1-5aa7-9e51-25ab196d79e5@linux.intel.com>
 <2ed5c9cc316950a5a47ee714715b7980f358a140.camel@intel.com>
 <ab17102c-0cb7-87d3-3494-969866d64573@linux.intel.com>
 <d53696f85ada39a91a3685c61d177c582810772e.camel@intel.com>
 <d63d2774-c44d-27da-74b6-550935a196fd@intel.com>
 <dca06ffa36abe9989f0a7abaeafc83c1a7250651.camel@intel.com>
 <20220507004236.5p5dyksftge7wwr3@black.fi.intel.com>
 <45d184273f1950320843f6696eb3071f7d354fd3.camel@intel.com>
 <20220509120927.7rg6v5pyc3f4pxsh@box.shutemov.name>
 <75d4755c9a376df2e98a267e10e60da3bd178b17.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <75d4755c9a376df2e98a267e10e60da3bd178b17.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/22 4:54 PM, Kai Huang wrote:
> And I suggested before, we can allocate a default size buffer (i.e. 4 pages),
> which is large enough to cover all requests for now, during driver
> initialization.  This avoids IOCTL time conversion.  We should still have code
> in the IOCTL to check the request buffer size and when it is larger than the
> default, the old should be freed a larger one should be allocated.  But for now
> this code path will never happen.
> 
> Btw above is based on assumption that we don't support concurrent IOCTLs.  This
> version Sathya somehow changed to support concurrent IOCTLs but this was a
> surprise as I thought we somehow agreed we don't need to support this.

Yes. Initially, I did not want to add this support to keep the code
simple. But recent changes (to handle cases like, cleanup the VMM
owned page after user prematurely ends the current request, and to
support VMAP model) already made the code complicated. With current
framework changes, since it is easy to extend the code to support
concurrent GetQuote requests, I have just enabled this support.


> 
> Anyway, now I don't have strong opinion here.  To me alloc_pages() +
> set_memory_decrypted() is also fine (seems AMD is using this anyway).   Will let
> Dave to decide.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
