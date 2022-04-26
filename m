Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40F950FB64
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349276AbiDZKu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbiDZKtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:49:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F21147;
        Tue, 26 Apr 2022 03:45:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 403F86173A;
        Tue, 26 Apr 2022 10:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2258C385A0;
        Tue, 26 Apr 2022 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650969943;
        bh=6gWdf0sx4XE9f8S+pDU7h2Xqd2fTzJnBt5BeFM/9wH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Id742V0xJ5l8zl5zUJpQ8HtxX0VBqF1DX1/YfNeEYETApb64r5/RilRtxqLgpNUyU
         oMHglFdtTjG6oJO35TMkCUAeWKv6rYkUMuqG/eF6/WRbn0vE4VPfn8STq5FPuaOiYK
         ezuml9uttCHTwOml/BHl8+e9pVYnTfQNf2FkxtAY=
Date:   Tue, 26 Apr 2022 12:45:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, rostedt@goodmis.org, dan.j.williams@intel.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: Re: [PATCH v4 04/10] platform/x86/intel/ifs: Read IFS firmware image
Message-ID: <YmfNVG0qLahv7TzL@kroah.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
 <20220422200219.2843823-1-tony.luck@intel.com>
 <20220422200219.2843823-5-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200219.2843823-5-tony.luck@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:02:13PM -0700, Tony Luck wrote:
> From: Jithu Joseph <jithu.joseph@intel.com>
> 
> Driver probe routine allocates structure to communicate status
> and parameters between functions in the driver. Also call
> load_ifs_binary() to load the scan image file.
> 
> There is a separate scan image file for each processor family,
> model, stepping combination. This is read from the static path:
> 
>   /lib/firmware/intel/ifs/{ff-mm-ss}.scan
> 
> Step 1 in loading is to generate the correct path and use
> request_firmware_direct() to load into memory.
> 
> Subsequent patches will use the IFS MSR interfaces to copy
> the image to BIOS reserved memory and validate the SHA256
> checksums.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/Makefile |  2 +-
>  drivers/platform/x86/intel/ifs/core.c   | 36 ++++++++++++++++++++++++-
>  drivers/platform/x86/intel/ifs/ifs.h    | 25 +++++++++++++++++
>  drivers/platform/x86/intel/ifs/load.c   | 28 +++++++++++++++++++
>  4 files changed, 89 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/platform/x86/intel/ifs/ifs.h
>  create mode 100644 drivers/platform/x86/intel/ifs/load.c
> 
> diff --git a/drivers/platform/x86/intel/ifs/Makefile b/drivers/platform/x86/intel/ifs/Makefile
> index af904880e959..98b6fde15689 100644
> --- a/drivers/platform/x86/intel/ifs/Makefile
> +++ b/drivers/platform/x86/intel/ifs/Makefile
> @@ -1,3 +1,3 @@
>  obj-$(CONFIG_INTEL_IFS)		+= intel_ifs.o
>  
> -intel_ifs-objs			:= core.o
> +intel_ifs-objs			:= core.o load.o
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 5713e6ee90f0..ed4ded6755b2 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -6,6 +6,8 @@
>  
>  #include <asm/cpu_device_id.h>
>  
> +#include "ifs.h"
> +
>  enum test_types {
>  	IFS_SAF,
>  };
> @@ -20,10 +22,27 @@ static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
>  };
>  MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
>  
> +static struct ifs_device ifs_devices[] = {
> +	[IFS_SAF] = {
> +		.data = {
> +			.integrity_cap_bit = MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT,
> +		},
> +		.misc = {
> +			.name = "intel_ifs_0",
> +			.nodename = "intel_ifs/0",
> +			.minor = MISC_DYNAMIC_MINOR,
> +		},
> +	},
> +};
> +
> +#define IFS_NUMTESTS ARRAY_SIZE(ifs_devices)

Cute way to do this, but I don't see you ever have any more devices
added to this list in this series.  Did I miss them?

If not, why all the overhead and complexity involved here for just a
single misc device?

thanks,

greg k-h
