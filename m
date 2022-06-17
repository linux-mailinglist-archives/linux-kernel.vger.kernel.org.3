Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D1B54F8A5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382473AbiFQNy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232133AbiFQNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:54:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4AD2DD79;
        Fri, 17 Jun 2022 06:54:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o16so5867635wra.4;
        Fri, 17 Jun 2022 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e/ZwI6/BN3As4V+Hk45i5RGBnBZ09YbFMnFnKVxdi/0=;
        b=mxbO4JHVFPGycvF6Kck5+xt1v3pUIG34WdSxN3Zscw1aDTFFvMISdJ577B/pQgeHLS
         6GA95yiYw9ruQFUuR6O/DNo3LRe9oMkbr14DfuZnL43GWrKrLoMhaSAKSm2AHGwI90lN
         JveYcstlfj5EOCJ84SnTJ+aVKptbPbWlM3VXv2cN6I1+nezx3UwepoVWJjlc2cA590Et
         1GsAbh3PZPNol33H1hRx/O+amN7Vae0rMaPPy2cHp9UjqQJuBuaf5aF0hT8RQxSdc/CH
         RnXPg95UwcC9mgfgARh4njHEucCC6hHOHxIPdKMaCB/m5JNRv3MYzh5xwRjpr5nlcDsq
         PCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e/ZwI6/BN3As4V+Hk45i5RGBnBZ09YbFMnFnKVxdi/0=;
        b=5SqR5Ntb86Uw4tzGuikSUfdLIG9KCwiHZZGZ+fJUp0XmNvc1Mnkdh4ZmcYR34bDlYo
         A9pFFoFYUij+KgxTsR3C1oqysdkUNbMH22VBT5HiK2VntytvVVc36aBSb0NmOtDh8E0S
         29dh5y+7kdJvDimQMDFub5znepyNcUIqJQLzqG83dCjEZpSL2/AVwxunc5XV8C8Saezv
         tozZTxORW4vk7uhnw50fYL8xUGgSDIyEYZKWzJNd9APjQQ8fxhVvWiRTHEdnUyBwnd5k
         ns0sCgYULAboKt8GBRzQJHWr3zTWUNSW85KC2yPIouG09X0qT9bplF1Q6aamKZyRCN4O
         xHTw==
X-Gm-Message-State: AJIora/0u3qGp5xbdwzkZjCbc4VBzmOnbGJ3v43gckvFLPU5NKnlYO8r
        Kk6eVWBRgGsxAcFSQXGkZWo=
X-Google-Smtp-Source: AGRyM1sSLJUnCFbcAfX8EfAMF/K4WBamM2ADKZuuEFvt75ViRCv5x+dyFKeJE6a2Tzxcv53Oy5ls4g==
X-Received: by 2002:a5d:5190:0:b0:217:1567:d311 with SMTP id k16-20020a5d5190000000b002171567d311mr9600267wrv.225.1655474063515;
        Fri, 17 Jun 2022 06:54:23 -0700 (PDT)
Received: from [192.168.0.24] (80.174.78.229.dyn.user.ono.com. [80.174.78.229])
        by smtp.gmail.com with ESMTPSA id m13-20020a5d4a0d000000b0021a2c923c72sm4824146wrq.69.2022.06.17.06.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jun 2022 06:54:21 -0700 (PDT)
Message-ID: <5f53e0a4-f6d5-f9be-222b-e6361b837071@gmail.com>
Date:   Fri, 17 Jun 2022 15:54:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v20 0/6] Add mutex support for MDP
Content-Language: en-US
To:     Moudy Ho <moudy.ho@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Landley <rob@landley.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Courbot <acourbot@chromium.org>, tfiga@chromium.org,
        drinkcat@chromium.org, pihsun@chromium.org, hsinyi@google.com,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        daoyuan huang <daoyuan.huang@mediatek.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        allen-kh.cheng@mediatek.com, xiandong.wang@mediatek.com,
        randy.wu@mediatek.com, jason-jh.lin@mediatek.com,
        roy-cw.yeh@mediatek.com, river.cheng@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        cellopoint.kai@gmail.com
