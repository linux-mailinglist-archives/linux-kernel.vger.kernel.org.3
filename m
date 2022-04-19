Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC13B507656
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244899AbiDSRTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbiDSRTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:19:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66716326ED;
        Tue, 19 Apr 2022 10:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0B6A46156D;
        Tue, 19 Apr 2022 17:16:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D39C385A5;
        Tue, 19 Apr 2022 17:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650388576;
        bh=ENunmgeNoizQFqrJQJf9oM/MqrrOp/nUO4aJ3UnidAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iE0cE2iYAP6pZxJEKglIfmI8TEGTBoAFZ6bELT5f9zT2JUjxZBzBnx+QaSdN7YU8R
         gyHlXmaMXn+6HAyW0esyqLQLztqdyHtUWS+VBr44PDu5Gc/sUWQojhEy1J0ujYh/Vc
         0tx2lMbI5wYu19uOUs7vGyu8IcgP20nKwMEiH28Y=
Date:   Tue, 19 Apr 2022 19:16:13 +0200
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
Subject: Re: [PATCH v3 06/11] platform/x86/intel/ifs: Check IFS Image sanity
Message-ID: <Yl7uXZW+dFcEXMFM@kroah.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
 <20220419163859.2228874-7-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419163859.2228874-7-tony.luck@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 09:38:54AM -0700, Tony Luck wrote:
> From: Jithu Joseph <jithu.joseph@intel.com>
> 
> IFS image is designed specifically for a given family, model and
> stepping of the processor. Like Intel microcode header, the IFS image
> has the Processor Signature, Checksum and Processor Flags that must be
> matched with the information returned by the CPUID.
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Co-developed-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/load.c | 69 +++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/platform/x86/intel/ifs/load.c b/drivers/platform/x86/intel/ifs/load.c
> index fa6c64707a73..b05d9055c391 100644
> --- a/drivers/platform/x86/intel/ifs/load.c
> +++ b/drivers/platform/x86/intel/ifs/load.c
> @@ -3,9 +3,73 @@
>  
>  #include <linux/firmware.h>
>  #include <linux/platform_device.h>
> +#include <asm/cpu.h>
> +#include <asm/microcode_intel.h>
>  
>  static const char *ifs_path = "intel/ifs/";
>  
> +static int ifs_sanity_check(struct device *dev, void *mc)
> +{
> +	struct microcode_header_intel *mc_header = mc;
> +	unsigned long total_size, data_size;
> +	u32 sum, i;
> +
> +	total_size = get_totalsize(mc_header);
> +	data_size = get_datasize(mc_header);
> +
> +	if ((data_size + MC_HEADER_SIZE > total_size) || (total_size % sizeof(u32))) {
> +		dev_err(dev, "bad ifs data file size.\n");
> +		return -EINVAL;
> +	}
> +
> +	if (mc_header->ldrver != 1 || mc_header->hdrver != 1) {
> +		dev_err(dev, "invalid/unknown ifs update format.\n");
> +		return -EINVAL;
> +	}
> +
> +	sum = 0;
> +	i = total_size / sizeof(u32);
> +	while (i--)
> +		sum += ((u32 *)mc)[i];
> +
> +	if (sum) {
> +		dev_err(dev, "bad ifs data checksum, aborting.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool find_ifs_matching_signature(struct device *dev, struct ucode_cpu_info *uci, void *mc)
> +{
> +	struct microcode_header_intel *shdr;
> +	unsigned int mc_size;
> +
> +	shdr = (struct microcode_header_intel *)mc;
> +	mc_size = get_totalsize(shdr);
> +
> +	if (!mc_size || ifs_sanity_check(dev, shdr) < 0) {
> +		dev_err(dev, "ifs sanity check failure\n");
> +		return false;
> +	}
> +
> +	if (!intel_cpu_signatures_match(uci->cpu_sig.sig, uci->cpu_sig.pf, shdr->sig, shdr->pf)) {
> +		dev_err(dev, "ifs signature, pf not matching\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static bool ifs_image_sanity_check(struct device *dev, void *data)

u8 *data?

> +{
> +	struct ucode_cpu_info uci;
> +
> +	intel_cpu_collect_info_early(&uci);
> +
> +	return find_ifs_matching_signature(dev, &uci, data);
> +}
> +
>  /*
>   * Load ifs image. Before loading ifs module, the ifs image must be located
>   * in /lib/firmware/intel/ifs and named as {family/model/stepping}.{testname}.
> @@ -25,6 +89,11 @@ int load_ifs_binary(struct device *dev)
>  		return ret;
>  	}
>  
> +	if (!ifs_image_sanity_check(dev, (void *)fw->data)) {

It's not a void pointer, it's a pointer to u8.  Why cast it away?

thanks,

greg k-h
