Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ABA4FDC4C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355770AbiDLKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378015AbiDLJ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:59:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8F4C45
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:06:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so26737231wrg.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=TcbQOnznNM38vbqn4dzf7jYEVnEO7TEqfVzrcEANZdA=;
        b=FgvDw1RuIAKPJbLmdUWuxbejU3TEbMwippcIC3e1RZFiwuTdqSXegk6DO/0S184zN7
         ZxetjPdw7QvHIknfHNJr2DbQF/5AKkurjIiaLA/fopymwMVH6cBTgTxXnRYIEFlUlSYs
         XEufP/K2/jtm9Crs/8dSJgPW7vvhW62UuvBxa5XJ4EU4OOG7EdAR+nbROACZb9/jHyIg
         gxRp8kZS9xsMf5edPWC4xWfakFXLV0HOIa179FqG0PzcAe3hYo7i/eXMeebGVruCb6o+
         iAte2FpSwgaF2oZCDVqZ5knjPR2wvtk1VihxMiPl9advkhXBl3JVxGVQKGg39s8ECZTw
         Quaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=TcbQOnznNM38vbqn4dzf7jYEVnEO7TEqfVzrcEANZdA=;
        b=xvefx5G2X5yp0iQ1yfrOnnmPwGulblTRleM2JnCmJhlz/BQF7fTqbqKDhqmpBmmGMS
         orOr4i5+1DhlIlY5Roy9ZckFOaDUZ1BFaXXNVTso7f36wQ+nCL0/u9inAHusWFT3QGUG
         4w2pjr4Vxda825ijDAqBthDuwDnI38WJMPifVTeePCiFck0Z51eYvVR7Gkyb9OsuMPfe
         awjNzse1FLoETf6nGkZkLP3pGh/pyc0n19WTv2yEnk1bOvzau+261f2ncIDBJ4qbG/PI
         T0u4/zMLfX/T3SwnzMIVGMzlAzRmgX/U6nDblHEe/aom7TlGN7xNubfx1XFwBIUMzonw
         1snQ==
X-Gm-Message-State: AOAM53375/2FsET7jSAHjc38sYuQRRelmQn+1TH3j8X7rdSxOfxNTu3/
        6/TuUv0b6y0nVhGSYAWroTLD2A==
X-Google-Smtp-Source: ABdhPJyCsICMMt55JJuqse75adWYa2k+xDavBtU14NQhFbciHUBoB8+E7linJ/Ua3r5xirDa71f7Aw==
X-Received: by 2002:a05:6000:15cb:b0:207:9f9e:547e with SMTP id y11-20020a05600015cb00b002079f9e547emr11653325wry.549.1649754375837;
        Tue, 12 Apr 2022 02:06:15 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id g17-20020a05600c4ed100b0038ca32d0f26sm2000647wmq.17.2022.04.12.02.06.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 02:06:15 -0700 (PDT)
Message-ID: <4d3a73bd-4048-2cef-0682-0823e29a6514@linaro.org>
Date:   Tue, 12 Apr 2022 10:06:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] slimbus: qcom: Fix IRQ check in qcom_slim_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <239c3b32-6754-02ba-6bfd-7f05fa2adfed@linux.intel.com>
 <20220301061421.14366-1-linmq006@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220301061421.14366-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/03/2022 06:14, Miaoqian Lin wrote:
> platform_get_irq() returns non-zero IRQ number on success,
> negative error number on failure.
> And the doc of platform_get_irq() provides a usage example:
> 
>      int irq = platform_get_irq(pdev, 0);
>      if (irq < 0)
>          return irq;
> 
> Fix the check of return value to catch errors correctly.
> 
> Fixes: ad7fcbc308b0 ("slimbus: qcom: Add Qualcomm Slimbus controller driver")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied thanks,

--srini
> ---
> changes in v2:
> - use more precise expression in commit message.
> ---
>   drivers/slimbus/qcom-ctrl.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/slimbus/qcom-ctrl.c b/drivers/slimbus/qcom-ctrl.c
> index f04b961b96cd..ec58091fc948 100644
> --- a/drivers/slimbus/qcom-ctrl.c
> +++ b/drivers/slimbus/qcom-ctrl.c
> @@ -510,9 +510,9 @@ static int qcom_slim_probe(struct platform_device *pdev)
>   	}
>   
>   	ctrl->irq = platform_get_irq(pdev, 0);
> -	if (!ctrl->irq) {
> +	if (ctrl->irq < 0) {
>   		dev_err(&pdev->dev, "no slimbus IRQ\n");
> -		return -ENODEV;
> +		return ctrl->irq;
>   	}
>   
>   	sctrl = &ctrl->ctrl;
