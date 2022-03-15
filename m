Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B76334D9DC7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243907AbiCOOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244198AbiCOOjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:39:00 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2FF2E7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:37:47 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id y27-20020a4a9c1b000000b0032129651bb0so24588596ooj.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rpmKOoeraRuQGQUThehNRRx57Aisb5avAtGzINvQREA=;
        b=btYHhIM/2AcNT2mHGxMQPLP23iKlNVDyc/vZohM3qpDd7+3O/i/a2gd+sL94O0MNmE
         as02/VxgKVf31ZMRpUKgErJLODlFTaVhOcYu2+ESfiqlzPXtbyWkfTDpNmxPt3xVMhOn
         iL2pIzOqtP63EW/rpznJdR20E2Czy/P7+hFV+9+d7A9r1IsR6el4+qICVp6d9tudWqyy
         PU5vc4wCDO0tSwkcVXStOPm02tVPmKINAIcxy/vE4Kljap5BICXGKBemh4RtgicAlEgS
         ZUA/oAcTydN2vOzeCEFHuwNx1PP/KdrPv2syTmdHRAvKTtjKivWUkdgXTfsJM+NddxMG
         1msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rpmKOoeraRuQGQUThehNRRx57Aisb5avAtGzINvQREA=;
        b=UrrbEMJN3MPbjEq/c2aOhhPkBgZMOJUf8bwDIzMgbH70Sdmt3vyjZkUsO+7aK0K5go
         W/3iFwW8oLTuMP44lJfMIjYYPJPIbFWrcstwUqVpYmz9UvNCeBKCXW5QUAmwZemq533R
         ZNQrM2fin2/Am0f+4bbyGXM5WcauPC9jt9GPpkjut9Y6Qt5DgSlcn7t/NUWo7Sjh4O/Q
         3nW4dArdcjNoxo14pvNOYDHvVD75tDdq0GFkWg/fPasqQNzOG/fA+frZpLtvyWl+9ip6
         /IRMp4V+D5b6SmustWoFXUCHCSQICacZy2FtGhf4ibMjMp9SOIxkQU2AML8W0CdIngj3
         5BTQ==
X-Gm-Message-State: AOAM533HxL2LIsBxozyZlehg5SPOUybiAQFPHhV4vlZiCYX2ZBtxzlm4
        xCychKCJQoCb4CJBCuQo0i3H0g==
X-Google-Smtp-Source: ABdhPJyvcljfmAWOAbxTQiajM8RYB5b1DsFb2rJguap6VrzxZaYDzEGfjeZQOutf0ny2oZHd4aTvXw==
X-Received: by 2002:a05:6870:4251:b0:d9:b7ee:f0ab with SMTP id v17-20020a056870425100b000d9b7eef0abmr1726880oac.56.1647355066566;
        Tue, 15 Mar 2022 07:37:46 -0700 (PDT)
Received: from [192.168.86.188] ([136.62.4.88])
        by smtp.gmail.com with ESMTPSA id f10-20020a4a8f4a000000b00320e5ecfecdsm8863070ool.46.2022.03.15.07.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 07:37:46 -0700 (PDT)
Subject: Re: [PATCH v13 1/6] soc: mediatek: mutex: add common interface to
 accommodate multiple modules operationg MUTEX
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
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
        river.cheng@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220315061031.21642-1-moudy.ho@mediatek.com>
 <20220315061031.21642-2-moudy.ho@mediatek.com>
 <ed5418b4-e353-d879-f9b0-7a9de8fed862@collabora.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <4fa1dd33-adeb-a8ae-0ded-51a813347252@landley.net>
Date:   Tue, 15 Mar 2022 09:41:25 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ed5418b4-e353-d879-f9b0-7a9de8fed862@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/22 4:10 AM, AngeloGioacchino Del Regno wrote:
> Il 15/03/22 07:10, Moudy Ho ha scritto:
>> In order to allow multiple modules to operate MUTEX hardware through
>> a common interfrace, a flexible index "mtk_mutex_table_index" needs to
>> be added to replace original component ID so that like DDP and MDP
>> can add their own MUTEX table settings independently.
>> 
>> In addition, 4 generic interface "mtk_mutex_set_mod", "mtk_mutex_set_sof",
>> "mtk_mutex_clear_mod" and "mtk_mutex_clear_sof" have been added, which is
>> expected to replace the "mtk_mutex_add_comp" and "mtk_mutex_remove_comp"
>> pair originally dedicated to DDP in the future.
>> 
>> Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
>> ---
>>   drivers/soc/mediatek/mtk-mutex.c       | 122 +++++++++++++++++++++++++
>>   include/linux/soc/mediatek/mtk-mutex.h |  33 +++++++
>>   2 files changed, 155 insertions(+)
>> 
>> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
>> index aaf8fc1abb43..778b01ce9e8f 100644
>> --- a/drivers/soc/mediatek/mtk-mutex.c
>> +++ b/drivers/soc/mediatek/mtk-mutex.c
>> @@ -156,6 +156,7 @@ struct mtk_mutex_data {
>>   	const unsigned int *mutex_sof;
>>   	const unsigned int mutex_mod_reg;
>>   	const unsigned int mutex_sof_reg;
>> +	const unsigned long long *mutex_table_mod;
> 
> Can we change this to u64 instead?

Linux is still LP64, correct?

Rob
