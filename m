Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6C94AA1A3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbiBDVMt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240638AbiBDVMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:12:47 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD95AC061714
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:12:46 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x3so6212213pll.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VaouZC+y0pCzuA+V41l6/rGosRhmVXwne6sUSr70gfY=;
        b=yJ7ITAUhmokbbTgM/46Xtj2VeUzNC51X4uIYa22QCS7v65/aXn3ZpaRWDtbDkJXBuM
         KKKb71sEZrZlnqSWY4sm0xRuW+Q9hpcj6aIRZ61X+2B0JpbefNGvt/9Y1vreHsf4e4Bp
         a5e/2fP4NoQISp66OfA521yB394CzhZe+wIB926YIHvEJmYU2I4acE4i4LaN/zCR9F+I
         euxXfzFONUH4pemYGAcP5s6d2RntJKDzMezvxMRQ+rU/tfC0HkpJ6POX8FxXgjQrjUde
         TUPHTlyW+IaJF+CGi+kgb9dtCcQ6mDG//rydQlbtdz2tQtSgNFxQRkTHP/oQefw7zaDc
         5fkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VaouZC+y0pCzuA+V41l6/rGosRhmVXwne6sUSr70gfY=;
        b=5imDNfJz1nz3TWD4KxvIX1wfnIFv21LWUhKrHEJDMkeo8F58O9OxdT0OEcEhZ0RPer
         WW1ZtBG2DVzXW1lZQd3UqEfn3qUwNlAGYxWHTdC0TFxMe8NB5J1CiSxHNI80lRAfaW2g
         xOGKkfew3aBeOQyRPcJgMO6Uz7EPZI75YrVSOr78RKXwMrgIXurSZdzuZAcZvJ7OPsOh
         FLrxbfuEBLPbcrBhbss7+GR44ViEgCFtWxxFKxBOXWny1Pm2JQZddEZ9TStFCnSluOq5
         XJnp+mqunj4ljKexEiA369OnJZLHoRBsn2+ZyXFiiDwYsVyaaOJZ9gNk7ENEopvW5imJ
         00ig==
X-Gm-Message-State: AOAM532tsiM/2kZU1OR3jLwQtsNOzX/8CTUMy7eZzrMnbJFTk4bzVokh
        hBZ4RYaY0tJ0++O2BpaH1JMrAb6U5UqOywofIBzV2Q==
X-Google-Smtp-Source: ABdhPJxi+9dRZrFQof6J+CuPdxQjT3Bhel6UHMzo7F8xVzZT4UpxJWX9Inl0DIPWlo0Vu3OuWwJUdXKiddMadSiGLK8=
X-Received: by 2002:a17:902:bcca:: with SMTP id o10mr5132570pls.147.1644009166378;
 Fri, 04 Feb 2022 13:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20220127175505.851391-1-ira.weiny@intel.com> <20220127175505.851391-45-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-45-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 13:12:35 -0800
Message-ID: <CAPcyv4g-_tNk3qJt_CUGCo458xS9FUQ_Dk1CpA3Z+O7bfbHy7Q@mail.gmail.com>
Subject: Re: [PATCH V8 44/44] devdax: Enable stray access protection
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
> Device dax is primarily accessed through user space and kernel access is
> controlled through the kmap interfaces.
>
> Now that all valid kernel initiated access to dax devices have been
> accounted for, turn on PGMAP_PKEYS_PROTECT for device dax.
>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
>
> ---
> Changes for V8
>         Rebase to 5.17-rc1
>         Use pgmap_protection_available()
>         s/PGMAP_PKEYS_PROTECT/PGMAP_PROTECTION/
> ---
>  drivers/dax/device.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
> index d33a0613ed0c..cee375ef2cac 100644
> --- a/drivers/dax/device.c
> +++ b/drivers/dax/device.c
> @@ -452,6 +452,8 @@ int dev_dax_probe(struct dev_dax *dev_dax)
>         if (dev_dax->align > PAGE_SIZE)
>                 pgmap->vmemmap_shift =
>                         order_base_2(dev_dax->align >> PAGE_SHIFT);
> +       if (pgmap_protection_available())
> +               pgmap->flags |= PGMAP_PROTECTION;

Looks good.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
