Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885EC590572
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbiHKRMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235855AbiHKRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:12:26 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 736F4192BA
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:51:55 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so5627869pjf.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=VJe3fAq5Px2+YocY2NExAuXr90mqD1OBl2Qy/S/GM3c=;
        b=BeW5eY0zOqmEKghf7cHu+OnRbYishvvjtOe1o1ISpid19UB64eqLNZIO6OCRtgLTAP
         /xL+cfSFFu6OjCZVh8HEnQluZO+8o4R8pMxdjYJHr3VlRpp3Y78gCaCvpvXgXYeu69q5
         Iz9GxFh95atnhdhrC9E3OuKzoiyuP4HooUtZ9LhLA3nz97avav41SLkusj7bLDDGCvSS
         nJRHp06ctjPoX5lSE6cU1UVv6XVUl4nreYWztaDz1icAMObL8XtAnecIUGF1iLwyxNqS
         J/5AJM2E2br/Aj9vHoA3d+YSu2sSq9+lD+OY7IyVasAYuQLTntxPPXE/ND2GfluqVI0X
         H3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VJe3fAq5Px2+YocY2NExAuXr90mqD1OBl2Qy/S/GM3c=;
        b=nWdFSVhhmKjdQK4CKnFGnjDCXwvpad+vbcnzJrVPDFXdg9OEf2/HReI9r5nfDMZDEq
         HJIGanH9tn4z4v5NmhM9Ms1I9pVJOBBrm05F2y6yTvbzecTnbDK8zIa82Cy5p/EC4d5P
         xv91IC9STq5S13eQHMX4KmJSIorsonw2zBZJxhc/qfAohgbb94gwWBso8D/9sTsP4wAk
         DVMWxi790HO0TGTCJtmeA73EC6du9ttNsEhqCD9MRej3dNCR4M91690daeyQohlFpcIO
         rrYezcBWS+ieTF9FRqGp0R9zmb41//gWz7baGM6viNwDZ68SyvRqqBJJ8WQ6MG0RuZ/u
         sjGA==
X-Gm-Message-State: ACgBeo3ljFo6RI1ebH3LO66oqejC/ygjonrsZ72Z1lJntA2YlxwN2Q/9
        YzQEDQoXXJcjTaxtwCjU3PIsMw==
X-Google-Smtp-Source: AA6agR5X0/klH2B6O492+UzBb8FzkReyMyEH9tRO3YVOAcLCU3k5/t4xE0OOGTALLdIBQG2Xi71v8Q==
X-Received: by 2002:a17:902:8502:b0:16c:c5c5:a198 with SMTP id bj2-20020a170902850200b0016cc5c5a198mr106836plb.88.1660236714777;
        Thu, 11 Aug 2022 09:51:54 -0700 (PDT)
Received: from google.com ([2620:15c:2d:3:4fcd:efd6:e25b:bec9])
        by smtp.gmail.com with ESMTPSA id a13-20020aa795ad000000b0052e78582aa2sm4258748pfk.181.2022.08.11.09.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 09:51:54 -0700 (PDT)
Date:   Thu, 11 Aug 2022 09:51:49 -0700
From:   Isaac Manjarres <isaacmanjarres@google.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] amba: Remove deferred device addition
Message-ID: <YvUzpSAQDktDPRbR@google.com>
References: <20220727181936.3250466-1-saravanak@google.com>
 <20220809103052.GA1778649@roeck-us.net>
 <CAGETcx_ATE6vy9YhygHnBA2P1GDVi54np-=E+50F+cwnj6Wg4A@mail.gmail.com>
 <0c6ef9a3-bbb1-9f1c-7f00-ceb05589594e@roeck-us.net>
 <CAGETcx8yKqEthtyd8Zb=mqMBNp1TPRXbQOoFp+OxeCoXnTs2kw@mail.gmail.com>
 <1196e002-c07d-44fd-b07a-aa5ae446ea0b@roeck-us.net>
 <YvQnbq2RhMOElQE3@google.com>
 <225747de-4348-58b3-19be-8b14356ab3a0@roeck-us.net>
 <CAGETcx895=9wPF+jnUfiycJ0k8d1S3BA0HLz42nCegtMBeo3LQ@mail.gmail.com>
 <971799be-8c15-fc81-ec71-bbca6483207d@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971799be-8c15-fc81-ec71-bbca6483207d@roeck-us.net>
