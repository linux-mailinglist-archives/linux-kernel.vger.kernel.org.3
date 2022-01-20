Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977B1494F13
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiATNgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232587AbiATNgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:36:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2828AC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:36:00 -0800 (PST)
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A76C1EC0495;
        Thu, 20 Jan 2022 14:35:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1642685754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SzASBohPLVdUyusiL5qeFStul+mPZO371ICfTnt+1zc=;
        b=CL2mHUrsv30FxqsVH3UoJ/RpjVCzRE2MOEoNjpfSbPDJcoZnPA8xtnkc/O5V74Y1v2wJ9E
        OqxScNex0EC/9FJMigKZcvQCmGVChgMzNrV71Fb8YS4d+xtx4WgtoG3uI7sxUldcX9QgXw
        IPr1EZvshj+TtpUMA4pyczzw/iJyhIs=
Date:   Thu, 20 Jan 2022 14:35:51 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Smita Koralahalli Channabasappa 
        <smita.koralahallichannabasappa@amd.com>,
        Wei Huang <wei.huang2@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, patches@lists.linux.dev
Subject: Re: [PATCH 5/5] x86/sysfs: Add PPIN in sysfs under cpu topology
Message-ID: <YellN/3VCasDI3OD@zn.tnic>
References: <20220107225442.1690165-1-tony.luck@intel.com>
 <20220107225442.1690165-6-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220107225442.1690165-6-tony.luck@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 02:54:42PM -0800, Tony Luck wrote:
> PPIN is the Protected Processor Identification Number.
> This is used to identify the socket as a Field Replaceable Unit (FRU).
> 
> Existing code only displays this when reporting errors. But this makes
> it inconvenient for large clusters to use it for its intended purpose
> of inventory control.

Do you have any concrete use cases you can cite here or this is one of
those: "let's make it available and see who'll use it" thing?

Because defeaturing a user-visible thing later is always a pain.

> There are several privacy concerns associated with a unique
> platform identifier. But making the PPIN available shouldn't
> change anything important. Notes:
> 
> 1) The PPIN is only enabled on server CPUs (E.g. Intel Xeon
> "-E5", "-E7" and "-SP" parts).

Can't use that as an argument - that can easily change in the future.

> 2) The PPIN MSR is may be implemented on some desktop/laptop parts.

s/is //

> But this is for OEM inventory control. Production BIOS versions
> leave the PPIN_CTL MSR in the "locked disabled" mode.

That either. Never let the BIOS do your work for you. :-)

> 3) There may be a BIOS option to lock the MSR in disabled mode
> to prevent Linux from reading it.
> 
> 4) The /sys file added here is readable only by "root".

Yap, that's the argument: your patch simply makes what is already
accessible to root through rdmsr in a more user-friendly way.

> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-system-cpu  | 4 ++++
>  Documentation/ABI/testing/sysfs-devices-system-cpu | 6 ++++++
>  arch/x86/include/asm/topology.h                    | 1 +
>  drivers/base/topology.c                            | 4 ++++
>  include/linux/topology.h                           | 3 +++
>  5 files changed, 18 insertions(+)

> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index 793c592e533a..4c8674715d36 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -54,6 +54,9 @@ static DEVICE_ATTR_RO(cluster_id);
>  define_id_show_func(core_id, "%d");
>  static DEVICE_ATTR_RO(core_id);
>  
> +define_id_show_func(ppin, "%llx");

			     "0x%llx"

Otherwise it is ambiguous.

> diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
> index cc164777e661..caba7db8c7b6 100644
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -110,6 +110,7 @@ extern const struct cpumask *cpu_clustergroup_mask(int cpu);
>  #define topology_logical_die_id(cpu)		(cpu_data(cpu).logical_die_id)
>  #define topology_die_id(cpu)			(cpu_data(cpu).cpu_die_id)
>  #define topology_core_id(cpu)			(cpu_data(cpu).cpu_core_id)
> +#define topology_ppin(cpu)			(cpu_data(cpu).ppin)

That looks unused. No need to add it.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
