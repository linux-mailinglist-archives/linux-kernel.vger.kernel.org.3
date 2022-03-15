Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 892804D9E40
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349505AbiCOO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbiCOO7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:59:39 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784101ADBF;
        Tue, 15 Mar 2022 07:58:27 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id E624A1F4304F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647356306;
        bh=W9WWZDCyjKEZgWKToHqeZGf4O53uVfpYv5D8zJtmRDo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gHPADtLHCuVqGguDHAaJ1a2jKzV9eCmr8++OqcQ3bFBpYkoApAALnlRUaXDI4e4fa
         slN2Le3XPPHQmDS9ekVrOowehTsP22iwQlPf9ZQwp5qTCCjzWzd04jwZQcNoL2tcOD
         FLtNnMsgNkJZge5v9hS3KuiGVy2M9n3m2w8wUToO1cooZfl2ITl3bjFc8QEaC3An8N
         3dfgaEJ5qGMd5jUBbWbRFAcUeuAeXAxA+vMH922vNIHy1ERMSPfTguw/0jd23XdjL4
         10VzQYAy6/B0lbj+EhMJdyT2i7XAxxg8z6357u4AC9MqCoJu9U744kSbGHveQcWWXg
         TQvpyEsWA/ouA==
Message-ID: <cdcf08d4-8b77-a94c-7906-073155b9865f@collabora.com>
Date:   Tue, 15 Mar 2022 15:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v13 1/6] soc: mediatek: mutex: add common interface to
 accommodate multiple modules operationg MUTEX
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Landley <rob@landley.net>
Cc:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>, drinkcat@chromium.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Hsin-Yi Wang <hsinyi@google.com>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        menghui.lin@mediatek.com, sj.huang@mediatek.com,
        allen-kh.cheng@mediatek.com, randy.wu@mediatek.com,
        jason-jh.lin@mediatek.com, roy-cw.yeh@mediatek.com,
        river.cheng@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220315061031.21642-1-moudy.ho@mediatek.com>
 <20220315061031.21642-2-moudy.ho@mediatek.com>
 <ed5418b4-e353-d879-f9b0-7a9de8fed862@collabora.com>
 <4fa1dd33-adeb-a8ae-0ded-51a813347252@landley.net>
 <CAMuHMdXA=Wo2mW_N9GGDY_NBgyhK3fDBpUO=mJb-CdoYvKU70w@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAMuHMdXA=Wo2mW_N9GGDY_NBgyhK3fDBpUO=mJb-CdoYvKU70w@mail.gmail.com>
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

Il 15/03/22 15:50, Geert Uytterhoeven ha scritto:
> Hi Rob,
> 
> On Tue, Mar 15, 2022 at 3:37 PM Rob Landley <rob@landley.net> wrote:
>> On 3/15/22 4:10 AM, AngeloGioacchino Del Regno wrote:
>>> Il 15/03/22 07:10, Moudy Ho ha scritto:
>>>> In order to allow multiple modules to operate MUTEX hardware through
>>>> a common interfrace, a flexible index "mtk_mutex_table_index" needs to
>>>> be added to replace original component ID so that like DDP and MDP
>>>> can add their own MUTEX table settings independently.
>>>>
>>>> In addition, 4 generic interface "mtk_mutex_set_mod", "mtk_mutex_set_sof",
>>>> "mtk_mutex_clear_mod" and "mtk_mutex_clear_sof" have been added, which is
>>>> expected to replace the "mtk_mutex_add_comp" and "mtk_mutex_remove_comp"
>>>> pair originally dedicated to DDP in the future.
>>>>
>>>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> 
>>>> --- a/drivers/soc/mediatek/mtk-mutex.c
>>>> +++ b/drivers/soc/mediatek/mtk-mutex.c
>>>> @@ -156,6 +156,7 @@ struct mtk_mutex_data {
>>>>       const unsigned int *mutex_sof;
>>>>       const unsigned int mutex_mod_reg;
>>>>       const unsigned int mutex_sof_reg;
>>>> +    const unsigned long long *mutex_table_mod;
>>>
>>> Can we change this to u64 instead?
>>
>> Linux is still LP64, correct?
> 
> On 64-bit platforms, yes.
> 
> Note that this is about "long long", which is 64-bit on all Linux platforms.
> But as the table seems to be used to store 2 32-bit values, it doesn't hurt
> to be explicit and use "u64"? Or a struct with 2 "u32" values?
> 

Exactly. I wanted this to be a hint of what's happening in the background,
without using unions to describe this.

Geert, thanks for immediately understanding my intention.

Cheers,
Angelo

> Gr{oetje,eeting}s,
> 
>                          Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds

