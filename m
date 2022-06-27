Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF1A55C534
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236883AbiF0OvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236581AbiF0OvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:51:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A52313F35
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656341471; x=1687877471;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=VtougEc3mlk0hUQBZinkWUtl+r/5WCfOEaLzQStDcdk=;
  b=PbDorxA3U6bLA484DIKzLt+LJmYLP3EkyjDhYsdMZUeZ5PKAUADd1cD0
   0DRuNBfvvHnZR6MQonHrwDdPbqx7qyOidN66U8wCAaVh6HncmqzoPwC6/
   TuMYJPJFl3aPyzYcPyHhoJjKaiqIWnCASsWZwXtzCJM9sdXqNkBenuDJI
   Dre+rtL9szAJmRFgDm8HVmxB8W7M4X485LtRRF+XotZt5N8mCVYvyZKKX
   GW/28ES8XBhzmXFmE7Vq0czTosOi9hoTY2VgPHFmdJyovh00Sh0trOaBV
   /zFDa+53RkdzHq0jR0F1vCdPjamo4XyC8OdRtwqyuLfW8u6UEYeDczdOa
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10390"; a="282556405"
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="282556405"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 07:51:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="679606458"
Received: from noraberg-mobl1.amr.corp.intel.com (HELO [10.209.14.29]) ([10.209.14.29])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 07:51:09 -0700
Message-ID: <2502d21b-8f27-ebe5-b677-4cc56b03ee2c@linux.intel.com>
Date:   Mon, 27 Jun 2022 07:51:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v8 0/5] Add TDX Guest Attestation support
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <9abde78c-d2c5-c762-24fe-f26669b7cc6c@intel.com>
Content-Language: en-US
In-Reply-To: <9abde78c-d2c5-c762-24fe-f26669b7cc6c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/24/22 11:24 AM, Dave Hansen wrote:
> On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
>> Following patches add the attestation support to TDX guest which
>> includes attestation user interface driver and related hypercall support.
> 
> This is also the place where you lay out the roadmap:
> 
> 	1. Get a report
> 	2. Get a quote
> 	 2a. Interrupt support because quotes take a long time
> 	 2b. Actual quote module calls and ABI
> 
> Right?  That seems worth a few sentences in the cover letter.

Ok. I will update the cover letter with brief introduction to
changes involved.

How about following?

In TDX guest, attestation process generally involves the following steps:

1. Get the TDREPORT using user specified REPORTDATA. This is implemented
   using TDG.MR.TDREPORT Module call. An IOCTL interface is added to let
   userspace get the TDREPORT data  (implemented in patch #1).
   
2. Using the TDREPORT data, generate a remotely verifiable signed Quote.
   Quote can be generated either using GetQuote hypercall or by communicating
   with VMM/Quoting Enclave(QE) using VSOCK. In this patch set, only the
   GetQuote hypercall model is supported. Since Quote generation is an
   asynchronous request, and takes more time, we let VMM notify the TDX Guest
   using the callback interrupt. Patch # 2-5 implements Quote generation support,
   in which Patch # 2 implements the callback interrupt support.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
