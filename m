Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1915E4FF5FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiDMLsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiDMLsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:48:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6954853B47
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649850338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EaxPGGHXyLb9wbskG5Rk/Qt8Ca+WGb+o08g1LVFPyuc=;
        b=QIojuyQmE8jiHBhS2elW2mUvSGJB7yJUfQ1bK8tJyf1cgHErP8QGfcuvTXFVphCnFRMPYP
        I7CD6l4lL5rroiIn92OY0e6h4U0z5kg8eXzroWN0AaMDCkzS63gFEs4sUaJ2hRYu7itDYo
        f7EeHyXLDpQlo9FR2xYfD9VZRr0tIRg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-3Dgo8dukNg26Flvn50NqPw-1; Wed, 13 Apr 2022 07:45:37 -0400
X-MC-Unique: 3Dgo8dukNg26Flvn50NqPw-1
Received: by mail-qk1-f197.google.com with SMTP id u7-20020ae9d807000000b00680a8111ef6so921360qkf.17
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 04:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=EaxPGGHXyLb9wbskG5Rk/Qt8Ca+WGb+o08g1LVFPyuc=;
        b=KiBxGU5EvsHbmSEUzrLga3BUtm1KenGvhIG149aTm+eJU9b8mWG+5xtQJIQL0A/D94
         x9M1Mm0Mfnv23+9A1cIFlX49LZHq2C3C46g+ONNW0V89RP1OnmiQR0wB/KhPwReJ5a6x
         T6EKggIgIA/SocOrX7Rnzt1BILbR32hM8UjrTu+cekgKJsabTXjX5jCzEj9uBXsYU+Qc
         wDN+NxHHruOWTmGSsb+eJt9IKPW/c6XNyQSofs5YjFPDiH1NFW+lEPNUNaQrmrkNdbNm
         qKOmims8X1ISA22oWeEtQyn+awXJYDS5wjQI2DDnBSHPlkIjhQx6b3Lg8dYr38apuq11
         5ziw==
X-Gm-Message-State: AOAM531bcHReOOWV2mkFUYw4yEDnjI0Vo+jVZXhMJSxYC1iN8KGGlr5d
        xzzcpJpB0VbcMyFWSFgQm/LlSazg1IM+18FeE37dzIWduYDHs6yt5gHS7SDQ88bXkIikTrAC5ey
        Wi7XwZWuFwlila8W7TgcORYrl
X-Received: by 2002:a0c:e98e:0:b0:444:2c4c:8e1a with SMTP id z14-20020a0ce98e000000b004442c4c8e1amr19543869qvn.129.1649850336685;
        Wed, 13 Apr 2022 04:45:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzldSp3Nk72saDE3BrEbvE/tO6CjGKEUpK3p2d9/m87+uUmhsTkoEdyRBpUZp+tbj3MOYuzTw==
X-Received: by 2002:a0c:e98e:0:b0:444:2c4c:8e1a with SMTP id z14-20020a0ce98e000000b004442c4c8e1amr19543856qvn.129.1649850336541;
        Wed, 13 Apr 2022 04:45:36 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id i17-20020a05620a405100b0069c45deb548sm1990502qko.130.2022.04.13.04.45.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Apr 2022 04:45:35 -0700 (PDT)
Subject: Re: [PATCH] spi: remove spin_lock_irq in the irq procress
To:     Li-hao Kuo <lhjeff911@gmail.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     wells.lu@sunplus.com, lh.kuo@sunplus.com, nathan@kernel.org
References: <9e12d806c5554b4ed18c644f71f6662fcf0d0516.1649813822.git.lhjeff911@gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <fdb1e0a6-62f9-c0a3-c1db-8857087701a1@redhat.com>
Date:   Wed, 13 Apr 2022 04:45:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <9e12d806c5554b4ed18c644f71f6662fcf0d0516.1649813822.git.lhjeff911@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/12/22 6:38 PM, Li-hao Kuo wrote:
> - remove spin_lock_irq and spin_unlock_irq in the irq funciton

function

I was expecting a statement on why is the lock is not needed.

Could you add one ?

Tom

>
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
>   drivers/spi/spi-sunplus-sp7021.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
> index f989f7b..120623c 100644
> --- a/drivers/spi/spi-sunplus-sp7021.c
> +++ b/drivers/spi/spi-sunplus-sp7021.c
> @@ -199,8 +199,6 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
>   	if (tx_len == 0 && total_len == 0)
>   		return IRQ_NONE;
>   
> -	spin_lock_irq(&pspim->lock);
> -
>   	rx_cnt = FIELD_GET(SP7021_RX_CNT_MASK, fd_status);
>   	if (fd_status & SP7021_RX_FULL_FLAG)
>   		rx_cnt = pspim->data_unit;
> @@ -239,7 +237,7 @@ static irqreturn_t sp7021_spi_master_irq(int irq, void *dev)
>   
>   	if (isrdone)
>   		complete(&pspim->isr_done);
> -	spin_unlock_irq(&pspim->lock);
> +
>   	return IRQ_HANDLED;
>   }
>   

