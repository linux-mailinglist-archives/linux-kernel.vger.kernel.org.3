Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB6B46964D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbhLFNKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243834AbhLFNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:10:47 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A202C061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 05:07:19 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y16so12791430ioc.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 05:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4qLqL6TExfilJQa816YeOozRIvZOpLAU1niZeo6h9s4=;
        b=RqbFbzidRsMZ6ISGBUafhletbxbU5A6KbKIV4Y/dzS/Kp12avFv0vyUFV2afbxunuQ
         P7/0Ze7JjtFyfNEaj9hAf30/T2LBcEqwRBs4w8zkaMUf2Jy5kA+TR17u0L36kCsrSQPU
         bhXkw09ylw46GaFzvDkZ3IRwn3prdmgWjpcrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4qLqL6TExfilJQa816YeOozRIvZOpLAU1niZeo6h9s4=;
        b=72BWIO7ByvbqDoy012bTH+G7cJHfDOjFZrqqAQb47836zj5RpNPxdPWWsiPYn7jChl
         SH2sFB0TifXY8b7Q9Aw7cRuYcv1BEWchgrAVFKK30kMoo59RSuT/kOJFcsT93KQ7zUJO
         ucR2XCAfH4twvflMOvjP439ZETUaNGtz2bCeRJiW+GA9Fa+f3iJUPNHwsY/KziMAxInm
         6LGrNS8YQc+ygg+V50Um+4ShPwJ/ZoM1TLN+7xROgXw31WEuutreCOkAT2tAbGc0X2c7
         KbUg7BlwTW9rYxrJWTjCwtOIHS3WX/ePDczsvNn7jO7eZsnTQwyyyFgNjzWVo+3WJoOf
         xPow==
X-Gm-Message-State: AOAM533Ek6gJlMnT6PeAJfr+0i6pv2WEeSFpWRY+gFVg9fUx0lX5Nwk/
        EWheeDTTdhLUNvTBe8Rwiy1m0WOAY2CfhN/FRMimIw==
X-Google-Smtp-Source: ABdhPJy085ORsitV4ZaNdB4Xow1WGBaA/RrivGlO/iRgMUsG0n9UtP5kWQuGtKWiXbbvXUuCUCWpEf8sSiE1MbF1mpM=
X-Received: by 2002:a05:6602:2e81:: with SMTP id m1mr31883395iow.55.1638796038291;
 Mon, 06 Dec 2021 05:07:18 -0800 (PST)
MIME-Version: 1.0
References: <20211112105509.12010-1-yong.wu@mediatek.com> <6d4056d6-21ac-c230-ac7f-a45eb3d3dcfa@xs4all.nl>
In-Reply-To: <6d4056d6-21ac-c230-ac7f-a45eb3d3dcfa@xs4all.nl>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 6 Dec 2021 21:06:52 +0800
Message-ID: <CAJMQK-iD_BCzkThV0gyHCY_YL+OwgJ6D0tHMx8Fk=m=8t-E7UA@mail.gmail.com>
Subject: Re: [PATCH v9 00/15] Clean up "mediatek,larb"
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Matthias Kaehlcke <mka@chromium.org>, anan.sun@mediatek.com,
        yi.kuo@mediatek.com, acourbot@chromium.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        anthony.huang@mediatek.com,
        Frank Wunderlich <frank-w@public-files.de>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 8:23 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> Hi Yong Wu,
>
> On 12/11/2021 11:54, Yong Wu wrote:
> > MediaTek IOMMU block diagram always like below:
> >
> >         M4U
> >          |
> >     smi-common
> >          |
> >   -------------
> >   |         |  ...
> >   |         |
> > larb1     larb2
> >   |         |
> > vdec       venc
> >
> > All the consumer connect with smi-larb, then connect with smi-common.
> >
> > When the consumer works, it should enable the smi-larb's power which also
> > need enable the smi-common's power firstly.
> >
> > Thus, Firstly, use the device link connect the consumer and the
> > smi-larbs. then add device link between the smi-larb and smi-common.
> >
> > After adding the device_link, then "mediatek,larb" property can be removed.
> > the iommu consumer don't need call the mtk_smi_larb_get/put to enable
> > the power and clock of smi-larb and smi-common.
> >
> > Base on a jpeg dt-bing patchset[1] that already got the necessary R-b.
> >
> > This patchset cross several tree, From [2], the media tree should be a good choice.
> >
> > [1] https://lore.kernel.org/linux-mediatek/20210702102304.3346429-1-hsinyi@chromium.org/
>
> Please resend this patch series converting the jpeg bindings to yaml, and this time
> CC the linux-media mailinglist. Because that was omitted, it never appeared in the
> media patchwork system, and so this was never merged. Since this patch series depends on
> this series, this needs to be merged first.

Hi Hans,

I've resent a v6 and cc linux-media:
https://patchwork.linuxtv.org/project/linux-media/patch/20211206130425.184420-1-hsinyi@chromium.org/

thanks

