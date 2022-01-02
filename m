Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C58482D1E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 00:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiABXUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 18:20:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54524 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiABXUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 18:20:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 142E0B80DB9;
        Sun,  2 Jan 2022 23:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39BE0C36AEE;
        Sun,  2 Jan 2022 23:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641165645;
        bh=A34D33k6RMW8JdsozuY0EuUv/rE0L1gufityMIS5DNQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NFHQq0le1HnsDP0BxzlgvSkG04+H7Z15u6tHu/o5OBWhjhfqb9B1PHnEmO9OVJe4C
         eqk5CR7Rdn16ouoXFclIp6MG0JmOMVtHOJahFY9/aA80xTvKJG1/zVY5f6bI+v25Gx
         NE1PiSLP/5mep8zcuuryJux0URfZ7juLuQTCdzCK0ZU5GrnRF8IRsWL6s8h8q4aTLw
         rCOF9riD/c2ftriYuxNLJNjjAG1zyzl10aJts1UYhUM+BXLlbGiVwwgs2F+mO2ZBY2
         NoBtsyIay7vD3O0bAwJ2tIgaHrY55tfQ9NWvXeCebt4yN7BJ+vj1cIZNU4PjEV3gCU
         ZTajFL5u6JQrw==
Date:   Sun, 2 Jan 2022 16:20:40 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
Message-ID: <YdIzSGjxvgiWwkXu@archlinux-ax161>
References: <20211116162116.93081-1-jarkko@kernel.org>
 <20211116162116.93081-2-jarkko@kernel.org>
 <YbzhBrimHGGpddDM@archlinux-ax161>
 <YcuhhI2+k0XVuTb1@iki.fi>
 <c857c964-89b9-d827-74ec-32cf874e8d8b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c857c964-89b9-d827-74ec-32cf874e8d8b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 01, 2022 at 08:54:51PM -0800, Dave Hansen wrote:
> On 12/28/21 3:45 PM, Jarkko Sakkinen wrote:
> >> If I can provide any further information or testing, let me know!
> > Dave, when is the fix going to be applied [*]?
> > 
> >> Cheers,
> >> Nathan
> > [*] https://lore.kernel.org/linux-sgx/YcGTePmWDMOQU1pn@iki.fi/T/#m831a01bdde347f9e0af2c973986fae0499718201
> 
> Greg preferred hiding the file as opposed to faking a number in there.
> Any testing of the attached would be appreciated.

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> Nathan Chancellor reported an oops when aceessing the
> 'sgx_total_bytes' sysfs file:
> 
> 	https://lore.kernel.org/all/YbzhBrimHGGpddDM@archlinux-ax161/
> 
> The sysfs output code accesses the sgx_numa_nodes[] array
> unconditionally.  However, this array is allocated during SGX
> initialization, which only occurs on systems where SGX is
> supported.
> 
> If the sysfs file is accessed on systems without SGX support,
> sgx_numa_nodes[] is NULL and an oops occurs.
> 
> To fix this, hide the entire nodeX/x86/ attribute group on
> systems without SGX support using the ->is_visible attribute
> group callback.
> 
> Fixes: 50468e431335 ("x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node")
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: linux-sgx@vger.kernel.org
> Cc: x86@kernel.org

On both my older Intel based test system and AMD based test system, the
sgx_total_bytes node is no longer visible.

$ ls -al /sys/devices/system/node/node0/x86/

Tested-by: Nathan Chancellor <nathan@kernel.org>

> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> ---
> 
>  b/arch/x86/kernel/cpu/sgx/main.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff -puN arch/x86/kernel/cpu/sgx/main.c~sgx-null-ptr arch/x86/kernel/cpu/sgx/main.c
> --- a/arch/x86/kernel/cpu/sgx/main.c~sgx-null-ptr	2021-12-20 07:56:38.309584807 -0800
> +++ b/arch/x86/kernel/cpu/sgx/main.c	2021-12-20 08:17:28.997705149 -0800
> @@ -910,6 +910,16 @@ static ssize_t sgx_total_bytes_show(stru
>  }
>  static DEVICE_ATTR_RO(sgx_total_bytes);
>  
> +static umode_t arch_node_attr_is_visible(struct kobject * kobj,
> +		struct attribute * attr, int idx)
> +{
> +	/* Make all x86/ attributes invisible when SGX is not initialized: */
> +	if (nodes_empty(sgx_numa_mask))
> +		return 0;
> +
> +	return attr->mode;
> +}
> +
>  static struct attribute *arch_node_dev_attrs[] = {
>  	&dev_attr_sgx_total_bytes.attr,
>  	NULL,
> @@ -918,6 +928,7 @@ static struct attribute *arch_node_dev_a
>  const struct attribute_group arch_node_dev_group = {
>  	.name = "x86",
>  	.attrs = arch_node_dev_attrs,
> +	.is_visible = arch_node_attr_is_visible,
>  };
>  #endif /* CONFIG_NUMA */
>  
> _

