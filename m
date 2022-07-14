Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DD2575544
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 20:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237995AbiGNSoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbiGNSo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 14:44:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8742A27C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 11:44:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 27638B8286C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:44:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE232C34114;
        Thu, 14 Jul 2022 18:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657824263;
        bh=JdBd5XGvIS5rTDRTr1iWkJJjxa555AsazYVwoG1Dz2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RjtSG3kaaAZLImu4VZWEEnO2PIyCYjeUI+C3dmlbrWgwj6xnThWky0HF9/DCLlb5p
         yCcp5r0qZdqpyXMdbiqvKgB57CIVcOGA3ApP7NEEUMH/wfdBhqUM0AP655Yh8BVYd1
         TedDfxrfSjOvEOEE21yWcnw2nMPiD0YOGC77Sn+4=
Date:   Thu, 14 Jul 2022 20:44:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Barry Song <21cnbao@gmail.com>,
        Tian Tao <tiantao6@hisilicon.com>,
        Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v4 RESEND] drivers/base: fix userspace break from using
 bin_attributes for cpumap and cpulist
Message-ID: <YtBkA3QvP8JDGbhX@kroah.com>
References: <20220714183021.2924119-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714183021.2924119-1-pauld@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 02:30:21PM -0400, Phil Auld wrote:
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

Git should have asked you to round at 72 columns, right?

And that's one huge wall of text for the first paragraph, can you make
that more readable?

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

You want to cc: stable too, right?

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

Please run checkpatch on your patches before sending them out and
getting grumpy emails from maintainers asking you to run checkpatch on
your patches...

greg k-h