X-Spam-Status: No, score=-14.5 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 09:09:26PM -0700, Guenter Roeck wrote:
> On 8/10/22 19:28, Saravana Kannan wrote:
> > On Wed, Aug 10, 2022 at 7:03 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > 
> > > On 8/10/22 14:47, Isaac Manjarres wrote:
> > > > On Wed, Aug 10, 2022 at 05:58:58AM -0700, Guenter Roeck wrote:
> > > > > On 8/9/22 20:33, Saravana Kannan wrote:
> > > > > [ ... ]
> > > > > 
> > > > > > 
> > > > > > Can you give me more details on the qemu configuration so I could try
> > > > > > to reproduce it?
> > > > > 
> > > > > qemu-system-arm -M vexpress-a9 -kernel arch/arm/boot/zImage -no-reboot \
> > > > >       -initrd rootfs-armv5.cpio -m 128 \
> > > > >       --append "rdinit=/sbin/init console=ttyAMA0,115200" \
> > > > >       -dtb arch/arm/boot/dts/vexpress-v2p-ca9.dtb \
> > > > >       -nographic -monitor null -serial stdio
> > > > > 
> > > > > using multi_v7_defconfig will hang nicely with your patch applied,
> > > > > and boot as expected without. This was with qemu v7.0, but I am
> > > > > sure older qemu versions will show the same behavior. The initrd
> > > > > used should not matter, but you'll find it at
> > > > > https://github.com/groeck/linux-build-test/blob/master/rootfs/arm-v7/rootfs-armv5.cpio.gz
> > > > > 
> > > > > Guenter
> > > > > 
> > > > Hi Guenter,
> > > > 
> > > > Thanks for the information; I was able to reproduce this on my end as
> > > > well. The following changes fixed the problem for me. Can you please try
> > > > them out?
> > > > 
> > > > diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> > > > index 70f79fc71539..b377f18d8acc 100644
> > > > --- a/drivers/base/dd.c
> > > > +++ b/drivers/base/dd.c
> > > > @@ -881,6 +881,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
> > > >                   dev_dbg(dev, "Device match requests probe deferral\n");
> > > >                   dev->can_match = true;
> > > >                   driver_deferred_probe_add(dev);
> > > > +               /*
> > > > +                * Device can't match with the bus right now, so don't attempt
> > > > +                * to match or bind with other drivers on the bus.
> > > > +                */
> > > > +               return ret;
> > > >           } else if (ret < 0) {
> > > >                   dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> > > >                   return ret;
> > > > @@ -1120,6 +1125,11 @@ static int __driver_attach(struct device *dev, void *data)
> > > >                   dev_dbg(dev, "Device match requests probe deferral\n");
> > > >                   dev->can_match = true;
> > > >                   driver_deferred_probe_add(dev);
> > > > +               /*
> > > > +                * Driver could not match with device, but may match with
> > > > +                * another device on the bus.
> > > > +                */
> > > > +               return 0;
> > > >           } else if (ret < 0) {
> > > >                   dev_dbg(dev, "Bus failed to match device: %d\n", ret);
> > > >                   return ret;
> > > > 
> > 
> > Thanks Isaac for debugging and providing a fix! It's surprising that
> > no one noticed this lack of "return"s for so long.
> > 
> > > 
> > > Most of the tests pass with the above applied, but there is still one crash.
> > 
> > Good to hear it's mostly good now.
> > 
> > > 8<--- cut here ---^M
> > > Unhandled fault: page domain fault (0x81b) at 0x00000122^M
> > > [00000122] *pgd=00000000^M
> > > Internal error: : 81b [#1] ARM^M
> > > Modules linked in:^M
> > > CPU: 0 PID: 1 Comm: swapper Tainted: G                 N 5.19.0+ #1^M
> > > Hardware name: ARM-Versatile (Device Tree Support)^M
> > > PC is at do_alignment_ldrstr+0x7c/0x164^M
> > > LR is at ai_half+0x0/0x4^M
> > > pc : [<c001fa00>]    lr : [<c0ca1278>]    psr: 60000113^M
> > > sp : c8811d68  ip : 00000003  fp : 00000004^M
> > > r10: c05433e4  r9 : c0ca1278  r8 : 00000801^M
> > > r7 : 00000122  r6 : 00000000  r5 : e5823000  r4 : c8811df8^M
> > > r3 : 00000100  r2 : c8811df8  r1 : 00000000  r0 : 00000122^M
> > > Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none^M
> > > Control: 00093177  Table: 01698000  DAC: 00000051^M
> > > Register r0 information: non-paged memory^M
> > > Register r1 information: NULL pointer^M
> > > Register r2 information: 2-page vmalloc region starting at 0xc8810000 allocated at kernel_clone+0x70/0x644^M
> > > Register r3 information: non-paged memory^M
> > > Register r4 information: 2-page vmalloc region starting at 0xc8810000 allocated at kernel_clone+0x70/0x644^M
> > > Register r5 information: non-paged memory^M
> > > Register r6 information: NULL pointer^M
> > > Register r7 information: non-paged memory^M
> > > Register r8 information: non-paged memory^M
> > > Register r9 information: non-slab/vmalloc memory^M
> > > Register r10 information: non-slab/vmalloc memory^M
> > > Register r11 information: non-paged memory^M
> > > Register r12 information: non-paged memory^M
> > > Process swapper (pid: 1, stack limit = 0x(ptrval))^M
> > > Stack: (0xc8811d68 to 0xc8812000)^M
> > > 1d60:                   c8811df8 e5823000 00000000 c00201dc 00000000 00000000^M
> > > 1d80: c0bf2fd4 60000013 00000000 c006c440 00000001 00000000 e5823000 c053cdc0^M
> > > 1da0: 00000000 c0be786c c1496d40 00000801 c0bec3f8 c001ffdc c8811df8 00000122^M
> > > 1dc0: c1496d40 c0bc4858 00000000 c001d66c c12ae950 00000001 c0c5f3b0 c1496d40^M
> > > 1de0: c05433e4 20000013 ffffffff c8811e2c c1496d40 c00095c4 00000001 00000001^M
> > > 1e00: 00000122 00000100 c24d8cc0 c1552c00 00000fff c0c5f230 c1496d40 c24d6e58^M
> > > 1e20: c0bc4858 00000000 c1497330 c8811e48 00000001 c05433e8 20000013 ffffffff^M
> > > 1e40: 00000053 c05433cc ffffffed c1552c00 00000fff c0c5f230 c1496d40 c24d6e58^M
> > > 1e60: c0bc4858 c053a784 c1552c00 c0c5f294 c0c5f294 c053a808 00000000 c1552c00^M
> > > 1e80: c0c5f294 c05d9f94 00000000 c0c5f294 c05d9f74 c0c5f230 c1496d40 c05d7984^M
> > > 1ea0: 00000000 c1540eac c7cd5fb4 c0be786c c0c5f294 c24d6e00 00000000 c05d8b7c^M
> > > 1ec0: c0acccd4 c0c92600 c1496d40 c0c5f294 c0c92600 c1496d40 00000000 c1496d40^M
> > > 1ee0: c0ca1000 c05dab3c c0bb0690 c0c92600 c1496d40 c000a8b0 00000000 00000000^M
> > > 1f00: c14d7e4b c0b5f800 000000bf c0047c5c c0b5e9b4 00000000 c0c92600 c088e078^M
> > > 1f20: c1496d40 00000007 c0c92600 c14d7e00 c0bc4874 c0b5e9b4 c0ca1000 c0bc4858^M
> > > 1f40: 00000000 c0be786c c0bdda90 00000008 c14d7e00 c0bc4878 c0b5e9b4 c0b93230^M
> > > 1f60: 00000007 00000007 00000000 c0b92400 00000000 000000bf 00000000 00000000^M
> > > 1f80: c088e340 00000000 00000000 00000000 00000000 00000000 00000000 c088e350^M
> > > 1fa0: 00000000 c088e340 00000000 c00084f8 00000000 00000000 00000000 00000000^M
> > > 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000^M
> > > 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000^M
> > >    do_alignment_ldrstr from do_alignment+0x200/0x984^M
> > >    do_alignment from do_DataAbort+0x38/0xb8^M
> > >    do_DataAbort from __dabt_svc+0x64/0xa0^M
> > > Exception stack(0xc8811df8 to 0xc8811e40)^M
> > > 1de0:                                                       00000001 00000001^M
> > > 1e00: 00000122 00000100 c24d8cc0 c1552c00 00000fff c0c5f230 c1496d40 c24d6e58^M
> > > 1e20: c0bc4858 00000000 c1497330 c8811e48 00000001 c05433e8 20000013 ffffffff^M
> > >    __dabt_svc from __clk_put+0x34/0x174^M
> > >    __clk_put from amba_read_periphid+0xd8/0x120^M
> > 
> > What the heck! How is clk_put() failing. I'll leave this to Isaac too.
> > 
> > >    amba_read_periphid from amba_match+0x3c/0x84^M
> > >    amba_match from __driver_attach+0x20/0x114^M
> > >    __driver_attach from bus_for_each_dev+0x74/0xc0^M
> > >    bus_for_each_dev from bus_add_driver+0x154/0x1e8^M
> > >    bus_add_driver from driver_register+0x74/0x10c^M
> > >    driver_register from do_one_initcall+0x8c/0x2fc^M
> > >    do_one_initcall from kernel_init_freeable+0x190/0x220^M
> > >    kernel_init_freeable from kernel_init+0x10/0x108^M
> > >    kernel_init from ret_from_fork+0x14/0x3c^M
> > > Exception stack(0xc8811fb0 to 0xc8811ff8)^M
> > > 1fa0:                                     00000000 00000000 00000000 00000000^M
> > > 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000^M
> > > 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000^M
> > > Code: e3a00002 e782310c e8bd8070 e792310c (e4c03001) ^M
> > > ---[ end trace 0000000000000000 ]---^M
> > > Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b^M
> > > 
> > > This is with versatile_defconfig and versatileab. Let me know if you need details.
> > 
> > Is the dts that's generated called versatilbeab.dts?
> > 
> 
> Yes. Here is the qemu command line:
> 
> qemu-system-arm -M versatileab -kernel arch/arm/boot/zImage -no-reboot \
>      -initrd rootfs-armv5.cpio -m 128 \
>      --append "rdinit=/sbin/init console=ttyAMA0,115200 earlycon" \
>      -dtb arch/arm/boot/dts/versatile-ab.dtb -nographic -monitor null \
>      -serial stdio
> 
> Guenter

Thanks for testing that out, and the additional information, Guenter.
I'll look into the crash in __clk_put() and get back to you.

--Isaac
