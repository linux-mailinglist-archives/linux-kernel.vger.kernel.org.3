Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443CE483AAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbiADCqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:46:38 -0500
Received: from mga17.intel.com ([192.55.52.151]:30082 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbiADCqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:46:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641264398; x=1672800398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=H96Tm0F+TQLNdpxg3zs/3n8g4VOZzuPmeC4q3qc1jM8=;
  b=PMmUA9fk4QP3P/CYJYm9OwRfRPXXovEZKt5nQ+JeiMgbXVHE1TLcF7hx
   S9zy+LXZoL8wGipnMSfxmgJErJMHWrPTTsVkX6Qt0CP42aTgAaOs8GoRS
   qyzYZMadcthr0NZY7cLQsMJIN0nQyM8F4kni//ImPilMcWZQmQoRDChM2
   bxHAtGKPgFvCXpfGE5pnamsuAZV9gHxJVM7Lmq+Vh1ksZaAhc3MwjX0Zb
   SPzHaHJgdi2j+DSbzz5YAmn4BrTCBhx4dkawWkIFhfU5owO/RKbMQCqi6
   DPJX6nFs2BRvretLXdEYMMY2wom7vSlDZeI+YfZalDyYbolgqiV9sT0Xi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="222817884"
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="222817884"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2022 18:46:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,258,1635231600"; 
   d="scan'208";a="610923983"
Received: from louislifei-optiplex-7050.sh.intel.com (HELO louislifei-OptiPlex-7050) ([10.239.154.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Jan 2022 18:46:36 -0800
Date:   Tue, 4 Jan 2022 10:47:29 +0800
From:   Li Fei1 <fei1.li@intel.com>
To:     Zhou Qingyang <zhou1615@umn.edu>
Cc:     kjlu@umn.edu, reinette.chatre@intel.com, zhi.a.wang@intel.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fei1.li@intel.com
Subject: Re: [PATCH] virt: acrn: fix a memory leak bug in acrn_dev_ioctl()
Message-ID: <20220104024729.GA26952@louislifei-OptiPlex-7050>
References: <20220104023439.33754-1-zhou1615@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220104023439.33754-1-zhou1615@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 10:34:39AM +0800, Zhou Qingyang wrote:
> In acrn_dev_ioctl(), vm_param is not released or passed out on the 
> error path of "if ((vm_param->reserved0 | vm_param->reserved1) != 0)", 
> which could lead to a memory leak.
> 
> Fix this bug by adding a kfree of vm_param on the error path.
> 
> This bug was found by a static analyzer.
> 
> Builds with CONFIG_ACRN_GUEST=y, CONFIG_ACRN_HSM=y show no new warnings, 
> and our static analyzer no longer warns about this code.
> 
> Fixes: 9c5137aedd11 (“9c5137aedd11 virt: acrn: Introduce VM management interfaces”)
> Signed-off-by: Zhou Qingyang <zhou1615@umn.edu>
> ---
> The analysis employs differential checking to identify inconsistent
> security operations (e.g., checks or kfrees) between two code paths
> and confirms that the inconsistent operations are not recovered in 
> the current function or the callers, so they constitute bugs. 
> 
> Note that, as a bug found by static analysis, it can be a false
> positive or hard to trigger. Multiple researchers have cross-reviewed
> the bug.
> 
Hi Qingyang

Thanks a lot to fix this issue. Would you please to help to fix the same issue
in ACRN_IOCTL_SET_VCPU_REGS case ?


>  drivers/virt/acrn/hsm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/virt/acrn/hsm.c b/drivers/virt/acrn/hsm.c
> index 5419794fccf1..205f4c637556 100644
> --- a/drivers/virt/acrn/hsm.c
> +++ b/drivers/virt/acrn/hsm.c
> @@ -136,9 +136,11 @@ static long acrn_dev_ioctl(struct file *filp, unsigned int cmd,
>  		if (IS_ERR(vm_param))
>  			return PTR_ERR(vm_param);
>  
> -		if ((vm_param->reserved0 | vm_param->reserved1) != 0)
> -			return -EINVAL;
> -
> +		if ((vm_param->reserved0 | vm_param->reserved1) != 0) {
> +			ret = -EINVAL;
> +			kfree(vm_param);
> +			break;
> +		}
>  		vm = acrn_vm_create(vm, vm_param);
>  		if (!vm) {
>  			ret = -EINVAL;
> -- 
> 2.25.1
> 
