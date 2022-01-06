Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F5486191
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 09:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236939AbiAFImp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 03:42:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:41317 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236880AbiAFImm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 03:42:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641458562; x=1672994562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sM6TJCgT/V+yPkhx/XfyARE+SklzEJnXQgkZSxob+5M=;
  b=Vmj4HOgl4Mer0ALKoutHEoY+sHvk65d70bIaLYYs11OcwbkEMHU7w/YQ
   jNFBvBzREck/WN7GODzXdD7z5KdRzWQRJelwRSYZZ53VQvk+G/ETMBbIM
   /DHVrrNOLlU0faQ0GDisMy7QakyK6nDCQbGbqPwN5+LMtItCXSoYhATVQ
   fuGdUhVTFGPwXDCQ0/McCcPz+FDTKib4nFJ5AhtK9GfRw6ptGwgke0dCE
   /aMWNVsH9sCCnhVe6MG36wr18IIN2E2tRl6PpHHzCqYrHzDvNDHHNf0ea
   I+WyiEoNFPEpyiB2VkXbQcQN9fOc7cwnEWQEqGwuYO4EK9nHwyD5YSn0s
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="222616209"
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="222616209"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 00:42:40 -0800
X-IronPort-AV: E=Sophos;i="5.88,266,1635231600"; 
   d="scan'208";a="513334267"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 00:42:37 -0800
Date:   Thu, 6 Jan 2022 16:42:07 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org
Subject: Re: [PATCH -next] ACPI: pfr_update: Fix return value check in
 pfru_write()
Message-ID: <20220106084207.GA865257@chenyu-desktop>
References: <20220106075448.3215141-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106075448.3215141-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 03:54:48PM +0800, Yang Yingliang wrote:
> In case of error, memremap() returns NULL pointer not
> ERR_PTR(). The IS_ERR() test in the return value check
> should be replaced with NULL test.
> 
> Fixes: 0db89fa243e5 ("ACPI: Introduce Platform Firmware Runtime Update device driver")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/acpi/pfr_update.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/acpi/pfr_update.c b/drivers/acpi/pfr_update.c
> index 149b5b2530b9..6bb0b778b5da 100644
> --- a/drivers/acpi/pfr_update.c
> +++ b/drivers/acpi/pfr_update.c
> @@ -460,8 +460,8 @@ static ssize_t pfru_write(struct file *file, const char __user *buf,
>  	/* map the communication buffer */
>  	phy_addr = (phys_addr_t)((buf_info.addr_hi << 32) | buf_info.addr_lo);
>  	buf_ptr = memremap(phy_addr, buf_info.buf_size, MEMREMAP_WB);
> -	if (IS_ERR(buf_ptr))
> -		return PTR_ERR(buf_ptr);
> +	if (!buf_ptr)
> +		return -ENOMEM;
>  
>  	if (!copy_from_iter_full(buf_ptr, len, &iter)) {
>  		ret = -EINVAL;
> -- 
> 2.25.1
>
Acked-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
