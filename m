Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72615589A15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 11:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiHDJtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 05:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiHDJta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 05:49:30 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A8325C51
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 02:49:28 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id j1so16228157wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=jf6rQzWg9XKx/4I7TLqmE7aH4TSjEP5xXPJunNqSOyo=;
        b=YyR4TFTALZdOKf6UBX8SDF3Px8qtx8DUe449U0on/FHPvOlKR1mppH2M9R6o+HMU1B
         HJEczZ3Iu4kE3jpHQeHLzJU+bICJBzgAttQumRjJUyPX2GaxoL06yhk3BhRVPHLtGUSg
         D1xyeqHYcbGD+ql7RlmL/2dLdga1eObVFrptcCGh2inU+35g6etgkYF5aODPwUv4eGWY
         fYwL9vRyjZniZPyUpPKatwZbBztduliAAFP9HakU5ZT072lQ54FygCEQlfmFkxs0FqiM
         iQCIwM3/s7DBk1w29IvcTAowkYYVXg9PUZqQb4Zm86BeQkmoC47wMKpFHyiOMcyBc4KJ
         cPHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=jf6rQzWg9XKx/4I7TLqmE7aH4TSjEP5xXPJunNqSOyo=;
        b=7hZmAmD0SmFPFprVig4nAUPdnBPDIiz5ZowAaylSojLh+VuzoISzJ5bm3oC7++FsuA
         5wmL+fH3TVcMAAMvgxM5BoMgdzKfBPsc0aP+8tYM5IFhrwzGQcXnIhS5Vh6hEK/NiHHK
         OX0Nr6bVyDfhbsekfV+o/bPtmgoZ/b8N07GhhbRcgJ7rkBBFN4Jgzl7cxL4Hztfrql0/
         e/5BMCE/mVDP6Ql2rMBOq/tUNZ0F0O09t80041x3QqJHthLd8/1xe1cSvrNp0ngMiTBy
         BKq/tDjg0DE3ot5HY7vyGCLELOgMyuxwwIsoYB1m0SdGO0ZEG6tqIUiBkXzefVkcB92o
         OT1w==
X-Gm-Message-State: ACgBeo0xEm4zQRdMkPQ2PJd8icmhqWbpYIDB09wO6n8TkFPFz579i8sS
        2xhp6GcXGJ66YACxCTxyOCgMhZ4DGtRM0vh9qh8=
X-Google-Smtp-Source: AA6agR7xLOWYmPNSQmmTeLo+20pG87QI8F2XC5TJ2AqFstiTtnsMHYG62WaR/6cgnhISHEN3k2q2M0UAJNx+FNhoFpI=
X-Received: by 2002:a5d:410a:0:b0:220:5ff7:3968 with SMTP id
 l10-20020a5d410a000000b002205ff73968mr801540wrp.689.1659606567069; Thu, 04
 Aug 2022 02:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220622003140.30365-1-pgwipeout@gmail.com> <88f2de00-32e3-ed74-082f-c0972a81f0f8@fivetechno.de>
In-Reply-To: <88f2de00-32e3-ed74-082f-c0972a81f0f8@fivetechno.de>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Thu, 4 Aug 2022 11:49:15 +0200
Message-ID: <CAMdYzYoTLjRW1FgwfizUu-+k0R4tCO78qYa7MEpgfz99aj3SvQ@mail.gmail.com>
Subject: Re: [BUG BISECT] phy: rockchip-inno-usb2: Sync initial otg state
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 2:39 PM Markus Reichl <m.reichl@fivetechno.de> wrote=
:
>
> Hi,
>
> with linux-next-20220728 rk3399-roc-pc does not boot.
> Bisecting pointed to this commit.
> By reverting this commit the board boots again.

Thank you for reporting this, someone was kind enough to reproduce the
problem on the rockpro64 and confirmed this is an issue. As I won't
have access to my hardware until next month, we should probably revert
this until the root cause can be identified.

Very Respectfully,
Peter Geis

