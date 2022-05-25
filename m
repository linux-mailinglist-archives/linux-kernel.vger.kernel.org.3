Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681EC533E06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 15:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbiEYNjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 09:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbiEYNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 09:39:07 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663542CE24;
        Wed, 25 May 2022 06:39:06 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3003cb4e064so42374997b3.3;
        Wed, 25 May 2022 06:39:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mkTJonZpVVhU9GrXs/xNzBFtjr3IRpy24yQsRWAj/20=;
        b=plZBkCpBNVAMch1NbYkT4xKya/NX3gKK9VN3ihj8taExI8ZxCh9py15GZm3fuzVcQo
         F5o2QYQq7fiZVIvniQJ81KVOQSTK43mx/PM0MtakEh/1TV71gx/WR3cJIVV++oToSDfE
         6/9GXkL0+xgbI1tnflxbHhI0Pk8E+V3tec2jqhtopsTdwq+PqCKUXa8RZQrGgy6xqb5I
         dJWacuPBt5nhymrqRfFlBkWSCuwirI+8v1Wrdv/NZ+nCynp4EwekBSB+Slr2fMrkV9OP
         AMNzjMySbJSWvQdHuUDBOsUzpbJ6GN95mVckeOVrG+Ls7XKboWtfOXlrNlCVc1fwGKAK
         mCHQ==
X-Gm-Message-State: AOAM5303S5BshfOLOJvvFGLY4uj2jQlx4SJBLimmVj7Z4+uzTU1wmxEN
        SRStTy+Ey/IuXQtmrFPsNSPxuh9HDv3keWtTvCdoikzG
X-Google-Smtp-Source: ABdhPJz+6wqL8uwBlWDCIRSBKx+Onpw5iv+Nb+SZkhHBVaSLX6XOzRMPg7UFGkV6mP9jGCvkwM1TXVAbfmI6Zom2N4o=
X-Received: by 2002:a81:8844:0:b0:2fe:a7de:20c2 with SMTP id
 y65-20020a818844000000b002fea7de20c2mr34021814ywf.515.1653485945505; Wed, 25
 May 2022 06:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220523172724.30556-1-sumeet.r.pawnikar@intel.com> <1cbb92bc48793177b24abcb13352c17a3b759542.camel@linux.intel.com>
In-Reply-To: <1cbb92bc48793177b24abcb13352c17a3b759542.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 May 2022 15:38:54 +0200
Message-ID: <CAJZ5v0gNaEbQD8wMuEaWRd6_dxDFdBh05UND+VDHLBWy4X07Kg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: DPTF: Support Meteor Lake
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, May 23, 2022 at 7:35 PM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2022-05-23 at 22:57 +0530, Sumeet Pawnikar wrote:
> > Add Meteor Lake ACPI IDs for DPTF devices.
> >
> > Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
> > Signed-off-by: Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com>
> Replace Signed-off-by
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Applied as 5.19-rc material, thanks!

> > ---
> >  drivers/acpi/dptf/dptf_pch_fivr.c                       | 1 +
> >  drivers/acpi/dptf/dptf_power.c                          | 2 ++
> >  drivers/acpi/dptf/int340x_thermal.c                     | 6 ++++++
> >  drivers/acpi/fan.h                                      | 1 +
> >  drivers/thermal/intel/int340x_thermal/int3400_thermal.c | 1 +
> >  drivers/thermal/intel/int340x_thermal/int3403_thermal.c | 1 +
> >  6 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/acpi/dptf/dptf_pch_fivr.c
> > b/drivers/acpi/dptf/dptf_pch_fivr.c
> > index c0da24c9f8c3..4919e7abe93f 100644
> > --- a/drivers/acpi/dptf/dptf_pch_fivr.c
> > +++ b/drivers/acpi/dptf/dptf_pch_fivr.c
> > @@ -151,6 +151,7 @@ static int pch_fivr_remove(struct platform_device
> > *pdev)
> >  static const struct acpi_device_id pch_fivr_device_ids[] = {
> >         {"INTC1045", 0},
> >         {"INTC1049", 0},
> > +       {"INTC1064", 0},
> >         {"INTC10A3", 0},
> >         {"", 0},
> >  };
> > diff --git a/drivers/acpi/dptf/dptf_power.c
> > b/drivers/acpi/dptf/dptf_power.c
> > index dc1f52a5b3f4..a5f29d061b37 100644
> > --- a/drivers/acpi/dptf/dptf_power.c
> > +++ b/drivers/acpi/dptf/dptf_power.c
> > @@ -231,6 +231,8 @@ static const struct acpi_device_id
> > int3407_device_ids[] = {
> >         {"INTC1050", 0},
> >         {"INTC1060", 0},
> >         {"INTC1061", 0},
> > +       {"INTC1065", 0},
> > +       {"INTC1066", 0},
> >         {"INTC10A4", 0},
> >         {"INTC10A5", 0},
> >         {"", 0},
> > diff --git a/drivers/acpi/dptf/int340x_thermal.c
> > b/drivers/acpi/dptf/int340x_thermal.c
> > index 42a556346548..b7113fa92fa6 100644
> > --- a/drivers/acpi/dptf/int340x_thermal.c
> > +++ b/drivers/acpi/dptf/int340x_thermal.c
> > @@ -27,6 +27,7 @@ static const struct acpi_device_id
> > int340x_thermal_device_ids[] = {
> >         {"INT3532"},
> >         {"INTC1040"},
> >         {"INTC1041"},
> > +       {"INTC1042"},
> >         {"INTC1043"},
> >         {"INTC1044"},
> >         {"INTC1045"},
> > @@ -37,6 +38,11 @@ static const struct acpi_device_id
> > int340x_thermal_device_ids[] = {
> >         {"INTC1050"},
> >         {"INTC1060"},
> >         {"INTC1061"},
> > +       {"INTC1062"},
> > +       {"INTC1063"},
> > +       {"INTC1064"},
> > +       {"INTC1065"},
> > +       {"INTC1066"},
> >         {"INTC10A0"},
> >         {"INTC10A1"},
> >         {"INTC10A2"},
> > diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> > index 44728529a5b6..e7b4b4e4a55e 100644
> > --- a/drivers/acpi/fan.h
> > +++ b/drivers/acpi/fan.h
> > @@ -14,6 +14,7 @@
> >         {"INT3404", }, /* Fan */ \
> >         {"INTC1044", }, /* Fan for Tiger Lake generation */ \
> >         {"INTC1048", }, /* Fan for Alder Lake generation */ \
> > +       {"INTC1063", }, /* Fan for Meteor Lake generation */ \
> >         {"INTC10A2", }, /* Fan for Raptor Lake generation */ \
> >         {"PNP0C0B", } /* Generic ACPI fan */
> >
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > index 79931ddc582a..1ea861473cba 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > @@ -669,6 +669,7 @@ static const struct acpi_device_id
> > int3400_thermal_match[] = {
> >         {"INT3400", 0},
> >         {"INTC1040", 0},
> >         {"INTC1041", 0},
> > +       {"INTC1042", 0},
> >         {"INTC10A0", 0},
> >         {}
> >  };
> > diff --git a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > index 07e25321dfe3..71d084c4c456 100644
> > --- a/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > +++ b/drivers/thermal/intel/int340x_thermal/int3403_thermal.c
> > @@ -285,6 +285,7 @@ static const struct acpi_device_id
> > int3403_device_ids[] = {
> >         {"INT3403", 0},
> >         {"INTC1043", 0},
> >         {"INTC1046", 0},
> > +       {"INTC1062", 0},
> >         {"INTC10A1", 0},
> >         {"", 0},
> >  };
>
