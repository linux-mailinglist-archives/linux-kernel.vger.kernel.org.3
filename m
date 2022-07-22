Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A64157E718
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 21:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbiGVTNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 15:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiGVTNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 15:13:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E898E6D3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 12:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658517222; x=1690053222;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YoJQ8g3alU7LX3m6yJN6hMCGycY7i0kWZrAaTQOKp5I=;
  b=ZyF/9NosOSo5Se8zTWt9L2nrNOoWjnt8q/yuv9Cq46McO7UwKmyO6sAT
   0oFAC3u0PeNmfJ5+vYBFoJceWmJjq8y9+xId0Lmj48ZlwBGyEMD2N4DVd
   3UoaEWlGWL80hYOI3jwkbDnKVLUPy2kFI4jYPK36ExWzgxmYGOlPlCfnE
   8xx6jhoMsJ5vPRT8MzVYnr97i/K0h0uH2UlWF3O2RlDy+DbEE9bZQKFtS
   G+W0Re+edhTip8vjHgOVSPQR+hEacfhLrm3uv4MPvwO8TAlDrNpsFCxfd
   gJ9PO9Bjaxr7VaDqVdapaNhJ9ZFh78fRRvHpsUFlHu6HX7b5j9p2EvqCW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="349088845"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="349088845"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 12:13:25 -0700
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="926157886"
Received: from jnoah-mobl.amr.corp.intel.com (HELO [10.209.71.211]) ([10.209.71.211])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 12:13:24 -0700
Message-ID: <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
Date:   Fri, 22 Jul 2022 12:13:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
        linux-kernel@vger.kernel.org
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
 <20220722190524.GA3299911@ls.amr.corp.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220722190524.GA3299911@ls.amr.corp.intel.com>
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

On 7/22/22 12:05, Isaku Yamahata wrote:
>> So, the quote portion of this is basically a bidirectional blob sender.
>>  It's to send a blob between guest userspace to host userspace.
>>
>> Do we *REALLY* need specific driver functionality for this?  For
>> instance, is there no existing virtio device that can send blobs back
>> and forth?
> It's virtio-vsock.  If virtio-vsock is available, the communication works.
> However, some users would like to disable virtio-vsock on their environment for
> some reasons.  Even virtio at all.  Especially for confidential computing use
> case.  It's their choice.  It can't be assumed that virtio is available.
> 
> The goal is VMM-agnostic (but TDX-specific) interface for that.

You're basically saying that every confidential computing technology
should have its own host user <-> guest kernel <-> guest user ABI.
That's insanity.  If we do this, we need *one* interface that says "talk
to the hypervisor" that's common for all hypervisors and hardware
vendors, or at least more than *one*.

We don't need a way to talk to hypervisors for Intel systems and another
for AMD and yet another on whatever.
