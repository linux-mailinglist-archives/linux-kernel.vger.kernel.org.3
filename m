Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EFE58CCAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbiHHRbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237606AbiHHRbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:31:42 -0400
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB4AB7E3;
        Mon,  8 Aug 2022 10:31:41 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id o15so14687408yba.10;
        Mon, 08 Aug 2022 10:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XE+n3oen5M0Y6e3hQHkhdlIj+r5EImjvF5ySJ/oi7Gg=;
        b=btQfjJT5q/UhTdJ8cImqgtcGMUR6JpYlmbd+PJ7Vdr85OHB/kS030gZxm8D0LxJvl+
         qhq8aO/Hdqn0koxNGSVyMpsbLrCALC+5ZmL3dYpdO3zkloX6Kg3vST7BbXGPtyrVA+aC
         atDrv6OX2h47OJmiiwgtpM0Sty+gCXigpP/67V2wp4WnoTWPUJAjpZbjp4pShsZcjBgm
         bHIsYVNkNlhBhxI0LJ7gHWs8RfRS4vh6R2TgEPtB/S9C3FQctiCQAy1NLOx4l7c4g5Ag
         slOJg4WuGOLYy/3vuFEQKLi3K9lGh75y1def8PKFZ8GPzNOtqIHdrKq71cKW8NdLYmeF
         nXTw==
X-Gm-Message-State: ACgBeo2FreQ+yrb+LkCCwwz6WFa4GXErKu2YLpu9Qp+FXgaMu6IBDEaW
        Kc874QK/xrqlfYSHuxrZ9U9p6V6Hbj00RRSLVVUwznyn
X-Google-Smtp-Source: AA6agR5upNhWU3fVwvA09Is8RJUsteXtRxDRvkNznDvaCZ5QkgtNuY18SStQsaUE4RmZF5tr5yF2iU53FoXtCcjjfTE=
X-Received: by 2002:a5b:40a:0:b0:677:a43b:dcd3 with SMTP id
 m10-20020a5b040a000000b00677a43bdcd3mr16122549ybp.622.1659979901028; Mon, 08
 Aug 2022 10:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220802193503.3092-1-andriy.shevchenko@linux.intel.com> <f2685007-0331-aaea-bfbe-074a3680fc29@redhat.com>
In-Reply-To: <f2685007-0331-aaea-bfbe-074a3680fc29@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 8 Aug 2022 19:31:30 +0200
Message-ID: <CAJZ5v0i7aqURUA3AOpssKCjucPpyys5-KKWgrujxNwxkg_x-+Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: VIOT: Do not dereference fwnode in struct device
To:     Eric Auger <eric.auger@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        iommu@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 3, 2022 at 12:03 PM Eric Auger <eric.auger@redhat.com> wrote:
>
> Hi Andy,
>
> On 8/2/22 21:35, Andy Shevchenko wrote:
> > In order to make the underneath API easier to change in the future,
> > prevent users from dereferencing fwnode from struct device.
> > Instead, use the specific dev_fwnode() and device_match_fwnode()
> > APIs for that.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Applied, thanks!

> > ---
> >  drivers/acpi/viot.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
> > index 647f11cf165d..6132092dab2a 100644
> > --- a/drivers/acpi/viot.c
> > +++ b/drivers/acpi/viot.c
> > @@ -88,7 +88,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
> >               return -ENODEV;
> >       }
> >
> > -     fwnode = pdev->dev.fwnode;
> > +     fwnode = dev_fwnode(&pdev->dev);
> >       if (!fwnode) {
> >               /*
> >                * PCI devices aren't necessarily described by ACPI. Create a
> > @@ -101,7 +101,7 @@ static int __init viot_get_pci_iommu_fwnode(struct viot_iommu *viommu,
> >               }
> >               set_primary_fwnode(&pdev->dev, fwnode);
> >       }
> > -     viommu->fwnode = pdev->dev.fwnode;
> > +     viommu->fwnode = dev_fwnode(&pdev->dev);
> >       pci_dev_put(pdev);
> >       return 0;
> >  }
> > @@ -314,7 +314,7 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
> >               return -ENODEV;
> >
> >       /* We're not translating ourself */
> > -     if (viommu->fwnode == dev->fwnode)
> > +     if (device_match_fwnode(dev, viommu->fwnode))
> >               return -EINVAL;
> >
> >       ops = iommu_ops_from_fwnode(viommu->fwnode);
>
