Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F032466318
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357641AbhLBMLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346505AbhLBMLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:11:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE92C06174A;
        Thu,  2 Dec 2021 04:07:48 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id F31B51F464A8
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638446866; bh=pPyD6PF5rFuQOiYOC4+IpwATefnYR78OfW8Ax9aUOMs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NcQEqFD9oH8mvt2zCAm3WVtnoZablrIDtMQfHyqK5qlr76zXDuOrHrs3ZaJpgHoKf
         bTgbuO4n21Cs1J8ib6opRTX8oPiw0YqYvKctLyFS7rRATF3nUhS8u2QzIJFGwKgxWE
         gBmWKHN45nPI0dUWK+pVP+7T3QkOOqD5RuI8piwc0OlIXql6Fn9Z3H+aCTbME0KAZg
         UtNx5atp/WgxaobOaT7HGFdirD1ATK46yGjcJSLM0bEKu/N8SNGwY2RO52VWD0yzUP
         rf8hZVfkAqg2A/MlzMAv6C91+aNnp0c5Jni90o1Hafn9qrYQkZ6pS6lh/eqfFLA7sy
         U2i1aqXkmv/7A==
Subject: Re: [PATCH v9 7/7] media: platform: mtk-mdp3: add Mediatek MDP3
 driver
To:     moudy ho <moudy.ho@mediatek.com>,
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
References: <20211201095031.31606-1-moudy.ho@mediatek.com>
 <20211201095031.31606-8-moudy.ho@mediatek.com>
 <103b1664-d04c-c1fc-ff4c-e2c92ce45ee8@collabora.com>
 <0d3f33e26b67cabc82246c49c0e952194a9a88c1.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <038d4a24-7d61-ebb2-796f-63b59001ee54@collabora.com>
Date:   Thu, 2 Dec 2021 13:07:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <0d3f33e26b67cabc82246c49c0e952194a9a88c1.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/12/21 04:35, moudy ho ha scritto:
> On Wed, 2021-12-01 at 11:37 +0100, AngeloGioacchino Del Regno wrote:
>> Il 01/12/21 10:50, Moudy Ho ha scritto:
>>> This patch adds driver for Mediatek's Media Data Path ver.3 (MDP3).
>>> It provides the following functions:
>>>     color transform, format conversion, resize, crop, rotate, flip
>>>     and additional image quality enhancement.
>>>
>>> The MDP3 driver is mainly used for Google Chromebook products to
>>> import the new architecture to set the HW settings as shown below:
>>>     User -> V4L2 framework
>>>       -> MDP3 driver -> SCP (setting calculations)
>>>         -> MDP3 driver -> CMDQ (GCE driver) -> HW
>>>
>>> Each modules' related operation control is sited in mtk-mdp3-comp.c
>>> Each modules' register table is defined in file with "mdp_reg_"
>>> prefix
>>> GCE related API, operation control  sited in mtk-mdp3-cmdq.c
>>> V4L2 m2m device functions are implemented in mtk-mdp3-m2m.c
>>> Probe, power, suspend/resume, system level functions are defined in
>>> mtk-mdp3-core.c
>>>
>>> Signed-off-by: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
>>> Signed-off-by: daoyuan huang <daoyuan.huang@mediatek.com>
>>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> ---
>>>    drivers/media/platform/Kconfig                |   19 +
>>>    drivers/media/platform/Makefile               |    2 +
>>>    drivers/media/platform/mtk-mdp3/Makefile      |    6 +
>>>    .../media/platform/mtk-mdp3/mdp_reg_ccorr.h   |   19 +
>>>    drivers/media/platform/mtk-mdp3/mdp_reg_isp.h |   27 +
>>>    .../media/platform/mtk-mdp3/mdp_reg_rdma.h    |   65 +
>>>    drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h |   39 +
>>>    .../media/platform/mtk-mdp3/mdp_reg_wdma.h    |   47 +
>>>    .../media/platform/mtk-mdp3/mdp_reg_wrot.h    |   55 +
>>>    drivers/media/platform/mtk-mdp3/mtk-img-ipi.h |  280 ++++
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.c   |  514 +++++++
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-cmdq.h   |   46 +
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-comp.c   | 1264
>>> +++++++++++++++++
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-comp.h   |  147 ++
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-core.c   |  338 +++++
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-core.h   |   76 +
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-m2m.c    |  789 ++++++++++
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-m2m.h    |   49 +
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-regs.c   |  737 ++++++++++
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-regs.h   |  372 +++++
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-vpu.c    |  312 ++++
>>>    .../media/platform/mtk-mdp3/mtk-mdp3-vpu.h    |   78 +
>>>    22 files changed, 5281 insertions(+)
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/Makefile
>>>    create mode 100644 drivers/media/platform/mtk-
>>> mdp3/mdp_reg_ccorr.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_isp.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rdma.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_rsz.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wdma.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mdp_reg_wrot.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-img-ipi.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
>>> cmdq.c
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
>>> cmdq.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
>>> comp.c
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
>>> comp.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
>>> core.c
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
>>> core.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.c
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-m2m.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
>>> regs.c
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-
>>> regs.h
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.c
>>>    create mode 100644 drivers/media/platform/mtk-mdp3/mtk-mdp3-vpu.h
>>>
>>
>> snip...
>>
>>> diff --git a/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
>>> b/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
>>> new file mode 100644
>>> index 000000000000..a643f3ee928b
>>> --- /dev/null
>>> +++ b/drivers/media/platform/mtk-mdp3/mtk-mdp3-cmdq.c
>>> @@ -0,0 +1,514 @@
>>
>> Looks like you forgot to check my review comments to this entire
>> file.
>> Can you please send a new version after applying the changes to this
>> file
>> suggested in my review of series v8?
> Hi Angelo,
> 
> Thanks for the reminder and sorry for my carelessness. Considering the
> compatibility of subsequent chips and function independence, I plan to
> move those mutex mod definition to the corresponding driver, and
> release next version ASAP.
> 
> Thanks & Regards,
> Moudy Ho
>> Thanks.
> 


Hi Moudy,

Don't worry, we're humans, it happens to the best. We're always here to improve!
Thank you for sending the v10 by the way, I will review it as soon as I can.

Regards,
- Angelo
