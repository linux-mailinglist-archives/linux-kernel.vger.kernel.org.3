Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21761580572
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiGYUXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiGYUXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:23:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90C921821
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 13:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658780597; x=1690316597;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+OyZ1HoUFD/UO5aD8rslmTwO77TClgrMNHoQPXCXrrg=;
  b=RdkXNw/xqzMkTw3pCk3Yh9pXRqHMxJ8wYVAkbj6khCILvjQ1dTW6Wqr9
   wRgG3kxQTuBvyjXJ1fjaQ8dMkPRtBWdF+zPGbqevdgz8AKijsaZuH2xsv
   3lB+yaiQMNIVXhyTzJHp5sMa6Z5NYXjcp7XYQsI7CCAEtaobGv1unKeEW
   viVakPEx+iaw2bj863lNKYhnxcuLzHNRwHtrEZOCUb/ajsz9wSYQ4ZBM0
   35EEIqoTQLJ+i2wB+1+fxyIf6Cwd1mi0h5rrbtMGcPPr/Vdj0VO5/z7ma
   E0jg1BzVwzPMJHVXG2CIrR+q3xRkfdE5J6L5JNJTz5pvhsRogDAKmnDJt
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="285337299"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="285337299"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 13:23:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="596793837"
Received: from spaletti-mobl1.amr.corp.intel.com (HELO [10.212.231.21]) ([10.212.231.21])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 13:23:16 -0700
Message-ID: <7c09d15b-40bc-c6a0-3282-a94e9d9c36be@intel.com>
Date:   Mon, 25 Jul 2022 13:23:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 5/5] x86/tdx: Add Quote generation support
Content-Language: en-US
To:     "Nakajima, Jun" <jun.nakajima@intel.com>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Isaku Yamahata <isaku.yamahata@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "tim.gardner@canonical.com" <tim.gardner@canonical.com>,
        "khalid.elmously@canonical.com" <khalid.elmously@canonical.com>,
        "Cox, Philip" <philip.cox@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220609025220.2615197-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220609025220.2615197-6-sathyanarayanan.kuppuswamy@linux.intel.com>
 <403cfccb-7fff-ab0b-8ebd-e5b04e631571@intel.com>
 <20220722190524.GA3299911@ls.amr.corp.intel.com>
 <18578c5a-7a35-ab20-467c-80141b0410a8@intel.com>
 <b8ea1778-02c1-b688-896d-dbb231eddf23@linux.intel.com>
 <4B48A192-8305-4E94-AA0C-10FCE23F424D@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <4B48A192-8305-4E94-AA0C-10FCE23F424D@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/22 13:19, Nakajima, Jun wrote:
> 3. Need to be available in minimal/early runtime environments,
> including pre-boot, e.g. guest BIOS, no user-space yet.

Jun, are we talking about the same thing here?  This patch is for a
guest userspace -> guest kernel ABI.  This facility is *FOR* userspace.
 It can't possibly be used before userspace is running.

I'm horribly confused.
