Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E1D47858F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbhLQH3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:29:50 -0500
Received: from esa4.hc1455-7.c3s2.iphmx.com ([68.232.139.117]:35439 "EHLO
        esa4.hc1455-7.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232167AbhLQH3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:29:49 -0500
IronPort-SDR: EONFwghqfOXhQ7yRCDxHVBD+5qmpH5m4vkgTUTmfuxls2fxNb/R6aEwZQHX2ADtVMIQH2o8b1m
 4jteIitB/nBdFE6Mtqwt0T8RjHK70bCqVjzlQYUaFmp6z1o4gnYa1oa9798fvXeGjJvI3xWBjr
 ka/aOQcOBZdWGYoZq6toHJpEfEI16fPj6YfCpYl6EvQq0dryEyrEY3NI17Fxe9fUPKMJqu/AX0
 JrpY7gM08km1zhKBnzkR0ZHlcWIWblgy909PK73Mb3tAy+FyLcU9lVxvkCz8aV/uPu1WWcVarp
 WfbHCrjWniK8/DJI8IAiaJjX
X-IronPort-AV: E=McAfee;i="6200,9189,10200"; a="56521217"
X-IronPort-AV: E=Sophos;i="5.88,213,1635174000"; 
   d="scan'208";a="56521217"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP; 17 Dec 2021 16:29:47 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 58B7BE0AA0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:29:46 +0900 (JST)
Received: from m3050.s.css.fujitsu.com (msm.b.css.fujitsu.com [10.134.21.208])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 9A82AD9975
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 16:29:45 +0900 (JST)
Received: from localhost.localdomain (unknown [10.125.5.220])
        by m3050.s.css.fujitsu.com (Postfix) with ESMTP id 4BB41A8;
        Fri, 17 Dec 2021 16:29:45 +0900 (JST)
From:   Rei Yamamoto <yamamoto.rei@jp.fujitsu.com>
To:     ming.lei@redhat.com
Cc:     hch@lst.de, kbusch@kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, tglx@linutronix.de, yamamoto.rei@jp.fujitsu.com
Subject: Re: [PATCH] irq: consider cpus on nodes are unbalanced
Date:   Fri, 17 Dec 2021 16:12:54 +0900
Message-Id: <20211217071254.85061-1-yamamoto.rei@jp.fujitsu.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <Ybw0yPhi01lro7m2@T590>
References: <Ybw0yPhi01lro7m2@T590>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 14:57, Ming Lei wrote:
> OK, I can understand the issue now, and only the following part is enough
> since nmsk won't be empty:
> 
> 
> diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
> index f7ff8919dc9b..d2d01565d2ec 100644
> --- a/kernel/irq/affinity.c
> +++ b/kernel/irq/affinity.c
> @@ -269,8 +269,9 @@ static int __irq_build_affinity_masks(unsigned int startvec,
>  	 */
>  	if (numvecs <= nodes) {
>  		for_each_node_mask(n, nodemsk) {
> +			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
>  			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
> -				   node_to_cpumask[n]);
> +				   nmsk);
>  			if (++curvec == last_affv)
>  				curvec = firstvec;
>  		}

OK, I will repost with the above code changes.

Thanks,
Rei

