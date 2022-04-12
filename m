Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC2F4FEA79
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiDLXcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbiDLXbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:31:55 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D66515B861
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:27:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id k13so243722oiw.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 15:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UxsCoDp31aiBImIkqt24q8Po1hYiUkBUonDFR5Ofntw=;
        b=bZwl33ihse6GJsvXWKqeF/IvrtS5uft25XvaEmueM5II7dwdtvYViIen+7Wp1P7mz4
         VKgUHWj8EIKf82qgI43YteAK0OkCiwKFfOgOMB1Q2JbRCIPw2BQcyLtCBRSkUb5h67yt
         oeFt0MzLGTD04LYu31FTgHr0p3sxhvuYqBr3HHxaPF7ebxmSskQlF3g5SHcJjviq+NhW
         xtat1qBFPUPJKwzEa2XQWuO24VxhE6IF/j2YYiKP/yRfH14bMFcJBFB3QlenXLMzYoap
         XqE32894ZyK+6LRmumbtoilW1fK5oZZZkEkyN1cQSU4E787hevhLMrHPMv/hP0nZ6kE1
         Jl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UxsCoDp31aiBImIkqt24q8Po1hYiUkBUonDFR5Ofntw=;
        b=2EdyhlTjWc+gl5G+yjLrUsTxruxeY29BV1/eWEn7PxSFJ9YnRzPiqpEKlO5FVfvu2Y
         yVSgeHg5Ba4F271hnaiZDaPqOhWZiTF6DHmm6JHcCZ9txk7r4J/essp8sxYCqmbLoBdd
         UhYilv2qw+Fnx+6EEdgxBW/XPvs5rk2mzTW9g3vZJsd41C8J+b4kU6p6BrvmdWgdZAo6
         +faNWRs55xmyFz8fsgWOTU0J9gHtlhJTfMgffcX9dRuc9jo+Q5OtrnYc0wjUHtAZn3Ve
         kvPAkdxQmmqv2iO1YEQ2Xwf8nc3/Xz10WiPzqVwZ7vSXLK27jCnt2g0J4LvMff+BIQPS
         nt8w==
X-Gm-Message-State: AOAM5303DwxiW4ryGEOxPEE6dc7LxHx7E2aYXJqBMUiNoeVjiYtaIawl
        L3s1vJbZ2uO2nCbd78MAlBQWnBS3pYCQiuK+
X-Google-Smtp-Source: ABdhPJxQXi0kdMcvyM1GWhqO3O9Kb0wbW7X9aOWlbTvYSzQW8CKf+NDBl31lTel+Bm4PQUGUuT9DAg==
X-Received: by 2002:a05:6808:114d:b0:2f7:59fd:2f18 with SMTP id u13-20020a056808114d00b002f759fd2f18mr2672185oiu.113.1649798910952;
        Tue, 12 Apr 2022 14:28:30 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w133-20020acadf8b000000b002ef9fa2ba84sm13078432oig.12.2022.04.12.14.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 14:28:30 -0700 (PDT)
Date:   Tue, 12 Apr 2022 14:30:44 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: qcom: gpi: set chain and link flag for
 duplex
Message-ID: <YlXvhAJHl2JKy2+6@ripper>
References: <20220406132508.1029348-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406132508.1029348-1-vkoul@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 06 Apr 06:25 PDT 2022, Vinod Koul wrote:

> Newer platforms seem to have strict requirement for TRE flags which
> causes transaction to timeout. This was resolved to missing chain and
> link flag for duplex spi transaction.
> 
> So add these two flags.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Tested-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/dma/qcom/gpi.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index 94f3648f7483..3429ceccd13b 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -1754,10 +1754,14 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
>  		tre->dword[2] = u32_encode_bits(spi->rx_len, TRE_RX_LEN);
>  
>  		tre->dword[3] = u32_encode_bits(TRE_TYPE_GO, TRE_FLAGS_TYPE);
> -		if (spi->cmd == SPI_RX)
> +		if (spi->cmd == SPI_RX) {
>  			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_IEOB);
> -		else
> +		} else if (spi->cmd == SPI_TX) {
> +			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
> +		} else { /* SPI_DUPLEX */
>  			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
> +			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_LINK);
> +		}
>  	}
>  
>  	/* create the dma tre */
> -- 
> 2.34.1
> 
