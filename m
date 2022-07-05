Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3763356779B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbiGETRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGETRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:17:09 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D70E205D9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:17:06 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3137316bb69so118704097b3.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 12:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b1yKxeC9Z/5jempaYRuLBnmQU9rFimOtqV6h5pHbuS0=;
        b=lLw3/dpZh/loyIlpchuxwFZwjADM5DPJWjUVrg10v40/k+57Wh+r8yaNg45lCkM4EI
         0j1QgEyN+apSuc/YvOhP/2yet5lePhoI5sISiSGxgz9FycC9rdKKReNO9Gc1t2TPQwN1
         fDzNIsxQLOkbGa6SeZLKjBWUlazwhQJ/a57gNt/mXluSKQvT3ZPYS2YWn+9wtMAkIp86
         II6PclRQubgsnNRfCzO1f/DA9MUAMrNR1U2khZC6JAcGb8BYb8+/DPNtBQTFYgsXnCdG
         zrlrxnOqyalEZq8TXSmUNEadoAa9esFjG0hIreVD5XfPEnwneUtRMfSCmSCUxHbcw8LI
         Yo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b1yKxeC9Z/5jempaYRuLBnmQU9rFimOtqV6h5pHbuS0=;
        b=wLwADm+94Tt9lXMm2LxJb+ln16OwRNe9nUIuvqvQNqfUtVwKnO6g+mO6AK5xbdem86
         z3u/PzsMqGD6pDzpYiY9134vRqfg9jbbNIkiE3DB1YDMTTshqRafYmRMN70V8NSt3jCu
         Dndwbu1j+KNevgPphEcwpvKlp6knh/ZcbfwtxWHbK7vbBgONAYKaTaBC/JVdh8Dvz8Aa
         Bc1xP6ET029W+t8MRNjjCXGAv5Wb8cVfXq/aJSb4kasAnNzLPd4u6u9iG8OTLH3n6H9W
         O6u/MDixKCk0CbpoU78/HvNIel5ex4r2MUo21YtuS3jDTIQk93wsB49tJXoCiF7z1KeP
         +9Wg==
X-Gm-Message-State: AJIora9e+vNvDh99Fb+hFAHJtQd6WThcF86t0JzWF4pbYigQH8nvDYFE
        ENUrtgW9cD8q9XpxYtVZY9SRruYyE9t/nJPIWpRlCg==
X-Google-Smtp-Source: AGRyM1uq8xowICccMsQI77XiNcaj1ELUkQ83Ly7Twc2++hFf13kAV4m78PeeC3tFU08fKy6NzHjLaaW/5ccKpBsaKhY=
X-Received: by 2002:a0d:cb95:0:b0:31c:85e3:3d70 with SMTP id
 n143-20020a0dcb95000000b0031c85e33d70mr19520581ywd.459.1657048625108; Tue, 05
 Jul 2022 12:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220705083934.3974140-1-saravanak@google.com> <20220705110413.vgu6qcpndjpwh5wv@bogus>
