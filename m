Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32F44D1BB2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347842AbiCHP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347816AbiCHP2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:28:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E414E384;
        Tue,  8 Mar 2022 07:27:21 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 7841A1F42FA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646753240;
        bh=mIroQP3tB1a7rDkP2yeLhxzu7G9KButjFXnb5VdUlUA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nbipGJDxzfwckK1I0UeDsp0CromMA5ceLPeeCxHVxHPLCzUBzHs4PzQnsAIEgcvhT
         NnO9ozCej3tF4E43fGFhwZKO1dqS8B+DvIPKEBgNTcojdA5EnEUowxNXwiPEPuel2s
         juPy82lrRaT6y6Gcr1s8KCzkbXrDTmZi61piJq48YyRRD5GsRgKrL0IICJFL1IQd0j
         JH9It5qs/TSfJDnuMsBfuL/sUtmCtsyyxigw1MrkUIF94ifxn9ottwtquLi7ahhKGv
         lKhAj2x0AjwgVOC9dIRqJIJHxYVFNz/5NmCeFz/ANKwXXBlgkMCmbsv2lLUlalZ6tK
         v1oEA2MmlUO3A==
Message-ID: <979ed023-ce90-ebae-7729-b5a2982b05d0@collabora.com>
Date:   Tue, 8 Mar 2022 16:27:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 07/11] pinctrl: mediatek: paris: Rework
 mtk_pinconf_{get,set} switch/case logic
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Sean Wang <sean.wang@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220308100956.2750295-1-wenst@chromium.org>
 <20220308100956.2750295-8-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220308100956.2750295-8-wenst@chromium.org>
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

Il 08/03/22 11:09, Chen-Yu Tsai ha scritto:
> The current code deals with optional features by testing for the
> function pointers and returning -ENOTSUPP if it is not valid. This is
> done for multiple pin config settings and results in the code that
> handles the supporting cases to get indented by one level. This is
> aggrevated by the fact that some features require another level of
> conditionals.
> 
> Instead of assigning the same error code in all unsupported optional
> feature cases, simply have that error code as the default, and break
> out of the switch/case block whenever a feature is unsupported, or an
> error is returned. This reduces indentation by one level for the useful
> code.
> 
> Also replace the goto statements with break statements. The result is
> the same, as the gotos simply exit the switch/case block, which can
> also be achieved with a break statement. With the latter the intent
> is clear and easier to understand.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pinctrl/mediatek/pinctrl-paris.c | 144 ++++++++++-------------
>   1 file changed, 61 insertions(+), 83 deletions(-)
> 

