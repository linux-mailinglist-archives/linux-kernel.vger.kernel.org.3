Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2D5A0AA6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238570AbiHYHsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238566AbiHYHsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:48:08 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49926A3471;
        Thu, 25 Aug 2022 00:48:06 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-3376851fe13so487226207b3.6;
        Thu, 25 Aug 2022 00:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=PBU1Ac7FU7Jrq9hi8wQsrAAPEUe9Qkp77GNUxX6pqSM=;
        b=xEMHLq8EuQfscNz5oWzWVSyXjpjmCqssnzZ/cjWHpsn+wdmaMgRmxDUUVgYZRrJBeu
         GAxWgVz2IO+X6goBANxFxhacpm9bZOfC6IRIL5GI8v98gsWYHfPwRb3iMhyrmVBnEEoo
         YUi9f4Gi5NmFsnXV0c+i1WULyeez4YTgRTjSKpvvkqhWPP7yloOKHO9HNSnsG0dyMJcP
         1m1rpGXnvWuLRR3y61iZSh/kl4NWLY1gw6FRbI5h7eFpYa67stKq3W3OefNNYDEwjvJu
         UrLzXZ6G1+W8XEq6p3kgZbGthDbXv0PJIG2P+Z/6/Ub72//HVGYhzQvca4+6VWpukDuX
         USJw==
X-Gm-Message-State: ACgBeo0xbngwIy6QVFswJFJl33IA7w9arriZakjAIISncq01u3s6Nb79
        Ua45x4dGF3oSndPqpfr8Veh0zynupfdBe9nEEQw=
X-Google-Smtp-Source: AA6agR4y0kxBGgbsLhp6QTmIqCaGRNLr6WO8+0CvY3rg5H2kR1Zj7wu1Ci4OT5u9T8+8OG0e1hiG6UJFns3HXP9QbKk=
X-Received: by 2002:a81:104e:0:b0:336:37f1:9686 with SMTP id
 75-20020a81104e000000b0033637f19686mr2801705ywq.149.1661413685431; Thu, 25
 Aug 2022 00:48:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220812130645.14710-1-sbinding@opensource.cirrus.com>
 <20220825072505.316002-1-ardb@kernel.org> <YwcogrMqqEO5KmPb@paasikivi.fi.intel.com>
In-Reply-To: <YwcogrMqqEO5KmPb@paasikivi.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 25 Aug 2022 09:47:54 +0200
Message-ID: <CAJZ5v0h+NMOPaTBSJEt0boWd2=g6umqAuq4buy7vL+mz=-jusw@mail.gmail.com>
Subject: Re: [PATCH v1] ACPI: Property: Fix type detection of unified integer
 reading functions
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Thu, Aug 25, 2022 at 9:45 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Ard,
>
> On Thu, Aug 25, 2022 at 09:25:05AM +0200, Ard Biesheuvel wrote:
> > > The current code expects the type of the value to be an integer type,
> > > instead the value passed to the macro is a pointer.
> > > Ensure the size comparison uses the correct pointer type to choose the
> > > max value, instead of using the integer type.
> > >
> > > Fixes: 923044133367 ("ACPI: property: Unify integer value reading functions")
> > >
> > > Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
> >
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >
> > Can we get this queued up and sent out please? This is breaking some ACPI arm64
> > systems, which use device properties for their MAC addresses.
> >
> > Some grumbling about the original patch below.
> >
> > > ---
> > >  drivers/acpi/property.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > index 7b3ad8ed2f4e..b1d4a8db89df 100644
> > > --- a/drivers/acpi/property.c
> > > +++ b/drivers/acpi/property.c
> > > @@ -1043,10 +1043,10 @@ static int acpi_data_prop_read_single(const struct acpi_device_data *data,
> > >                             break;                                  \
> > >                     }                                               \
> > >                     if (__items[i].integer.value > _Generic(__val,  \
> > > -                                                           u8: U8_MAX, \
> > > -                                                           u16: U16_MAX, \
> > > -                                                           u32: U32_MAX, \
> > > -                                                           u64: U64_MAX, \
> > > +                                                           u8 *: U8_MAX, \
> > > +                                                           u16 *: U16_MAX, \
> > > +                                                           u32 *: U32_MAX, \
> > > +                                                           u64 *: U64_MAX, \
> > >                                                             default: 0U)) { \
> >
> > Why is there a default here? Having one is what hides the fact that the patch was completely broken.
>
> I think the default can be removed. I can send a patch.

Please do.
