Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF65A57D34E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiGUSbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiGUSbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:31:11 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E672559A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658428270; x=1689964270;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W4/tIIdtERhphnO7fWOgUzVvIqF1v4fyTEzDJ1w8bGc=;
  b=H0igRBmaPEMArSCdvZSun+cmgb0jfQ1tayWIHeGU1rP0fOusfY2L44XO
   ZF5XGmVz2dhSeo5AeXqEW7xCeO14Xw5G764Yee5fT/MeoCddjPVJqCA0u
   /UZvr9oIDPDF9qEA0eFTC2RCV2A3N6yiltpobbU2Ug2EsYGAY0Wq1xpgq
   RstQjzUXB22J44RGOxbMF3x7yZBzthy9HieHQATr/IRH8giL5T3WgfDip
   Ev4dZJHnfzjO57TFe2sI8E82L16Y82/7E9pStYqmnPNvE3dEoI9/I3zDe
   /9qKnia1aitlh2rKedLPwSSB+hwKoAY5NqAFCzIDTCY1favaljAbZsybF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="284697925"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="284697925"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 11:31:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="598574968"
Received: from sattaran-mobl1.amr.corp.intel.com (HELO [10.212.246.186]) ([10.212.246.186])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 11:31:10 -0700
Message-ID: <9a85546c-954d-446d-28d5-8a88be5a1ce3@linux.intel.com>
Date:   Thu, 21 Jul 2022 11:31:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
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
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <d3808510-9974-258e-0c7b-9a76e0868d48@intel.com>
 <f043d9f5-8f89-4ef3-2ce1-75665122bb3a@linux.intel.com>
 <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
 <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
 <a65473db-b307-c076-6d2f-8f2084d81eb5@intel.com>
 <b8af932e-13da-ddcd-4ecb-bd8369853242@linux.intel.com>
 <fb9cbec5-6f64-4647-3bc2-30f07a0b6b59@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <fb9cbec5-6f64-4647-3bc2-30f07a0b6b59@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 7/21/22 10:19 AM, Dave Hansen wrote:
> How many bytes does the TDX module read from and write to the guest
> physical address space?  What are the absolute limits?  What is the
> minimum and the maximum that the kernel needs to handle?

Minimum is 1K (equal to TDREPORT size, on input Quoting Enclave reads 1K TDREPORT
data from GPA)

Maximum size is not defined in the spec. I think for future compatibility, spec
does not limit the quote size. For most cases, I think 8K should be big enough.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
