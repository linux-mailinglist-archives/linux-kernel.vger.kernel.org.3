Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D44876DE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbiAGLxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiAGLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:53:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25E0C061245;
        Fri,  7 Jan 2022 03:53:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E707B8259E;
        Fri,  7 Jan 2022 11:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A9AC36AE5;
        Fri,  7 Jan 2022 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641556419;
        bh=uo4WZxRwd3p3Bnx7jX/0q2Y2n3W/q54d6WDL9IjTF0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m/McJmExy6m1HgrSmvW8Ef8OjVr/3GUYuAuhkRug7yZeJCW5X88O0jF9EkEjT+aJR
         qG0BtrIN0I7V+h0p3AWNmgg9U5aWnQi4ukye+JX9NJ8ZJGxEDNxU1anIe/O2bvKwUd
         g0YCwxADs7oAWEAB+yynvgwm1FiseTdLhE5qlApxeWNuFe03DOAP4+vnpgu6+RKPjI
         EY0NAaWvH1ZFsMqRWSTL8gjUS3svSCDIPIsyt1I5xvDIEe3OMdclSjNUItqSCCsu3q
         gRGnc4v5b/rf7m35BqCYCgq+BzaA134BVaOGyzXHJtNJeJHTccsAhtySMSfbXp2LVY
         l8Lvwdcq9R5Hw==
Date:   Fri, 7 Jan 2022 13:53:34 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        nathan@kernel.org, gregkh@linuxfoundation.org,
        linux-sgx@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] [v3] x86/sgx: Fix NULL pointer dereference on non-SGX
 systems
Message-ID: <YdgpvkqpIbRUw9yT@iki.fi>
References: <20220104171527.5E8416A8@davehans-spike.ostc.intel.com>
 <YdgoNDt9dYaqfE7u@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdgoNDt9dYaqfE7u@iki.fi>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 01:47:00PM +0200, Jarkko Sakkinen wrote:
