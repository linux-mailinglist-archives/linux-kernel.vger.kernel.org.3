Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBDE524AE6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352903AbiELK7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238426AbiELK7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:59:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D71CCEABAB
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:59:07 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE85C106F;
        Thu, 12 May 2022 03:59:07 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B008A3F66F;
        Thu, 12 May 2022 03:59:06 -0700 (PDT)
Message-ID: <89525069-4fd5-2fd8-20eb-5af240a4bceb@arm.com>
Date:   Thu, 12 May 2022 12:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V2] arch_topology: support parsing cluster_id from DT
Content-Language: en-US
To:     Qing Wang <wangqing@vivo.com>, Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <1652262776-3056-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2022 11:52, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>

[...]

> @@ -582,7 +594,8 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  			}
>  
>  			if (leaf) {
> -				ret = parse_core(c, package_id, core_id++);
> +				ret = parse_core(c, package_id, (depth == 2)?cluster_id : -1,
> +					       core_id++);
>  			} else {
>  				pr_err("%pOF: Non-leaf cluster with core %s\n",
>  				       cluster, name);
> @@ -599,9 +612,6 @@ static int __init parse_cluster(struct device_node *cluster, int depth)
>  	if (leaf && !has_cores)
>  		pr_warn("%pOF: empty cluster\n", cluster);
>  
> -	if (leaf)
> -		package_id++;
> -
>  	return 0;
>  }

The issue I mentioned under
https://lkml.kernel.org/r/bd746cf0-0fdd-1ee6-d394-67fffb5d9b58@arm.com
still exists.

Btw, I recommend the following test strategy.

(A) Create a set of dts files which represent today's topologies in DT:

  (1) 8 CPUs flat (Arm DynamIQ single DSU)

  (2) 2 groups of 4 CPUs (e.g. hikey 960) (which covers Phantom* domain)

  (3) your QC SM8450 Armv9 tri-gear (4-3-1) DynamIQ single DSU w/ shared
      L2 btwn CPU0-1 and CPU2-3.
  ...

 * used in Android

(B) Compile dtb's

  dtc -I dts -O dtb -o foo.dtb foo.dts


(C) Run them under qemu w/ and w/o CONFIG_SCHED_CLUSTER and check:

  sudo qemu-system-aarch64 ... -dtb foo.dtb

  (1) sched domains:

      cat /sys/kernel/debug/sched/domains/cpu*/domain*/name

  (2) sched flags:

      cat /sys/kernel/debug/sched/domains/cpu*/domain*/flags

  (3) cpumasks:

      cat /proc/schedstat | awk '{print $1 " " $2 }' | grep ^[cd]

You can even mention the test results in your patch so that people see
that you already covered them. This will speed up the review-process
enormously.
