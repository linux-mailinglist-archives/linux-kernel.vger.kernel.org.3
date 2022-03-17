Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3773B4DCF3C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiCQUYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiCQUYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:24:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942191459A3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647548601; x=1679084601;
  h=message-id:date:mime-version:from:to:cc:references:
   subject:in-reply-to:content-transfer-encoding;
  bh=oZJ4KFDXQV7ySk5DGdry86aL5ZaJLmcTxOI6m7btcbY=;
  b=gqGYnfCQr5R8cvbpc2ophXSMA3KQ8VxfwQ6jg11t322r+sWVbOS6MlHN
   Q3DaN1SnPoDhkbnsCTmeRGtCbVizHFnCh4GAsuJNSDr8z40QQizRYRnkv
   wA03Emxm6OvXBEjA6rPOzOKipjfKb9r7g/Nf5yQqo64dcR7CAPTe3gk7r
   AnfjxzVXAC8G4bF67yl7uYmlMC26DHGU0hVb3yqernQftdyJ8cNusnZx9
   xlwHGBOboWgigDth8sqoEYLzXXv07ilL63Ew7EDySiFNXe/O4YAW8JMOj
   mDgdizHijYHK/WlFRUlNvuDUVgcSFV233atsgKq60gxn+IMpHOGj1sdtQ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="254531026"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="254531026"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:23:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="516912256"
Received: from dstanfie-mobl2.amr.corp.intel.com (HELO [10.212.178.19]) ([10.212.178.19])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:23:18 -0700
Message-ID: <2b91abe5-88bd-2941-d561-a8b0ad40f62b@intel.com>
Date:   Thu, 17 Mar 2022 13:23:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   Dave Hansen <dave.hansen@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     mingo@redhat.com, bp@alien8.de, luto@kernel.org,
        peterz@infradead.org, sathyanarayanan.kuppuswamy@linux.intel.com,
        aarcange@redhat.com, ak@linux.intel.com, dan.j.williams@intel.com,
        david@redhat.com, hpa@zytor.com, jgross@suse.com,
        jmattson@google.com, joro@8bytes.org, jpoimboe@redhat.com,
        knsathya@kernel.org, pbonzini@redhat.com, sdeep@vmware.com,
        seanjc@google.com, tony.luck@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, thomas.lendacky@amd.com,
        brijesh.singh@amd.com, x86@kernel.org, linux-kernel@vger.kernel.org
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-16-kirill.shutemov@linux.intel.com>
 <87czik22wk.ffs@tglx> <20220317201054.5wdykfru5hhvukvd@black.fi.intel.com>
 <c3b640aa-05a1-7706-0c0f-b3f75eee58c6@intel.com>
Subject: Re: [PATCHv6 15/30] x86/boot: Port I/O: allow to hook up alternative
 helpers
In-Reply-To: <c3b640aa-05a1-7706-0c0f-b3f75eee58c6@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/22 13:20, Dave Hansen wrote:
> You keep the preprocessor away from things like
> 
> 	foo.inb = bar;
> 
> with:
> 
> 	#define inb(x) pio_ops.inb(x)

... and I spotted my nonsense just as I hit send.

You could do that ^^.  But you'd need to rename the 'inb' op  like:

struct port_io_ops {
	u8 (*f_inb)(u16 port);
	...
};

so that you do:

	#define inb(x) pio_ops.f_inb(x)

But, remember when I said I hate playing #define tricks? ;)  This is one
reason why.
