Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCE05465E3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348318AbiFJLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343951AbiFJLhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:37:32 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D999E6FD34
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:36:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id g2so487887ljk.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2bt8jTYVrowhc1gg8uINAlbLKdSaOnKBxI1tejzJnw0=;
        b=VytV+NMseeOv5ay6lpQ90w3nH/J9TkSL7TDekYgqNJ6A5QUx0JjdEV0LQWDwhoNvvm
         Rz8hppK3LV/Zx32rXRUnaGgGsmX5wt3+Wmt5lTiuSxzOy65Y0u8rI5JHIib+7RFuxjoR
         K4FMqtzyophRWwfQGCU0kfhqOEQ94XiFDzl6um4dsmiYHUWa3LfOkaMwdF1Qku7lIBoX
         +J4huc80z4RkwDz+5pqpvmsCfTSDrhJkZa4kFfpu1icagXacVx0PxFd+2xgKHpaVRf2K
         OAx2EknOTp0kRe54ep30g5Aq3K5hi4ofIym1NY+KaQ9x9OaGRMBB+UILcxymGGjOJClP
         HyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2bt8jTYVrowhc1gg8uINAlbLKdSaOnKBxI1tejzJnw0=;
        b=L5Di9jT7ujYesbeYm6DZGTLjZkc99ggbWwa6GpAuEOctaAPPCiN0xph9rDlJ/QPKxz
         HtFmz6+mSLhurayhVJFujj7Xgs7MxE8RQTF7rhqouQ1g1f4xRLWajZZwOcRoC1P2eejA
         JhIpeIxc2nXqdNRx42xNTHfYaTjIWghCLpquVeZBB+/qx5l8gERo2UXXsCfKW21mg9KV
         oZcFZy89fONjDBQpkP+HGBU2q935ywZXCP9ucZHQGc36YqORMX2NGRCgkTr1Q9iWfenm
         /MHEwPKDfHkGgQfq73fw586YAZ1llvDT4tq8r5o7VvBaJbSggXph5lOsj1o1wgOYo6Rs
         QgQA==
X-Gm-Message-State: AOAM530jjV/V9NGeJ+0D9qMnLJWeTbHd9L0ACcF8QaD47/e4V0X5QScx
        aknSQkc5V15mtP+0U6YEpxm0uGbkWFuGam9C27QYCQ==
X-Google-Smtp-Source: ABdhPJz8nMlzBjn3iuzofJua8K4CiElzoan8JfpHCRGcxYs+YT4rOc7inWwuPW0xOg+L4p23ZR9tOj3oZXYetl1y8Z0=
X-Received: by 2002:a2e:9a82:0:b0:255:77fd:1c2c with SMTP id
 p2-20020a2e9a82000000b0025577fd1c2cmr21978710lji.357.1654861012161; Fri, 10
 Jun 2022 04:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220609110337.1238762-1-jaz@semihalf.com> <20220609110337.1238762-2-jaz@semihalf.com>
 <f62ab257-b2e0-3097-e394-93a9e7a0d2bf@intel.com>
In-Reply-To: <f62ab257-b2e0-3097-e394-93a9e7a0d2bf@intel.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Fri, 10 Jun 2022 13:36:41 +0200
Message-ID: <CAH76GKPo6VL33tBaZyszL8wvjpzJ7hjOg3o1JddaEnuGbwk=dQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: notify hypervisor about guest entering s2idle state
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, Dmytro Maluka <dmy@semihalf.com>,
        Zide Chen <zide.chen@intel.corp-partner.google.com>,
        Peter Fang <peter.fang@intel.corp-partner.google.com>,
        Tomasz Nowicki <tn@semihalf.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sachi King <nakato@nakato.io>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Dunn <daviddunn@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        "open list:KERNEL VIRTUAL MACHINE (KVM)" <kvm@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 9 cze 2022 o 16:27 Dave Hansen <dave.hansen@intel.com> napisa=C5=82(a=
):
>
> On 6/9/22 04:03, Grzegorz Jaszczyk wrote:
> > Co-developed-by: Peter Fang <peter.fang@intel.corp-partner.google.com>
> > Signed-off-by: Peter Fang <peter.fang@intel.corp-partner.google.com>
> > Co-developed-by: Tomasz Nowicki <tn@semihalf.com>
> > Signed-off-by: Tomasz Nowicki <tn@semihalf.com>
> > Signed-off-by: Zide Chen <zide.chen@intel.corp-partner.google.com>
> > Co-developed-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> > ---
> >  Documentation/virt/kvm/x86/hypercalls.rst | 7 +++++++
> >  arch/x86/kvm/x86.c                        | 3 +++
> >  drivers/acpi/x86/s2idle.c                 | 8 ++++++++
> >  include/linux/suspend.h                   | 1 +
> >  include/uapi/linux/kvm_para.h             | 1 +
> >  kernel/power/suspend.c                    | 4 ++++
> >  6 files changed, 24 insertions(+)
>
> What's the deal with these emails?
>
>         zide.chen@intel.corp-partner.google.com
>
> I see a smattering of those in the git logs, but never for Intel folks.

I've kept emails as they were in the original patch and I do not think
I should change them. This is what Zide and Peter originally used.

>
> I'll also say that I'm a bit suspicious of a patch that includes 5
> authors for 24 lines of code.  Did it really take five of you to write
> 24 lines of code?

This patch was built iteratively: original patch comes from Zide and
Peter, I've squashed it with Tomasz later changes and reworked by
myself for upstream. I didn't want to take credentials from any of the
above so ended up with Zide as an author and 3 co-developers. Please
let me know if that's an issue.

Best regards,
Grzegorz
