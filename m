Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AE05762C7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 15:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbiGON1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 09:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiGON1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 09:27:43 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAC979EEF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:27:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id q5so3235420plr.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 06:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0w0kQnLZNCUoA67Subv68HnzjOpEtCqrqlpvwcv8QtQ=;
        b=aQJTeA/7QYoqg4phh6dYbrQSrhVVwmYY+spKooPDbdK0/+3i5UXnK5MMw1/F6ry2/e
         qTCtfYnU6xf2MfjFDlDdR4Ux7++iRsvOhr+NYVNSwL8ImRpCOv4ju2Kw1ED5ovrhkXsr
         /3cPLPIg/KN8FEYj6D7UGhWwYiIEhQUQSDw7KC4kEul7gTCFVJ9pvBQ58S+OfNtCxWgo
         Tex/aWXTs9mccMEc9BzY+3Uk5c7vb6x978y1fzzX8PMgEXdPShX1nGddytJLu2YVEbA9
         fvNefAmRSSpOR2rEd+qpzYaH66WcfPMXIwBxfyCN5WRFZz0nc9XWxevPlzPZQUn66jwf
         X4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0w0kQnLZNCUoA67Subv68HnzjOpEtCqrqlpvwcv8QtQ=;
        b=UW5jQY+/lhH6PcF9RDYtOeByEy7fe9OeebQm278qUhobXph3utyQYZm9oX9M0EQzTi
         cIxThlDWkJH4emEb760fsmDqAcz1OcOhcF80ntL5EWORT5Ujw8rG0QTyiDh16BBVheSB
         LNpxhgOcyuESczwpsT3aXJ9gjbrJJ9M5PPHkyE8vXytgj4cbQ6arY7HA/qGfjCNr2xzD
         zo59lRaA1klwiRaPwquAsGotlOc9JDLNMwKlWJNE8mqdNdq3dhIiWjSFx/laz3VRuZzO
         tXhUmJqdAr5Xk2DRAUi5LkccpuSjiGf1qjQeDp5OCIuB/GB1rCf5Deyv6be193j2xRDL
         A8pQ==
X-Gm-Message-State: AJIora8bLUkloBnvDrRm1Fx+nH4JXHQEYc4AlTlM3eHCvKSk1FyjjrAY
        w3IWYLcLzEISyq7GAp7rcie/F8kAjb8ePJd8sixcHQ==
X-Google-Smtp-Source: AGRyM1uxobt3jQNw8mkgTNw7tHuEHXM0gZenwP8TKU40cNS4zzk/pNnAHQubPXJXXJpyrdH3FzItpK7St541HUkKyP4=
X-Received: by 2002:a17:902:d510:b0:16c:3cd:db78 with SMTP id
 b16-20020a170902d51000b0016c03cddb78mr13974279plg.17.1657891661082; Fri, 15
 Jul 2022 06:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220707125329.378277-1-jaz@semihalf.com> <MN0PR12MB610107D8E99AC05C7884AEE6E2839@MN0PR12MB6101.namprd12.prod.outlook.com>
In-Reply-To: <MN0PR12MB610107D8E99AC05C7884AEE6E2839@MN0PR12MB6101.namprd12.prod.outlook.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Fri, 15 Jul 2022 15:27:30 +0200
Message-ID: <CAH76GKM+bGM77gcPCz1yt=MULOxRW=-TCVFwsn6grP0aGRpsMg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] x86: allow to notify host about guest entering s2idle
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "seanjc@google.com" <seanjc@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmy@semihalf.com" <dmy@semihalf.com>,
        "dbehr@google.com" <dbehr@google.com>,
        "upstream@semihalf.com" <upstream@semihalf.com>,
        "zide.chen@intel.corp-partner.google.com" 
        <zide.chen@intel.corp-partner.google.com>,
        Len Brown <lenb@kernel.org>, Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sachi King <nakato@nakato.io>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:X86 PLATFORM DRIVERS" 
        <platform-driver-x86@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 7 lip 2022 o 17:27 Limonciello, Mario
<Mario.Limonciello@amd.com> napisa=C5=82(a):
>
> [Public]
>
>
>
> > -----Original Message-----
> > From: Grzegorz Jaszczyk <jaz@semihalf.com>
> > Sent: Thursday, July 7, 2022 07:53
> > To: linux-kernel@vger.kernel.org
> > Cc: jaz@semihalf.com; dmy@semihalf.com; Limonciello, Mario
> > <Mario.Limonciello@amd.com>; seanjc@google.com; dbehr@google.com;
> > upstream@semihalf.com; zide.chen@intel.corp-partner.google.com; Rafael =
J.
> > Wysocki <rafael@kernel.org>; Len Brown <lenb@kernel.org>; Hans de Goede
> > <hdegoede@redhat.com>; Mark Gross <markgross@kernel.org>; Pavel Machek
> > <pavel@ucw.cz>; Mika Westerberg <mika.westerberg@linux.intel.com>; Sach=
i
> > King <nakato@nakato.io>; open list:ACPI <linux-acpi@vger.kernel.org>; o=
pen
> > list:X86 PLATFORM DRIVERS <platform-driver-x86@vger.kernel.org>; open
> > list:HIBERNATION (aka Software Suspend, aka swsusp) <linux-
> > pm@vger.kernel.org>
> > Subject: [RFC PATCH 0/2] x86: allow to notify host about guest entering=
 s2idle
