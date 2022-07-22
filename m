Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8CC57DEF5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236165AbiGVJmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235303AbiGVJmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:42:01 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7CEB90
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 02:31:39 -0700 (PDT)
Received: from [192.168.1.90] (unknown [188.24.146.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AF9506601AC4;
        Fri, 22 Jul 2022 10:31:37 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658482298;
        bh=9obwjyJ+1wqQsOOAQX4IrPl0kRLwK1h9fBoLG2aAqiM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l3PSKczOCoLazgjcsNJNtecODu4S6sAk81ATcCpFYL0WSlXGIgZek6RBG8yztZrdl
         NXE44gTSUW3GEGBBfA7PyJo+yJq8kV6e3GOqwNWiY4wliTWAUvlRf461tKbuurEUIJ
         Q5iqa7Hwex73+/ygO4YDeCzyhGTRxw9vp4rbEx+1uhH6Zm8NmtEoHTMKPtHMquszqe
         6wEA6vWN06QWUGXC7anZszlFIxZGuZDdauuAs40iOMn2Kr1GwJBX75Vo7nsjz5GkFb
         99YiyaRUalLbk1yM2sA2FiDTMFPvnyF7c49jcDxebruggP/YYYtIRE2u8lnc0fMATE
         90NzI5SssYHwg==
Message-ID: <c0fa7b9f-8f0b-da2c-5cd9-550df0b695c8@collabora.com>
Date:   Fri, 22 Jul 2022 12:31:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ASoC: amd: vangogh: Use non-legacy DAI naming for cs35l41
Content-Language: en-US
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20220721233227.1459374-1-cristian.ciocaltea@collabora.com>
 <20220722090532.GF92394@ediswmail.ad.cirrus.com>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <20220722090532.GF92394@ediswmail.ad.cirrus.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/22/22 12:05, Charles Keepax wrote:
> On Fri, Jul 22, 2022 at 02:32:27AM +0300, Cristian Ciocaltea wrote:
>> Unlike most CODEC drivers, the CS35L41 driver did not have the
>> non_legacy_dai_naming set, meaning the corresponding DAI has been
>> traditionally registered using the legacy naming: spi-VLV1776:0x
>>
>> The recent migration to the new legacy DAI naming style has implicitly
>> corrected that behavior and DAI gets now registered via the non-legacy
>> naming, i.e. cs35l41-pcm.
>>
>> The problem is the acp5x platform driver is now broken as it continues
>> to refer to the above mentioned codec using the legacy DAI naming in
>> function acp5x_cs35l41_hw_params() and, therefore, the related setup
>> is not being executed anymore.
>>
>> Let's fix that by replacing the obsolete DAI name with the correct one.
>>
>> Fixes: bc949a3b4af3 ("ASoC: core: Switch core to new DAI naming flag")
> 
> Although sorry just noticed you might want to double check the SHA
> here, I think the upstream one is 129f055a2144.

You are right, thanks for noticing!
I've done some rebasing/bisecting operations and I forgot to recheck the 
original commit.. I've just sent v2.

Regards,
Cristian

> Thanks,
> Charles
