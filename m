Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D396E58A463
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 03:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbiHEBKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 21:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiHEBK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 21:10:29 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE21C1658A;
        Thu,  4 Aug 2022 18:10:27 -0700 (PDT)
Subject: Re: [PATCH] md : Replace snprintf with scnprintf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659661825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZVovro5Ag+pD9/r+qf8uqvxV33xSu7xjMQAA8ihq0w0=;
        b=VhN6XathNqe72otCNwtZIuvcF99UIp6/9+5uOzP3+nkYUYvMMNOykZg0F8TraUyl2dwLBl
        XSTf7lBHj9bVvrNXq2pQPDTqombb771BH6x45qIlWfsmhQUybJbMo/klwr533OFHM1h3Bn
        ZPImV1KN9PErqnaPUM7XHORayR3Dl8U=
To:     Saurabh Sengar <ssengar@linux.microsoft.com>, song@kernel.org,
        shli@fb.com, neilb@suse.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, ssengar@microsoft.com,
        mikelley@microsoft.com
References: <1659633958-32756-1-git-send-email-ssengar@linux.microsoft.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Message-ID: <a939c6f6-1df8-77ac-8366-7121abc2f57b@linux.dev>
Date:   Fri, 5 Aug 2022 09:10:13 +0800
MIME-Version: 1.0
In-Reply-To: <1659633958-32756-1-git-send-email-ssengar@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/5/22 1:25 AM, Saurabh Sengar wrote:
> Current code produces a warning as shown below when total characters
> in the constituent block device names plus the slashes exceeds 200.
> snprintf() returns the number of characters generated from the given
> input, which could cause the expression “200 – len” to wrap around
> to a large positive number. Fix this by using scnprintf() instead,
> which returns the actual number of characters written into the buffer.
>
> [ 1513.267938] ------------[ cut here ]------------
> [ 1513.267943] WARNING: CPU: 15 PID: 37247 at <snip>/lib/vsprintf.c:2509 vsnprintf+0x2c8/0x510
> [ 1513.267944] Modules linked in:  <snip>
> [ 1513.267969] CPU: 15 PID: 37247 Comm: mdadm Not tainted 5.4.0-1085-azure #90~18.04.1-Ubuntu
> [ 1513.267969] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS Hyper-V UEFI Release v4.1 05/09/2022
> [ 1513.267971] RIP: 0010:vsnprintf+0x2c8/0x510
> <-snip->
> [ 1513.267982] Call Trace:
> [ 1513.267986]  snprintf+0x45/0x70
> [ 1513.267990]  ? disk_name+0x71/0xa0
> [ 1513.267993]  dump_zones+0x114/0x240 [raid0]
> [ 1513.267996]  ? _cond_resched+0x19/0x40
> [ 1513.267998]  raid0_run+0x19e/0x270 [raid0]
> [ 1513.268000]  md_run+0x5e0/0xc50
> [ 1513.268003]  ? security_capable+0x3f/0x60
> [ 1513.268005]  do_md_run+0x19/0x110
> [ 1513.268006]  md_ioctl+0x195e/0x1f90
> [ 1513.268007]  blkdev_ioctl+0x91f/0x9f0
> [ 1513.268010]  block_ioctl+0x3d/0x50
> [ 1513.268012]  do_vfs_ioctl+0xa9/0x640
> [ 1513.268014]  ? __fput+0x162/0x260
> [ 1513.268016]  ksys_ioctl+0x75/0x80
> [ 1513.268017]  __x64_sys_ioctl+0x1a/0x20
> [ 1513.268019]  do_syscall_64+0x5e/0x200
> [ 1513.268021]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Fixes: 766038846e875 ("md/raid0: replace printk() with pr_*()")
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>   drivers/md/raid0.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index b21e101..b6f0fc1 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -48,7 +48,7 @@ static void dump_zones(struct mddev *mddev)
>   		int len = 0;
>   
>   		for (k = 0; k < conf->strip_zone[j].nb_dev; k++)
> -			len += snprintf(line+len, 200-len, "%s%s", k?"/":"",
> +			len += scnprintf(line+len, 200-len, "%s%s", k?"/":"",
>   					bdevname(conf->devlist[j*raid_disks
>   							       + k]->bdev, b));
>   		pr_debug("md: zone%d=[%s]\n", j, line);

Acked-by: Guoqing Jiang <guoqing.jiang@linux.dev>

Thanks,
Guoqing
