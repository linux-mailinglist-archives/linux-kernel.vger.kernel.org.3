Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 976C157CEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiGUPMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiGUPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:12:46 -0400
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA07876E89;
        Thu, 21 Jul 2022 08:12:45 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id l11so3220062ybu.13;
        Thu, 21 Jul 2022 08:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8M1nirNTiuqHscQWbBFugbLXKUqQTiiZndKuM5c0HjA=;
        b=ohhn+jEUAfS6VY2AQBx0QVAQkmEC0OzcwnhnkDysy5cnZaNsoN5SZ6YbHs3rKyR2P4
         vu41sjEe9ptoyMd3VGlhyP1HFWt7ywkpIY+ycqW45zfUXeKRrrEWycagma3WhA3ptUkh
         6g014U+SSP3cLBvdh9I4oGUVoRXgQbt9QVLMhsiwx6pQJkKuoGO8CqSgaX+tXmLsbZGI
         1TkaOXn51J3lVp0u0gKHSOEaQdWRZ0IjBV/YBeXP1bSJFJN6k0cjHnCh0M6BQuCbBjy6
         m+45oVd0ATCPvh8vKVJkBvG6UprlpeNdqmtjpwcvD4yK1IGbFTmWNTUYyxgGYPx6qGJV
         0+pg==
X-Gm-Message-State: AJIora+IkUCP5ZEAeFUQgZbud+GGt/iW4uJ+g1wd56OupNmzi50a92gE
        JjWiEdapxQTs7zOdyDf44pxbxCxHO0saCbE3MQfmihih
X-Google-Smtp-Source: AGRyM1tvHclDKZjwe5xPrRwEqXONCS6N+q7O6Z1j1BsG1r3Iw+tI15jWFRZyumgEAkXx4TDxUrFWOTU0bOPiDP6nVF4=
X-Received: by 2002:a05:6902:1207:b0:66e:f2d2:6e91 with SMTP id
 s7-20020a056902120700b0066ef2d26e91mr43366462ybu.153.1658416364750; Thu, 21
 Jul 2022 08:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220712020058.90374-1-gch981213@gmail.com> <CAJZ5v0jjyvWniC8ReZqAgnaoaRm4cr_Vs3pXhddKf9B6+zONLw@mail.gmail.com>
 <8eef6593-ebaf-5b5a-b9b2-c93277d4afaa@amd.com>
In-Reply-To: <8eef6593-ebaf-5b5a-b9b2-c93277d4afaa@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 21 Jul 2022 17:12:33 +0200
Message-ID: <CAJZ5v0isLQVX3EqsokFthY5ka=V4Vse9T52s3EGSv41FKM1iGw@mail.gmail.com>
Subject: Re: [PATCH v6] ACPI: skip IRQ override on AMD Zen platforms
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Tighe Donnelly <tighe.donnelly@protonmail.com>,
        Len Brown <lenb@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 5:39 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> On 7/14/2022 13:35, Rafael J. Wysocki wrote:
> > On Tue, Jul 12, 2022 at 4:01 AM Chuanhong Guo <gch981213@gmail.com> wrote:
> >>
> >> IRQ override isn't needed on modern AMD Zen systems.
> >> There's an active low keyboard IRQ on AMD Ryzen 6000 and it will stay
> >> this way on newer platforms. This IRQ override breaks keyboards for
> >> almost all Ryzen 6000 laptops currently on the market.
> >>
> >> Skip this IRQ override for all AMD Zen platforms because this IRQ
> >> override is supposed to be a workaround for buggy ACPI DSDT and we can't
> >> have a long list of all future AMD CPUs/Laptops in the kernel code.
> >> If a device with buggy ACPI DSDT shows up, a separated list containing
> >> just them should be created.
> >>
> >> Suggested-by: Mario Limonciello <mario.limonciello@amd.com>
> >> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> >
> > I need an ACK from Mario here.
>
> Sure.  As he mentioned this polarity change is needed going forward.
> So if we end up with a similar regression as the Baytrail attempt to
> make this generic and need to revert we'll need to find a different
> heuristic to make it generic on RMB and later.
>
> Acked-by: Mario Limonciello <mario.limonciello@amd.com>
>
> Here's some other tags to pick up too in the commit message.
>
> Tested-by: XiaoYan Li <lxy.lixiaoyan@gmail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216118

Applied as 5.20 material with the above tags added, thanks!

> >> ---
> >> Change sice v5: reworked
> >>
> >>   drivers/acpi/resource.c | 10 ++++++++++
> >>   1 file changed, 10 insertions(+)
> >>
> >> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> >> index c2d494784425..510cdec375c4 100644
> >> --- a/drivers/acpi/resource.c
> >> +++ b/drivers/acpi/resource.c
> >> @@ -416,6 +416,16 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> >>   {
> >>          int i;
> >>
> >> +#ifdef CONFIG_X86
> >> +       /*
> >> +        * IRQ override isn't needed on modern AMD Zen systems and
> >> +        * this override breaks active low IRQs on AMD Ryzen 6000 and
> >> +        * newer systems. Skip it.
> >> +        */
> >> +       if (boot_cpu_has(X86_FEATURE_ZEN))
> >> +               return false;
> >> +#endif
> >> +
> >>          for (i = 0; i < ARRAY_SIZE(skip_override_table); i++) {
> >>                  const struct irq_override_cmp *entry = &skip_override_table[i];
> >>
> >> --
> >> 2.36.1
> >>
>
