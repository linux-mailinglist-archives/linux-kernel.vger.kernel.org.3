Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA244D289D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiCIF5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiCIF5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:57:08 -0500
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85FEEEC5E9
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:56:10 -0800 (PST)
Received: by mail-vk1-xa2a.google.com with SMTP id i43so687014vkd.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 21:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y4/OuWLBji+6VTiCXM/a3doY0qINZlzqUpyxddd3GcI=;
        b=By0ECgOBNferd8GoY7Rpp+PRxebOZD7PPCp+nGiF/LW0MdaikNTnNmKa9d3ZX+5HN9
         JOa8qy7tkOJIb8OkDXsZJ6O0ho+xKSPdo1T1Id22V3EnqR8OZkkADh0RSOswlpCAV65E
         SUjay/6GhnEZ8Np0ukadlOMqZzjUx12HJRhJM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y4/OuWLBji+6VTiCXM/a3doY0qINZlzqUpyxddd3GcI=;
        b=AOyEbNKdhLCwZA97JnYLw+NeFsJfSshbS2RpOcIvOrHc8D8Z991CjGzc5oED+a/Nwd
         LnSPPrWojEaEUeso0+3nteEPrjc3LVdqvcudhQBbk3DZ2etsTsvmf842kwqvwUy5jT0Q
         54GNIw1OJyMavhvH+utnuU38O+4e4NEnvAyl7oTJVEQpUgR0pruPN+j6eISI72Vb/XGz
         GmqPbaQzkdiC364T4B8SFoHvz8rJKMbUz2ziiqCmyJJdZ3MIPYLFZrlroO8UTq9VmBhV
         jqzZVgoUrPpamCo0wO/kvbH4r9EqZpc03CojzXX+ppaSvhyYS2kHzKhoPrJL95mXKBWp
         eA0A==
X-Gm-Message-State: AOAM533C4OE8gCf28JuR0jCBJnguVnReSI1MEmuedJOcK+R9lVojKPkG
        JOpsN3+Oey/rCsWWR7eWf9ohGwwBHAk/OdU08Syixw==
X-Google-Smtp-Source: ABdhPJzHCZbKdmWp591ZwsY/ysoow9x2y7PHhTzdKgGF+rgOfISnKuRzxOCbEK52EyyYVHd1n8LtqmiJ6uO9Ppn3v6M=
X-Received: by 2002:a1f:ae10:0:b0:337:7a83:899b with SMTP id
 x16-20020a1fae10000000b003377a83899bmr5437397vke.17.1646805369369; Tue, 08
 Mar 2022 21:56:09 -0800 (PST)
MIME-Version: 1.0
References: <1646388956-8033-1-git-send-email-xinlei.lee@mediatek.com>
 <fb73a54a-7e75-2e5d-d78a-cacb5f065b06@collabora.com> <CAJMQK-jkmw1iKmy1s6CU5rbngQWNPDS4zT23PnuDf2nGus=X2w@mail.gmail.com>
 <d6f880e1-83c6-7663-2a8a-8541115f5242@collabora.com>
In-Reply-To: <d6f880e1-83c6-7663-2a8a-8541115f5242@collabora.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Wed, 9 Mar 2022 13:55:43 +0800
Message-ID: <CAJMQK-ghfMF==qvPk9ecKGeE5HhyvLG2T8nLSBzji2-9wzJeNA@mail.gmail.com>
Subject: Re: [PATCH v2, 0/4] Cooperate with DSI RX devices to modify dsi funcs
 and delay mipi high to cooperate with panel sequence
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com, allen-kh.cheng@mediatek.com,
        Rex-BC.Chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 8, 2022 at 6:00 PM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 08/03/2022 =C3=A0 10:12, Hsin-Yi Wang a =C3=A9crit :
