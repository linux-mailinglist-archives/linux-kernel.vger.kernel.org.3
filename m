Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAC05A1C01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 00:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244334AbiHYWMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 18:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242855AbiHYWMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 18:12:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E99B4423
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 15:12:22 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.27.54.142])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 419056601EB5;
        Thu, 25 Aug 2022 23:12:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661465540;
        bh=ZpkdgljukMvecL8dgUDfn4ptIdOfX7y4FE5jJ/1fyU8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=CEbKAGvNBIYzi/Ti1LMdKMpobOKF+6xnSWpPY8TtbYhJmhvkUPzXS7TCk15ELaiyG
         RmDBvSGUrPPOP36LARHEo/YqzG0abwAvwOsart9PACe+QmB7OTAoOKXwmFWJeP6iv9
         HVu6iQCvpK2lrY/K65Em5GbxT4qem/A/pT7nsO+OGs0yt6PjK5JtsV+GoZnlGXjHee
         NuBCeHYFUFid+sW5x+baxZ4Q8WyfVflumIRXR7VeKnPtcXzfXCm1ZAom8uo80HB2kU
         BkOO2p21RGzk7QYBIJtUP4nRtZoJ9UedFi0R5Vg8zcnHjTp4A4CBB5ad/CumusXZo3
         Bh6D/yQ4w7z/A==
Message-ID: <1d0bd2ec-ce27-02fa-b538-4636ca9ac289@collabora.com>
Date:   Fri, 26 Aug 2022 01:12:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] ASoC: wm_adsp: Silent parsing error on loading speaker
 protection fw
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Vlad Karpovich <Vlad.Karpovich@cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220823133347.919706-1-cristian.ciocaltea@collabora.com>
 <20220825124715.GM92394@ediswmail.ad.cirrus.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20220825124715.GM92394@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/25/22 15:47, Charles Keepax wrote:
> On Tue, Aug 23, 2022 at 04:33:47PM +0300, Cristian Ciocaltea wrote:
>> The tracing capabilities for the speaker protection fw enabled via
>> commit c55b3e46cb99 ("ASoC: wm_adsp: Add trace caps to speaker
>> protection FW") are not be available on all platforms, such as the
>> Valve's Steam Deck which is based on the Halo Core DSP.
>>
>> As a consequence, whenever the firmware is loaded, a rather misleading
>> 'Failed to parse legacy: -19' error message is written to the kernel
>> ring buffer:
>>
>> [  288.977412] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Firmware version: 3
>> [  288.978002] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: cs35l41-dsp1-spk-prot.wmfw: Fri 02 Apr 2021 21:03:50 W. Europe Daylight Time
>> [  289.094065] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Firmware: 400a4 vendor: 0x2 v0.33.0, 2 algorithms
>> [  289.095073] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: 0: ID cd v29.53.0 XM@94 YM@e
>> [  289.095665] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: 1: ID f20b v0.0.1 XM@170 YM@0
>> [  289.096275] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Protection: C:\Users\ocanavan\Desktop\cirrusTune_july2021.bin
>> [  291.172383] steamdeck kernel: cs35l41 spi-VLV1776:01: DSP1: Failed to parse legacy: -19
>>
>> Update wm_adsp_buffer_init() to *not* report the ENODEV error when the
>> firmware type is WM_ADSP_FW_SPK_PROT.
>>
>> Fixes: c55b3e46cb99 ("ASoC: wm_adsp: Add trace caps to speaker protection FW")
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>   sound/soc/codecs/wm_adsp.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
>> index cfaa45ede916..7514fc03b468 100644
>> --- a/sound/soc/codecs/wm_adsp.c
>> +++ b/sound/soc/codecs/wm_adsp.c
>> @@ -1602,7 +1602,7 @@ static int wm_adsp_buffer_init(struct wm_adsp *dsp)
>>   	if (list_empty(&dsp->buffer_list)) {
>>   		/* Fall back to legacy support */
>>   		ret = wm_adsp_buffer_parse_legacy(dsp);
>> -		if (ret)
>> +		if (ret && (dsp->fw != WM_ADSP_FW_SPK_PROT || ret != -ENODEV))
>>   			adsp_warn(dsp, "Failed to parse legacy: %d\n", ret);
> 
> Fixing this for a single firmware probably doesn't really make
> the most sense, if we are treating buffers as optional these days
> I guess really the best solution would be to make this either an
> info and slightly rephrase the message or make it a dbg message.

Indeed, I have just submitted v2 for a more generic handling of the issue:

https://lore.kernel.org/all/20220825220530.1205141-1-cristian.ciocaltea@collabora.com/

Thanks for reviewing,
Cristian

> Thanks,
> Charles