> On Tue, Jan 04, 2022 at 09:15:27AM -0800, Dave Hansen wrote:
> > 
> > From: Dave Hansen <dave.hansen@linux.intel.com>
> > 
> > == Problem ==
> > 
> > Nathan Chancellor reported an oops when aceessing the
> > 'sgx_total_bytes' sysfs file:
> > 
> > 	https://lore.kernel.org/all/YbzhBrimHGGpddDM@archlinux-ax161/
> > 
> > The sysfs output code accesses the sgx_numa_nodes[] array
> > unconditionally.  However, this array is allocated during SGX
> > initialization, which only occurs on systems where SGX is
> > supported.
> > 
> > If the sysfs file is accessed on systems without SGX support,
> > sgx_numa_nodes[] is NULL and an oops occurs.
> > 
> > == Solution ==
> > 
> > To fix this, hide the entire nodeX/x86/ attribute group on
> > systems without SGX support using the ->is_visible attribute
> > group callback.
> > 
> > Unfortunately, SGX is initialized via a device_initcall() which
> > occurs _after_ the ->is_visible() callback.  Instead of moving
> > SGX initialization earlier, call sysfs_update_group() during
> > SGX initialization to update the group visiblility.
> > 
> > This update requires moving the SGX sysfs code earlier in
> > sgx/main.c.  There are no code changes other than the addition of
> > arch_update_sysfs_visibility() and a minor whitespace fixup to
> > arch_node_attr_is_visible() which checkpatch caught.
> > 
> > Fixes: 50468e431335 ("x86/sgx: Add an attribute for the amount of SGX memory in a NUMA node")
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jarkko Sakkinen <jarkko@kernel.org>
> > Cc: linux-sgx@vger.kernel.org
> > Cc: x86@kernel.org
> > ---
> > 
> >  b/arch/x86/kernel/cpu/sgx/main.c |   65 ++++++++++++++++++++++++++++-----------
> >  1 file changed, 47 insertions(+), 18 deletions(-)
> > 
> > diff -puN arch/x86/kernel/cpu/sgx/main.c~sgx-null-ptr arch/x86/kernel/cpu/sgx/main.c
> > --- a/arch/x86/kernel/cpu/sgx/main.c~sgx-null-ptr	2021-12-20 07:56:38.309584807 -0800
> > +++ b/arch/x86/kernel/cpu/sgx/main.c	2022-01-04 08:43:17.042821249 -0800
> > @@ -6,11 +6,13 @@
> >  #include <linux/highmem.h>
> >  #include <linux/kthread.h>
> >  #include <linux/miscdevice.h>
> > +#include <linux/node.h>
> >  #include <linux/pagemap.h>
> >  #include <linux/ratelimit.h>
> >  #include <linux/sched/mm.h>
> >  #include <linux/sched/signal.h>
> >  #include <linux/slab.h>
> > +#include <linux/sysfs.h>
> >  #include <asm/sgx.h>
> >  #include "driver.h"
> >  #include "encl.h"
> > @@ -780,6 +782,48 @@ static inline u64 __init sgx_calc_sectio
> >  	       ((high & GENMASK_ULL(19, 0)) << 32);
> >  }
> >  
> > +#ifdef CONFIG_NUMA
> > +static ssize_t sgx_total_bytes_show(struct device *dev, struct device_attribute *attr, char *buf)
> > +{
> > +	return sysfs_emit(buf, "%lu\n", sgx_numa_nodes[dev->id].size);
> > +}
> > +static DEVICE_ATTR_RO(sgx_total_bytes);
> > +
> > +static umode_t arch_node_attr_is_visible(struct kobject *kobj,
> > +		struct attribute *attr, int idx)
> > +{
> > +	/* Make all x86/ attributes invisible when SGX is not initialized: */
> > +	if (nodes_empty(sgx_numa_mask))
> > +		return 0;
> > +
> > +	return attr->mode;
> > +}
> > +
> > +static struct attribute *arch_node_dev_attrs[] = {
> > +	&dev_attr_sgx_total_bytes.attr,
> > +	NULL,
> > +};
> > +
> > +const struct attribute_group arch_node_dev_group = {
> > +	.name = "x86",
> > +	.attrs = arch_node_dev_attrs,
> > +	.is_visible = arch_node_attr_is_visible,
> > +};
> > +
> > +static void __init arch_update_sysfs_visibility(int nid)
> > +{
> > +	struct node *node = node_devices[nid];
> > +	int ret;
> > +
> > +	ret = sysfs_update_group(&node->dev.kobj, &arch_node_dev_group);
> > +
> > +	if (ret)
> > +		pr_err("sysfs update failed (%d), files may be invisible", ret);
> > +}
> > +#else /* !CONFIG_NUMA */
> > +static void __init arch_update_sysfs_visibility(int nid) {}
> > +#endif
> > +
> >  static bool __init sgx_page_cache_init(void)
> >  {
> >  	u32 eax, ebx, ecx, edx, type;
> > @@ -826,6 +870,9 @@ static bool __init sgx_page_cache_init(v
> >  			INIT_LIST_HEAD(&sgx_numa_nodes[nid].sgx_poison_page_list);
> >  			node_set(nid, sgx_numa_mask);
> >  			sgx_numa_nodes[nid].size = 0;
> > +
> > +			/* Make SGX-specific node sysfs files visible: */
> > +			arch_update_sysfs_visibility(nid);
> >  		}
> >  
> >  		sgx_epc_sections[i].node =  &sgx_numa_nodes[nid];
> > @@ -903,24 +950,6 @@ int sgx_set_attribute(unsigned long *all
> >  }
> >  EXPORT_SYMBOL_GPL(sgx_set_attribute);
> >  
> > -#ifdef CONFIG_NUMA
> > -static ssize_t sgx_total_bytes_show(struct device *dev, struct device_attribute *attr, char *buf)
> > -{
> > -	return sysfs_emit(buf, "%lu\n", sgx_numa_nodes[dev->id].size);
> > -}
> > -static DEVICE_ATTR_RO(sgx_total_bytes);
> > -
> > -static struct attribute *arch_node_dev_attrs[] = {
> > -	&dev_attr_sgx_total_bytes.attr,
> > -	NULL,
> > -};
> > -
> > -const struct attribute_group arch_node_dev_group = {
> > -	.name = "x86",
> > -	.attrs = arch_node_dev_attrs,
> > -};
> > -#endif /* CONFIG_NUMA */
> > -
> >  static int __init sgx_init(void)
> >  {
> >  	int ret;
> > _
> 
> Please add both:
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Tested-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I explained the testing procedure in the other email.

To add: I tested both this final version and also the earlier
attached version.

/Jarkko
