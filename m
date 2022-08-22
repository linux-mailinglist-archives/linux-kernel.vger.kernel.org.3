Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A161E59CAB2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237941AbiHVVTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbiHVVTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:19:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1019250719
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661203187; x=1692739187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bfYeALJ9XMZ1f/RIz9Wkxnk0R94HbBWs7O8zuYk+pDI=;
  b=S9d4BMs6l5keFOp+JZNAeAvKGfwZlC2+33WBnf0fQjv6FDpAZJpVvVXp
   gQ45Y3JHUaIUdVL0Ss01E9F3fIF6WSQF9ULcTyDcjE9t7ZG1tsVVXUFvG
   i9nBfV+IUlmKkV5HX8Ce4opOCRBjL54DX45nzN45MiAO+KKX+9HceXphZ
   hfIAS6S3uNIVfmMFPypAfaaX+v99Dz2GDY840MaQaxIq9Nfux+0zHrE+9
   x+kFgWJ9bhM1ewsBWW/LUjuXmdYtOmgd7PobX2D9SIgHo/jJOHFOxbbH7
   6gmSJSdFSjPWkXCh86jPm8oAQX1erAsahFIJPH9P44TELy92ExLSu+qDk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="294311362"
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="294311362"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:19:46 -0700
X-IronPort-AV: E=Sophos;i="5.93,255,1654585200"; 
   d="scan'208";a="751436370"
Received: from sraksht-mobl.amr.corp.intel.com (HELO [10.212.204.203]) ([10.212.204.203])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 14:19:45 -0700
Message-ID: <20abfa00-b70c-f151-9ee4-5668f09f4ace@intel.com>
Date:   Mon, 22 Aug 2022 14:19:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v9 1/6] x86/tdx: Add TDX Guest attestation interface
 driver
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Yv5KNyX992ddvVtD@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/22 07:18, Borislav Petkov wrote:
>>  /* TDX module Call Leaf IDs */
>>  #define TDX_GET_INFO			1
>>  #define TDX_GET_VEINFO			3
>> @@ -34,6 +39,10 @@
>>  #define VE_GET_PORT_NUM(e)	((e) >> 16)
>>  #define VE_IS_IO_STRING(e)	((e) & BIT(4))
>>  
>> +#define DRIVER_NAME	"tdx-guest"
> Just "tdx". When you add another driver, then you can disambiguate.

This actually shows up to apps, though.  They'll actually be opening
/dev/tdx.  When the other driver comes along, they'll all need to change
to /dev/tdx-guest.  That seems a bit unkind to those poor app developers.

BTW, do we consider these kernel names be part of the ABI?  Seems like
we should.

