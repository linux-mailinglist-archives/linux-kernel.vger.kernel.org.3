Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600FD51F82F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiEIJdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiEIJOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:14:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4229C15E495
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652087424; x=1683623424;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+9I3M3M149O5m/K/6SP4VV21MJHrSVn8FFuRfBVfwVo=;
  b=KA+BaYhdgKSc/iGDbYKn/CiralU1wwc/rfG0pkssNYEEnWHxQnIXLpR1
   trtTMyMgH0Gkw9e9xrMY5jHwaO644AkHuC0Hb14LMn3bChoYJjPY81b84
   ZLxP6t5dnGIDmrWUS6eBaod5rwdDi/Fc3jnAHS1MdzPUbEdIHBE8StmcN
   BftPNKEcjpEB/H5A9xchqifeS2x4PjUVJNCv9+66DMjVQiBkHsVPRGjfq
   47+ev3Xsf3or8vzQTPm4N5ZSkbHvNVtJwY1wZlAosSPe1Rv7WvuOUk0c+
   c1HTaWmAdXLinsfKxpn6MsWGE1w5EzzM6i+EH4/5MOhtsJDRNmYM9gGCX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="266580840"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="266580840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 02:10:24 -0700
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="668908606"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.170.55]) ([10.249.170.55])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 02:10:22 -0700
Subject: Re: [kbuild-all] Re: [PATCH] fs/ufs: Replace kmap() with
 kmap_local_page()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org
References: <20220508200755.24586-1-fmdefrancesco@gmail.com>
 <202205090835.NEUQ3VKB-lkp@intel.com> <4710227.GXAFRqVoOG@leap>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <b46bf8e8-9901-1026-2abf-ae7af163c7ad@intel.com>
Date:   Mon, 9 May 2022 17:10:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <4710227.GXAFRqVoOG@leap>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/2022 2:14 PM, Fabio M. De Francesco wrote:
> On lunedì 9 maggio 2022 02:25:00 CEST kernel test robot wrote:
>> Hi "Fabio,
>>

Hi Fabio,

Here is a note:

>>
>> Note: the below error/warnings can be found in parent commit:
>> << WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in
> reference from the function rtc_update_irq() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in
> reference from the function rproc_exit_sysfs() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in
> reference from the variable .L0 to the variable .debug_str:.LASF1567
>> << WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in
> reference from the function rtc_get_dev_attribute_groups() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in
> reference from the function ir_raw_get_allowed_protocols() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in
> reference from the function ir_raw_event_prepare() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in
> reference from the function ir_raw_event_free() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in
> reference from the function ir_raw_event_unregister() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in
> reference from the function btintel_enter_mfg() to the variable
> .init.text:.LBB19521
>> << WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in
> reference from the function rtc_update_irq() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in
> reference from the function rproc_exit_sysfs() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in
> reference from the variable .L0 to the variable .debug_str:.LASF1567
>> << WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in
> reference from the function rtc_get_dev_attribute_groups() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in
> reference from the function ir_raw_get_allowed_protocols() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in
> reference from the function ir_raw_event_prepare() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in
> reference from the function ir_raw_event_free() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in
> reference from the function ir_raw_event_unregister() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in
> reference from the function btintel_enter_mfg() to the variable
> .init.text:.LBB19521
>> << WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in
> reference from the function rtc_update_irq() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in
> reference from the function rproc_exit_sysfs() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in
> reference from the variable .L0 to the variable .debug_str:.LASF1567
>> << WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in
> reference from the function rtc_get_dev_attribute_groups() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in
> reference from the function ir_raw_get_allowed_protocols() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in
> reference from the function ir_raw_event_prepare() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in
> reference from the function ir_raw_event_free() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in
> reference from the function ir_raw_event_unregister() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in
> reference from the function btintel_enter_mfg() to the variable
> .init.text:.LBB19521
>> << WARNING: modpost: vmlinux.o(.text+0xa76d10): Section mismatch in
> reference from the function rtc_update_irq() to the variable .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.exit.text+0x9b48): Section mismatch in
> reference from the function rproc_exit_sysfs() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(__ex_table+0x141c): Section mismatch in
> reference from the variable .L0 to the variable .debug_str:.LASF1567
>> << WARNING: modpost: vmlinux.o(.text+0xa7839c): Section mismatch in
> reference from the function rtc_get_dev_attribute_groups() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2676): Section mismatch in
> reference from the function ir_raw_get_allowed_protocols() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2cb8): Section mismatch in
> reference from the function ir_raw_event_prepare() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2e16): Section mismatch in
> reference from the function ir_raw_event_free() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xae2e3a): Section mismatch in
> reference from the function ir_raw_event_unregister() to the variable
> .init.text:.L0
>> << WARNING: modpost: vmlinux.o(.text+0xb35172): Section mismatch in
> reference from the function btintel_enter_mfg() to the variable
> .init.text:.LBB19521
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
>>
> I cannot understand this report. All the functions listed here seem to have
> nothing to do with my patch. Can anyone explain how these errors are
> related to my changes?
> 
> Thanks,
> 
> Fabio
> 
> 


Please ignore this report, a lot of similar warnings can be found in 
parent commit.

Best Regards,
Rong Chen