In-Reply-To: <20220705110413.vgu6qcpndjpwh5wv@bogus>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 5 Jul 2022 12:16:28 -0700
Message-ID: <CAGETcx8xSgVYuG3dXXg30+Yb=MKfbz7oQCTEUvEOyi+0yUkR0A@mail.gmail.com>
Subject: Re: [PATCH v4] amba: Remove deferred device addition
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 4:05 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Tue, Jul 05, 2022 at 01:39:34AM -0700, Saravana Kannan wrote:
> > The uevents generated for an amba device need PID and CID information
> > that's available only when the amba device is powered on, clocked and
> > out of reset. So, if those resources aren't available, the information
> > can't be read to generate the uevents. To workaround this requirement,
> > if the resources weren't available, the device addition was deferred and
> > retried periodically.
> >
> > However, this deferred addition retry isn't based on resources becoming
> > available. Instead, it's retried every 5 seconds and causes arbitrary
> > probe delays for amba devices and their consumers.
> >
> > Also, maintaining a separate deferred-probe like mechanism is
> > maintenance headache.
> >
> > With this commit, instead of deferring the device addition, we simply
> > defer the generation of uevents for the device and probing of the device
> > (because drivers needs PID and CID to match) until the PID and CID
> > information can be read. This allows us to delete all the amba specific
> > deferring code and also avoid the arbitrary probing delays.
> >
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: John Stultz <john.stultz@linaro.org>
> > Cc: Saravana Kannan <saravanak@google.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Cc: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > v1 -> v2:
> > - Dropped RFC tag
> > - Complete rewrite to not use stub devices.
> >
> > v2 -> v3:
> > - Flipped the if() condition for hard-coded periphids.
> > - Added a stub driver to handle the case where all amba drivers are
> >   modules loaded by uevents.
> > - Cc Marek after I realized I forgot to add him.
> >
> > v3 -> v4:
> > - Finally figured out and fixed the issue reported by Kefeng (bus match
> >   can't return an error other than -EPROBE_DEFER).
> > - I tested the patch on "V2P-CA15" on qemu
> > - Marek tested v3, but that was so long ago and the rebase wasn't clean,
> >   so I didn't include the tested-by.
> >
> > Marek/Kefeng,
> >
> > Mind giving a Tested-by?
> >
> > -Saravana
> >
> >  drivers/amba/bus.c | 317 +++++++++++++++++++++------------------------
> >  1 file changed, 145 insertions(+), 172 deletions(-)
> >
> > diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
> > index 0e3ed5eb367b..9590c93b2aea 100644
> > --- a/drivers/amba/bus.c
> > +++ b/drivers/amba/bus.c
> > @@ -130,11 +130,100 @@ static struct attribute *amba_dev_attrs[] = {
> >  };
> >  ATTRIBUTE_GROUPS(amba_dev);
> >
> > +static int amba_read_periphid(struct amba_device *dev)
> > +{
> > +     struct reset_control *rstc;
> > +     u32 size, pid, cid;
> > +     void __iomem *tmp;
> > +     int i, ret;
> > +
> > +     ret = dev_pm_domain_attach(&dev->dev, true);
> > +     if (ret) {
> > +             dev_dbg(&dev->dev, "can't get PM domain: %d\n", ret);
> > +             goto err_out;
> > +     }
> > +
> > +     ret = amba_get_enable_pclk(dev);
> > +     if (ret) {
> > +             dev_dbg(&dev->dev, "can't get pclk: %d\n", ret);
> > +             goto err_pm;
> > +     }
> > +
> > +     /*
> > +      * Find reset control(s) of the amba bus and de-assert them.
> > +      */
> > +     rstc = of_reset_control_array_get_optional_shared(dev->dev.of_node);
> > +     if (IS_ERR(rstc)) {
> > +             ret = PTR_ERR(rstc);
> > +             if (ret != -EPROBE_DEFER)
> > +                     dev_err(&dev->dev, "can't get reset: %d\n", ret);
> > +             goto err_clk;
> > +     }
> > +     reset_control_deassert(rstc);
> > +     reset_control_put(rstc);
> > +
> > +     size = resource_size(&dev->res);
> > +     tmp = ioremap(dev->res.start, size);
> > +     if (!tmp) {
> > +             ret = -ENOMEM;
> > +             goto err_clk;
> > +     }
> > +
>
> I am seeing constant crash roughly around here. The read below is triggering
> synchronous external abort.

I didn't touch anything in amba_read_periphid() except add two
dev_dbg() for the error paths. So I'm really surprised that you are
hitting any problems there.

> And adding even a single printk above this
> anywhere seem to be making the issue disappear.

Makes me wonder if there's a timing bug in one of the provider drivers
like pm domain/clk/reset that aren't adding udelays() for the
power/clk/reset signal to propagate in hardware/take effect. And
somehow my patch is increasing the likelihood of hitting it.

> While any prints after
> the below reads just defer the issue and finally hit for some other device
> while it always hits for the first delayed amba device.

This is so strange. I'm guessing qemu doesn't model this?

>
> > +     /*
> > +      * Read pid and cid based on size of resource
> > +      * they are located at end of region
> > +      */
> > +     for (pid = 0, i = 0; i < 4; i++)
> > +             pid |= (readl(tmp + size - 0x20 + 4 * i) & 255) << (i * 8);
> > +     for (cid = 0, i = 0; i < 4; i++)
> > +             cid |= (readl(tmp + size - 0x10 + 4 * i) & 255) << (i * 8);
> > +
>
> I haven't spent time debugging this any further.

I think I'm going to end up needing your help with this one because it
seems to be some hardware related race. Actually, can you try this
patch on 5.18? Basically without my recent changes to linux-next?

Marek/Kefeng,

Can you test it too please? I'm hoping that can shed some additional
light on this.

Or maybe a second set of eyes to review my changes? I did code this
pretty late at night after all :)

Thanks,
Saravana


>
> --
> Regards,
> Sudeep
>
> 1. No logs, always crash
>
> Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
>  Modules linked in:
>  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc5-next-20220705-00001-g69f8b939ba4c #244
>  Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jun 21 2022
>  pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>  pc : amba_read_periphid+0x128/0x270
>  lr : amba_read_periphid+0x114/0x270
>  sp : ffff80000803bc40
>  x29: ffff80000803bc40 x28: f675a09e14a55da9 x27: ffff800009c56068
>  x26: 0000000000000007 x25: ffff00080035f500 x24: ffff0008016c6468
>  x23: ffff80000a5be848 x22: ffff80000a446088 x21: 0000000000000000
>  x20: ffff0008003e1c00 x19: 0000000000001000 x18: ffffffffffffffff
>  x17: 000000000000001c x16: 000000005885f043 x15: ffff000800032a1c
>  x14: ffffffffffffffff x13: 0000000000000000 x12: 0101010101010101
>  x11: ffff800008000000 x10: 0000000022010000 x9 : 0140000000000000
>  x8 : 0040000000000001 x7 : 0000800019e9b000 x6 : 0000000000000000
>  x5 : ffff800048175000 x4 : 0000000000000000 x3 : ffff800008175fe0
>  x2 : 0068000000000f13 x1 : 0000000000000000 x0 : ffff800008175000
>  Call trace:
>   amba_read_periphid+0x128/0x270
>   amba_match+0x24/0x90
>   __driver_attach+0x2c/0x1c4
>   bus_for_each_dev+0x60/0xd0
>   driver_attach+0x24/0x30
>   bus_add_driver+0xf4/0x230
>   driver_register+0xbc/0x110
>   amba_stub_drv_init+0x6c/0x9c
>   do_one_initcall+0x6c/0x1c0
>   kernel_init_freeable+0x34c/0x444
>   kernel_init+0x28/0x13c
>   ret_from_fork+0x10/0x20
>  Code: d1008263 52800004 8b030003 52800006 (b9400062)
>  ---[ end trace 0000000000000000 ]---
>
> 2. With prints after 2 for loops above
>
> amba_read_periphid 20030000.tpiu
> amba_read_periphid 20040000.funnel
> amba_read_periphid 20070000.etr
> amba_read_periphid 20100000.stm
> amba_read_periphid 20120000.replicator
> Internal error: synchronous external abort: 96000210 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.19.0-rc5-next-20220705-00001-g69f8b939ba4c-dirty #243
> Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform, BIOS EDK II Jun 21 2022
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : readl+0x4/0x20
> lr : amba_read_periphid+0x138/0x250
> sp : ffff80000803bc40
> x29: ffff80000803bc40 x28: f675a09e14a55da9 x27: ffff800009c56068
> x26: 0000000000000007 x25: ffff00080035f500 x24: ffff000800248568
> x23: ffff80000a5be848 x22: ffff80000a446088 x21: 0000000000001000
> x20: ffff0008003e1c00 x19: 00000000fffffff4 x18: ffffffffffffffff
> x17: 000000040044ffff x16: 00400032b5503510 x15: 0000000000000000
> x14: ffffffffffffffff x13: 0000000000000000 x12: 0101010101010101
> x11: ffff800008000000 x10: 0000000022010000 x9 : 0140000000000000
> x8 : 0040000000000001 x7 : 0000800019e9b000 x6 : 0000000000000000
> x5 : ffff800048175000 x4 : 0000000000000000 x3 : ffff800008175000
> x2 : ffff800008175fe0 x1 : 0000000000000000 x0 : ffff800008175fe0
> Call trace:
>  readl+0x4/0x20
>  amba_match+0x24/0x90
>  __driver_attach+0x2c/0x1c4
>  bus_for_each_dev+0x60/0xd0
>  driver_attach+0x24/0x30
>  bus_add_driver+0xf4/0x230
>  driver_register+0xbc/0x110
>  amba_stub_drv_init+0x6c/0x9c
>  do_one_initcall+0x6c/0x1c0
>  kernel_init_freeable+0x34c/0x444
>  kernel_init+0x28/0x13c
>  ret_from_fork+0x10/0x20
> Code: d50323bf d65f03c0 00000000 d503233f (b9400000)
> ---[ end trace 0000000000000000 ]---
>
>
>
