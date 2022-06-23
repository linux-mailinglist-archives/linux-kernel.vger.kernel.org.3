Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461105575E5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiFWIvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiFWIvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:51:13 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651CE4927A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:51:11 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso1044587wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 01:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ylS4KYcnz6zgUnk7J6zC70zT8oatpCWr1rIO6eciB1E=;
        b=ozGokIM2DE8EhXhuCPuJqvKhj0nhAWB3Aa4za/fwCRvjcN5P/HYriOKzX/yNe1NgRq
         6eWujNDbI2LZC8iY7NKZhpX0tT1L8tliYgIliqnVEvOMIZKx1ityI0XnHLUHjCoWk1UT
         MtZLA3GJC4bg1lHglwrnEnrx0dDD2cTcJbOdurdJviEI50CLSes7UEBPLji3pSNyP4Um
         PyEj2eA5EiAVodIa27c0IAv08f6Iv1gKRok8le46zhwgHm5XpD3BRk5vglWu98KeYisa
         Zx8QgOgq+LMitS3tbSnzZB7Oh/IaRdItB0nhmxtm5CDsSlSLUtnxFSSjADmBO884zf2z
         gHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ylS4KYcnz6zgUnk7J6zC70zT8oatpCWr1rIO6eciB1E=;
        b=Cke7CasKGUIfxqTtPn3MGU2iYrMPQ/+fLMNW0EapB/nfSoqrlAdBHrXmLDdtGk7XFm
         g34URokAE92AXi9NfkF+koxwcljfEb4/4zxj4chSUtXc5Idp/OrkgkRf+WSN+VmlTV5k
         2kE7vp32SsgZ6t9GyCsZVk94Tdj9HNA36Wuzy6Ru31+7ltvCh+4F2SRYsGRwxFe8JUEG
         pxwa6PUP9sgAYtjmCJvSsromSV9qZ9zSlKVS58ZZS+nUOSr+Lp6yPFpKJIYU0HZtjRls
         uX+BrjlRiSVKIJQhY4GCPQpdZyZ6Ws23ZExd3ZDV2dGdANytqutldrSJxw3HaqaVGUHj
         9g/g==
X-Gm-Message-State: AJIora88ytZV0B0G68C+EwKhSFYAK6RQc/kNv1MxYF5xm1Q5onsU6xvG
        Fi8sbWZ4Gg1VAAZK/y+MjOgotUEptn3VKQ==
X-Google-Smtp-Source: AGRyM1u5qeXVGO1tvxIAbEoG86z8itNjxxGvYTqHh3hKkTQSz6pGim39H88wj31B7rpiRiM5RQMPAQ==
X-Received: by 2002:a1c:4409:0:b0:39e:f586:6fd8 with SMTP id r9-20020a1c4409000000b0039ef5866fd8mr2800542wma.157.1655974269794;
        Thu, 23 Jun 2022 01:51:09 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c1c0900b0039c7f790f6asm2561988wms.30.2022.06.23.01.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 01:51:08 -0700 (PDT)
Message-ID: <57cc70a9-1f70-66fb-3ed1-7c67a34f131b@gmail.com>
Date:   Thu, 23 Jun 2022 10:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2] soc: mediatek: fix missing clk_disable_unprepare() on
 err in svs_resume()
Content-Language: en-US
To:     Peng Wu <wupeng58@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com
References: <20220623070240.63382-1-wupeng58@huawei.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220623070240.63382-1-wupeng58@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/06/2022 09:02, Peng Wu wrote:
> Fix the missing clk_disable_unprepare() before return
> from svs_resume() in the error handling case.
> 
> Signed-off-by: Peng Wu <wupeng58@huawei.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>

Applied, thanks!

> ---
> v2:
> - Same holds for the error path of svs_init02().
> ---
>   drivers/soc/mediatek/mtk-svs.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 606a00a2e57d..87e05ab51552 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1526,16 +1526,20 @@ static int svs_resume(struct device *dev)
>   	ret = reset_control_deassert(svsp->rst);
>   	if (ret) {
>   		dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
> -		return ret;
> +		goto out_of_resume;
>   	}
>   
>   	ret = svs_init02(svsp);
>   	if (ret)
> -		return ret;
> +		goto out_of_resume;
>   
>   	svs_mon_mode(svsp);
>   
>   	return 0;
> +
> +out_of_resume:
> +	clk_disable_unprepare(svsp->main_clk);
> +	return ret;
>   }
>   
>   static int svs_bank_resource_setup(struct svs_platform *svsp)