>
> [    2.398700] Unable to handle kernel NULL pointer dereference at virtua=
l address
> 0000000000000008
> [    2.399517] Mem abort info:
> [    2.399772]   ESR =3D 0x0000000096000004
> [    2.400114]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [    2.400594]   SET =3D 0, FnV =3D 0
> [    2.400873]   EA =3D 0, S1PTW =3D 0
> [    2.401161]   FSC =3D 0x04: level 0 translation fault
> [    2.401602] Data abort info:
> [    2.401864]   ISV =3D 0, ISS =3D 0x00000004
> [    2.402212]   CM =3D 0, WnR =3D 0
> [    2.402484] user pgtable: 4k pages, 48-bit VAs, pgdp=3D000000000137600=
0
> [    2.403071] [0000000000000008] pgd=3D0000000000000000, p4d=3D000000000=
0000000
> [    2.403687] Internal error: Oops: 96000004 [#1] SMP
> [    2.404130] Modules linked in: ip_tables x_tables ipv6 xhci_plat_hcd x=
hci_hcd
> dwc3 rockchipdrm drm_cma_helper analogix_dp dw_hdmi realtek drm_display_h=
elper
> dwc3_of_simple dw_mipi_dsi ehci_platform ohci_platform ohci_hcd ehci_hcd
> drm_kms_helper dwmac_rk syscopyarea sysfillrect stmmac_platform sysimgblt
> fb_sys_fops usbcore stmmac pcs_xpcs drm phylink drm_panel_orientation_qui=
rks
> [    2.407155] CPU: 4 PID: 71 Comm: kworker/4:6 Not tainted
> 5.19.0-rc8-next-20220728 #437
> [    2.407868] Hardware name: Firefly ROC-RK3399-PC Mezzanine Board (DT)
> [    2.408448] Workqueue: events rockchip_usb2phy_otg_sm_work
> [    2.408958] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [    2.411634] pc : rockchip_usb2phy_otg_sm_work+0x50/0x330
> [    2.414332] lr : process_one_work+0x1d8/0x380
> [    2.416948] sp : ffff800009373d60
> [    2.419406] x29: ffff800009373d60 x28: 0000000000000000 x27: 000000000=
0000000
> [    2.422199] x26: ffff0000f779fcb8 x25: ffff0000f77a3a05 x24: 000000000=
000000c
> [    2.424978] x23: 0000000000000000 x22: ffff0000010c8258 x21: ffff80000=
888ec10
> [    2.427768] x20: ffff0000010c82f0 x19: 000000000000000c x18: 000000000=
0000001
> [    2.430604] x17: 000000040044ffff x16: 00400034b5503510 x15: 000000000=
0000000
> [    2.433390] x14: ffff000000708000 x13: ffff8000eec96000 x12: 000000003=
4d4d91d
> [    2.436185] x11: 0000000000000000 x10: 0000000000000a10 x9 : ffff00000=
1aa7a74
> [    2.438958] x8 : fefefefefefefeff x7 : 0000000000000018 x6 : ffff00000=
1aa7a74
> [    2.441668] x5 : 000073746e657665 x4 : 000000000000002f x3 : ffff00000=
356c808
> [    2.444407] x2 : ffff800009373da4 x1 : 000000000000e2ac x0 : ffff80000=
888eb34
> [    2.447190] Call trace:
> [    2.449557]  rockchip_usb2phy_otg_sm_work+0x50/0x330
> [    2.452169]  process_one_work+0x1d8/0x380
> [    2.454684]  worker_thread+0x170/0x4e0
> [    2.457056]  kthread+0xd8/0xdc
> [    2.459354]  ret_from_fork+0x10/0x20
> [    2.461728] Code: 91037015 295be001 f9403c77 b940e413 (f94006e0)
> [    2.464338] ---[ end trace 0000000000000000 ]---
>
> Am 22.06.22 um 02:31 schrieb Peter Geis:
> > The initial otg state for the phy defaults to device mode. The actual
> > state isn't detected until an ID IRQ fires. Fix this by syncing the ID
> > state during initialization.
> >
> > Fixes: 51a9b2c03dd3 ("phy: rockchip-inno-usb2: Handle ID IRQ")
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > ---
> >   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/ph=
y/rockchip/phy-rockchip-inno-usb2.c
> > index 6711659f727c..6e44069617df 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > @@ -1162,6 +1162,12 @@ static int rockchip_usb2phy_otg_port_init(struct=
 rockchip_usb2phy *rphy,
> >                                       EXTCON_USB_HOST, &rport->event_nb=
);
> >               if (ret)
> >                       dev_err(rphy->dev, "register USB HOST notifier fa=
iled\n");
> > +
> > +             if (!of_property_read_bool(rphy->dev->of_node, "extcon"))=
 {
> > +                     /* do initial sync of usb state */
> > +                     ret =3D property_enabled(rphy->grf, &rport->port_=
cfg->utmi_id);
> > +                     extcon_set_state_sync(rphy->edev, EXTCON_USB_HOST=
, !ret);
> > +             }
> >       }
> >
> >   out:
>
> Gru=C3=9F,
> --
> Markus Reichl
