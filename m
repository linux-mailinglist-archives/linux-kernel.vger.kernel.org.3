Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAE1500C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242854AbiDNL5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242847AbiDNL47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:56:59 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777061A062
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:54:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B009C1F479A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649937272;
        bh=b1Qs+7yt5i52Y0vqCOXaUWCnj9gXnqVJSriesALO6dU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BVo9/App19AXDvXABST6TIBcWiKh16uI6AF2q698a+uy8uLiJItQWXBgQf7+vVD0p
         xWtH3pmTQia4xYUp4WNnEp87B3gAH7Lvc6c4PAd7VgeDigmKlNjz8ZXX759Xy/C+E+
         hdI6fLFHxfcC6D5hvAG9H8WMk0ZF7KD/6orE8w5Kwk5Qh2S+s7f52MFrg8G4E4eBzb
         PRefpTpEJqcfnADQI2Kg2SDxDLkRLTP+0rnQ3EYV+cOeorjfR/AmX5PKXlahNZUYE7
         dbAvPxUBwRHMKIet4tXusWPoGt9fJ4z+rdlPuts0D3EfXVBKQvcZBUF1LxkktjqbRm
         i7UUWaUnSD9fw==
Message-ID: <d7234c71-f5c4-d623-16c4-e16c34b6de35@collabora.com>
Date:   Thu, 14 Apr 2022 13:54:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next] sound/oss/dmasound: fix 'dmasound_setup' defined
 but not used
Content-Language: en-US
To:     Miles Chen <miles.chen@mediatek.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220414081119.30851-1-miles.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220414081119.30851-1-miles.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/04/22 10:11, Miles Chen ha scritto:
> We observed: 'dmasound_setup' defined but not used error with
> COMPILER=gcc ARCH=m68k DEFCONFIG=allmodconfig build.
> 
> __setup() does not work if MODULE is defined.
> Fix it by warpping dmasound_setup with #ifndef MODULES.
> 
> Error(s):
> sound/oss/dmasound/dmasound_core.c:1431:12: error: 'dmasound_setup' defined but not used [-Werror=unused-function]
> 
> Signed-off-by: Miles Chen <miles.chen@mediatek.com>
> ---
>   sound/oss/dmasound/dmasound_core.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
> index 9c48f3a9e3d1..a1b3e71beadf 100644
> --- a/sound/oss/dmasound/dmasound_core.c
> +++ b/sound/oss/dmasound/dmasound_core.c
> @@ -1428,6 +1428,7 @@ void dmasound_deinit(void)
>   		unregister_sound_dsp(sq_unit);
>   }
>   
> +#ifndef MODULE
>   static int dmasound_setup(char *str)

Hello Miles,
I agree with Takashi, __maybe_unused looks way better.

Regards,
Angelo
