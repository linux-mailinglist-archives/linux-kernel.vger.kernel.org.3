Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65DA59CB9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiHVWlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiHVWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:41:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD9193F6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661208075; x=1692744075;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=l6AcQXtZoUrGSYmI0Nyks60UXBALKJWo/hybvTs+Bmc=;
  b=LsccqduzhoVfV8Vq6otQzYxnujbOWFMV2kbm9bGyEyKooAQSIlXZsep2
   EhmtAkjQIgLcXWtP3+XEP3mcozKRTjNoK97mVLI1AzaA6W6JVtInAjCrY
   MLjq82roP5XI7b6a5EAqIORAyL0OvnGVEHBQ5iD9iajpJQ9EU6OEMpcqO
   K9d+d+PLetgnzLajzLzUO66GL8cxPq3SHNgQajGt8i56AaZ9ZrU0Zk24B
   UjKstZvwmbN3MG1ug9q2UXnbrX2zOmLbnzj9ym5x7qSJ6lSYnmLLngMxX
   tiCCfeko69J9fvW72lE6u1pXH12iQ8hrkTXt/ms46Mv/MIPwTUTxlznsd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="379827678"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="379827678"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 15:41:02 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="698453395"
Received: from eteeman-mobl1.amr.corp.intel.com (HELO [10.212.253.86]) ([10.212.253.86])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 15:41:01 -0700
Message-ID: <08c5b818-a030-4c97-80f7-52ee42dc1f79@linux.intel.com>
Date:   Mon, 22 Aug 2022 15:41:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org
References: <20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220728034420.648314-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yv5KNyX992ddvVtD@zn.tnic> <20abfa00-b70c-f151-9ee4-5668f09f4ace@intel.com>
 <YwP27a6/9Yq8LBM3@zn.tnic> <be080a46-e6c2-995b-9064-a8506c38bef8@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <be080a46-e6c2-995b-9064-a8506c38bef8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/22/22 2:44 PM, Dave Hansen wrote:
> On 8/22/22 14:36, Borislav Petkov wrote:
>> Which makes my initial suggestion of calling this whole guest
>> functionality a "tdx" driver not such a bad idea... Depends on
>> whether there will be a split at all or it'll continue gaining more
>> functionality.
> 
> Yep, let's get the crystal ball out.
> 
> TDX folks:
> 
> What other ioctl()s are in the pipeline for the guest side?

In addition to the GetReport support currently implemented, we have
following two attestation related IOCTLs in the pipeline.

1. GetQuote     - Adds support to get signed Quote for the given TDREPORT. This
                  is currently in the review process.
2. VerifyReport - Verifies whether given Reportdata is generated in
                  the current platform. It is only enabled in v1.5 TDX
                  Module specification.

In addition to above, I think there is a possibility to add IOCTL to get
storage keys from the ACPI SVKL table. Storage Volume Key Table (SVKL) is
used by the VBIOS to share keys required to access encrypted drives. Although
we don't have a clear requirement, I suspect that we might add IOCTL for it.

Kirill/Isaku/Kai, If I missed any other IOCTL requirements, please add it.
              
> 
> What ioctl()s are in the pipeline for the host side?  Are they all part
> of /dev/kvm, or are there any TDX-specific "drivers" for the host?
> 
> We want to avoid both:
> 
>  1. A driver called /dev/tdx (or "tdx-guest) which is only and will only
>     ever do TDX guest attestation.

>  2. A driver called /dev/tdx-guest-attest which shares a ton of
>     functionality with some future TDX guest feature like
>     /dev/tdx-guest-snazzy-feature-foo.  Then, a new driver every time
>     a new snazzy TDX feature shows up.

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
