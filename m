Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3228157D1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbiGUQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiGUQtG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:49:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D42A8812E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 09:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658422146; x=1689958146;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3bbPDMQI859gWFZ/CAYf4oPUAKhL1F/jX/zsW+laJyc=;
  b=alg1LsITR/aruPzXQ3nNqXLPLGvInDhSscy7fHm3Oj2+HtQAJ1bL2QVf
   eNTRlg5z6lioUUGQM3mVI8Q168VmxUIGC7i4TPXlXWkS0iFBuMfbU+Xm2
   IXTIDX2uiAr+6Tbe+6giSa51VxfK/U0fD6IJIcgI0hadch91sMtVSlhJu
   4YmX8MI88/j5tKnhP8Ro4UGoInzEDzgGxzcA9OldsmZxkwi/Pmy029OJO
   he5++AMQ+8QlflCyIa5pXzajBhHMbjTQ5NsN2Y+4trL5ikRw73SwasEdC
   zYn+kwUcSysI+cLgIN+RTtIfhi+co4GEzOl3wp6rTwcNaeRJkLqGWALDi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="285866216"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="285866216"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:49:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573816219"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 09:49:04 -0700
Message-ID: <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
Date:   Thu, 21 Jul 2022 09:49:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
 <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 09:42, Sathyanarayanan Kuppuswamy wrote:
> On 7/21/22 9:08 AM, Dave Hansen wrote:
>> On 6/8/22 19:52, Kuppuswamy Sathyanarayanan wrote:
>>> For shared buffer allocation, alternatives like using the DMA API is
>>> also considered. Although it simpler to use, it is not preferred because
>>> dma_alloc_*() APIs require a valid bus device as argument, which would
>>> need converting the attestation driver into a platform device driver.
>>> This is unnecessary, and since the attestation driver does not do real
>>> DMA, there is no need to use real DMA APIs.
>> Let's actually try to walk through the requirements for the memory
>> allocation here.
>>
>>  1. The guest kernel needs to allocate some guest physical memory
>>     for the attestation data buffer
> Physically contiguous memory.

Remind me how large the quote structures are.

