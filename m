Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61FC346E521
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhLIJMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 04:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhLIJMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 04:12:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A341C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 01:08:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2583B82361
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF42BC004DD;
        Thu,  9 Dec 2021 09:08:24 +0000 (UTC)
Date:   Thu, 9 Dec 2021 09:08:21 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     dan.carpenter@oracle.com, robh@kernel.org, will@kernel.org,
        kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bauerman@linux.ibm.com, qiuguorui1@huawei.com
Subject: Re: [PATCH] arm64: kexec: Fix missing error code 'ret' warning in
 load_other_segments()
Message-ID: <YbHHhRnpR/EtSV3f@arm.com>
References: <20211209004522.91926-1-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209004522.91926-1-nramas@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 04:45:22PM -0800, Lakshmi Ramasubramanian wrote:
> Since commit ac10be5cdbfa ("arm64: Use common
> of_kexec_alloc_and_setup_fdt()"), smatch reports the following warning:
> 
>   arch/arm64/kernel/machine_kexec_file.c:152 load_other_segments()
>   warn: missing error code 'ret'
> 
> Return code is not set to an error code in load_other_segments() when
> of_kexec_alloc_and_setup_fdt() call returns a NULL dtb. This results
> in status success (return code set to 0) being returned from
> load_other_segments().
> 
> Set return code to -ENOMEM if of_kexec_alloc_and_setup_fdt() returns
> NULL dtb.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: ac10be5cdbfa ("arm64: Use common of_kexec_alloc_and_setup_fdt()")
> ---
> Patch created in dt/next branch in git repo
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
> 
>  arch/arm64/kernel/machine_kexec_file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 63634b4d72c1..04d072885e64 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -149,6 +149,7 @@ int load_other_segments(struct kimage *image,
>  					   initrd_len, cmdline, 0);
>  	if (!dtb) {
>  		pr_err("Preparing for new dtb failed\n");
> +		ret = -ENOMEM;
>  		goto out_err;
>  	}

Above the 'if' block we have:

	dtb = of_kexec_alloc_and_setup_fdt(image, initrd_load_addr,
					   initrd_len, cmdline, 0);

Looking at this function, it has several ways to fail, not just on
allocation. However, we assume above that it's always -ENOMEM. We could
do like powerpc and use -EINVAL as more likely than allocation failure
or change of_kexec_alloc_and_setup_fdt() to return ERR_PTR() and we use
that. The latter would be my preferred option, though it probably
doesn't matter much. The second best would be -EINVAL.

-- 
Catalin
