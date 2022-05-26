Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB051534D17
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244351AbiEZKOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbiEZKOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:14:02 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118865F58
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:14:01 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n8so1083507plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cJRzOpKgtwU4rrRmVY0G9vrNWq/M/GyTzVQS/4EO73M=;
        b=kw6tfDLlv/2wMtAl9/ySnsycGYMBVDM1PY4gGAFJmWDGBshKOu60vIaSpy3kRN4FMw
         Gdbw158BJWeB3Y6NIV8/WgaWu33kw5ZNXeeUmOLcpArVjyNXTp05Gz90KEH9XYCmkE/Q
         WLNuPNhkkVc3GhXhEElA0IrVKUpp8k1p3YMFQiOeN8sxjQnviRu8VjHp5Kq2yq0hhJmN
         2cwLt1kXhmgncnkwK4FSTbA0e6qwloIzM/tgmpHntFJIznFE/35Ii1v/h2dkSKIqPSaY
         VchGopo3XRBEaT4yg2au7r9Fi0hXPJG/63suLBlwPf4KWkHyneyFsZwLw1jqorBGW5MO
         gVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cJRzOpKgtwU4rrRmVY0G9vrNWq/M/GyTzVQS/4EO73M=;
        b=2ILbOaygT+EnHU7y01FakuKCM6x7Ba8ShHtgZb9NjC2uNe3wgclsRATVGP/Op/00ay
         FXxdvYip+9g30fVNSbB5r4waHCz4pJwiDiqsVr4aZE4k5ObbSJfWmgqHqC/+dTn+n4b+
         p55aC8wWOTKrD6FAsgbanDEiQKaE+ftslLRUoCB2w45DstnWj1JQs/k/Dk9WPu+6R69a
         P4rzlro2sHwvnhmYnVbb0UOMeQAM+lM5uuCpikT0oV5C3sas9vlqFP/HYHgYQHXLuCCD
         VKXJczW3sIPn100imNX/S07pOppxlDfolSLh+VGJ9PwbQkzo10KOjVcyczMeCvhkAgBl
         lBbA==
X-Gm-Message-State: AOAM5318yZ32QcCSuPehpS2zj/8Hx5cxMSyDbKMUQuKOYn0TH0tuLS3M
        WC5Ar0xm4DEEmHj04HPHgqIhrg==
X-Google-Smtp-Source: ABdhPJzZkEDR9mScCjsy8EHki8r7EX5qcp+SQ0l9TAfWxkM5LohggkZQCS3MIz6l/wdl311kgxq9Ww==
X-Received: by 2002:a17:90a:55cc:b0:1e0:c4a7:4a59 with SMTP id o12-20020a17090a55cc00b001e0c4a74a59mr1835936pjm.127.1653560040601;
        Thu, 26 May 2022 03:14:00 -0700 (PDT)
Received: from sunil-laptop ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id ce17-20020a17090aff1100b001e09a4afd69sm1090043pjb.7.2022.05.26.03.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:14:00 -0700 (PDT)
Date:   Thu, 26 May 2022 15:43:54 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Sunil V L <sunil.vl@gmail.com>
Subject: Re: [PATCH 5/5] riscv/efi_stub: Support for 64bit boot-hartid
Message-ID: <20220526101354.GA19431@sunil-laptop>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
 <20220525151106.2176147-6-sunilvl@ventanamicro.com>
 <CAMj1kXFhEBv7MVCKZuXdx9=hZx3qWbkATdLDwXAe_Zn9Xyx=dg@mail.gmail.com>
 <1e90b15b-8c73-0de8-2885-1292923b7575@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e90b15b-8c73-0de8-2885-1292923b7575@canonical.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 06:09:05PM +0200, Heinrich Schuchardt wrote:
> On 5/25/22 17:48, Ard Biesheuvel wrote:
> > On Wed, 25 May 2022 at 17:11, Sunil V L <sunilvl@ventanamicro.com> wrote:
> > > 
> > > The boot-hartid can be a 64bit value on RV64 platforms. Currently,
> > > the "boot-hartid" in DT is assumed to be 32bit only. This patch
> > > detects the size of the "boot-hartid" and uses 32bit or 64bit
> > > FDT reads appropriately.
> > > 
> > > Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> > > ---
> > >   drivers/firmware/efi/libstub/riscv-stub.c | 12 +++++++++---
> > >   1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/firmware/efi/libstub/riscv-stub.c b/drivers/firmware/efi/libstub/riscv-stub.c
> > > index 9e85e58d1f27..d748533f1329 100644
> > > --- a/drivers/firmware/efi/libstub/riscv-stub.c
> > > +++ b/drivers/firmware/efi/libstub/riscv-stub.c
> > > @@ -29,7 +29,7 @@ static int get_boot_hartid_from_fdt(void)
> > >   {
> > >          const void *fdt;
> > >          int chosen_node, len;
> > > -       const fdt32_t *prop;
> > > +       const void *prop;
> > > 
> > >          fdt = get_efi_config_table(DEVICE_TREE_GUID);
> > >          if (!fdt)
> > > @@ -40,10 +40,16 @@ static int get_boot_hartid_from_fdt(void)
> > >                  return -EINVAL;
> > > 
> > >          prop = fdt_getprop((void *)fdt, chosen_node, "boot-hartid", &len);
> > > -       if (!prop || len != sizeof(u32))
> > > +       if (!prop)
> > > +               return -EINVAL;
> > > +
> > > +       if (len == sizeof(u32))
> > > +               hartid = (unsigned long) fdt32_to_cpu(*(fdt32_t *)prop);
> > > +       else if (len == sizeof(u64))
> > > +               hartid = (unsigned long) fdt64_to_cpu(*(fdt64_t *)prop);
> > 
> > Does RISC-V care about alignment? A 64-bit quantity is not guaranteed
> > to appear 64-bit aligned in the DT, and the cast violates C alignment
> > rules, so this should probably used get_unaligned_be64() or something
> > like that.
> 
> When running in S-mode the SBI handles unaligned access but this has a
> performance penalty.
> 
> We could use fdt64_to_cpu(__get_unaligned_t(fdt64_t, prop)) here.

Thank you very much for the feedback. Have updated as per your
suggestion and sent V2.

Thanks
Sunil

> 
> Best regards
> 
> Heinrich
> 
> > 
> > 
> > > +       else
> > >                  return -EINVAL;
> > > 
> > > -       hartid = fdt32_to_cpu(*prop);
> > >          return 0;
> > >   }
> > > 
> > > --
> > > 2.25.1
> > > 
> 