References: <20220610063424.7800-1-moudy.ho@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220610063424.7800-1-moudy.ho@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/06/2022 08:34, Moudy Ho wrote:
> Change since V19:
> - Reduce parameters pass to function "mtk_mutex_write_sof"
>    to avoid redundant action.
> 
> Change since V18:
> - Rebase on v5.19-rc1
> - Remove unnecessary functions:
>    "mtk_mutex_set_mod", "mtk_mutex_clear_mod",
>    "mtk_mutex_set_sof" and "mtk_mutex_clear_sof", and export
>    "mtk_mutex_write_mod" and "mtk_mutex_write_sof" to
>    set MOD/SOF directly.
> - Remove unnecessary SOF tables and add new enumerations of SOF instead.
> - Adjust the error checking for CMDQ operations.
> 
> Change since V17:
> - Rebase on v5.18-rc6
> - Fix undeclared identifier causing compilation to fail.
> 
> Change since V16:
> - Rebase on v5.18-rc4
> - Fix misplacement of definition "CONFIG_MTK_CMDQ" which
>    caused compilation error when CMD is not supported.
> 
> Change since V15:
> - Rebase on linux-next.
> - As suggested by Angelo, split common parts into independent functions to
>    make functions more concise.
> - Based on safety considerations, increase the returned error number and
>    message to facilitate error handling.
> 
> Change since V14:
> - Rebase on linux-next.
> - Add new SOF and MOD table for general interface to integrate the requirement
>    of different modules.
> - Remove unnecessary MOD structure.
> - By Rob Herring's suggestion, revise the description of
>    "mediatek,gce-client-reg" in MUTEX dt-bindings.
> - Delete the redundant definition of MTK_MUTEX_ENABLE and modify corresponding
>    function.
> 
> Change since V13:
> - Rebase on linux-next tag:next-20220316
> - Adjust the MUTEX MOD table structure and corresponding functions.
> - Adjust the definition style about 8183 MDP MOD.
> - Remove redundant definitions and enumerations.
> - Adjust the CMDQ operation in MUTEX to be backward compatible
> 
> Change since V12:
> - Rebase on linux-next
> - Remove ISP related settings in MMSYS
> - Removed CMDQ operations previously used by MDP in MMSYS
> - Move mediatek MUTEX dt-binding path
> - Add additional property in MUTEX for CMDQ operations
> 
> Change since V11:
> - Rebase on v5.17-rc6.
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.17-next/soc&id=5f9b5b757e44de47ebdc116c14b90e3cc8bc7acb
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.17-next/soc&id=831785f0e5b919c29e1bc5f9a74e9ebd38289e24
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/matthias.bgg/linux.git/commit/?h=v5.17-next/soc&id=15f1768365aed810826a61fef4a744437aa5b426
> 
> Change since v10:
> - For some ISP application scenarios, such as preview and recording
>    at the same time.
>    The routing table needs to be discarded, and the calculation result
>    on the SCP side is used to write a suitable mux setting for
>    1 input and 2 output.
> - Adjust the GCE client register parsing method to avoid redundant warning logs.
> 
> Change since v9:
> - Add API for MDP getting mutex mod.
> 
> Hi,
> 
> This patch splits mmsys and mutex settings from Media Data Path 3 (MDP3),
> and original mailling list list below:
> https://patchwork.kernel.org/project/linux-mediatek/cover/20211201095031.31606-1-moudy.ho@mediatek.com/
> Corresponding settings and interfaces are added for MDP operation in the
> mmsys and mutex drivers, which increases the independence of the modules
> 
> Moudy Ho (6):
>    soc: mediatek: mutex: add common interface for modules setting
>    soc: mediatek: mutex: add 8183 MUTEX MOD settings for MDP
>    dt-bindings: soc: mediatek: move out common module from display folder
>    dt-bindings: soc: mediatek: add gce-client-reg for MUTEX
>    dts: arm64: mt8183: add GCE client property for Mediatek MUTEX

If fixed the commit subject to arm64: dts: mt8183...
Whole series applied,

Thanks!

>    soc: mediatek: mutex: add functions that operate registers by CMDQ
> 
>   .../mediatek/mediatek,mutex.yaml              |  14 ++-
>   arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   1 +
>   drivers/soc/mediatek/mtk-mutex.c              | 119 +++++++++++++++++-
>   include/linux/soc/mediatek/mtk-mutex.h        |  27 ++++
>   4 files changed, 159 insertions(+), 2 deletions(-)
>   rename Documentation/devicetree/bindings/{display => soc}/mediatek/mediatek,mutex.yaml (81%)
> 
