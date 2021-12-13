Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10A14737CB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 23:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243779AbhLMWoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 17:44:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240747AbhLMWo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 17:44:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19976C061574;
        Mon, 13 Dec 2021 14:44:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id 7A1501F44304
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1639435458; bh=+jzYdtXs7CB4ta79rrB++MGxP0waydJU7QsAh1AmXQo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lIhD4VLFF2S6LlIDylVcf8FfHctEQWqmhWUr+LKKcAcmy9YIByC53bq6Eo7A2Q+GW
         G1bDUmwqaSkSoMMnGWD7S/e6cDOqeOaqjRy3Y0GsYOEga5PibX2MJA/dlMIq0VeaB/
         ZFXivb0uRKvsinimGrTPvCG+fml899xWKRTbLvBTdCky2nj1Jo8ZsCBz5eFox/SOO/
         gQ5TwXw9vLjtHFqNIyZPIdvwBwmfSeIjz0Ns+NFWpN0JKasZEHSTlmeHyVaIRVpgh/
         bG7XQVAWqF1hck75vl29HTYXEhYOnlrckapPzQrsKu95krz3dG1cQ2U8xOPYbhvJyh
         lXhvoa6gMND9A==
Subject: Re: [PATCH 3/4] ASoC: fsl-asoc-card: Add optional dt property for
 setting mclk-id
To:     Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com,
        tony@atomide.com
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
 <20211203134930.128703-4-ariel.dalessandro@collabora.com>
 <Ybeu/1vsUzvAg2Ya@robh.at.kernel.org>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Message-ID: <288a8463-b4dc-80cc-1964-23ef613201c4@collabora.com>
Date:   Mon, 13 Dec 2021 19:44:07 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <Ybeu/1vsUzvAg2Ya@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 12/13/21 5:37 PM, Rob Herring wrote:
> On Fri, Dec 03, 2021 at 10:49:29AM -0300, Ariel D'Alessandro wrote:
>> Sound cards may allow using different main clock inputs. In the generic
>> fsl-asoc-card driver, these values are hardcoded for each specific card
>> configuration.
>>
>> Let's make it more flexible, allowing setting mclk-id from the
>> device-tree node. Otherwise, the default value for each card
>> configuration is used.
>>
>> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
>> ---
>>  Documentation/devicetree/bindings/sound/fsl-asoc-card.txt | 1 +
>>  sound/soc/fsl/fsl-asoc-card.c                             | 6 ++++++
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
>> index 23d83fa7609f..b219626a5403 100644
>> --- a/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
>> +++ b/Documentation/devicetree/bindings/sound/fsl-asoc-card.txt
>> @@ -82,6 +82,7 @@ Optional properties:
>>    - dai-format		: audio format, for details see simple-card.yaml.
>>    - frame-inversion	: dai-link uses frame clock inversion, for details see simple-card.yaml.
>>    - bitclock-inversion	: dai-link uses bit clock inversion, for details see simple-card.yaml.
>> +  - mclk-id		: main clock id, specific for each card configuration.
> 
> Ahh, there it is. This change and the header defines should be 1 patch 
> and driver changes another.

Ah, I see. I'll split it and send a patchset v2 for this.

Thanks,
Ariel
