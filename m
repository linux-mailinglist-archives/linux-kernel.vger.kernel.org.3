Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04ED530E20
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiEWJcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiEWJcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:32:35 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F19F286E6;
        Mon, 23 May 2022 02:32:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0A4861F42DBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653298351;
        bh=ZH48jvF0up+hCWZK5ypwMWTFHlSbfZaq2hSsrwUJGyw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VYgCeGVHMpNsdy8YVaOEe6io1q1onUzgTlJlgffHMUa3cVhgDBooaQjGRMCYJb4hy
         fWsFmiPkEZsyZwrmRvECcT0NvOjnz1P7iVo0nIycEBX8QSnXNyhGLxsuhDlLqQLOTG
         Gg5syFe5GXzK1k11GHoqEU2yhR+hosiul+EyjucubTJ8lWiRjU+fYrjbP2eVZvjymg
         gxRLLyMH7L8Vs87RqqolD/UnFJv1AqaBjEEd+WMp66phr7ybmrv2LXLp6frDGmpzpD
         XGq+FnLXjRarmnzZDNNC1FzkdZG1F8XQQgqNVif6k77QujkXloOpFkT0pZWz6+DNYb
         bdssQlXDE2kyQ==
Message-ID: <22b05750-6062-8c59-ac30-c7b342194ea8@collabora.com>
Date:   Mon, 23 May 2022 11:32:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v11 3/3] mmc: mediatek: add support for SDIO eint wakup
 IRQ
Content-Language: en-US
To:     Axe Yang <axe.yang@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Satya Tangirala <satyat@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lucas Stach <dev@lynxeye.de>,
        Eric Biggers <ebiggers@google.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Stephen Boyd <swboyd@chromium.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        Yue Hu <huyue2@yulong.com>, Tian Tao <tiantao6@hisilicon.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Yong Mao <yong.mao@mediatek.com>
References: <20220523074017.12649-1-axe.yang@mediatek.com>
 <20220523074017.12649-4-axe.yang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220523074017.12649-4-axe.yang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/05/22 09:40, Axe Yang ha scritto:
> Add support for eint IRQ when MSDC is used as an SDIO host. This
> feature requires SDIO device support async IRQ function. With this
> feature, SDIO host can be awakened by SDIO card in suspend state,
> without additional pin.
> 
> MSDC driver will time-share the SDIO DAT1 pin. During suspend, MSDC
> turn off clock and switch SDIO DAT1 pin to GPIO mode. And during
> resume, switch GPIO function back to DAT1 mode then turn on clock.
> 
> Some device tree property should be added or modified in MSDC node
> to support SDIO eint IRQ. Pinctrls "state_eint" is mandatory. Since
> this feature depends on asynchronous interrupts, "wakeup-source",
> "keep-power-in-suspend" and "cap-sdio-irq" flags are necessary, and
> the interrupts list should be extended(the interrupt named with
> sdio_wakeup):
>          &mmcX {
> 		...
> 		interrupt-names = "msdc", "sdio_wakeup";
> 		interrupts-extended = <...>,
>                                	      <&pio xxx IRQ_TYPE_LEVEL_LOW>;
>                  ...
>                  pinctrl-names = "default", "state_uhs", "state_eint";
>                  ...
>                  pinctrl-2 = <&mmc2_pins_eint>;
>                  ...
>                  cap-sdio-irq;
> 		keep-power-in-suspend;
> 		wakeup-source;
>                  ...
>          };
> 
> Co-developed-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Axe Yang <axe.yang@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


