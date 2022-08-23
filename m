Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B65359EAF2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiHWSZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiHWSZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:25:26 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917267E828;
        Tue, 23 Aug 2022 09:43:02 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3321c2a8d4cso394605777b3.5;
        Tue, 23 Aug 2022 09:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/gDV+GVLpJWz4HxWURgyPhOW3DPummyzOYP/8Om8IFQ=;
        b=qy68F4NsialSef1KpyquY7Srrcn4MXpPTDCmxsWtrWseUDBxoQGyTmoTEWoNwTLUjv
         u+w8PxQ5ACa6Ra0NVMJegZS6KsLQt/XFUWj2PV14G6bekxhvmWopd9scuY30jsiFdEGJ
         fGfrfEtVhwzhWvSLDGuafAJTmracKS2E/mu9gpiG/S4uTWMcER8W285y2ISeCidRKHfl
         GSAB9TmrqPcl7CGX3TuWmRrqaI2ZLRZ1UVDBV+8qnIIHHmc634YBXIxS+OpSrwZQfr7i
         tDWRfp6zTjYwcWkpDaLw0g+IWewARWnavpDcZX7PNTBBt1mRnBMMM8GcyVdJ55lCNzp8
         d0jA==
X-Gm-Message-State: ACgBeo04v+QBf6l8wOD2IDxJqmcX6UN7EEDdoZSpQzLDDmoe2ro4PbPN
        1GREDOwAreTb36PKlGjtgV1mMhx1oTGA+/xQerJYENAR
X-Google-Smtp-Source: AA6agR5TOxKA+4W9IqYAEfEi3Ub3wtwiOglAL943t/fVgPU8CnSRA8MuXK3l/V6I+4AghrSFYoUeEy4UH2suF8quBqU=
X-Received: by 2002:a25:ec0c:0:b0:690:d092:2d56 with SMTP id
 j12-20020a25ec0c000000b00690d0922d56mr23429607ybh.622.1661272981822; Tue, 23
 Aug 2022 09:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <1660649244-146842-1-git-send-email-john.garry@huawei.com>
 <1660649244-146842-3-git-send-email-john.garry@huawei.com>
 <CAHp75VdhCovo1uT3oxQAymEO9X+29oDet7LjYkLvpmj+r15Tfg@mail.gmail.com> <dd41c5c3-ee16-821c-afd4-ddda4443bc78@huawei.com>
In-Reply-To: <dd41c5c3-ee16-821c-afd4-ddda4443bc78@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 23 Aug 2022 18:42:50 +0200
Message-ID: <CAJZ5v0gR0mZBGiCLR6mxdbaNGebti54M-VvV=jT0310KioPD7g@mail.gmail.com>
Subject: Re: [PATCH PoC 2/3] ACPI: platform: Refactor acpi_create_platform_device()
To:     John Garry <john.garry@huawei.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>
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

On Fri, Aug 19, 2022 at 10:10 AM John Garry <john.garry@huawei.com> wrote:
>
> On 18/08/2022 20:41, Andy Shevchenko wrote:
> > On Tue, Aug 16, 2022 at 2:33 PM John Garry <john.garry@huawei.com> wrote:
> >>
> >> There is commonality between acpi_create_platform_device() and
> >> hisi_lpc_acpi_add_child(), in that it covers 2x main steps:
> >> - Read resources for the acpi_device
> >> - Create platform device
> >>
> >> Refactor acpi_create_platform_device() so that it may be reused by
> >> hisi_lpc_acpi_add_child() to reduce duplication.
> >
> > ...
> >
> >> + * acpi_create_platform_device_ops - Create platform device for ACPI device node
> >
> > Not sure I understand why _ops is a suffix for the function. I would
> > expect _ops to be a data struct where the ->xlate() and perhaps other
> > callbacks may be collected. It may be that I have missed that portion
> > in the previous discussion.
>
> ok, maybe I can put all the members into a struct, but I don't think
> that it improves the overall code too much.
>
> >
> > ...
> >
> >> +       if (name)
> >> +               pdevinfo.name = name;
> >> +       else
> >> +               pdevinfo.name = dev_name(&adev->dev);
> >
> >> +       pdevinfo.data = data;
> >> +       pdevinfo.size_data = size_data;
> >
> > It rather reminds me of platform device registration full with this
> > device info. May be what you need is
> > struct acpi_platfrom_device_info {
> >    properties;
> >    name;
> >    id;
> >    ->xlate();
> >    ...
> > };
> >
> > ?
> >
> > ...
> >
> >> +struct platform_device *acpi_create_platform_device_ops(
> >> +                               struct acpi_device *adev,
> >> +                               const char *name,
> >> +                               const struct property_entry *properties,
> >> +                               void *data, size_t size_data,
> >> +                               int (*xlat)(struct acpi_device *adev,
> >> +                                           struct resource *res,
> >> +                                           void *data, size_t size_data),
> >> +                               int id);
> >
> > ...because this looks  a bit too much from the amount of parameters
> > point of view.
> >
>
> ok, agreed.
>
> But even if we improve this code, the hisi_lpc changes are quite large
> and unwieldly.

Well, they allow you to drop quite a few LOC ...
