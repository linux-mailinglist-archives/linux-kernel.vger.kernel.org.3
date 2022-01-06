Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F4C486A71
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243292AbiAFTSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243235AbiAFTSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:18:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948BFC061245;
        Thu,  6 Jan 2022 11:18:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6098AB82369;
        Thu,  6 Jan 2022 19:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6C3DC36AE3;
        Thu,  6 Jan 2022 19:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641496717;
        bh=YDuZHR0Qu3o0lNe3alckOklSPNdvNLbGwS8If0Z9lz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LXBsbGmQ5hH0jNtJC2pOfCC5iLP1G9BVWiLNOIaJoPkS3EMfMU823YEynflzLCjt1
         6gqzrK40nhR0azq2MXorY0iuwjNjBip2s4dIWsBfmeXSTSsOKVdnsxYvZQARSEFLPC
         SfI6kw/plfUUzQ7hf+V7RvFf7bezH0e0zPmdegEETtwCUugPGpJgwty6/h1eW7bBUy
         dVEs4VOYnAHKd4SrvXHt4PkycK5+BeGSieEnq1R1bc9PpqTh1SxpxUuqIrbgwTRsy2
         /oIzy63kSgU3ZpLi6v7zhqwnv1VAfb6J0c3qUNU/sa/afNG3XlF7FYHXZOx0xHINDE
         b2STsNLJBoGyA==
Date:   Thu, 6 Jan 2022 21:18:32 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, reinette.chatre@intel.com,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org
Subject: Re: [PATCH v13 2/2] x86/sgx: Add an attribute for the amount of SGX
 memory in a NUMA node
Message-ID: <YddAiHSSX0V7UUik@iki.fi>
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

I'm compiling now kernel with this applied, reporting soon but the fix
looks good to me.

/Jarkko
