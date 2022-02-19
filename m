Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5EB4BC8F9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 15:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbiBSOvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 09:51:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239513AbiBSOvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 09:51:45 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C1F1E4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 06:51:25 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso10596019wmj.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 06:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rYUHQGVZWG/BJQYQ7GxA8Ug9hwIrIbM8BVOjZ1GKhyY=;
        b=RXYF/VmCEnP1p1poEPWgm1D+RkIkZvkSYTDov+lKU4yvbxZxL4LN5NtF7TlRBOe85m
         oKrUiM+rm3ODP3qxQjC0Kdynx+oCGNCDz+aBxxqIGWnnOLsq00I4FbzHn5vxuAjnjh8J
         EnW8LljsBGvYzUzPx8pq9zhWvvu+D6H2xCJF4iktjwjdAcK0u8cS7db3nW2Fv1D38+cR
         jn4OgaIcWIYNc5hJpJihHoNaAMdh0Y+Lqg04LorBKENv8/6PbRq5Sityya93jXtgt0zH
         NHHMjvmCJ2p361e+PQyy+E4KPjON//POGNn1RPBCIcWxGBk3L5k+MTnOhpqm2QbAW3V6
         NDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rYUHQGVZWG/BJQYQ7GxA8Ug9hwIrIbM8BVOjZ1GKhyY=;
        b=pdEt0jaNzp9ID1PY/C9vLQOKzZQbp0Nf3PmzAJZQcpL8lRBuks03x7XyrUfaqs2MxC
         gQ1KhP7yFErjc33E3GC9naJqvXT9N9uh04nB9VJvxAytXG/I2ADO//rXkIkoaTaJnFT7
         Iar4XI7j21NEWXYYN4N6OUlyx98huXN/fbCsetJ0Nnv+MoXZFPfujJBKkQXu5QtV/jMV
         z4+enTuCi+rO2b31iS1hHbxNjPQpZLqYWrjTHRAUmOkNMc4DsRYe3jTNgB5y8SPBXdaH
         NRfcOlxDpwonVJtjTMxeeXXtVJtXz6yH3xr4qVBmXRXyvQLD4T2k+nY0SX7LnvErB9Y5
         ogiA==
X-Gm-Message-State: AOAM531C1N0lDo71Z79efjEUdkEHHRFE98C7ZEemxJy2pIZoPCYXlEnT
        pP2Lpk0bTM7WKAKaODWEeO/JKA==
X-Google-Smtp-Source: ABdhPJxl+GmlayF0BLCtf01kmDw9RrKO/gguegu3Et+bYmMb7/fCG/VyksHnS+Jk6/5Q0GJAcWrzKw==
X-Received: by 2002:a7b:c196:0:b0:37c:91e0:85f3 with SMTP id y22-20020a7bc196000000b0037c91e085f3mr14702183wmi.172.1645282283954;
        Sat, 19 Feb 2022 06:51:23 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id u7sm36254112wrq.112.2022.02.19.06.51.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Feb 2022 06:51:23 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH v2 2/6] irqchip/riscv-intc: Create domain using named
 fwnode
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <31fea18e51a5021b79adb17973f9528e@kernel.org>
Date:   Sat, 19 Feb 2022 14:51:22 +0000
Cc:     Anup Patel <anup@brainfault.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4A07582C-80BD-41F8-AEF5-EE48EB7D2D15@jrtc27.com>
References: <20220128052505.859518-1-apatel@ventanamicro.com>
 <20220128052505.859518-3-apatel@ventanamicro.com>
 <063b8a5636d6372f37029946b2c3e0f4@kernel.org>
 <CAAhSdy387r314f=YjvXJCxqxkvjm5q-EBOVu420giFzaVr_NYw@mail.gmail.com>
 <31fea18e51a5021b79adb17973f9528e@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Feb 2022, at 09:32, Marc Zyngier <maz@kernel.org> wrote:
