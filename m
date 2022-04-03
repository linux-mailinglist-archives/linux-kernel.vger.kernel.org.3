Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBE64F088A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356115AbiDCJO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 05:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbiDCJO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 05:14:57 -0400
Received: from smtp.smtpout.orange.fr (smtp07.smtpout.orange.fr [80.12.242.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292B832EF4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 02:13:03 -0700 (PDT)
Received: from [192.168.1.18] ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id awI7nFC7WRGzQawI7nw1jb; Sun, 03 Apr 2022 11:13:01 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 03 Apr 2022 11:13:01 +0200
X-ME-IP: 90.126.236.122
Message-ID: <6dd4ac07-397c-1e02-2ac5-2a8f243bfefe@wanadoo.fr>
Date:   Sun, 3 Apr 2022 11:12:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: msm8916-wcd-digital: Fix missing
 clk_disable_unprepare() in msm8916_wcd_digital_probe
Content-Language: en-US
To:     =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Cc:     alsa-devel@alsa-project.org,
        Banajit Goswami <bgoswami@codeaurora.org>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20220307084523.28687-1-linmq006@gmail.com>
 <93751991-30ce-93a0-0f33-105f99b8dfe3@wanadoo.fr>
 <CAH-r-ZGw+toVfasD-45p4Z4Rryn2advNOZbgJd0g4SGw_Kd6FQ@mail.gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <CAH-r-ZGw+toVfasD-45p4Z4Rryn2advNOZbgJd0g4SGw_Kd6FQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 03/04/2022 à 09:15, 林妙倩 a écrit :
> Hi,
> 
> Yes, I agree with you. We should check the error code of
> devm_snd_soc_register_component() and do corresponding
> handling.

You already fixed the first issue, do you mind sending a patch for this 
one as well?

CJ
> 
> Christophe JAILLET <christophe.jaillet@wanadoo.fr> 于2022年4月3日周日 13:51写道：
> 
>> Le 07/03/2022 à 09:45, Miaoqian Lin a écrit :
>>> Fix the missing clk_disable_unprepare() before return
>>> from msm8916_wcd_digital_probe in the error handling case.
>>>
>>> Fixes: 150db8c5afa1 ("ASoC: codecs: Add msm8916-wcd digital codec")
>>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>>> ---
>>>    sound/soc/codecs/msm8916-wcd-digital.c | 5 ++++-
>>>    1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/codecs/msm8916-wcd-digital.c
>> b/sound/soc/codecs/msm8916-wcd-digital.c
>>> index fcc10c8bc625..9ad7fc0baf07 100644
>>> --- a/sound/soc/codecs/msm8916-wcd-digital.c
>>> +++ b/sound/soc/codecs/msm8916-wcd-digital.c
>>> @@ -1201,7 +1201,7 @@ static int msm8916_wcd_digital_probe(struct
>> platform_device *pdev)
>>>        ret = clk_prepare_enable(priv->mclk);
>>>        if (ret < 0) {
>>>                dev_err(dev, "failed to enable mclk %d\n", ret);
>>> -             return ret;
>>> +             goto err_clk;
>>>        }
>>>
>>>        dev_set_drvdata(dev, priv);
>>> @@ -1209,6 +1209,9 @@ static int msm8916_wcd_digital_probe(struct
>> platform_device *pdev)
>>>        return devm_snd_soc_register_component(dev, &msm8916_wcd_digital,
>>>                                      msm8916_wcd_digital_dai,
>>>                                      ARRAY_SIZE(msm8916_wcd_digital_dai));
>>> +err_clk:
>>> +     clk_disable_unprepare(priv->ahbclk);
>>> +     return ret;
>>>    }
>>>
>>>    static int msm8916_wcd_digital_remove(struct platform_device *pdev)
>>
>> Hi,
>> I think that the same should be done for 'priv->mclk' if
>> devm_snd_soc_register_component() returns an error.
>>
>> Can you give it a look?
>>
>> CJ
>>
> 

