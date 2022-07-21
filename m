Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2697957D278
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiGUR2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGUR2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:28:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBA489EAF
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658424494; x=1689960494;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=C7OM+7gmEvFiG7txHrhKLL6FE+AyPkqqZ7WvQWwgEQE=;
  b=K/PiTF2dtDxE/2ORKp063ZAcnBFck+2oi9tPvICxTcLlhW8kwineTDSC
   vtTiYFJH5qyFqpEni3L2xFZPp4Glhg73PK226pmvJl5rpt6y/Yg9jnJdf
   KZywwUVAbpBROBKgB2E62eVStndBHArbosHkOlp/Wit5HMv1Him62Y//m
   s+u111LPen4LYDGujtsqTJ7+hTpy47XDA+za7nj5RAYflmtpJqhU171sK
   VLJmuELtjZdgvux50MIcHpptUHgDgHEZq1YDD+m8/3tRRK7Q5X+3JTJAP
   JfKPg5hSvb8nkbYw4dR1knSZRM9DBw2vbkYWVPGbuDq2dO+4pDGbtcwWr
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="270156891"
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="270156891"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 10:19:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,183,1654585200"; 
   d="scan'208";a="573830939"
Received: from vasantgx-mobl.amr.corp.intel.com (HELO [10.212.244.191]) ([10.212.244.191])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 10:19:30 -0700
Message-ID: <fb9cbec5-6f64-4647-3bc2-30f07a0b6b59@intel.com>
Date:   Thu, 21 Jul 2022 10:19:30 -0700
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
 <214e24f0-5236-be8d-024a-da48737d854a@intel.com>
 <e280aaf4-57da-6453-c31c-6996dc85219c@linux.intel.com>
 <a65473db-b307-c076-6d2f-8f2084d81eb5@intel.com>
 <b8af932e-13da-ddcd-4ecb-bd8369853242@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <b8af932e-13da-ddcd-4ecb-bd8369853242@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/22 10:16, Sathyanarayanan Kuppuswamy wrote:
>> What is this "additional data"?  Is that "REPORTDATA" from the TDX
>> module spec?
>>
>> 	"Additional REPORTDATA, a 64-byte value, is provided by the
>> 	guest TD to be included in the TDG.MR.REPORT."
> 
> It is not the REPORTDATA. REPORTDATA is already included in the TDREPORT during
> REPORT generation process (using TDG.MR.REPORT).
> 
> Spec does not clearly define the details about the additional data. I think it is
> related to certificates.
> 
> Isaku, do you have more details about it?
> 
> Current ABI allows attestation service and agent to decide the quote size. So
> we can't make assumptions on what that size will be.
> 
> Following is copied from TDX Module specification, sec titled "Measurement
> and Attestation"
> 
> An Intel SGX Quoting Enclave, written specifically to support quoting Intel TDX TDs,
> uses a new ENCLU instruction leaf, EVERIFYREPORT2, to help check the integrity of the
> TDG.MR.REPORT. If it passes, the Quoting Enclave can use a certified quote signing key
> to sign a quote containing the guest TD’s measurements and the additional data being
> quoted.

<sigh> We're off in the weeds again.

How many bytes does the TDX module read from and write to the guest
physical address space?  What are the absolute limits?  What is the
minimum and the maximum that the kernel needs to handle?
