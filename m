Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5408159ED36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbiHWUPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiHWUOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:14:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5770C6E2EB
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661283404; x=1692819404;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TRX0w6w6k4xHdGhnqgWb1WuGwu0FoTE1WVd+VrdE3AA=;
  b=gFJBy2sPIFOVgcXUw/SHIrvFaZvnbGT0D7WGLECIDL8UW/2VMLqbO9TB
   +jdZhS5wi6oPfP8RK8shw+XiFicCP7BtM0LauqotSdiqsKgHi80JA/b+0
   xYkp7qdgNyunxM3gjs6LWvgOAi1Uoun92F9rdd8s1+h2jaiF0cfp10kiG
   4WXnDXBDIFPiozGPFSSXC1aH8JzoC+MNdL4htN1RipZo1kgE6XxIM0Vh1
   qS3HLapBeeni1TakVh7/yHBFtX1zpSj44WO4Mfjc4+PlHq4srurMSA6zu
   AZPEFJVukl0XOJE8L1Cp0U4BkvpqLPAzQmt7CJQy7/zDZRk/v5Qa0w8WR
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="274168404"
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="274168404"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 12:36:44 -0700
X-IronPort-AV: E=Sophos;i="5.93,258,1654585200"; 
   d="scan'208";a="605770624"
Received: from shyleshu-mobl.amr.corp.intel.com (HELO [10.209.104.113]) ([10.209.104.113])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 12:36:43 -0700
Message-ID: <c8262af7-1552-98e0-fb35-4cf17228b039@linux.intel.com>
Date:   Tue, 23 Aug 2022 12:36:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
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
 <Yv5KNyX992ddvVtD@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Yv5KNyX992ddvVtD@zn.tnic>
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

Hi Boris,

On 8/18/22 7:18 AM, Borislav Petkov wrote:
>> diff --git a/arch/x86/coco/tdx/attest.c b/arch/x86/coco/tdx/attest.c
>> new file mode 100644
>> index 000000000000..46a2f3612753
>> --- /dev/null
>> +++ b/arch/x86/coco/tdx/attest.c
>> @@ -0,0 +1,81 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * attest.c - TDX attestation feature support.
> s/feature //
> 
>> + *
>> + * Implements attestation related IOCTL handlers.
>> + *
>> + * Copyright (C) 2022 Intel Corporation
>> + *
>> + */
>> +
>> +#include <linux/mm.h>
>> +#include <linux/io.h>
>> +#include <asm/tdx.h>
>> +
>> +#include "tdx.h"
>> +
>> +/* TDREPORT module call leaf ID */
>> +#define TDX_GET_REPORT			4
> All TDX leaf definitions go to arch/x86/include/asm/shared/tdx.h, for
> example.
> 
> Not spread around the tree. There are some in arch/x86/coco/tdx/tdx.c
> too.
> 
> In a pre-patch: please pick a fitting header, move them there and keep
> them all there.
> 

In v10 of this patch set, this code is moved to coco/tdx/tdx.c and the module
call leaf IDs are grouped together in tdx.c.

Regarding moving the leaf definition to asm/shared, the following patch from
Kirill's unaccepted memory patch set is already doing it. Do you want to me to
leave it to Kirill to handle the cleanup, or submit a new patch here?

https://lore.kernel.org/linux-mm/20220614120231.48165-13-kirill.shutemov@linux.intel.com/

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
