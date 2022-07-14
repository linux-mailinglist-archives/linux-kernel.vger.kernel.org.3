Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140695754D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240593AbiGNSUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbiGNSUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:20:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C045568DFB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6AA75B82768
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:20:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67BADC34114;
        Thu, 14 Jul 2022 18:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657822845;
        bh=iKFL8MhgnwvAzfXoCa/xPbE8h1onzSSmHhZbueGDxas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AzCMaqSw4zc4mCQAf9RRReN7QGBYuoeEF/Wo6MEKU6hdvUdhSRSA1EYakW9MRGLu3
         LAx+tKlwdbmQQ1wmIj6xWfnMjPbKbrAiwnAPEu4ri5od8LTek62FHo/D9ueKvwUDwZ
         XHNMcySfdkx0mEefR4pzC0qMP1tyDvrqYnsAqYzU=
Date:   Thu, 14 Jul 2022 20:20:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v4] drivers/base: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <YtBeeL+eB6iQ7CHH@kroah.com>
References: <20220714180121.2917662-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714180121.2917662-1-pauld@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 02:01:21PM -0400, Phil Auld wrote:
> Using bin_attributes with a 0 size causes fstat and friends to return that 0 size.
> This breaks userspace code that retrieves the size before reading the file. Rather
> than reverting 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size
> limitation of cpumap ABI") let's put in a size value at compile time. Use direct
> comparison and a worst-case maximum to ensure compile time constants. For cpulist the
> max is on the order of NR_CPUS * (ceil(log10(NR_CPUS)) + 1) which for 8192 is 40960
> (8192 * 5). In order to get near that you'd need a system with every other CPU on one
> node or something similar. e.g. (0,2,4,8, ... ). To simplify the math and support
> larger NR_CPUS in the future we are using NR_CPUS * 7. We also set it to a min of
> PAGE_SIZE to retain the older behavior for smaller NR_CPUS. The cpumap file wants to
> be something like NR_CPUS/4 + NR_CPUS/32, for the ","s so for simplicity we are using
> NR_CPUS/2.
> 
> Add a set of macros for these values to cpumask.h so they can be used in multiple places.
> Apply these to the handful of such files in drivers/base/topology.c as well as node.c.
> 
> On an 80 cpu 4-node sytem (NR_CPUS == 8192)
> 
> before:
> 
> -r--r--r--. 1 root root 0 Jul 12 14:08 /sys/devices/system/node/node0/cpulist
> -r--r--r--. 1 root root 0 Jul 11 17:25 /sys/devices/system/node/node0/cpumap
> 
> after:
> 
> -r--r--r--. 1 root root 57344 Jul 13 11:32 /sys/devices/system/node/node0/cpulist
> -r--r--r--. 1 root root  4096 Jul 13 11:31 /sys/devices/system/node/node0/cpumap
> 
> CONFIG_NR_CPUS = 16384
> -r--r--r--. 1 root root 114688 Jul 13 14:03 /sys/devices/system/node/node0/cpulist
> -r--r--r--. 1 root root   8192 Jul 13 14:02 /sys/devices/system/node/node0/cpumap
> 
> Fixes: 75bd50fa841 ("drivers/base/node.c: use bin_attribute to break the size limitation of cpumap ABI")
> Fixes: bb9ec13d156 ("topology: use bin_attribute to break the size limitation of cpumap ABI")
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> ---
>  drivers/base/node.c     |  4 ++--
>  drivers/base/topology.c | 32 ++++++++++++++++----------------
>  include/linux/cpumask.h | 16 ++++++++++++++++
>  3 files changed, 34 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index 0ac6376ef7a1..eb0f43784c2b 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -45,7 +45,7 @@ static inline ssize_t cpumap_read(struct file *file, struct kobject *kobj,
>  	return n;
>  }
>  
> -static BIN_ATTR_RO(cpumap, 0);
> +static BIN_ATTR_RO(cpumap, CPUMAP_FILE_MAX_BYTES);
>  
>  static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
>  				   struct bin_attribute *attr, char *buf,
> @@ -66,7 +66,7 @@ static inline ssize_t cpulist_read(struct file *file, struct kobject *kobj,
>  	return n;
>  }
>  
> -static BIN_ATTR_RO(cpulist, 0);
> +static BIN_ATTR_RO(cpulist, CPULIST_FILE_MAX_BYTES);
>  
>  /**
>   * struct node_access_nodes - Access class device to hold user visible
> diff --git a/drivers/base/topology.c b/drivers/base/topology.c
> index ac6ad9ab67f9..89f98be5c5b9 100644
> --- a/drivers/base/topology.c
> +++ b/drivers/base/topology.c
> @@ -62,47 +62,47 @@ define_id_show_func(ppin, "0x%llx");
>  static DEVICE_ATTR_ADMIN_RO(ppin);
>  
>  define_siblings_read_func(thread_siblings, sibling_cpumask);
> -static BIN_ATTR_RO(thread_siblings, 0);
> -static BIN_ATTR_RO(thread_siblings_list, 0);
> +static BIN_ATTR_RO(thread_siblings, CPUMAP_FILE_MAX_BYTES);
> +static BIN_ATTR_RO(thread_siblings_list, CPULIST_FILE_MAX_BYTES);
>  
>  define_siblings_read_func(core_cpus, sibling_cpumask);
> -static BIN_ATTR_RO(core_cpus, 0);
> -static BIN_ATTR_RO(core_cpus_list, 0);
> +static BIN_ATTR_RO(core_cpus, CPUMAP_FILE_MAX_BYTES);
> +static BIN_ATTR_RO(core_cpus_list, CPULIST_FILE_MAX_BYTES);
>  
>  define_siblings_read_func(core_siblings, core_cpumask);
> -static BIN_ATTR_RO(core_siblings, 0);
> -static BIN_ATTR_RO(core_siblings_list, 0);
> +static BIN_ATTR_RO(core_siblings, CPUMAP_FILE_MAX_BYTES);
> +static BIN_ATTR_RO(core_siblings_list, CPULIST_FILE_MAX_BYTES);
>  
>  #ifdef TOPOLOGY_CLUSTER_SYSFS
>  define_siblings_read_func(cluster_cpus, cluster_cpumask);
> -static BIN_ATTR_RO(cluster_cpus, 0);
> -static BIN_ATTR_RO(cluster_cpus_list, 0);
> +static BIN_ATTR_RO(cluster_cpus, CPUMAP_FILE_MAX_BYTES);
> +static BIN_ATTR_RO(cluster_cpus_list, CPULIST_FILE_MAX_BYTES);
>  #endif
>  
>  #ifdef TOPOLOGY_DIE_SYSFS
>  define_siblings_read_func(die_cpus, die_cpumask);
> -static BIN_ATTR_RO(die_cpus, 0);
> -static BIN_ATTR_RO(die_cpus_list, 0);
> +static BIN_ATTR_RO(die_cpus, CPUMAP_FILE_MAX_BYTES);
> +static BIN_ATTR_RO(die_cpus_list, CPULIST_FILE_MAX_BYTES);
>  #endif
>  
>  define_siblings_read_func(package_cpus, core_cpumask);
> -static BIN_ATTR_RO(package_cpus, 0);
> -static BIN_ATTR_RO(package_cpus_list, 0);
> +static BIN_ATTR_RO(package_cpus, CPUMAP_FILE_MAX_BYTES);
> +static BIN_ATTR_RO(package_cpus_list, CPULIST_FILE_MAX_BYTES);
>  
>  #ifdef TOPOLOGY_BOOK_SYSFS
>  define_id_show_func(book_id, "%d");
>  static DEVICE_ATTR_RO(book_id);
>  define_siblings_read_func(book_siblings, book_cpumask);
> -static BIN_ATTR_RO(book_siblings, 0);
> -static BIN_ATTR_RO(book_siblings_list, 0);
> +static BIN_ATTR_RO(book_siblings, CPUMAP_FILE_MAX_BYTES);
> +static BIN_ATTR_RO(book_siblings_list, CPULIST_FILE_MAX_BYTES);
>  #endif
>  
>  #ifdef TOPOLOGY_DRAWER_SYSFS
>  define_id_show_func(drawer_id, "%d");
>  static DEVICE_ATTR_RO(drawer_id);
>  define_siblings_read_func(drawer_siblings, drawer_cpumask);
> -static BIN_ATTR_RO(drawer_siblings, 0);
> -static BIN_ATTR_RO(drawer_siblings_list, 0);
> +static BIN_ATTR_RO(drawer_siblings, CPUMAP_FILE_MAX_BYTES);
> +static BIN_ATTR_RO(drawer_siblings_list, CPULIST_FILE_MAX_BYTES);
>  #endif
>  
>  static struct bin_attribute *bin_attrs[] = {
> diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
> index fe29ac7cc469..007acdb462bd 100644
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -1071,4 +1071,20 @@ cpumap_print_list_to_buf(char *buf, const struct cpumask *mask,
>  	[0] =  1UL							\
>  } }
>  
> +/* 
> + * Provide a valid theoretical max size for cpumap ands cpulist sysfs files to 
> + * avoid breaking userspace which may allocate a buffer based on the size 
> + * reported by e.g. fstat.
> + *
> + * For cpumap NR_CPUS/2 is a simplification of NR_CPUS/4 + NR_CPUS/32. 
> + *
> + * For cpulist 7 is (ceil(log10(NR_CPUS)) + 1) allowing for NR_CPUS to be up to 
> + * 2 orders of magnitude larger than 8192. This covers a worst-case of every 
> + * other cpu being on one of two nodes for a very large NR_CPUS.
> + *
> + *  Use PAGE_SIZE as a minimum for smaller configurations. 
> + */
> +#define CPUMAP_FILE_MAX_BYTES  (((NR_CPUS >> 1) > PAGE_SIZE) ? NR_CPUS >> 1 : PAGE_SIZE)
> +#define CPULIST_FILE_MAX_BYTES  (((NR_CPUS * 7) > PAGE_SIZE) ? NR_CPUS * 7 : PAGE_SIZE)
> +
>  #endif /* __LINUX_CPUMASK_H */
> -- 
> 2.31.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
