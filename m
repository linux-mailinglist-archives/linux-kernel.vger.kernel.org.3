Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3664EDFC8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231195AbiCaRjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiCaRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:39:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EC261A0E;
        Thu, 31 Mar 2022 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648748251; x=1680284251;
  h=message-id:date:mime-version:to:cc:references:from:
   subject:in-reply-to:content-transfer-encoding;
  bh=OsbB4CS85V6dvivII4TLydK8t8h1zg+NqSPoaAXzN/k=;
  b=IL2geJTG1Pl97AstLEgW1BmtSXUMJjTox3qO7mEtMiJN1SR2rBGsaTRi
   jffuXftVpNNXrHjkSu7eUXKH6OryQR6iJYUPURXvsOwiYk4VzlBpxT1bg
   3oykMWb5o1mFSpwIETh95pvdAYtQ+kL2rhgu460ircd6EjgqfKduI0xPi
   KDC1aSZwmC4fvTGUVobCPyeG6L6GfUReFDLXiybctHLf5NpecgpHqf8le
   DyuyB9rd6zDhycv1NFlfwxChVhdJ5/teck5HE2Vnjrl/q1aL8Xf/7jX3O
   E598KbKg0TxEaMX68wAOa3aoSJRpQFk5+d4z06GWyxd+m6Bh8X7Gb3nbM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258738348"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="258738348"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:37:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="586521739"
Received: from ticela-or-095.amr.corp.intel.com (HELO [10.251.17.146]) ([10.251.17.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:37:31 -0700
Message-ID: <2444feb5-3c61-3d90-c57a-84c40849cd67@intel.com>
Date:   Thu, 31 Mar 2022 10:37:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-doc@vger.kernel.org
References: <20220314183552.1446911-1-dave.hansen@linux.intel.com>
 <YkWgv1yBGtcAbPVj@zn.tnic>
From:   Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] [RFC] Documentation/process: Add testing section to tip
 handbook
In-Reply-To: <YkWgv1yBGtcAbPVj@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/22 05:38, Borislav Petkov wrote:
>> +Code should be tested before submitting to the tip maintainers.  Anything
>> +other than minor changes should be built, booted and tested with the
>> +following set of comprehensive (and heavyweight) set of kernel debugging
>> +options enabled.
>> +
>> +	CONFIG_X86_DEBUG_FPU=y
>> +	CONFIG_LOCK_STAT=y
...
> It would be cool if there were a command I can run so that I can enable
> all those. Example:
> 
> $ grep CONFIG_VMLINUX_VALIDATION .config
> $ ./scripts/config --enable CONFIG_VMLINUX_VALIDATION
> $ grep CONFIG_VMLINUX_VALIDATION .config
> CONFIG_VMLINUX_VALIDATION=y
> $ make oldconfig
> #
> # configuration written to .config
> #
> $ grep CONFIG_VMLINUX_VALIDATION .config
> $
> 
> Needs other options.
> 
> Maybe you could create a .config snippet which we can merge
> with scripts/kconfig/merge_config.sh... or maybe start from
> arch/x86/configs/x86_64_defconfig, add all those and call it
> 
> arch/x86/configs/x86_64_testconfig

Well, after some digging around it turns out that we're not the first
ones with this problem.  Just throwing those options into:

	kernel/configs/x86_debug.config

and doing:

	make x86_debug.config

will magically do:

	Using .config as base
	Merging /home/davehans/linux.git/kernel/configs/x86_debug.config
	#
	# merged configuration written to .config (needs make)
	...

Who knew?  I'll move the options and send another patch.
