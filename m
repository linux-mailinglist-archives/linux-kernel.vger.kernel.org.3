Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2560F4C5AB6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 12:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbiB0LtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 06:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiB0LtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 06:49:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCB51377F8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7710F60E77
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 11:48:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5145C340F3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 11:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645962523;
        bh=mmOPqNQ/HxJGyaWWMIT4Ouh7YX0eIMMLxbT4tqq5Xus=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gr2dE5jnUp80xdh7eyee/f5jlDMsWvA2pOyeD3kMr6lVt2FGAIUff2OuPlTkMmsgN
         IANMyqoaDMUOGINSNAi9SD2SZERG+mP1JJD4BOA9rI0Ni96nAu17RAFcBFnLLRC4SJ
         qyCGeis8uNbifIA0f4cHpYow4/BgOl8Sf1a/hzLp5BM1u72cXOuFgnaK4RBaM6PUNl
         yJvfBORs/rhaTeqwbdjLItrcxMWu22RscOKeNijrzqmIF7Ons8G3lQXY8hrD5HtU+A
         z32Ei0AJ5R0h5mimZuPdh1wNsJ+FIUlcLvyDlFFL4WQKBt9pnCw2TaeW49pG8EloUP
         OT9Qv3HQT3vBg==
Received: by mail-yb1-f179.google.com with SMTP id e140so14990292ybh.9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 03:48:43 -0800 (PST)
X-Gm-Message-State: AOAM533KKm5ab7qteB4C4kk4XmqtPj+KvHc9S0LWcY8Tz4zn9Uyma+yM
        zuUHM++O/L8xpRuAOeXYZCFp0TPcuZKwH1uSJh0=
X-Google-Smtp-Source: ABdhPJxXx1vhYIfuDRkhCb9jZNgMIP6kHfmaR6RyMYaC9vpgagzj7rxWLm5ws3HMQmpB6es66IaSmiLgjTp2IOu3qi4=
X-Received: by 2002:a25:a4e8:0:b0:61e:1eb6:19bd with SMTP id
 g95-20020a25a4e8000000b0061e1eb619bdmr15308801ybi.168.1645962522830; Sun, 27
 Feb 2022 03:48:42 -0800 (PST)
