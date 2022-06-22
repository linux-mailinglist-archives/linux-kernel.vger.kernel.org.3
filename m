Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B176F554C1C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350991AbiFVODI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357889AbiFVODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:03:04 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68AADFD4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:02:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k22so17134422wrd.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 07:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=e2GTDbUmRu18NwC+1WvY5Rsf+dw1KVd96phhm5UWgsA=;
        b=Gr5BDyX/k/r9/SHskmWky1cirIzDw/jMRmY8Mm+hStke7+GZxDU+zP++m+NIpp64fq
         owApReBr3/VwoZEacCr8KgHf7dmyG3ubOUgchqqWY3DrPrlUi4Fzd5veVO6gX9neaa5f
         EZR7sOgX9iU4ixgoFfZtFh/pK/pOTnUX+2DLjujRiWRS363uoiAAFhTrm9bIJ2tRPZI8
         LVExA8AwtXEIUNro1vp1hcvwPR1qyAIx5x2pQozXhCpGBzhfPs8v9Qh7k2lfftDQIFrO
         5DJJ9Apvp69AJ+eiVxcwsxREaA/o19sqcdYz2sM3OroOkg+Uk8JEPVD2iQa0Q/mfIqm4
         Ov3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=e2GTDbUmRu18NwC+1WvY5Rsf+dw1KVd96phhm5UWgsA=;
        b=c4tbPcSBrAUd5tGBb8k+B2JYbTmhzhV3R/XSrVNAKP/VBmMtQuqkc4TKGo7RacLmqW
         pIJjoXa1WZ8nNSX6smUosJvWQx4fgP58FFwYffjQLG5ZlT+W+c+HkKa2AuMc5t8qrzxm
         btZBCvnct/uBpDUTlHjsJJ5yYh9LKM9oBBm2vsT/yMlcxhXroTY9M6up/9hX2FT1fb69
         GFicO/i3A3KV4Fj4XXc+JIBwqMKSaUyESVYu0v3bc9wYTcG9MpX6v/oQ/3mCirBAFBAC
         WfMZca4BS3xlX4YGce+EkwU8Ft1hxpcKBublu3oowrgPZLPH4H9NaxBtzaZt+i2O5TXC
         ivyA==
X-Gm-Message-State: AJIora8w8TeRi6EJlW195FMH4lusgTiQxm3h+HMalzVyS2JMIWWnQwhx
        cB/SXS3Y2LgyRATq2vgE8+Y=
X-Google-Smtp-Source: AGRyM1veyrLsvSIgFm2G1Nn8pqcbhMb1D+Cmbvb6GGNrC03EewmSkf80cEfjccnmNy2HiPly6p7Mag==
X-Received: by 2002:a5d:48c8:0:b0:21b:826a:6f86 with SMTP id p8-20020a5d48c8000000b0021b826a6f86mr3531919wrs.220.1655906578348;
        Wed, 22 Jun 2022 07:02:58 -0700 (PDT)
Received: from [192.168.0.16] ([37.223.148.38])
        by smtp.gmail.com with ESMTPSA id f27-20020a5d58fb000000b0021b9e8d4c22sm2300195wrd.61.2022.06.22.07.02.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 07:02:57 -0700 (PDT)
Message-ID: <f48e0cca-644a-bad7-282b-28e3e0d5d437@gmail.com>
Date:   Wed, 22 Jun 2022 16:02:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] soc: mediatek: fix missing clk_disable_unprepare() on err
 in svs_resume()
Content-Language: en-US
To:     Peng Wu <wupeng58@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com
References: <20220621114658.10054-1-wupeng58@huawei.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220621114658.10054-1-wupeng58@huawei.com>
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



On 21/06/2022 13:46, Peng Wu wrote:
> Fix the missing clk_disable_unprepare() before return
> from svs_resume() in the error handling case.
> 
> Signed-off-by: Peng Wu <wupeng58@huawei.com>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> ---
>   drivers/soc/mediatek/mtk-svs.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 606a00a2e57d..1b5c297aaec5 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1525,6 +1525,7 @@ static int svs_resume(struct device *dev)
>   
>   	ret = reset_control_deassert(svsp->rst);
>   	if (ret) {
> +		clk_disable_unprepare(svsp->main_clk);

Same holds for the error path of svs_init02(), correct?

Regards,
Matthias

>   		dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
>   		return ret;
>   	}
