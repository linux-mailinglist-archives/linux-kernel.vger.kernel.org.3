Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B07546A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345891AbiFJQPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244605AbiFJQPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:15:34 -0400
Received: from smtp.smtpout.orange.fr (smtp05.smtpout.orange.fr [80.12.242.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2336531DF3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 09:15:31 -0700 (PDT)
Received: from [192.168.1.18] ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id zhIDnDopVE80KzhIDn3fuF; Fri, 10 Jun 2022 18:15:30 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Fri, 10 Jun 2022 18:15:30 +0200
X-ME-IP: 90.11.190.129
Message-ID: <d53ad0e2-e32d-1b46-b626-e82b44230704@wanadoo.fr>
Date:   Fri, 10 Jun 2022 18:15:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] ASoC: samsung: i2s: Check before clk_unregister() not
 needed
Content-Language: fr
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yihao Han <hanyihao@vivo.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220527065412.3677-1-hanyihao@vivo.com>
 <2bcf706b-10d5-9369-ff8a-2a3263f9fa70@linaro.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <2bcf706b-10d5-9369-ff8a-2a3263f9fa70@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 29/05/2022 à 10:06, Krzysztof Kozlowski a écrit :
> On 27/05/2022 08:54, Yihao Han wrote:
>> clk_unregister() already checks the clk ptr using
>> !clk || WARN_ON_ONCE(IS_ERR(clk)) so there is no need to check it
>> again before calling it.
>>
> 
> No, this explanation does not make sense. clk_unregister() warns and
> this code is not equivalent.
> 
> 
> 
> Best regards,
> Krzysztof
> 

Hi,

Moreover, as pointed out by greg in [1] on some plateform the assertion 
in the commit description is wrong. His message is about clk_disable() 
but, IIUC, it makes sense for clk_unregister() as well. See [2] on the 
sh plateform.

CJ

[1]: https://lore.kernel.org/all/YqMIUOTU%2Fk5XpW3I@kroah.com/
[2]: 
https://elixir.bootlin.com/linux/v5.18.3/source/drivers/sh/clk/core.c#L452
