Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5BD5596827
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 06:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbiHQE0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 00:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHQE0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 00:26:38 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A066071725;
        Tue, 16 Aug 2022 21:26:37 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-333b049f231so90600377b3.1;
        Tue, 16 Aug 2022 21:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Bvy/9Pfbis3IVpMKx38SkeHJHXRbjKHGNZtMW922TLc=;
        b=BN/GzPINQHC9lo4QCbZs3j4FwS6njxrQ1hd+lVcBG3rqvzOEWk/JrvMuarLANIHM/T
         DTv0X/0BuCQ81YZ0BB3TXVENR2j5tnQFTRJ4wPZMFOCsxS4Z2D1T1IiBsNIqlglbGbM2
         hjjMZayq4oNZco56CyeDVvkdS7LGObFEOo6Uei5W59tKbokEybQCAOpBNb7YyR/9bkFe
         z5eONbgAhoMe+sKTxt3gZlrrJKrgNq9MU3blAs1HDCLRA9UUYFCTjSM4KZp6vn1kKjy/
         57I9CsbqmIbdX5gVL4KDD8hT/Xf5FYuMyOKsTFJRvt7VeXKhoDRhetJwr37pITZMB3uw
         etlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Bvy/9Pfbis3IVpMKx38SkeHJHXRbjKHGNZtMW922TLc=;
        b=pb4glntJkze/rs3wVsXUao1zkXO+gxWlli30Vkv2YIYx7A6egr6gBNlHUK8tmrpSyt
         tHXxpm1oIg8J6snWhTFAgaEhp3pNtzRoSXnDGqDHBedQ0uzKISsu1FmdoDgksv4QGH6s
         KH0GatomfsbU7BlELOEdEJA+3M88+4exX+OsNVzWAU9SEvhp0Ap0Y9wb8gw/63K1towk
         JgHGdRdZf5fP68mqh2ZlnEr6vDxAHXPXZLNigKUUEnAWXenwPJ7EsG+Grz8RDR//B5dR
         htWjJRRjO2eZebG8Q9C/88CshO6ER8IDckkRuqtoIQkZXLp8s6de8i7v8g8ra29EmFnp
         hHvQ==
X-Gm-Message-State: ACgBeo27jToTF1tQ5PID82w34QKoOJ3EsR9kCMG3nIG0qg/jMYnc7sGD
        qu23RzJpdu53IBW2u/WOiMpU4fTcTZ8XNDdWUP8=
X-Google-Smtp-Source: AA6agR7UZg63eGvx44ABnzj9B4GB1Una2uz7rHgcASUsetqcJIwIVJMCy3VHvBR9jRzHk2Mvebol7nOlrOs/bk37j2g=
X-Received: by 2002:a25:be44:0:b0:690:8e9:7d19 with SMTP id
 d4-20020a25be44000000b0069008e97d19mr1368381ybm.389.1660710396801; Tue, 16
 Aug 2022 21:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220810050712.9539-1-lukas.bulwahn@gmail.com>
 <20220810050712.9539-4-lukas.bulwahn@gmail.com> <081fa42d-8587-a69e-5e1c-672152ac8c3e@epam.com>
In-Reply-To: <081fa42d-8587-a69e-5e1c-672152ac8c3e@epam.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 17 Aug 2022 06:26:26 +0200
Message-ID: <CAKXUXMx4fBTN5e3aO9Hy2j3==3QDr85bknLxjyGLoT0geUq=jQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] xen: move XEN_BALLOON_MEMORY_HOTPLUG to generic config
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 1:32 PM Oleksandr Tyshchenko
<Oleksandr_Tyshchenko@epam.com> wrote:
>
>
> On 10.08.22 08:07, Lukas Bulwahn wrote:
>
> Hello Lukas, all
>
> > While reviewing arch/x86/configs/xen.config, I noticed the following
> > note in this file:
> >
> >    '# depends on MEMORY_HOTPLUG, arm64 doesn't enable this yet,
> >    '# move to generic config if it ever does.
> >    CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=y
> >
> > Commit 6c6685055a28 ("kconfig: add xenconfig defconfig helper") in June
> > 2015 adds this note. Fortunately, commit 4ab215061554 ("arm64: Add memory
> > hotplug support") from December 2018 adds the memory hotplug in arm64, so
> > the precondition of this note above is now met.
> >
> > Move setting the config XEN_BALLOON_MEMORY_HOTPLUG into the generic
> > xen.config now.
>
>
> I might have missed something but I have never heard of anyone using
> XEN_BALLOON_MEMORY_HOTPLUG on Arm.
>
> Looking into the code, I am afraid, CONFIG_XEN_BALLOON_MEMORY_HOTPLUG
> won't be functional on Arm without reworking resource allocation logic
> in drivers/xen/ballon.c at least, since system "iomem_resource" cannot
> be used on Arm to allocate unused memory region(s), please see
> additional_memory_resource(). I might be wrong, but it feels to me that
> here we would need a similar logic like in
> drivers/xen/unpopulated-alloc.c which is functional on Arm since it uses
> specific Xen resource (on x86 it is just an iomem_resource, but on Arm
> it contains provided by the hypervisor extended regions).
>
> I am not aware of anyone working on it, so I wouldn't enable that
> support on Arm by default until the code is updated.
>

Thanks for the in-depth investigation and explanation. For now, let us
drop this patch here and keep the configs as they are.

Lukas
