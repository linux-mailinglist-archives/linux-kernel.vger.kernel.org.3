Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB53C515429
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 20:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380189AbiD2TAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380172AbiD2TAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:00:17 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17ADB82C7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:56:57 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q12so7143705pgj.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 11:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUb2AeTNJcZwD078seN9U1UAiMId+LQbZ7Ey7wYnH7M=;
        b=lCZ+u1S+AFvX2KAPzeeyfNspgNzW2MhKZeU9/82UI2hA3U4Y4FzX7+SkEU6yi6zNjz
         Mkdm5qWqL6gaskhqOO+vrjp1EBAP9sjnhovlkU9w32PSxUVIe3H3yn9tlxjDLUJDgQCv
         L7b7Graze7N7RjiBC+Z44qj5QihUoKDeTs4phvkE0Tk9Wzhh59NVtm5sC9bt28DtsF6z
         WG225h0HcSLmvgkkL3WCwXCMJ6YYpMwxnuo4uy1tXKLw8KiaFF2CDHkI2YqrpS4yA6T4
         pLvkDvqeo6qYrMiwg+rwOSsI1kn3SCF94CUvINJThFOSwv2RbXGEmXYQbf2Nq6V9uPqR
         YQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUb2AeTNJcZwD078seN9U1UAiMId+LQbZ7Ey7wYnH7M=;
        b=8E0LsEqZoo0H5I7mHPvnrv2Tpz7DZYgGhiMaxkm6vSiRWYmDaCyurI3p6atbCWBeLH
         5cSM+ASGb6zd7hoCfr5GOZmVSF5nBbQOy9I4UDyCN/+kMtoi4mZASWR29mleK56lLWJn
         UhKEk9a1X/tFBxenXaSGYvxUIZXflPvuNlGkZ+E7mcubeQXxj4JxXiCA/7BUGqnYIERz
         UOWLMP5GoR/8Rnd86iiX/t4sEAvGXFTFqA7FF4b49+ou5vH5+5Kg7H/FSRV9VZvbMrM8
         YF9X0v5MXJMdzXEJWme+aqMY+ZML4Evgc1krfQV+faJpAAFw0D5Dz0BRjlZ17WXyNFD6
         Ij6Q==
X-Gm-Message-State: AOAM532X0UqFQVJ/fwsVtdiZUuHKHfdOFmj5B6RdBCYgXjFV1ULJZSK8
        yivrIn3QjFQ721cp9EBspgUYmd3LFEqj6pzPt6oreg==
X-Google-Smtp-Source: ABdhPJyAQ9fwnpAk2Ts6MauMQOVJu3OiitVnvRuUjeBbPPg4ife6hXfiwPfjwiEmGv5y/CBqMtaclPgDWCA1uvplV9o=
X-Received: by 2002:a62:a105:0:b0:50d:c97b:3084 with SMTP id
 b5-20020a62a105000000b0050dc97b3084mr177523pff.61.1651258617382; Fri, 29 Apr
 2022 11:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220429134039.18252-1-msuchanek@suse.de>
In-Reply-To: <20220429134039.18252-1-msuchanek@suse.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 29 Apr 2022 11:56:46 -0700
Message-ID: <CAPcyv4g7wBJvw-yNz58eGcLYSvsSHOGZsZV8Px=WRacQ5Ur2Og@mail.gmail.com>
Subject: Re: [PATCH] testing: nvdimm: iomap: make __nfit_test_ioremap a macro
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     Linux NVDIMM <nvdimm@lists.linux.dev>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Zou Wei <zou_wei@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 6:41 AM Michal Suchanek <msuchanek@suse.de> wrote:
>
> The ioremap passed as argument to __nfit_test_ioremap can be a macro so
> it cannot be passed as function argument. Make __nfit_test_ioremap into
> a macro so that ioremap can be passed as untyped macro argument.
>

Looks reasonable to me and passes tests, applied.

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  tools/testing/nvdimm/test/iomap.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
> index b752ce47ead3..ea956082e6a4 100644
> --- a/tools/testing/nvdimm/test/iomap.c
> +++ b/tools/testing/nvdimm/test/iomap.c
> @@ -62,16 +62,14 @@ struct nfit_test_resource *get_nfit_res(resource_size_t resource)
>  }
>  EXPORT_SYMBOL(get_nfit_res);
>
> -static void __iomem *__nfit_test_ioremap(resource_size_t offset, unsigned long size,
> -               void __iomem *(*fallback_fn)(resource_size_t, unsigned long))
> -{
> -       struct nfit_test_resource *nfit_res = get_nfit_res(offset);
> -
> -       if (nfit_res)
> -               return (void __iomem *) nfit_res->buf + offset
> -                       - nfit_res->res.start;
> -       return fallback_fn(offset, size);
> -}
> +#define __nfit_test_ioremap(offset, size, fallback_fn) ({              \
> +       struct nfit_test_resource *nfit_res = get_nfit_res(offset);     \
> +       nfit_res ?                                                      \
> +               (void __iomem *) nfit_res->buf + (offset)               \
> +                       - nfit_res->res.start                           \
> +       :                                                               \
> +               fallback_fn((offset), (size)) ;                         \
> +})
>
>  void __iomem *__wrap_devm_ioremap(struct device *dev,
>                 resource_size_t offset, unsigned long size)
> --
> 2.34.1
>
