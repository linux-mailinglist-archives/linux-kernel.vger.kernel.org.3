Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6357177A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiGLKle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiGLKlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:41:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146967CB61;
        Tue, 12 Jul 2022 03:41:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C277266018EA;
        Tue, 12 Jul 2022 11:41:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657622489;
        bh=aOj+sQx7dj4knkAMQNH+ntgBvPv44y7F0cbpMrBGyOY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Twxvmviw03FzYyIwPUIjYmNGsgHcFzfCylKPNIhAw8llGo2yt81ZhUL4y4uXfXK/v
         7F5hSOQrEkVvtNO8pV3d0GPii9cMDONdLIzhlAlQz6/IeFgzNgAbIjlPYYsKNI++NK
         hvdpMTatwHDSnQ7xmlPd25Rw9yBnVzpyTI/j+3xe485hJzwzepGW45nxha25j20jv8
         mBhOcdC881hmSsFdiUeQh+xq9clXltl6aMhMP0+11MX+2terDAL5K2t6SqMQ36G8wH
         MHbS4TRHvDWu5sgFS80STUVEtN28Ndz6c/zU9M5ebE+wKoWL7e5iXzkF79WzWc5xNL
         L3qovPPeDUSbA==
Message-ID: <79a79313-00e0-632f-f238-95686362675e@collabora.com>
Date:   Tue, 12 Jul 2022 12:41:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: mediatek: Don't check HW status for mt8192/5's
 imp_iic_wrap clocks
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ran Jianping <ran.jianping@zte.com.cn>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20220711205733.203963-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220711205733.203963-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/07/22 22:57, Nícolas F. R. A. Prado ha scritto:
> The imp_iic_wrap clocks on mt8192/mt8195 require that the i2c_sel parent
> clock be enabled before their hardware status can be checked. Since this
> wasn't taken into account, reading from the clk_summary debugfs file
> would cause the system to completely freeze.
> 
> Assuming that this clock is managed only by the kernel, and not by any
> firmware, simply drop the is_enabled() optional callback and instead
> rely on the enable count for the imp_iic_wrap clocks.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

For both MT8192 and MT8195:

Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> 
>   drivers/clk/mediatek/clk-gate.c                | 6 ++++++
>   drivers/clk/mediatek/clk-gate.h                | 1 +
>   drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c | 2 +-
>   drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 2 +-
>   4 files changed, 9 insertions(+), 2 deletions(-)
> 