> > On Fri, Mar 4, 2022 at 7:25 PM Benjamin Gaignard
> > <benjamin.gaignard@collabora.com> wrote:
> >>
> >> Le 04/03/2022 =C3=A0 11:15, xinlei.lee@mediatek.com a =C3=A9crit :
> >>> From: Xinlei Lee <xinlei.lee@mediatek.com>
> >>>
> >>> In upstream-v5.8, dsi_enable will operate panel_enable, but this
> >>> modification has been moved in v5.9. In order to ensure the timing of
> >>> dsi_power_on/off and the timing of pulling up/down the MIPI signal,
> >>> the modification of v5.9 is synchronized in this series of patches.
> >> Hello,
> >>
> >> I'm trying to debug an issue on mt8183 kukui krane sku176 device.
> >> The problem is that boe-tv101wum-nl6 panel isn't working.
> >> At boot time I can see these logs:
> >> panel-boe-tv101wum-nl6 14014000.dsi.0: failed to write command 1
> >> panel-boe-tv101wum-nl6 14014000.dsi.0: failed to init panel: -62
> >> and a DSI interrupt time out.
> >>
> >> Since I believe the problem is link to DSI/panel enabling sequence
> >> I have try this series but that doesn't solve the issue.
> >> I notice that when going out of deep sleep mode panel is functional.
> >>
> >> May you have any idea to debug/solve this problem ?
> >>
> > Hi Benjamin,
> >
> > I think this might not be related to this series. Which kernel are you =
using?
> > I tried the krane sku176 with linux-next 5.17-rc6
> > (519dd6c19986696f59847ff8bf930436ccffd9a1 (tag: next-20220307,
> > linux-next/master) with or without this series, both can get the displa=
y on.
> >
> > dsi related message:
> > [    0.206330] mediatek-drm mediatek-drm.1.auto: Adding component
> > match for /soc/dsi@14014000
> > [    4.567577] panel-boe-tv101wum-nl6 14014000.dsi.0: supply pp3300
> > not found, using dummy regulator
> > [    4.567732] panel-boe-tv101wum-nl6 14014000.dsi.0: GPIO lookup for
> > consumer enable
> > [    4.567738] panel-boe-tv101wum-nl6 14014000.dsi.0: using device
> > tree for GPIO lookup
> > [    4.567757] of_get_named_gpiod_flags: parsed 'enable-gpios'
> > property of node '/soc/dsi@14014000/panel@0[0]' - status (0)
> > [    4.585884] panel-boe-tv101wum-nl6 14014000.dsi.0: supply pp3300
> > not found, using dummy regulator
> > [    4.586037] panel-boe-tv101wum-nl6 14014000.dsi.0: GPIO lookup for
> > consumer enable
> > [    4.586042] panel-boe-tv101wum-nl6 14014000.dsi.0: using device
> > tree for GPIO lookup
> > [    4.586059] of_get_named_gpiod_flags: parsed 'enable-gpios'
> > property of node '/soc/dsi@14014000/panel@0[0]' - status (0)
> > [    4.587430] mediatek-drm mediatek-drm.1.auto: bound 14014000.dsi
> > (ops 0xffffffd369a752b8)
> >
> >
> > Maybe some config is not enabled?
>
> I using 5.17.0-rc1-next-20220127 kernel tag.
> The configs look similar.
>
> I have the follow log at boot time:
>
Hi Xinlei,

Can you resend this patch to base on the latest rc? This patch no
longer applies to rc6, I have to resolve conflict locally.

Thanks


> [    1.533384] phy phy-11e50000.dsi-phy.2: Looking up phy-supply from dev=
ice tree
> [    1.533402] phy phy-11e50000.dsi-phy.2: Looking up phy-supply property=
 in node /soc/dsi-phy@11e50000 failed
> [    3.173068] mediatek-drm mediatek-drm.1.auto: Adding component match f=
or /soc/dsi@14014000
> [    4.671806] panel-boe-tv101wum-nl6 14014000.dsi.0: Looking up avdd-sup=
ply from device tree
> [    4.680348] panel-boe-tv101wum-nl6 14014000.dsi.0: Looking up avee-sup=
ply from device tree
> [    4.688784] panel-boe-tv101wum-nl6 14014000.dsi.0: Looking up pp3300-s=
upply from device tree
> [    4.697816] panel-boe-tv101wum-nl6 14014000.dsi.0: Looking up pp1800-s=
upply from device tree
> [    4.842346] panel-boe-tv101wum-nl6 14014000.dsi.0: Looking up avdd-sup=
ply from device tree
> [    4.854573] panel-boe-tv101wum-nl6 14014000.dsi.0: Looking up avee-sup=
ply from device tree
> [    4.862976] panel-boe-tv101wum-nl6 14014000.dsi.0: Looking up pp3300-s=
upply from device tree
> [    4.871568] panel-boe-tv101wum-nl6 14014000.dsi.0: Looking up pp1800-s=
upply from device tree
> [    4.964021] mediatek-drm mediatek-drm.1.auto: bound 14014000.dsi (ops =
mtk_dsi_component_ops)
> ...
> [   38.273437] [drm] Wait DSI IRQ(0x00000002) Timeout
> [   38.281584] panel-boe-tv101wum-nl6 14014000.dsi.0: failed to write com=
mand 1
> [   38.288651] panel-boe-tv101wum-nl6 14014000.dsi.0: failed to init pane=
l: -62
> ...
> [   70.113674] mediatek-drm mediatek-drm.1.auto: [drm] *ERROR* flip_done =
timed out
> [   70.121054] mediatek-drm mediatek-drm.1.auto: [drm] *ERROR* [CRTC:45:c=
rtc-0] commit wait timed out
> [   70.130037] [drm:mtk_drm_crtc_atomic_begin] *ERROR* new event while th=
ere is still a pending event
> [   70.241222] ------------[ cut here ]------------
> [   70.245898] [CRTC:45:crtc-0] vblank wait timed out
> [   70.250729] WARNING: CPU: 7 PID: 397 at drivers/gpu/drm/drm_atomic_hel=
per.c:1529 drm_atomic_helper_wait_for_vblanks.part.0+0x290/0x24
> [   70.262815] Modules linked in: hci_uart btqca btbcm bluetooth cdc_ethe=
r usbnet r8152 mtk_mdp3 hid_multitouch mtk_jpeg panfrost cros_6
> [   70.309348] CPU: 7 PID: 397 Comm: gnome-shell Tainted: G        W     =
    5.17.0-rc1-next-20220127+ #57
> [   70.318731] Hardware name: MediaTek krane sku176 board (DT)
> [   70.324293] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYP=
E=3D--)
> [   70.331244] pc : drm_atomic_helper_wait_for_vblanks.part.0+0x290/0x2b4
> [   70.337762] lr : drm_atomic_helper_wait_for_vblanks.part.0+0x290/0x2b4
> [   70.344279] sp : ffff8000092339e0
> [   70.347583] x29: ffff8000092339e0 x28: 0000000000000001 x27: 000000000=
0000000
> [   70.354713] x26: 0000000000000000 x25: ffffc7e8feee4660 x24: 000000000=
0000038
> [   70.361842] x23: ffff6fe702b0d000 x22: 0000000000000001 x21: ffff6fe70=
30d5080
> [   70.368970] x20: ffff6fe709d7d700 x19: 0000000000000000 x18: 000000000=
0000030
> [   70.376099] x17: 000000040044ffff x16: 00400032b5503510 x15: fffffffff=
fffffff
> [   70.383227] x14: ffffc7e8ffa99220 x13: 000000000000094b x12: 000000000=
0000319
> [   70.390354] x11: 6e616c6276205d30 x10: ffffc7e8ffb49220 x9 : 00000000f=
fffe000
> [   70.397483] x8 : ffffc7e8ffa99220 x7 : 0000000000000001 x6 : 000000000=
0000000
> [   70.404611] x5 : 0000000000000000 x4 : ffff6fe73b5e4cf8 x3 : ffff6fe73=
b5f0840
> [   70.411738] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff6fe70=
2f20000
> [   70.418866] Call trace:
> [   70.421301]  drm_atomic_helper_wait_for_vblanks.part.0+0x290/0x2b4
> [   70.427472]  drm_atomic_helper_commit_tail_rpm+0x88/0xac
> [   70.432775]  commit_tail+0xa0/0x17c
> [   70.436254]  drm_atomic_helper_commit+0x190/0x3a0
> [   70.440949]  drm_atomic_commit+0x5c/0x6c
> [   70.444864]  drm_mode_gamma_set_ioctl+0x45c/0x640
> [   70.449560]  drm_ioctl_kernel+0xc4/0x174
> [   70.453475]  drm_ioctl+0x238/0x45c
> [   70.456868]  __arm64_sys_ioctl+0xac/0xf0
> [   70.460786]  invoke_syscall+0x48/0x114
> [   70.464529]  el0_svc_common.constprop.0+0x60/0x11c
> [   70.469312]  do_el0_svc+0x28/0x90
> [   70.472619]  el0_svc+0x4c/0x100
> [   70.475754]  el0t_64_sync_handler+0xec/0xf0
> [   70.479928]  el0t_64_sync+0x1a0/0x1a4
> [   70.483582] irq event stamp: 0
> [   70.486625] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
> [   70.492883] hardirqs last disabled at (0): [<ffffc7e8fd49383c>] copy_p=
rocess+0x658/0x197c
> [   70.501053] softirqs last  enabled at (0): [<ffffc7e8fd49383c>] copy_p=
rocess+0x658/0x197c
> [   70.509219] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   70.515475] ---[ end trace 0000000000000000 ]---
>
> Regards,
> Benjamin
>
> >
> >
> >
> >> Regards,
> >> Benjamin
> >>
> >>> Changes since v1:
> >>> 1. Dsi sequence marked with patch adjustment
> >>> 2. Fixes: mtk_dsi: Use the drm_panel_bridge
> >>>
> >>> Jitao Shi (3):
> >>>     drm/mediatek: Adjust the timing of mipi signal from LP00 to LP11
> >>>     drm/mediatek: Separate poweron/poweroff from enable/disable and d=
efine
> >>>       new funcs
> >>>     drm/mediatek: keep dsi as LP00 before dcs cmds transfer
> >>>
> >>> Xinlei Lee (1):
> >>>     drm/mediatek: Add pull-down MIPI operation in mtk_dsi_poweroff
> >>>       function
> >>>
> >>>    drivers/gpu/drm/mediatek/mtk_dsi.c | 73 ++++++++++++++++++++------=
----
> >>>    1 file changed, 49 insertions(+), 24 deletions(-)
> >>>
> >> _______________________________________________
> >> Linux-mediatek mailing list
> >> Linux-mediatek@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >>
> >> _______________________________________________
> >> Linux-mediatek mailing list
> >> Linux-mediatek@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-mediatek
