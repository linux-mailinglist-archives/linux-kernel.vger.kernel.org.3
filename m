Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1663E4AA221
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 22:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244165AbiBDVS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 16:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348594AbiBDVSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 16:18:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FF2C061795
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 13:17:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id oa14-20020a17090b1bce00b001b61aed4a03so7233743pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 13:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kDEtWBF+FkzY2NKHxDg+IP2BBNRMiosO3bx2fXdN2Zs=;
        b=r42ec818szqLkxWoZYqBAhS9cGcDXcv2mRyuvEfw3F7D16kltjOkJRitiddd3N3+Hj
         JeVRC4RpR1rK8a9E2eMyTEVdh1UQfw8q0ERznMg96qWADTVMDBDsXgRXRrEugON6ECZK
         oKt6+q4iTGJOgzo4xKt1URjxHjbctHnOfnYaXSyL+C5Ts8eRJ6vhStKrEd+gFkRVX6e8
         8zi2NFXX3iz3yR/XwjUeNPXx/642wvWCVAgTpgbBqczj8wdK8Sk+fr43NrNV8m40fgVd
         bGoMDfJC4pFqB4bGrUUZlJaS//ElOsdCn7W6CJs2GlfrNedawjQaPvM+pP9dLzfabw1m
         G3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kDEtWBF+FkzY2NKHxDg+IP2BBNRMiosO3bx2fXdN2Zs=;
        b=akP+M9FWhGbkxlGyfQLWZ2qN9Hjy0X5/dlJFZZSS09uBFbrkvet18gQp51pBwMYBvS
         0wtyBfPlGCmcGXn/xHZlhQU9tZnykCr9CCA0ZzZQANGa+uqVL/2dq2c07jTNf39O2yRg
         m3z6asg7nPLrVWro/by/CJ3go79eQcOgja9zoes+Ge88sFE05Qd2K6C3KGPaNOPXDShF
         N1XffOKWgRp0fESyWXkZ9BhzLg97s1tGmWJTEixR/fJJtrgbh5yc2QEypvqte9z17PCb
         BLTD1AGagAMQ2U9+GWZZYebXyH7XRRr3a9hU7Bc5SjAdo6Av+DXyqXocP6LMk8rh9Cr5
         jamA==
X-Gm-Message-State: AOAM532k5QOugo9LgsLDY5jmreVsXFWAuZm1DaGx+tLUPepnP1x/8Ey+
        D/TETy7EnpTTn0wO/MQNh6otl/WGXvadhk3HwIKW+2XHmiI=
X-Google-Smtp-Source: ABdhPJyYTHXd2SrC9SGFxE2ktHk2dl3UoJFNcRrSZVbTvz8JWMKwrHE3BqN2e3RkLP538tVK3yIoU7ZN4ib1cUV+/Cw=
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr5259433ply.34.1644009420472;
 Fri, 04 Feb 2022 13:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20220201071952.900068-1-ira.weiny@intel.com> <20220201071952.900068-3-ira.weiny@intel.com>
In-Reply-To: <20220201071952.900068-3-ira.weiny@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 4 Feb 2022 13:16:49 -0800
Message-ID: <CAPcyv4hokCBMZCbqZ38-Aj+yMk3H+OmX7Ykn=5-4_jqiCV5Zug@mail.gmail.com>
Subject: Re: [PATCH V6 02/10] PCI: Replace magic constant for PCI Sig Vendor ID
To:     "Weiny, Ira" <ira.weiny@intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 11:20 PM <ira.weiny@intel.com> wrote:
>
> From: Ira Weiny <ira.weiny@intel.com>
>
> Based on Bjorn's suggestion[1], now that the PCI Sig Vendor ID is
> defined the define should be used in pci_bus_crs_vendor_id() rather than
> the hard coded magic value.
>
> Replace the magic value in pci_bus_crs_vendor_id() with
> PCI_VENDOR_ID_PCI_SIG.
>
> [1] https://lore.kernel.org/linux-cxl/20211117215044.GA1777828@bhelgaas/
>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/pci/probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 087d3658f75c..d92dbb136fc9 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2318,7 +2318,7 @@ EXPORT_SYMBOL(pci_alloc_dev);
>
>  static bool pci_bus_crs_vendor_id(u32 l)
>  {
> -       return (l & 0xffff) == 0x0001;
> +       return (l & 0xffff) == PCI_VENDOR_ID_PCI_SIG;
>  }

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
