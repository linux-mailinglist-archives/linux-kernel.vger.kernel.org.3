Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A0C4BE547
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354329AbiBUKZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 05:25:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353246AbiBUKYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 05:24:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2716C65494
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:44:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u1so25952217wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 01:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xZF9VPY+1TXkileF1qxxCQ2LRDWtQxNEI8s6875dzs4=;
        b=4QHLnrhlwnZcj5DJ3/G46uWsDBuCIetkwxkmd/MdlZ6iEoCOeoU5pPwLqeWW44CU7H
         DI+LsFmwDxfHTSQRa7f0QbbmWh0NxjW1SQI7FSqmYNkRSpBiTer4JrE9sskhsIF6LM1K
         4j9H+gnoduOc3RvTapYELk6FotuQPAJFQWd6FDpQ375pGK+KyPita/wrYEt92iAzfotb
         3FwCa7el23sTY6eIO1PmTC+Kz6+8Q4nSMQXnGDrQyT4PohDuqtoTdJScZCJnWOMjM6F6
         T+FFyrRMjdTGv889Bim0VclYZKsn6uokSai1snou9jMQhg2EOSbLaDdYEqa4IUH0IaKK
         xCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xZF9VPY+1TXkileF1qxxCQ2LRDWtQxNEI8s6875dzs4=;
        b=LZwObT6j2Lntl+LW3vjLpS3tQFEYNzFVkboNWV2QtwikrpCvr5frmKPez1Fh80ATQC
         nRz/Dn8iXUdLeTG2u7UuXu/iXvLt9gZbmIUgCud7xW4aJgH4dreVwoaMRLQaCaYEMiwm
         EOiUZvJ41VF52gYOzGEMkoqH0drdRd/Pdwh5FgtkZagv44gvzI7eqKXMzjRiRahS77CN
         gYoIjGhSMvPyShm8TJ4Yp1DrxTC7kSIPcA7N8Atl30LIlxuN1TiMZk5aqwco7lkIjvYK
         D63A/C0xUHgQvR//5wwINEXgEzNpa6OHpqm5hAA+wRR0vsqrRyrr6yjPBNZHuiEJOqZ7
         aI6A==
X-Gm-Message-State: AOAM531SYojHmYLCIP+znBDAcujbRhRSm0u6Eefa2wBJrkaoxqYnBZv7
        N6bvxD4lVFANC0BWdaqkJdeoseyWw+CWPPa4/UQgyA==
X-Google-Smtp-Source: ABdhPJzxcjh1RSAKHy35QGrgtWqpnYXvOMU3RukzoWMnRQVnYFIlPEMv40fZS1NH1VcazmtLeISGthiK/ESvhfLVWT4=
X-Received: by 2002:a5d:6c6b:0:b0:1ea:77ea:dde8 with SMTP id
 r11-20020a5d6c6b000000b001ea77eadde8mr162179wrz.690.1645436653537; Mon, 21
 Feb 2022 01:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20220128052505.859518-1-apatel@ventanamicro.com>
 <20220128052505.859518-3-apatel@ventanamicro.com> <063b8a5636d6372f37029946b2c3e0f4@kernel.org>
 <CAAhSdy387r314f=YjvXJCxqxkvjm5q-EBOVu420giFzaVr_NYw@mail.gmail.com>
 <31fea18e51a5021b79adb17973f9528e@kernel.org> <4A07582C-80BD-41F8-AEF5-EE48EB7D2D15@jrtc27.com>
 <87ee3w4lmz.wl-maz@kernel.org>
In-Reply-To: <87ee3w4lmz.wl-maz@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 21 Feb 2022 15:14:01 +0530
Message-ID: <CAAhSdy0LAqNerpd+qXwJj8NTTOX+Qu_CjmtpKPJFSbMH-HT_4g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] irqchip/riscv-intc: Create domain using named fwnode
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jessica Clarke <jrtc27@jrtc27.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 2:55 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Sat, 19 Feb 2022 14:51:22 +0000,
> Jessica Clarke <jrtc27@jrtc27.com> wrote:
> >
> > On 19 Feb 2022, at 09:32, Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > But how do you plan to work around the fact that everything is curren=
tly
> > > build around having a node (and an irqdomain) per CPU? The PLIC, for =
example,
> > > clearly has one parent per CPU, not one global parent.
> > >
> > > I'm sure there was a good reason for this, and I suspect merging the =
domains
> > > will simply end up breaking things.
> >
> > On the contrary, the drivers rely on the controller being the same
> > across all harts, with riscv_intc_init skipping initialisation for all
> > but the boot hart=E2=80=99s controller. The bindings are a complete pai=
n to
> > deal with as a result, what you *want* is like you have in the Arm
> > world where there is just one interrupt controller in the device tree
> > with some of the interrupts per-processor, but instead we have this
> > overengineered nuisance. The only reason there are per-hart interrupt
> > controllers is because that=E2=80=99s how the contexts for the CLINT/PL=
IC are
> > specified, but that really should have been done another way rather
> > than abusing the interrupts-extended property for that. In the FreeBSD
> > world we=E2=80=99ve been totally ignoring the device tree nodes for the=
 local
> > interrupt controllers but for my AIA and ACLINT branch I started a few
> > months ago (though ACLINT's now been completely screwed up by RVI
> > politics, things have been renamed and split up differently in the past
> > few days and software interrupts de-prioritised with no current path to
> > ratification, so that was a waste of my time) I just hang the driver
> > off the boot hart=E2=80=99s node and leave all the others as totally ig=
nored
> > and a waste of space other than to figure out the contexts for the PLIC
> > etc.
> >
> > TL;DR yes the bindings are awful, no there=E2=80=99s no issue with merg=
ing the
> > domains.
>
> I don't know how that flies with something like[1], where CPU0 only
> gets interrupts in M-Mode and not S-Mode. Maybe it doesn't really
> matter, but this sort of asymmetric routing is totally backward.

The example PLIC DT node which I provided is from SiFive FU540, where
we have 5 CPUs. The CPU0 in FU540 is a cache-coherent microcontroller
having only M-mode (i.e. No MMU hence not Linux capable).

>
> It sometime feels like the RV folks are actively trying to make this
> architecture a mess... :-/

Well, I still fail to understand what is messy here.

Regards,
Anup

>
>         M.
>
> [1] CAAhSdy0jTTDzoc+3T_8uLiWfBN3AFCWj99Ayc-Yh8FBfzUY2sQ@mail.gmail.com
>
> --
> Without deviation from the norm, progress is not possible.
