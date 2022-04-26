Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98A450F92D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 11:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345121AbiDZJsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244600AbiDZJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 05:46:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320E31E2718;
        Tue, 26 Apr 2022 02:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650963688; x=1682499688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+xZRHKcwhDmc5PGtGEj5nPEl6roQ+b341vPY2YfKU2U=;
  b=SVoqDI7aAl5XAVIVJvLdG49kgsU+95EuvFv11mJ7CeTDv8h8IzVg7uBt
   u4hWlsmkbZTq6GUApBERZtmyl58CEoqZTmaHwEkRl3kUcykKKV4ezwiPQ
   Y4j8eg59uiJC1/RTS10s6dqPEp0ujnptQm4R/gQ42WhfEGYnfLkGISBpr
   n32qA58Aa72jc6ueBneyKIRjZkvxmhpwPfw/v2Ci/CT1aIsHsqkCWpGLJ
   C0x6Q8kZgJPMP+ciV1FppV71ukVma83919zMStuJby6Sux4fWw87CfV1Y
   znWvnCzEI35oi5VCpI8JaIY3Y+siZqKkUT+0zfRJN6C5ifSvX93tOxC69
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="325995802"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="325995802"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:01:17 -0700
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="579780567"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.209]) ([10.99.241.209])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 02:01:01 -0700
Message-ID: <263f190b-b618-4f88-2965-551af939652a@linux.intel.com>
Date:   Tue, 26 Apr 2022 11:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220426183044.4f72059b@canb.auug.org.au>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220426183044.4f72059b@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/2022 10:30 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> sound/soc/soc-acpi.c:34:1: error: redefinition of 'snd_soc_acpi_find_machine'
>     34 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>        | ^~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/soc-acpi.c:9:
> include/sound/soc-acpi.h:38:1: note: previous definition of 'snd_soc_acpi_find_machine' with type 'struct snd_soc_acpi_mach *(struct snd_soc_acpi_mach *)'
>     38 | snd_soc_acpi_find_machine(struct snd_soc_acpi_mach *machines)
>        | ^~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/soc-acpi.c: In function 'snd_soc_acpi_find_package':
> sound/soc/soc-acpi.c:58:36: error: implicit declaration of function 'acpi_fetch_acpi_dev'; did you mean 'device_match_acpi_dev'? [-Werror=implicit-function-declaration]
>     58 |         struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
>        |                                    ^~~~~~~~~~~~~~~~~~~
>        |                                    device_match_acpi_dev
> sound/soc/soc-acpi.c:58:36: error: initialization of 'struct acpi_device *' from 'int' makes pointer from integer without a cast [-Werror=int-conversion]
> sound/soc/soc-acpi.c:64:25: error: invalid use of undefined type 'struct acpi_device'
>     64 |         if (adev && adev->status.present && adev->status.functional) {
>        |                         ^~
> sound/soc/soc-acpi.c:64:49: error: invalid use of undefined type 'struct acpi_device'
>     64 |         if (adev && adev->status.present && adev->status.functional) {
>        |                                                 ^~
> sound/soc/soc-acpi.c:80:26: error: implicit declaration of function 'acpi_extract_package' [-Werror=implicit-function-declaration]
>     80 |                 status = acpi_extract_package(myobj,
>        |                          ^~~~~~~~~~~~~~~~~~~~
> sound/soc/soc-acpi.c: At top level:
> sound/soc/soc-acpi.c:95:6: error: redefinition of 'snd_soc_acpi_find_package_from_hid'
>     95 | bool snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>        |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/soc-acpi.c:9:
> include/sound/soc-acpi.h:44:1: note: previous definition of 'snd_soc_acpi_find_package_from_hid' with type 'bool(const u8 *, struct snd_soc_acpi_package_context *)' {aka '_Bool(const unsigned char *, struct snd_soc_acpi_package_context *)'}
>     44 | snd_soc_acpi_find_package_from_hid(const u8 hid[ACPI_ID_LEN],
>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> sound/soc/soc-acpi.c:109:27: error: redefinition of 'snd_soc_acpi_codec_list'
>    109 | struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>        |                           ^~~~~~~~~~~~~~~~~~~~~~~
> In file included from sound/soc/soc-acpi.c:9:
> include/sound/soc-acpi.h:51:41: note: previous definition of 'snd_soc_acpi_codec_list' with type 'struct snd_soc_acpi_mach *(void *)'
>     51 | static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
>        |                                         ^~~~~~~~~~~~~~~~~~~~~~~
> 
> Caused by commit
> 
>    47a1886a610a ("ASoC: Intel: avs: Enable AVS driver only on x86 platforms")
> 
> I have applied the following patch for today:
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Tue, 26 Apr 2022 18:01:06 +1000
> Subject: [PATCH] partial revert of "ASoC: Intel: avs: Enable AVS driver only on x86 platforms"
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>   sound/soc/intel/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index be42c4eff165..b0b46deb25c6 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -211,7 +211,7 @@ config SND_SOC_INTEL_KEEMBAY
>   
>   config SND_SOC_INTEL_AVS
>   	tristate "Intel AVS driver"
> -	depends on (X86 && ACPI) || COMPILE_TEST
> +	depends on (X86 && ACPI)
>   	depends on PCI
>   	depends on COMMON_CLK
>   	select SND_SOC_ACPI

Well, I'm surprised, as there are 2 other drivers that have
depends on ACPI || COMPILE_TEST...

I guess it is ultimately caused by
  select SND_SOC_ACPI
as failure is in sound/soc/soc-acpi.c file.

I guess SND_SOC_ACPI could depend on ACPI explicitly, to make sure there 
is no weird dependency issues?

On the other hand I guess we can just leave X86 with COMPILE_TEST and 
move ACPI to depends on, without COMPILE_TEST.

Mark, what do you think?