>
> Bindings for media drivers must be CC-ed to linux-media, since we maintain those.
>
> Regards,
>
>         Hans
>
> > [2] https://lore.kernel.org/linux-mediatek/e7269c80-5437-6ab9-c1db-df0b94eb97d8@gmail.com/
> >
> > Change notes:
> > v9: 1) Add return -ENODEV when the dev is null.
> >     2) Add more strict about the case that a iommu consume device use the ports in
> >     different larbs. Don't allow this case.
> >     3) Remove two codec interface: mtk_vcodec_release_enc/dec_pm since it only has one
> >     line now.
> >
> > v8: https://lore.kernel.org/linux-mediatek/20210929013719.25120-1-yong.wu@mediatek.com/
> >     1) Rebase on v5.15-rc1.
> >     2) Don't rebase the below mdp patchset that may still need more discuss.
> >     https://lore.kernel.org/linux-mediatek/20210709022324.1607884-1-eizan@chromium.org/
> >     3) Add Frank's Tested-by. Remove Dafna's Tested-by as he requested.
> >
> > v7: https://lore.kernel.org/linux-mediatek/20210730025238.22456-1-yong.wu@mediatek.com/
> >     1) Fix a arm32 boot fail issue. reported from Frank.
> >     2) Add a return fail in the mtk drm. suggested by Dafna.
> >
> > v6: https://lore.kernel.org/linux-mediatek/20210714025626.5528-1-yong.wu@mediatek.com/
> >     1) rebase on v5.14-rc1.
> >     2) Fix the issue commented in v5 from Dafna and Hsin-Yi.
> >     3) Remove the patches about using pm_runtime_resume_and_get since they have
> >        already been merged by other patches.
> >
> > v5: https://lore.kernel.org/linux-mediatek/20210410091128.31823-1-yong.wu@mediatek.com/
> >     1) Base v5.12-rc2.
> >     2) Remove changing the mtk-iommu to module_platform_driver patch, It have already been a
> >     independent patch.
> >
> > v4: https://lore.kernel.org/linux-mediatek/1590826218-23653-1-git-send-email-yong.wu@mediatek.com/
> >     base on v5.7-rc1.
> >   1) Move drm PM patch before smi patchs.
> >   2) Change builtin_platform_driver to module_platform_driver since we may need
> >      build as module.
> >   3) Rebase many patchset as above.
> >
> > v3: https://lore.kernel.org/linux-iommu/1567503456-24725-1-git-send-email-yong.wu@mediatek.com/
> >     1) rebase on v5.3-rc1 and the latest mt8183 patchset.
> >     2) Use device_is_bound to check whether the driver is ready from Matthias.
> >     3) Add DL_FLAG_STATELESS flag when calling device_link_add and explain the
> >    reason in the commit message[3/14].
> >     4) Add a display patch[12/14] into this series. otherwise it may affect
> >    display HW fastlogo even though it don't happen in mt8183.
> >
> > v2: https://lore.kernel.org/linux-iommu/1560171313-28299-1-git-send-email-yong.wu@mediatek.com/
> >    1) rebase on v5.2-rc1.
> >    2) Move adding device_link between the consumer and smi-larb into
> > iommu_add_device from Robin.
> >    3) add DL_FLAG_AUTOREMOVE_CONSUMER even though the smi is built-in from Evan.
> >    4) Remove the shutdown callback in iommu.
> >
> > v1: https://lore.kernel.org/linux-iommu/1546318276-18993-1-git-send-email-yong.wu@mediatek.com/
> >
> > Yong Wu (14):
> >   dt-binding: mediatek: Get rid of mediatek, larb for multimedia HW
> >   iommu/mediatek-v1: Free the existed fwspec if the master dev already
> >     has
> >   iommu/mediatek: Return ENODEV if the device is NULL
> >   iommu/mediatek: Add probe_defer for smi-larb
> >   iommu/mediatek: Add device_link between the consumer and the larb
> >     devices
> >   media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
> >   media: mtk-mdp: Get rid of mtk_smi_larb_get/put
> >   drm/mediatek: Get rid of mtk_smi_larb_get/put
> >   media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
> >   media: mtk-vcodec: dec: Remove mtk_vcodec_release_dec_pm
> >   media: mtk-vcodec: enc: Remove mtk_vcodec_release_enc_pm
> >   memory: mtk-smi: Get rid of mtk_smi_larb_get/put
> >   arm: dts: mediatek: Get rid of mediatek, larb for MM nodes
> >   arm64: dts: mediatek: Get rid of mediatek, larb for MM nodes
> >
> > Yongqiang Niu (1):
> >   drm/mediatek: Add pm runtime support for ovl and rdma
> >
> >  .../display/mediatek/mediatek,disp.txt        |  9 ----
> >  .../bindings/media/mediatek-jpeg-decoder.yaml |  9 ----
> >  .../bindings/media/mediatek-jpeg-encoder.yaml |  9 ----
> >  .../bindings/media/mediatek-mdp.txt           |  8 ---
> >  .../bindings/media/mediatek-vcodec.txt        |  4 --
> >  arch/arm/boot/dts/mt2701.dtsi                 |  2 -
> >  arch/arm/boot/dts/mt7623n.dtsi                |  5 --
> >  arch/arm64/boot/dts/mediatek/mt8173.dtsi      | 16 ------
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  6 ---
> >  drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  8 ++-
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |  9 +++-
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 15 +++---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   | 36 +------------
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |  1 -
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  5 +-
> >  drivers/iommu/mtk_iommu.c                     | 34 ++++++++++++
> >  drivers/iommu/mtk_iommu_v1.c                  | 42 ++++++++++++++-
> >  .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 45 +---------------
> >  .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  2 -
> >  drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 40 --------------
> >  drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 -
> >  drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
> >  .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  8 +--
> >  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 46 +++-------------
> >  .../platform/mtk-vcodec/mtk_vcodec_dec_pm.h   |  3 +-
> >  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
> >  .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
> >  .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  6 +--
> >  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 52 +++----------------
> >  .../platform/mtk-vcodec/mtk_vcodec_enc_pm.h   |  3 +-
> >  drivers/memory/mtk-smi.c                      | 14 -----
> >  include/soc/mediatek/smi.h                    | 20 -------
> >  32 files changed, 125 insertions(+), 339 deletions(-)
> >
>