>=20
> On 2022-02-19 03:38, Anup Patel wrote:
>> On Thu, Feb 17, 2022 at 8:42 PM Marc Zyngier <maz@kernel.org> wrote:
>>> On 2022-01-28 05:25, Anup Patel wrote:
>>> > We should create INTC domain using a synthetic fwnode which will =
allow
>>> > drivers (such as RISC-V SBI IPI driver, RISC-V timer driver, =
RISC-V
>>> > PMU driver, etc) not having dedicated DT/ACPI node to directly =
create
>>> > interrupt mapping for standard local interrupt numbers defined by =
the
>>> > RISC-V privileged specification.
>>> >
>>> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
>>> > ---
>>> >  arch/riscv/include/asm/irq.h      |  2 ++
>>> >  arch/riscv/kernel/irq.c           | 13 +++++++++++++
>>> >  drivers/clocksource/timer-clint.c | 13 +++++++------
>>> >  drivers/clocksource/timer-riscv.c | 11 ++---------
>>> >  drivers/irqchip/irq-riscv-intc.c  | 12 ++++++++++--
>>> >  drivers/irqchip/irq-sifive-plic.c | 19 +++++++++++--------
>>> >  6 files changed, 45 insertions(+), 25 deletions(-)
>>> >
>>> > diff --git a/arch/riscv/include/asm/irq.h
>>> > b/arch/riscv/include/asm/irq.h
>>> > index e4c435509983..f85ebaf07505 100644
>>> > --- a/arch/riscv/include/asm/irq.h
>>> > +++ b/arch/riscv/include/asm/irq.h
>>> > @@ -12,6 +12,8 @@
>>> >
>>> >  #include <asm-generic/irq.h>
>>> >
>>> > +extern struct fwnode_handle *riscv_intc_fwnode(void);
>>> > +
>>> >  extern void __init init_IRQ(void);
>>> >
>>> >  #endif /* _ASM_RISCV_IRQ_H */
>>> > diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
>>> > index 7207fa08d78f..f2fed78ab659 100644
>>> > --- a/arch/riscv/kernel/irq.c
>>> > +++ b/arch/riscv/kernel/irq.c
>>> > @@ -7,9 +7,22 @@
>>> >
>>> >  #include <linux/interrupt.h>
>>> >  #include <linux/irqchip.h>
>>> > +#include <linux/irqdomain.h>
>>> > +#include <linux/module.h>
>>> >  #include <linux/seq_file.h>
>>> >  #include <asm/smp.h>
>>> >
>>> > +static struct fwnode_handle *intc_fwnode;
>>> > +
>>> > +struct fwnode_handle *riscv_intc_fwnode(void)
>>> > +{
>>> > +     if (!intc_fwnode)
>>> > +             intc_fwnode =3D =
irq_domain_alloc_named_fwnode("RISCV-INTC");
>>> > +
>>> > +     return intc_fwnode;
>>> > +}
>>> > +EXPORT_SYMBOL_GPL(riscv_intc_fwnode);
>>> Why is this created outside of the root interrupt controller driver?
>>> Furthermore, why do you need to create a new fwnode the first place?
>>> As far as I can tell, the INTC does have a node, and what you don't
>>> have is the firmware linkage between PMU (an others) and the INTC.
>> Fair enough, I will update this patch to not create a synthetic =
fwnode.
>> The issue is not with INTC driver. We have other drivers and places
>> (such as SBI IPI driver, SBI PMU driver, and KVM RISC-V AIA support)
>> where we don't have a way to locate INTC fwnode.
>=20
> And that's exactly what I am talking about: The INTC is OK (sort of),
> but the firmware is too crap for words, and isn't even able to expose
> where the various endpoints route their interrupts to.
>=20
> Yes, this is probably fine today because you can describe the topology
> of RISC-V systems on the surface of a post stamp. Once you get to the
> complexity of a server-grade SoC (or worse, a mobile phone style SoC),
> this *implicit topology* stuff doesn't fly, because there is no =
guarantee
> that all endpoints will always all point to the same controller.
>=20
>>> what you should have instead is something like:
>>> static struct fwnode_handle *(*__get_root_intc_node)(void);
>>> struct fwnode_handle *riscv_get_root_intc_hwnode(void)
>>> {
>>>         if (__get_root_intc_node)
>>>                 return __get_root_intc_node();
>>>         return NULL;
>>> }
>>> and the corresponding registration interface.
>> Thanks, I will follow this suggestion. This is a much better approach
>> and it will avoid touching existing drivers.
>>> But either way, something breaks: the INTC has one node per CPU, and
>>> expect one irqdomain per CPU. Having a single fwnode completely =
breaks
>>> the INTC driver (and probably the irqdomain list, as we don't check =
for
>>> duplicate entries).
>>> > diff --git a/drivers/irqchip/irq-riscv-intc.c
>>> > b/drivers/irqchip/irq-riscv-intc.c
>>> > index b65bd8878d4f..26ed62c11768 100644
>>> > --- a/drivers/irqchip/irq-riscv-intc.c
>>> > +++ b/drivers/irqchip/irq-riscv-intc.c
>>> > @@ -112,8 +112,16 @@ static int __init riscv_intc_init(struct
>>> > device_node *node,
>>> >       if (riscv_hartid_to_cpuid(hartid) !=3D smp_processor_id())
>>> >               return 0;
>>> >
>>> > -     intc_domain =3D irq_domain_add_linear(node, BITS_PER_LONG,
>>> > -                                         &riscv_intc_domain_ops, =
NULL);
>>> > +     /*
>>> > +      * Create INTC domain using a synthetic fwnode which will =
allow
>>> > +      * drivers (such as RISC-V SBI IPI driver, RISC-V timer =
driver,
>>> > +      * RISC-V PMU driver, etc) not having dedicated DT/ACPI node =
to
>>> > +      * directly create interrupt mapping for standard local =
interrupt
>>> > +      * numbers defined by the RISC-V privileged specification.
>>> > +      */
>>> > +     intc_domain =3D =
irq_domain_create_linear(riscv_intc_fwnode(),
>>> > +                                            BITS_PER_LONG,
>>> > +                                            =
&riscv_intc_domain_ops, NULL);
>>> This is what I'm talking about. It is simply broken. So either you =
don't
>>> need a per-CPU node (and the DT was bad the first place), or you
>>> absolutely need
>>> one (and the whole 'well-known/default domain' doesn't work at all).
>>> Either way, this patch is plain wrong.
>> Okay, I will update this patch with the new approach which you =
suggested.
>=20
> But how do you plan to work around the fact that everything is =
currently
> build around having a node (and an irqdomain) per CPU? The PLIC, for =
example,
> clearly has one parent per CPU, not one global parent.
>=20
> I'm sure there was a good reason for this, and I suspect merging the =
domains
> will simply end up breaking things.

On the contrary, the drivers rely on the controller being the same
across all harts, with riscv_intc_init skipping initialisation for all
but the boot hart=E2=80=99s controller. The bindings are a complete pain =
to
deal with as a result, what you *want* is like you have in the Arm
world where there is just one interrupt controller in the device tree
with some of the interrupts per-processor, but instead we have this
overengineered nuisance. The only reason there are per-hart interrupt
controllers is because that=E2=80=99s how the contexts for the =
CLINT/PLIC are
specified, but that really should have been done another way rather
than abusing the interrupts-extended property for that. In the FreeBSD
world we=E2=80=99ve been totally ignoring the device tree nodes for the =
local
interrupt controllers but for my AIA and ACLINT branch I started a few
months ago (though ACLINT's now been completely screwed up by RVI
politics, things have been renamed and split up differently in the past
few days and software interrupts de-prioritised with no current path to
ratification, so that was a waste of my time) I just hang the driver
off the boot hart=E2=80=99s node and leave all the others as totally =
ignored
and a waste of space other than to figure out the contexts for the PLIC
etc.

TL;DR yes the bindings are awful, no there=E2=80=99s no issue with =
merging the
domains.

Jess

