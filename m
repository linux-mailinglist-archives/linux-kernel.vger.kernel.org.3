Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B6F59ED1C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiHWUJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiHWUIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:08:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB01B9436
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:26:21 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id s3-20020a17090a2f0300b001facfc6fdbcso15026160pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 12:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=if3Wu5vCv14WPiE5YYFtKJ7NmPwOHQ61EcTR2rYW06Q=;
        b=gb99UBL+xqsO8C3uNt4C/qEgvqPAQNlqzT/mWH210kTh9QHQ9ChDiWKKjXVf5cQQ1z
         ybGH5VLhxUwAS0RLDFB195OxggA9SoMB7b71QplPASrCl84Isek9hCRRxtYHPmWXgYUn
         rA9DplBf48Zdv4VtSCIy+tN1UyKLiPGtAFBrnJc9QG9MCffjTZBklegv8AiFxp6Wz8Sz
         cAXK8KFUQPA7821QnSh7ILC/6jY/EqQ5LC0Bd/puBNegQ5VzOnsCwiM91s2b3ouvI0Mz
         /TyyS+X4ftn/aHzEErRANMAfYmcl2GvJNxSSg1ac/znz36RWYAUwFlAtYER99XR18AaK
         e08g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=if3Wu5vCv14WPiE5YYFtKJ7NmPwOHQ61EcTR2rYW06Q=;
        b=FCWpkYJHUja9nGkZpe6U//5ugQ4gYJq+70XY45Rj0a0za1ULqx5QbEFGS+w4COKKtl
         XR0h0Kzw3u2WDHiWgdjJmSyG8OOBuXLXtzWFmV15Wf6LmY5t2ecsoBnIMAlxh58i1hQr
         T7iN9H9NsTKzYN2c0SPVqv05dlOFau21Jz93/Zk3s0LdM5p6R0DMGYb37ADr8gd/Hwr8
         DNw6MdYDoVa+8apmY3zpmWjc62p/xEtcy5eLbuk09wUrQ2y8mcMiDm1RtYhiKPh9jIUr
         BJgCgmk567i20nZSWtsJ1fp9cYZOYz3aZRL+F8w4mY5AxxsGsMMElskWO6H/bJdulKYo
         FvRA==
X-Gm-Message-State: ACgBeo1KYvhVdISZwSK7IBK0NnIX4l6C3y23g1jRwBpGB1hdb9zoQq6w
        Wt9fA4bhCF5Nd48Rpb9NbnlBnw==
X-Google-Smtp-Source: AA6agR6TKsIjgsl0w9cS4g5nPdI3TS9Zk7RRQuZWRYCfJ3lfV3usrWgaQ4Uki3BtWS7V8s0tFxAxzA==
X-Received: by 2002:a17:902:b410:b0:172:c9d1:7501 with SMTP id x16-20020a170902b41000b00172c9d17501mr18889146plr.106.1661282781182;
        Tue, 23 Aug 2022 12:26:21 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902758600b00172a2a41064sm10732401pll.298.2022.08.23.12.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 12:26:20 -0700 (PDT)
Date:   Tue, 23 Aug 2022 13:26:18 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Julien Massot <julien.massot@iot.bzh>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, rmk+kernel@armlinux.org.uk,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] remoteproc: rcar_rproc: silince address space sparse
 warning
Message-ID: <20220823192618.GB1781852@p14s>
References: <20220808011610.188119-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220808011610.188119-1-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 09:16:09AM +0800, Kefeng Wang wrote:
> Fix sparse warnings,
>    drivers/remoteproc/st_remoteproc.c:98:12: sparse: sparse: incorrect type in assignment (different address spaces) @@
> 	   expected void *va @@     got void [noderef] __iomem * @@
>    drivers/remoteproc/st_remoteproc.c:98:12: sparse:     expected void *va
>    drivers/remoteproc/st_remoteproc.c:98:12: sparse:     got void [noderef] __iomem *
>    ...
>    drivers/remoteproc/st_remoteproc.c:114:20: sparse:     expected void volatile [noderef] __iomem *io_addr
>    drivers/remoteproc/st_remoteproc.c:114:20: sparse:     got void *va
> 
> Add __iomem to io address space 'va' to fix it.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> note: the commit d803336abdbc "(ARM: mm: kill unused runtime hook arch_iounmap())"
> won't introduce the warning, but lkp report issue to me many times,
> let's fix it.
> 
>  drivers/remoteproc/rcar_rproc.c | 2 +-
>  include/linux/remoteproc.h      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

$ ./scripts/checkpatch.pl _PATCH_remoteproc_rcar_rproc_silince_address_space_sparse_warning.patch 
WARNING: A patch subject line should describe the change not the tool that found it
#9: 
Subject: [PATCH] remoteproc: rcar_rproc: silince address space sparse warning

total: 0 errors, 1 warnings, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

_PATCH_remoteproc_rcar_rproc_silince_address_space_sparse_warning.patch has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


> diff --git a/drivers/remoteproc/rcar_rproc.c b/drivers/remoteproc/rcar_rproc.c
> index aa86154109c7..e3363a4cde0a 100644
> --- a/drivers/remoteproc/rcar_rproc.c
> +++ b/drivers/remoteproc/rcar_rproc.c
> @@ -22,7 +22,7 @@ static int rcar_rproc_mem_alloc(struct rproc *rproc,
>  				 struct rproc_mem_entry *mem)
>  {
>  	struct device *dev = &rproc->dev;
> -	void *va;
> +	void __iomem *va;
>  
>  	dev_dbg(dev, "map memory: %pa+%zx\n", &mem->dma, mem->len);
>  	va = ioremap_wc(mem->dma, mem->len);
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 7c943f0a2fc4..c0c950cf7d72 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -330,7 +330,7 @@ struct rproc;
>   * @alloc: specific memory allocator function
>   */
>  struct rproc_mem_entry {
> -	void *va;
> +	void __iomem *va;
>  	bool is_iomem;
>  	dma_addr_t dma;
>  	size_t len;
> -- 
> 2.35.3
> 
