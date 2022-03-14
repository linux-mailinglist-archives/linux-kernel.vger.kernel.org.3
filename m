Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC944D80BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238932AbiCNLcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbiCNLcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:32:51 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C87841F80;
        Mon, 14 Mar 2022 04:31:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4BBDF1F433F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647257500;
        bh=xtxrT2bamlWz6iXZa45LA5QO3D2qQ09Z7rxdq4K7m4I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bkBm6JJXlTt7MmmN71Nlm9cMk1/zHBg9MkbwKg8XzoEbuWmK26zYeYrFews0nI0Jc
         ZapKj23jnPtVXFcL9OvYTNKp1EGu/NJcb6d71cjcer+T9Mx3rvu9UFCzc+ld1qQeBA
         9uEnDlUOwDWdL4Zx6tGjWL1aeflzZy3egX8igARPlUQljEFqe1da/qMhVUIgpUBZnA
         5dSnKmYi4jY1aPW2PEJd7M9hZ1fZfsR7UHosTf8KR3PhyoofUvZfHCq/u2Z/YTetVY
         MNOcG4qj1X/k5yVwDuaza7hnsT61Ti/gReMcOUdMai3hKLRBU9FQXkwj73AzwcWRHU
         KasflN6tsJ26w==
Message-ID: <36e7847e-56ed-8768-388e-c6a00a2cb0ec@collabora.com>
Date:   Mon, 14 Mar 2022 12:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v3] remoteproc: mediatek: fix side effect of mt8195 sram
 power on
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220314111806.28168-1-tinghan.shen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220314111806.28168-1-tinghan.shen@mediatek.com>
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

Il 14/03/22 12:18, Tinghan Shen ha scritto:
> The definition of L1TCM_SRAM_PDN bits on mt8195 is different to mt8192.
> 
> L1TCM_SRAM_PDN bits[3:0] control the power of mt8195 L1TCM SRAM.
> 
> L1TCM_SRAM_PDN bits[7:4] control the access path to EMI for SCP.
> These bits have to be powered on to allow EMI access for SCP.
> 
> Bits[7:4] also affect audio DSP because audio DSP and SCP are
> placed on the same hardware bus. If SCP cannot access EMI, audio DSP is
> blocked too.
> 
> L1TCM_SRAM_PDN bits[31:8] are not used.
> 
> This fix removes modification of bits[7:4] when power on/off mt8195 SCP
> L1TCM. It's because the modification introduces a short period of time
> blocking audio DSP to access EMI. This was not a problem until we have
> to load both SCP module and audio DSP module. audio DSP needs to access
> EMI because it has source/data on DRAM. Audio DSP will have unexpected
> behavior when it accesses EMI and the SCP driver blocks the EMI path at
> the same time.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>


Hello Tinghan,

I'm sorry, but in the last review I forgot to mention that you should
really add a Fixes tag to this commit, since this is.. a fix.

This is the tag that you should use:

Fixes: 79111df414fc ("remoteproc: mediatek: Support mt8195 scp")

After adding that,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> v3: fix build error
> v2: apply comments about macro definition and function calls
> ---
>   drivers/remoteproc/mtk_common.h |  2 +
>   drivers/remoteproc/mtk_scp.c    | 67 +++++++++++++++++++++++++--------
>   2 files changed, 53 insertions(+), 16 deletions(-)
> 
