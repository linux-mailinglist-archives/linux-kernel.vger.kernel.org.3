Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B50655E785
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbiF1Psj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347960AbiF1Pr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:47:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945937A03;
        Tue, 28 Jun 2022 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656431246; x=1687967246;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZsLTlpPVTkp+QEt+1Ek5ZOFyD2hxJXmK6Jry4VmCBfo=;
  b=CnUGHsjFBEmWBGGPiAolbfJEqSP+C6I+16ubdgOwmv06nOi5Yje0xh7r
   o5GnFyxnLx0A91HDRx46ol7inZeSg3bvO6dJACKDzoiH21Rwh5S6vE6iq
   gE5tiUotj8OoC2ncAKSJPVNsviaDbwFTDxu8dz1S7KbuHi1YPUwFC1xVc
   +uho9Q4V0P2vJNcCP5U0+LRZOeZA6Q77gkhCA7Lb/H3I3jg62KOI8hvcy
   IXR+llGsxh3IwJOf18JBdbb9YvL2j7EtNIuUHQ7I/faXyjfZZViG6Qd6A
   uSOsvAv9h4//aTDc1pbyTY2yV2q++wuNPlgBXCzfM1632IYanPotUYhpV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="264817913"
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="264817913"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 08:47:18 -0700
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="587910883"
Received: from staibmic-mobl1.amr.corp.intel.com (HELO [10.209.67.166]) ([10.209.67.166])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 08:47:18 -0700
Message-ID: <086370dd-281f-5ac6-3a0f-f1b80500c668@intel.com>
Date:   Tue, 28 Jun 2022 08:46:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and
 x86
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com>
 <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com>
 <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
 <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 02:36, Linus Walleij wrote:
> The right way to solve this is to make the Linux kernel contain the
> necessary heuristics to identify which tasks and thus cores need this
> to improve efficiency and then apply it automatically.

I agree in theory.  But, I also want a pony in theory.

Any suggestions for how to do this in the real world?

Otherwise, I'm inclined to say that this series incrementally makes
things better in the real world by at least moving folks away from wrmsr(1).