MIME-Version: 1.0
References: <20220227094430.1059796-1-ogabbay@kernel.org> <ef21ffe9-0e9f-0526-7cde-a16b219c8aec@wanadoo.fr>
In-Reply-To: <ef21ffe9-0e9f-0526-7cde-a16b219c8aec@wanadoo.fr>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 27 Feb 2022 13:48:16 +0200
X-Gmail-Original-Message-ID: <CAFCwf10Q5T3w952xdOZmkR5sYbVr+n5RWv5viwcwuOvhJgk12A@mail.gmail.com>
Message-ID: <CAFCwf10Q5T3w952xdOZmkR5sYbVr+n5RWv5viwcwuOvhJgk12A@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: add an option to delay a device reset
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Tomer Tayar <ttayar@habana.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 12:26 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> Hi,
>
> Le 27/02/2022 =C3=A0 10:44, Oded Gabbay a =C3=A9crit :
> > From: Tomer Tayar <ttayar@habana.ai>
> >
> > Several H/W events can be sent adjacently, even due to a single error.
> > If a hard-reset is triggered as part of handling one of these events,
> > the following events won't be handled.
> > The debug info from these missed events is important, sometimes even
> > more important than the one that was handled.
> >
> > To allow handling these close events, add an option to delay a device
> > reset and use it when resetting due to H/W events.
> >
> > Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> > Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
> > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > ---
> >   drivers/misc/habanalabs/common/device.c     | 8 +++++++-
> >   drivers/misc/habanalabs/common/habanalabs.h | 4 ++++
> >   drivers/misc/habanalabs/gaudi/gaudi.c       | 2 +-
> >   3 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/hab=
analabs/common/device.c
> > index d52381d1fbd2..651326cd22fb 100644
> > --- a/drivers/misc/habanalabs/common/device.c
> > +++ b/drivers/misc/habanalabs/common/device.c
> > @@ -13,6 +13,8 @@
> >   #include <linux/pci.h>
> >   #include <linux/hwmon.h>
> >
> > +#define HL_RESET_DELAY_USEC          10000   /* 10ms */
> > +
> >   enum hl_device_status hl_device_status(struct hl_device *hdev)
> >   {
> >       enum hl_device_status status;
> > @@ -980,7 +982,7 @@ int hl_device_reset(struct hl_device *hdev, u32 fla=
gs)
> >   {
> >       bool hard_reset, from_hard_reset_thread, fw_reset, hard_instead_s=
oft =3D false,
> >                       reset_upon_device_release =3D false, schedule_har=
d_reset =3D false,
> > -                     skip_wq_flush =3D false;
> > +                     skip_wq_flush, delay_reset;
> >       u64 idle_mask[HL_BUSY_ENGINES_MASK_EXT_SIZE] =3D {0};
> >       struct hl_ctx *ctx;
> >       int i, rc;
> > @@ -994,6 +996,7 @@ int hl_device_reset(struct hl_device *hdev, u32 fla=
gs)
> >       from_hard_reset_thread =3D !!(flags & HL_DRV_RESET_FROM_RESET_THR=
);
> >       fw_reset =3D !!(flags & HL_DRV_RESET_BYPASS_REQ_TO_FW);
> >       skip_wq_flush =3D !!(flags & HL_DRV_RESET_DEV_RELEASE);
> > +     delay_reset =3D !!(flags && HL_DRV_RESET_DELAY);
>
> s/&&/&/ ?
>
> CJ

Yes, of course you are correct. Thanks for noticing that.
Oded
>
> >
> >       if (!hard_reset && !hdev->asic_prop.supports_soft_reset) {
> >               hard_instead_soft =3D true;
> > @@ -1043,6 +1046,9 @@ int hl_device_reset(struct hl_device *hdev, u32 f=
lags)
> >               hdev->reset_info.in_reset =3D 1;
> >               spin_unlock(&hdev->reset_info.lock);
> >
> > +             if (delay_reset)
> > +                     usleep_range(HL_RESET_DELAY_USEC, HL_RESET_DELAY_=
USEC << 1);
> > +
> >               handle_reset_trigger(hdev, flags);
> >
> >               /* This still allows the completion of some KDMA ops */
> > diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc=
/habanalabs/common/habanalabs.h
> > index cef4717d0916..1edaf6ab67bd 100644
> > --- a/drivers/misc/habanalabs/common/habanalabs.h
> > +++ b/drivers/misc/habanalabs/common/habanalabs.h
> > @@ -142,6 +142,9 @@ enum hl_mmu_page_table_location {
> >    *
> >    * - HL_DRV_RESET_FW_FATAL_ERR
> >    *       Set if reset is due to a fatal error from FW
> > + *
> > + * - HL_DRV_RESET_DELAY
> > + *       Set if a delay should be added before the reset
> >    */
> >
> >   #define HL_DRV_RESET_HARD           (1 << 0)
> > @@ -151,6 +154,7 @@ enum hl_mmu_page_table_location {
> >   #define HL_DRV_RESET_DEV_RELEASE    (1 << 4)
> >   #define HL_DRV_RESET_BYPASS_REQ_TO_FW       (1 << 5)
> >   #define HL_DRV_RESET_FW_FATAL_ERR   (1 << 6)
> > +#define HL_DRV_RESET_DELAY           (1 << 7)
> >
> >   #define HL_MAX_SOBS_PER_MONITOR     8
> >
> > diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/haban=
alabs/gaudi/gaudi.c
> > index 0eed0efae040..21c2b678ff72 100644
> > --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> > +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> > @@ -8199,7 +8199,7 @@ static void gaudi_handle_eqe(struct hl_device *hd=
ev,
> >                                       | HL_DRV_RESET_BYPASS_REQ_TO_FW
> >                                       | fw_fatal_err_flag);
> >       else if (hdev->hard_reset_on_fw_events)
> > -             hl_device_reset(hdev, HL_DRV_RESET_HARD | fw_fatal_err_fl=
ag);
> > +             hl_device_reset(hdev, HL_DRV_RESET_HARD | HL_DRV_RESET_DE=
LAY | fw_fatal_err_flag);
> >       else
> >               hl_fw_unmask_irq(hdev, event_type);
> >   }
>
