Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67529490824
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbiAQME5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:04:57 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55850 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239479AbiAQME4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:04:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA36EB80EF2;
        Mon, 17 Jan 2022 12:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFEFC36AE3;
        Mon, 17 Jan 2022 12:04:47 +0000 (UTC)
Message-ID: <6044093c-a3e3-135d-9c14-016d64dcef1f@xs4all.nl>
Date:   Mon, 17 Jan 2022 13:04:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v10 00/13] Clean up "mediatek,larb"
Content-Language: en-US
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Evan Green <evgreen@chromium.org>,
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
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Eizan Miyamoto <eizan@chromium.org>,
        anthony.huang@mediatek.com,
        Frank Wunderlich <frank-w@public-files.de>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com
References: <20220117070510.17642-1-yong.wu@mediatek.com>
 <06e5e76c-557a-20a5-b8dd-37b25b3384a3@collabora.com>
 <c8fc24a2-9ee3-75a2-0928-95a217d9dfdf@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <c8fc24a2-9ee3-75a2-0928-95a217d9dfdf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 1/17/22 12:49, Matthias Brugger wrote:
> 
> 
> On 17/01/2022 11:27, AngeloGioacchino Del Regno wrote:
>> Il 17/01/22 08:04, Yong Wu ha scritto:
>>> MediaTek IOMMU block diagram always like below:
>>>
>>>          M4U
>>>           |
>>>      smi-common
>>>           |
>>>    -------------
>>>    |         |  ...
>>>    |         |
>>> larb1     larb2
>>>    |         |
>>> vdec       venc
>>>
>>> All the consumer connect with smi-larb, then connect with smi-common.
>>>
>>> When the consumer works, it should enable the smi-larb's power which also
>>> need enable the smi-common's power firstly.
>>>
>>> Thus, Firstly, use the device link connect the consumer and the
>>> smi-larbs. then add device link between the smi-larb and smi-common.
>>>
>>> After adding the device_link, then "mediatek,larb" property can be removed.
>>> the iommu consumer don't need call the mtk_smi_larb_get/put to enable
>>> the power and clock of smi-larb and smi-common.
>>>
>>> Base on the media branch [1] and a jpeg dtbinding patchset[2] that already got
>>> the necessary R-b.
>>>
>>> [1] git://linuxtv.org/hverkuil/media_tree.git tags/br-v5.18d
>>> [2] https://lore.kernel.org/linux-mediatek/20211206130425.184420-1-hsinyi@chromium.org/
>>>
>>> Change notes:
>>> v10: a) Rebase on the media tree. Respin the "media: mtk-vcodec:" patches.
>>>       b) Add Joerg's Ack for iommu patches.
>>>
>>> v9: https://lore.kernel.org/linux-mediatek/20211112105509.12010-1-yong.wu@mediatek.com/
>>>      1) Add return -ENODEV when the dev is null.
>>>      2) Add more strict about the case that a iommu consume device use the ports in
>>>      different larbs. Don't allow this case.
>>>      3) Remove two codec interface: mtk_vcodec_release_enc/dec_pm since it only has one
>>>      line now.
>>>
>>> v8: https://lore.kernel.org/linux-mediatek/20210929013719.25120-1-yong.wu@mediatek.com/
>>>      1) Rebase on v5.15-rc1.
>>>      2) Don't rebase the below mdp patchset that may still need more discuss.
>>>      https://lore.kernel.org/linux-mediatek/20210709022324.1607884-1-eizan@chromium.org/
>>>      3) Add Frank's Tested-by. Remove Dafna's Tested-by as he requested.
>>>
>>> v7: https://lore.kernel.org/linux-mediatek/20210730025238.22456-1-yong.wu@mediatek.com/
>>>      1) Fix a arm32 boot fail issue. reported from Frank.
>>>      2) Add a return fail in the mtk drm. suggested by Dafna.
>>>
>>> v6: https://lore.kernel.org/linux-mediatek/20210714025626.5528-1-yong.wu@mediatek.com/
>>>      1) rebase on v5.14-rc1.
>>>      2) Fix the issue commented in v5 from Dafna and Hsin-Yi.
>>>      3) Remove the patches about using pm_runtime_resume_and_get since they have
>>>         already been merged by other patches.
>>>
>>> v5: https://lore.kernel.org/linux-mediatek/20210410091128.31823-1-yong.wu@mediatek.com/
>>>      1) Base v5.12-rc2.
>>>      2) Remove changing the mtk-iommu to module_platform_driver patch, It have already been a
>>>      independent patch.
>>>
>>> v4: https://lore.kernel.org/linux-mediatek/1590826218-23653-1-git-send-email-yong.wu@mediatek.com/
>>>      base on v5.7-rc1.
>>>    1) Move drm PM patch before smi patchs.
>>>    2) Change builtin_platform_driver to module_platform_driver since we may need
>>>       build as module.
>>>    3) Rebase many patchset as above.
>>>
>>> v3: https://lore.kernel.org/linux-iommu/1567503456-24725-1-git-send-email-yong.wu@mediatek.com/
>>>      1) rebase on v5.3-rc1 and the latest mt8183 patchset.
>>>      2) Use device_is_bound to check whether the driver is ready from Matthias.
>>>      3) Add DL_FLAG_STATELESS flag when calling device_link_add and explain the
>>>     reason in the commit message[3/14].
>>>      4) Add a display patch[12/14] into this series. otherwise it may affect
>>>     display HW fastlogo even though it don't happen in mt8183.
>>> v2: https://lore.kernel.org/linux-iommu/1560171313-28299-1-git-send-email-yong.wu@mediatek.com/
>>>     1) rebase on v5.2-rc1.
>>>     2) Move adding device_link between the consumer and smi-larb into
>>> iommu_add_device from Robin.
>>>     3) add DL_FLAG_AUTOREMOVE_CONSUMER even though the smi is built-in from Evan.
>>>     4) Remove the shutdown callback in iommu.
>>>
>>> v1: https://lore.kernel.org/linux-iommu/1546318276-18993-1-git-send-email-yong.wu@mediatek.com/
>>>
>>> Yong Wu (12):
>>>    dt-binding: mediatek: Get rid of mediatek,larb for multimedia HW
>>>    iommu/mediatek-v1: Free the existed fwspec if the master dev already
>>>      has
>>>    iommu/mediatek: Return ENODEV if the device is NULL
>>>    iommu/mediatek: Add probe_defer for smi-larb
>>>    iommu/mediatek: Add device_link between the consumer and the larb
>>>      devices
>>>    media: mtk-jpeg: Get rid of mtk_smi_larb_get/put
>>>    media: mtk-mdp: Get rid of mtk_smi_larb_get/put
>>>    drm/mediatek: Get rid of mtk_smi_larb_get/put
>>>    media: mtk-vcodec: Get rid of mtk_smi_larb_get/put
>>>    memory: mtk-smi: Get rid of mtk_smi_larb_get/put
>>>    arm: dts: mediatek: Get rid of mediatek,larb for MM nodes
>>>    arm64: dts: mediatek: Get rid of mediatek,larb for MM nodes
>>>
>>> Yongqiang Niu (1):
>>>    drm/mediatek: Add pm runtime support for ovl and rdma
>>>
>>>   .../display/mediatek/mediatek,disp.txt        |  9 ----
>>>   .../media/mediatek,vcodec-decoder.yaml        |  7 ---
>>>   .../media/mediatek,vcodec-encoder.yaml        |  8 ----
>>>   .../bindings/media/mediatek-jpeg-decoder.yaml |  9 ----
>>>   .../bindings/media/mediatek-jpeg-encoder.yaml |  9 ----
>>>   .../bindings/media/mediatek-mdp.txt           |  8 ----
>>>   arch/arm/boot/dts/mt2701.dtsi                 |  2 -
>>>   arch/arm/boot/dts/mt7623n.dtsi                |  5 ---
>>>   arch/arm64/boot/dts/mediatek/mt8173.dtsi      | 16 -------
>>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |  6 ---
>>>   drivers/gpu/drm/mediatek/mtk_disp_ovl.c       |  8 +++-
>>>   drivers/gpu/drm/mediatek/mtk_disp_rdma.c      |  9 +++-
>>>   drivers/gpu/drm/mediatek/mtk_drm_crtc.c       | 15 ++++---
>>>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c   | 36 +--------------
>>>   drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h   |  1 -
>>>   drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  5 +--
>>>   drivers/iommu/mtk_iommu.c                     | 34 ++++++++++++++
>>>   drivers/iommu/mtk_iommu_v1.c                  | 42 ++++++++++++++++-
>>>   .../media/platform/mtk-jpeg/mtk_jpeg_core.c   | 45 +------------------
>>>   .../media/platform/mtk-jpeg/mtk_jpeg_core.h   |  2 -
>>>   drivers/media/platform/mtk-mdp/mtk_mdp_comp.c | 40 -----------------
>>>   drivers/media/platform/mtk-mdp/mtk_mdp_comp.h |  2 -
>>>   drivers/media/platform/mtk-mdp/mtk_mdp_core.c |  1 -
>>>   .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  |  2 -
>>>   .../platform/mtk-vcodec/mtk_vcodec_dec_hw.c   |  1 -
>>>   .../platform/mtk-vcodec/mtk_vcodec_dec_pm.c   | 41 +++--------------
>>>   .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  3 --
>>>   .../platform/mtk-vcodec/mtk_vcodec_enc.c      |  1 -
>>>   .../platform/mtk-vcodec/mtk_vcodec_enc_drv.c  |  2 -
>>>   .../platform/mtk-vcodec/mtk_vcodec_enc_pm.c   | 45 +++----------------
>>>   drivers/memory/mtk-smi.c                      | 14 ------
>>>   include/soc/mediatek/smi.h                    | 20 ---------
>>>   32 files changed, 115 insertions(+), 333 deletions(-)
>>>
>>
>> Hello Hans, Matthias,
>> on my side, this series is totally ready for merge, hence, green light from here.
>>
>> Can you please take it for 5.18?
>>
> 
> @Hans: I understand you take the series through your tree. Please let me know when you do so. I'll take care of patch 12 and 13, which should go through my tree.

Will do. I hope to send the PR in the next few days.

Regards,

	Hans
