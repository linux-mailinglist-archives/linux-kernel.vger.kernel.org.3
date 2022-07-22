Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F179157E8DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 23:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiGVVYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 17:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbiGVVYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 17:24:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DCCCB5572
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658525076; x=1690061076;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BFyrrU4JpvFwOwtflDL2hKyk+SUGMV4TsEEfCWSIYH8=;
  b=T67qFuWdMYX7EYwX2zQ3+7U32nn29qRIC0cRRrxft/sYCKvVh1Kdecx/
   viLfcmm02Ho6ajAV4SE8fQyLZ1Etj2GibDZUtsYqqj5G4mgga56dF7WQt
   29Zn+vaP+3PchLoOj8i+wG+Gtn4cPVjXcncArz2A/Dv8g/Bqw20g+T4uA
   BjFqjXuiesob7Hjob5iTwTzjH7obGNVo+xv+j+zg9ElH/JFC5MXmpVm5l
   YRSwbtZkmDBmSFQlAF2yqpH+f6yGX+J93UQo1nPxBmHIZps3pTbz7giDH
   cHG87mv/PmDhbWWP+Fa0CT5q+oCPVDEiWWj9LVDmWMh5T8H4EC5J5cPU6
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="270444439"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="270444439"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 14:24:35 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="657367220"
Received: from suprajva-mobl1.amr.corp.intel.com (HELO [10.212.247.119]) ([10.212.247.119])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 14:24:34 -0700
Message-ID: <30220ec4-d35f-4a8a-4c08-959765ea6f26@intel.com>
Date:   Fri, 22 Jul 2022 14:24:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org,
        "Nakajima, Jun" <jun.nakajima@intel.com>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
 <20220722190524.GA3299911@ls.amr.corp.intel.com>
 <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
 <b8ea1778-02c1-b688-896d-dbb231eddf23@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <b8ea1778-02c1-b688-896d-dbb231eddf23@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/22 14:18, Sathyanarayanan Kuppuswamy wrote:
> For cases where your platform does not want to support or enable the generic
> interface (like vsock), isn't it better to have a fallback approach? I am not
> saying we should have such an ABI for all cases. But attestation is a must-have
> feature for the TDX guest, and we want to support it in all TD guest platforms.
> I think the GHCI ABI is added to meet this requirement.

This logic is basically: it's in the spec so it must be useful.  I don't
buy that, sorry.
