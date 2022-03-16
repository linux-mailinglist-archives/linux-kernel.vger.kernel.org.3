Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF3D4DAC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 09:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354441AbiCPIhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 04:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237832AbiCPIhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 04:37:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E125043EFF;
        Wed, 16 Mar 2022 01:36:01 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id EFC5B1F42B80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647419760;
        bh=efJeF6dJBeqxwFUqrdFttfn3nFeJx5A/SlouGiahdVs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I4ANDCEjwel37JTQn85VKIWejFYOpyQ5k4f5gxx8UpCivaB4pcanORinaev9dBjN/
         5x4jXs0nGSy1KyAbqbwM+LMileTZEeTh2gUVZHbwJ6IytFNfV9XnUlVo0pD9IcAapl
         sD73bvhIEs8AiyWZPFmh5TvrXFBcGdbq2LAEgn+5Uli4H9z6DO5/kz8nW6nhJo2/6L
         wTPA0/LwuXnlUBTWX0VO2gqvRlABO9+n3qLIsQpqm3hopPpi2KranGBQTq2sGMwNvj
         dcNniQhl0bV0aTz5ZjSi1J4FA9E2BWWPzRQ6pfWWeOZl6XqgWEvj1zCMjJZQzrYnOi
         11/z8ZMpkPUlQ==
Message-ID: <fb2f47a9-49ca-b7d1-64a3-c1bada0519f5@collabora.com>
Date:   Wed, 16 Mar 2022 09:35:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v11 0/3] media: mediatek: support mdp3 on mt8183 platform
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        menghui.lin@mediatek.com, sj.huang@mediatek.com,
        allen-kh.cheng@mediatek.com, randy.wu@mediatek.com,
        jason-jh.lin@mediatek.com, roy-cw.yeh@mediatek.com,
        river.cheng@mediatek.com, srv_heupstream@mediatek.com
References: <20220105093758.6850-1-moudy.ho@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220105093758.6850-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/01/22 10:37, Moudy Ho ha scritto:
> Change since v10:
> - The routing table needs to be discarded, and the calculation result
>    on the SCP side is used to write a suitable mux setting for
>    1 input port and 2 output ports.
> - Adjust dts parsing flow to remove redundant HW IDs.
> - Fix memory leak caused by no free path information in function "mdp_cmdq_send".
> 
> Change since v9:
> - Keep only the MDP3 driver patches and split the remaining mmsys and
>    mutex patches into another mail.
> - Move mutex mod settings to corresponding driver and make relevant adjustments
>    for this in MDP3 driver.
> - Fix compile warning reported by kernel test robot.
> 
> Change since v8:
> - Rebase on v5.16-rc2.
> - Refer to Angelo's suggestion, adjust the register writing format to increase
>    readability and significance.
> - Refer to Angelo's suggestion, adjust or reduce inappropriate debugging
>    messages.
> - Refer to Rob Herring's suggestion to correct the the binding file
>    to make it with the specification.
> - Fix compile warning reported by kernel test robot.
> 
> Change since v7:
> - Rebase on v5.15-rc6.
> - Revise several V4L2 M2M settings to pass v4l2-compliance test.
> - Integrate those same component dt-binding documents of DRM and MDP, and
>    move them under the MMSYS domain.
> - Split MMSYS and MUTEX into two different files according to
>    their functional properties.
> 
> Changes since v6:
> - Refactor GCE event to corresponding node.
> - Fix dt_binding_check fail.
> - Fix compilation errors.
> 
> Changes since v5:
> - Rebase on v5.14-rc6.
> - Move MMSYS/Mutex settings to corresponding driver.
> - Revise the software license description and copyright.
> - Remove unnecessary enum. or definitions.
> - Optimize platform/chip definition conditions.
> - Use general printing functions instead of MDP3 private ones.
> - Fix compile warning.
> 
> Changes since v4:
> - Rebase on v5.13-rc1.
> - Remove the CMDQ flush flow to match the CMDQ API change.
> - Integrate four of MDP's direct-link subcomponents into MDP controller node
>    from syscon node to avoid illegal clock usage.
> - Rewrite dt-binding in a JSON compatible subset of YAML
> - Fix a bit of macro argument precedence.
> 
> Changes since v3:
> - Rebase on v5.9-rc1.
> - modify code for review comment from Rob Herring, cancel multiple nodes using
>    same register base situation.
> - control IOMMU port through pm runtime get/put to DMA components' device.
> - SCP(VPU) driver revision.
> - stop queuing jobs(remove flush_workqueue()) after mdp_m2m_release().
> - add computation of plane address with data_offset.
> - fix scale ratio check issue.
> - add default v4l2_format setting.
> 
> Changes since v2:
> - modify code for review comment from Tomasz Figa & Alexandre Courbot
> - review comment from Rob Herring will offer code revision in v4, due to
>    it's related to device node modification, will need to modify code
>    architecture
> 
> Changes since v1:
> - modify code for CMDQ v3 API support
> - EC ipi cmd migration
> - fix compliance test fail item (m2m cmd with -f) due to there is two problem in runing all format(-f) cmd:
> 1. out of memory before test complete
>          Due to capture buffer mmap (refcount + 1) after reqbuf but seems
>          no corresponding munmap called before device close.
>          There are total 12XX items(formats) in format test and each format
>          alloc 8 capture/output buffers.
> 2. unceasingly captureBufs() (randomly)
>          Seems the break statement didn't catch the count == 0 situation:
>          In v4l2-test-buffers.cpp, function: captureBufs()
>                          ...
>                          count--;
>                          if (!node->is_m2m && !count)
>                                  break;
>          Log is as attachment
> 
> I will paste the test result with problem part in another e-mail
> 
> Hi,
> 
> This is the first version of RFC patch for Media Data Path 3 (MDP3),
> MDP3 is used for scaling and color format conversion.
> support using GCE to write register in critical time limitation.
> support V4L2 m2m device control.
> 
> Moudy Ho (3):
>    dt-binding: mt8183: add Mediatek MDP3 dt-bindings
>    dts: arm64: mt8183: add Mediatek MDP3 nodes
>    media: platform: mtk-mdp3: add Mediatek MDP3 driver
> 

Hello Moudy,

In next-20220315, all MediaTek media drivers have been moved in a different
subdirectory. Now they are all in drivers/media/platform/mediatek/.

Can you please rebase this series, placing the MDP3 driver in
drivers/media/platform/mediatek/mdp3 ?

While at it, also please include the additional documentation and address the
rdma/rsz (etc) suggestions about using one compatible and a instance-id property
to express the multiple instances (remember: "mediatek,mt8183-mdp3-rdma",
mediatek,instance-id = <0>).... and all the other constructive suggestions that
were given during the extensive review of patch 1/3 of this series.

Looking forward to see a new version!

Regards,
Angelo
