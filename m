Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967114AA19D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240464AbiBDVLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiBDVLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:11:06 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A69C061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:11:05 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so7219744pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RgiksQOc66bKk1Qxc/E2lq0lexiQJ3+V8qY3o3U8E5c=;
        b=x2EfMbj4RgYo9lbuojMbJhCdZA2j8JnOk0dRfvrTPSC/zdiCYyqf9kH+95Z3Uh5s1X
         +hjEUuLkvQ33XAwuIIu2b36t7TYnb4yjM8grYNnuBBqlj4GfDypnIjvOoaXSCWMfPBUq
         82I+28wPMvcQsigwoG7HDEuy7iGZy2urTfdA55S7Ce6xaxVb3Ush3V+zqsu/k13mB7U+
         l92E0+PLgpADLs7/aMg4YkFXz38xPUhvpG3f7QPP9m9sYpDFpQaIydI1VBUz7Q/mQlt+
         WsJG1tIVxG9xNcRAmRF9rSi+X3fsKs5TF/Q/o0RscKJKHm9+eiWr4zCvY07UaoOWGrDS
         MyyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RgiksQOc66bKk1Qxc/E2lq0lexiQJ3+V8qY3o3U8E5c=;
        b=ojHIWqwgGFhmGZC1G6kgndO146H3Gzqu108jd7AxGBaZ87/rjIGMpGx06LT0GheuGs
         gNAaMkDThaXlK41WQJXSxzl/DXyomRvdDWjkwCIbCAA/5p9+gm5UPmzl7+HHens+r2fA
         q3OqY3SNOsCNrNiZBOeR4pudmLlLyW9ldpUKG75TRFwOYCJzhouHxVc4cI3fyEkEpVDN
         vmWabhdYjwLhQEL1uFE0oxOsotOfySwyVeGkJES0broroO0EICmxm0+BC0PGxkNuj6kd
         +mQ0ntima9W7nawwByJScmg/6xoXKvqL3K0LApyrYYTl43saufQ3cOndDmMcpeJ8Vn9F
         s6OA==
X-Gm-Message-State: AOAM532fiUHU83Yn1Dgp3ry1gRP0ehpSKJbfg/6afK0lAc606/eHt1+M
        9f4s0F/toCx7awS9f9GVEnp/yZr0FD3GXYh+HOdmQZHNBv4=
X-Google-Smtp-Source: ABdhPJxns8NvhgbQnMi6I7HTXzW12F5GZ9V3WK7V7keVI+wOCfmxZnDKvKOh+g2Txe3/QHzeTzqm8wTbrEcWbZ4egyY=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr5237256ply.34.1644009064806;
 Fri, 04 Feb 2022 13:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-44-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-44-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 13:10:53 -0800
Message-ID: <CAPcyv4idgNDaxJfj2MZgJnuGyygFJ9ozvrEghSnsR7zXB=pj0A@mail.gmail.com>
Subject: Re: [PATCH V8 43/44] nvdimm/pmem: Enable stray access protection
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 9:55 AM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Now that all valid kernel access' to PMEM have been annotated with
> {__}pgmap_mk_{readwrite,noaccess}() PGMAP_PROTECTION is safe to enable
> in the pmem layer.
>
> Implement the pmem_map_protected() and pmem_mk_{readwrite,noaccess}() to
> communicate this memory has extra protection to the upper layers if
> PGMAP_PROTECTION is specified.
>
> Internally, the pmem driver uses a cached virtual address,
> pmem->virt_addr (pmem_addr).  Use __pgmap_mk_{readwrite,noaccess}()
> directly when PGMAP_PROTECTION is active on the device.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes for V8
>         Rebase to 5.17-rc1
>         Remove global param
>         Add internal structure which uses the pmem device and pgmap
>                 device directly in the *_mk_*() calls.
>         Add pmem dax ops callbacks
>         Use pgmap_protection_available()
>         s/PGMAP_PKEY_PROTECT/PGMAP_PROTECTION
> ---
>  drivers/nvdimm/pmem.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
> index 58d95242a836..2afff8157233 100644
> --- a/drivers/nvdimm/pmem.c
> +++ b/drivers/nvdimm/pmem.c
> @@ -138,6 +138,18 @@ static blk_status_t read_pmem(struct page *page, unsigned int off,
>         return BLK_STS_OK;
>  }
>
> +static void __pmem_mk_readwrite(struct pmem_device *pmem)
> +{
> +       if (pmem->pgmap.flags & PGMAP_PROTECTION)
> +               __pgmap_mk_readwrite(&pmem->pgmap);
> +}
> +
> +static void __pmem_mk_noaccess(struct pmem_device *pmem)
> +{
> +       if (pmem->pgmap.flags & PGMAP_PROTECTION)
> +               __pgmap_mk_noaccess(&pmem->pgmap);
> +}
> +

Per previous feedback let's find a way for the pmem driver to stay out
of the loop, and just let these toggles by pgmap generic operations.
