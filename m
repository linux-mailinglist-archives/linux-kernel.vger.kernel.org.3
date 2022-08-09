Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596258D89C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 14:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243086AbiHIMIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiHIMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 08:08:39 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756A8248E3;
        Tue,  9 Aug 2022 05:08:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DC49FCE13A1;
        Tue,  9 Aug 2022 12:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFEDC433D6;
        Tue,  9 Aug 2022 12:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660046915;
        bh=tQpfWG7zuVH534A9iJhM+o2JAdiqZG5gW5+/sTvJ0hI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PxmP0VuiQu5GH/0EZLswL6SXVlspr3F/1ACb3WgXZhFEZKLc2N+UABpbUcFQLY8yX
         X6++Lx9tU6/eBSrCuIkyv705J87wNVAwSwAZrUedhB0G3h4UPRm1cfmH9OebH5SP5R
         4VQZe3mY8mkSFQLfuZNJdN5Y8ZGj0NfiBY6oPIGQ=
Date:   Tue, 9 Aug 2022 14:08:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-api@vger.kernel.org
Subject: Re: [PATCH] MIPS: Expose prid and globalnumber to sysfs
Message-ID: <YvJOQC7eQBjsHWct@kroah.com>
References: <20220809113444.17757-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809113444.17757-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 09, 2022 at 11:34:44AM +0000, Jiaxun Yang wrote:
> Some application would like to know precise model and rev of processor
> to do errata workaround or optimization.
> 
> Expose them in sysfs as:
> /sys/devices/system/cpu/cpuX/regs/identification/prid
> /sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> 
> Reusing AArch64 CPU registers directory.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 11 +++
>  arch/mips/kernel/topology.c                   | 96 +++++++++++++++++++
>  2 files changed, 107 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 5bf61881f012..adf855e7bb9b 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -512,6 +512,17 @@ Description:	information about CPUs heterogeneity.
>  
>  		cpu_capacity: capacity of cpuX.
>  
> +What:		/sys/devices/system/cpu/cpuX/regs/
> +		/sys/devices/system/cpu/cpuX/regs/identification/
> +		/sys/devices/system/cpu/cpuX/regs/identification/prid
> +		/sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> +Date:		Augest 2022
> +Contact:	Linux MIPS Kernel Mailing list <linux-mips@vger.kernel.org>
> +Description:	MIPS CPU registers
> +
> +		'identification' directory exposes the Processor ID and Global Number
> +		registers for identifying model and revision of the CPU.
> +
>  What:		/sys/devices/system/cpu/vulnerabilities
>  		/sys/devices/system/cpu/vulnerabilities/meltdown
>  		/sys/devices/system/cpu/vulnerabilities/spectre_v1
> diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
> index 9429d85a4703..90b5136afb63 100644
> --- a/arch/mips/kernel/topology.c
> +++ b/arch/mips/kernel/topology.c
> @@ -5,6 +5,8 @@
>  #include <linux/node.h>
>  #include <linux/nodemask.h>
>  #include <linux/percpu.h>
> +#include <linux/seq_file.h>
> +#include <linux/smp.h>
>  
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>  
> @@ -26,3 +28,97 @@ static int __init topology_init(void)
>  }
>  
>  subsys_initcall(topology_init);
> +
> +static struct kobj_type cpuregs_kobj_type = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +struct cpureg {
> +	struct kobject kobj;
> +	struct cpuinfo_mips *info;
> +};
> +static DEFINE_PER_CPU(struct cpureg, cpuregs);

static kobjects are nothing you should ever create willingly.  That's a
dynamic reference counted structure being declared on the "stack"?

Please no.

thanks,

greg k-h