> >
> > According to the mailing list discussion [1] about the preferred approa=
ch
> > for notifying hypervisor/VMM about guest entering s2idle state this RFC=
 was
> > implemented.
> >
> > Instead of original hypercall based approach, which involves KVM change=
 [2]
> > and makes it hypervisor specific, implement different mechanism, which
> > takes advantage of MMIO/PIO trapping and makes it hypervisor independen=
t.
> >
> > Patch #1 extends S2Idle ops by new notify handler which will be invoked=
 as
> > a very last command before system actually enters S2Idle states. It als=
o
> > allows to register and use driver specific notification hook which is u=
sed
> > in patch #2.
> >
> > Patch #2 introduces new driver for virtual PMC, which registers
> > acpi_s2idle_dev_ops's notify handler. Its implementation is based on an
> > ACPI _DSM evaluation, which in turn can perform MMIO access and allow t=
o
> > trap and therefore notify the VMM about guest entering S2Idle state.
> >
> > Please see individual patches and commit logs for more verbose descript=
ion.
> >
> > This patchset is marked as RFC since patch #2 implements driver for non
> > existing device "HYPE0001", which ACPI ID was not registered yet.
> > Furthermore the required registration process [3] will not be started
> > before getting positive feedback about this patchset.
> >
> > [1]
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
chw
> > ork.kernel.org%2Fproject%2Flinux-pm%2Fpatch%2F20220609110337.1238762-
> > 2-
> > jaz%40semihalf.com%2F&amp;data=3D05%7C01%7Cmario.limonciello%40amd.co
> > m%7C514a545cf9aa4a7b6d9508da6018138b%7C3dd8961fe4884e608e11a82d9
> > 94e183d%7C0%7C0%7C637927953769026163%7CUnknown%7CTWFpbGZsb3d8
> > eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C3000%7C%7C%7C&amp;sdata=3DRIDiHUNpHUsBYyK3pwGND%2BWJoioXZNCKt
> > mML2%2F1LAxs%3D&amp;reserved=3D0
> > [2]
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpat=
chw
> > ork.kernel.org%2Fproject%2Flinux-pm%2Fpatch%2F20220609110337.1238762-
> > 3-
> > jaz%40semihalf.com%2F&amp;data=3D05%7C01%7Cmario.limonciello%40amd.co
> > m%7C514a545cf9aa4a7b6d9508da6018138b%7C3dd8961fe4884e608e11a82d9
> > 94e183d%7C0%7C0%7C637927953769026163%7CUnknown%7CTWFpbGZsb3d8
> > eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C3000%7C%7C%7C&amp;sdata=3DBqykAwWzO%2BfeGPSsAqTmX13O8F0Vvm3G
> > PL56EpmdSJ8%3D&amp;reserved=3D0
> > [3]
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fuef=
i.org
> > %2FPNP_ACPI_Registry&amp;data=3D05%7C01%7Cmario.limonciello%40amd.co
> > m%7C514a545cf9aa4a7b6d9508da6018138b%7C3dd8961fe4884e608e11a82d9
> > 94e183d%7C0%7C0%7C637927953769026163%7CUnknown%7CTWFpbGZsb3d8
> > eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C3000%7C%7C%7C&amp;sdata=3DQXK52zFXJGEBm6xIv6IFeF7Xxgz4Yp5UmgLSQ
> > diXtlI%3D&amp;reserved=3D0
> >
> > Grzegorz Jaszczyk (2):
> >   suspend: extend S2Idle ops by new notify handler
> >   platform/x86: Add virtual PMC driver used for S2Idle
> >
> >  drivers/acpi/x86/s2idle.c       | 11 +++++
> >  drivers/platform/x86/Kconfig    |  7 ++++
> >  drivers/platform/x86/Makefile   |  1 +
> >  drivers/platform/x86/virt_pmc.c | 73 +++++++++++++++++++++++++++++++++
> >  include/linux/acpi.h            |  1 +
> >  include/linux/suspend.h         |  1 +
> >  kernel/power/suspend.c          |  4 ++
> >  7 files changed, 98 insertions(+)
> >  create mode 100644 drivers/platform/x86/virt_pmc.c
> >
> > --
> > 2.37.0.rc0.161.g10f37bed90-goog
>
> Thanks, you matched the implementation I was expecting.
> This looks fine by me.

Thank you Mario.

Rafael, Sean, Hans - could you please kindly tell if this approach is
ok by you? If so I will want to start the registration process of ACPI
ID required for this series.

Previously Mario suggested that maybe Linux Foundation could own the
namespace and ID for this Virtual PMC device - could you please advise
in this matter?

Thank you in advance,
Grzegorz
