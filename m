Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B870F4E2B8E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 16:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349872AbiCUPO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 11:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349852AbiCUPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:14:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ED665BA;
        Mon, 21 Mar 2022 08:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9798760F3C;
        Mon, 21 Mar 2022 15:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8905C340E8;
        Mon, 21 Mar 2022 15:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647875577;
        bh=ipkgJQjf5K2R+S1QsRulpTCFGjeQCivNGHqHR4lHm5g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NlAnS+O1h0ZwjtCK+NlIhwFXGU5XDIfc6JGdZ3urIL2RJgtikmxARsu5T/xn2sG44
         +sMa8uQKAJl5lDfb0Gtk130vRqiUiPP4k7Ew+S0s4pW6avdeWP4xku+nyMuhTN2Rmp
         iPSaHZ/oH4lRowbTla4PbRXLvuADQ/+xfZAP3HMpj7TQNLOIM2sr1tYVt+2Vt7cOKO
         fY2tr+LI2U4d3OjryhCDpf+ExYtyfDMrOm2C/W/LtZRXW0qUNsEhHhU0rpggDyVl5b
         yPNWxbwu/5SL1vBKAPkQ5TKZrNkyEeob1ohw/VLGf7GFhUoKlpm7JKIIKcT3ys79Cl
         yMdFEDZAz58Qw==
Date:   Mon, 21 Mar 2022 23:12:52 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        angelogioacchino.delregno@collabora.com, yc.hung@mediatek.com
Subject: Re: [PATCH v3 5/6] ASoC: mediatek: mt8195: add machine support for
 max98390 and rt5682
Message-ID: <YjiV9DfLC7T1uweb@google.com>
References: <20220321072312.14972-1-trevor.wu@mediatek.com>
 <20220321072312.14972-6-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220321072312.14972-6-trevor.wu@mediatek.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 21, 2022 at 03:23:11PM +0800, Trevor Wu wrote:
> diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
[...]
>  #define RT1011_SPEAKER_AMP_PRESENT		BIT(0)
>  #define RT1019_SPEAKER_AMP_PRESENT		BIT(1)
> +#define MAX98390_SPEAKER_AMP_PRESENT		BIT(2)
> +
> +#define MAX98390_CODEC_DAI	"max98390-aif1"
> +#define MAX98390_DEV0_NAME	"max98390.2-0038" /* right */
> +#define MAX98390_DEV1_NAME	"max98390.2-0039" /* left */
>  
>  #define RT1011_CODEC_DAI	"rt1011-aif"
>  #define RT1011_DEV0_NAME	"rt1011.2-0038"

The quirk bit order: RT1011, RT1019, and MAX98390.  To be neat, move
MAX98390_CODEC_DAI, MAX98390_DEV0_NAME, and MAX98390_DEV1_NAME after
RT1019_DEV0_NAME to maintain the order.

> +static int mt8195_max98390_init(struct snd_soc_pcm_runtime *rtd)
[...]
> +
> +	ret = snd_soc_dapm_add_routes(&card->dapm, mt8195_max98390_routes,
> +				      ARRAY_SIZE(mt8195_max98390_routes));
> +
> +	if (ret)

Remove the extra blank line.
