Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A677E5250BE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355653AbiELO6S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 May 2022 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347344AbiELO6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 10:58:16 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DA45DD1A;
        Thu, 12 May 2022 07:58:15 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id y76so10299937ybe.1;
        Thu, 12 May 2022 07:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4O1k7I/CH4N/aEPXR6lSNVfiMtZH2gmEFshql9wDoQk=;
        b=E/if2hswEDyBPgftn1NQ926dNZQN02lVNY9JHrDcJXXNYGHjCgxXwCmdI4CRIeHToc
         qBn32hd3Vp58eEc1p8pGZQtd8o40MAKfCilKE7TLS9TL9jZWGIpGZL8cpfeqANLCrNmV
         GXh2Nl6ZLIXO1yTV4N0EhVtk3V2I158Z/Bj9F7jWqgVNqY2GfKEOlKXHnLZ5WSWav/m6
         CbTjhxgum+i4TZXcTqJl/RJOBj5fQVRfvn5NezFUkepY/L3d1ZIdcg8RMcJyHRw+3Ah9
         kDvM22XAft9Y7Ufiim3e0pUmSTUP4JdLNecVpMofMijhRqmWQsI1T82v0kmW9paqX3OW
         LiZA==
X-Gm-Message-State: AOAM53003o+dzSwkgMD+kd6R5CJkrt6XpfuMdUNknZA1kuijR2pjPkSk
        TZhWEuilI975MMnjGcPEavHGspqjKNEslagxY8E=
X-Google-Smtp-Source: ABdhPJylzAVZ4tD7vda9G2EjXUeC2XbuORzktWXOI46xz8R/5rp8jCvCD0EwdBJj3k4nCf0F+jmlgu/SFS6MXbcVW70=
X-Received: by 2002:a25:c0d5:0:b0:64a:c6dd:1a00 with SMTP id
 c204-20020a25c0d5000000b0064ac6dd1a00mr160093ybf.365.1652367494726; Thu, 12
 May 2022 07:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220510131136.1103-1-mario.limonciello@amd.com> <CAPpJ_efn1YiLRtbhNwDEr8j+jJfZrHBM9fukDJpuH0czJpgRTQ@mail.gmail.com>
In-Reply-To: <CAPpJ_efn1YiLRtbhNwDEr8j+jJfZrHBM9fukDJpuH0czJpgRTQ@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 12 May 2022 16:58:03 +0200
Message-ID: <CAJZ5v0iUM0oYxFnRZ9g_UGOY43v9ori=pdO2FWVO+L8hKKYfAw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: PM: Block ASUS B1400CEAE from suspend to idle by default
To:     Jian-Hong Pan <jhp@endlessos.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 4:40 AM Jian-Hong Pan <jhp@endlessos.org> wrote:
>
> Mario Limonciello <mario.limonciello@amd.com> 於 2022年5月10日 週二 下午9:11寫道：
> >
> > ASUS B1400CEAE fails to resume from suspend to idle by default.  This was
> > bisected back to commit df4f9bc4fb9c ("nvme-pci: add support for ACPI
> > StorageD3Enable property") but this is a red herring to the problem.
> >
> > Before this commit the system wasn't getting into deepest sleep state.
> > Presumably this commit is allowing entry into deepest sleep state as
> > advertised by firmware, but there are some other problems related to
> > the wakeup.
> >
> > As it is confirmed the system works properly with S3, set the default for
> > this system to S3.
> >
> > Reported-by: Jian-Hong Pan <jhp@endlessos.org>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=215742
> > Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> > ---
> >  drivers/acpi/sleep.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > index c992e57b2c79..3147702710af 100644
> > --- a/drivers/acpi/sleep.c
> > +++ b/drivers/acpi/sleep.c
> > @@ -373,6 +373,18 @@ static const struct dmi_system_id acpisleep_dmi_table[] __initconst = {
> >                 DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
> >                 },
> >         },
> > +       /*
> > +        * ASUS B1400CEAE hangs on resume from suspend (see
> > +        * https://bugzilla.kernel.org/show_bug.cgi?id=215742).
> > +        */
> > +       {
> > +       .callback = init_default_s3,
> > +       .ident = "ASUS B1400CEAE",
> > +       .matches = {
> > +               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> > +               DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
> > +               },
> > +       },
> >         {},
> >  };
> >
> > --
> > 2.34.1
> >
>
> Tested-by: Jian-Hong Pan <jhp@endlessos.org>

Applied as 5.19 material, thanks!
