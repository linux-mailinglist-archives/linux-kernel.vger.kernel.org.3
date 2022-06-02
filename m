Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187AA53B784
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbiFBKuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 06:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiFBKum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 06:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 900C83ED29
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 03:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654167040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrhV5vnxv6SRuKZJ5gBXpRv/4ZhVI+1PkR2Fak5zt3E=;
        b=PqE6hC/lUcz630ZnZyFPtwZE+lEPTGuWWTQQUmI5UIOO/At38K8Ou4UnnC3nYU2HSqChFL
        Ui7pUtU4So4zfsTJReO3UBkJMfxwS/pRoLc5sY+YxBEa/PxxkdDRS/SsqY6oWyS8iIX0N6
        vRiOSseDAjSdDkqWB6cjx98S0X4wq/8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-CX_6wEC9Ow-VAiDipp8GPQ-1; Thu, 02 Jun 2022 06:50:39 -0400
X-MC-Unique: CX_6wEC9Ow-VAiDipp8GPQ-1
Received: by mail-ej1-f70.google.com with SMTP id au8-20020a170907092800b00707784fd7e0so2187485ejc.22
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 03:50:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DrhV5vnxv6SRuKZJ5gBXpRv/4ZhVI+1PkR2Fak5zt3E=;
        b=WiWLh5BSmtK9OhTUOLzkggJr14Qh8f8yr9K9JzJmvvXWQXAI0s6cGrvSU340Fnej6p
         NdA/lBLlK3B/jtQj1GlA/9gRKE2RVlws/Pdqp4NsDtCnlD4u6jHsi+ah5SIjCjnHlRk4
         YNESY7HsfdZ9v8iYBMbQXi0KlwGhuPZi4rvCOQ9cqBjSuq0vcOwK0a6DWims8nBXM7+F
         PEG/kRt0edrcQhb50M5Z+myWwLgoThihVhYBjWmBqPLrlkrqSlzP63Geg2Id28R3t853
         CCJC+EkLZUHAhm3eExHE5HI9nS8mB6xawx1fv16ZPvkFn3WVBDy+Fyak6x8/FEfy+qsI
         ZY5g==
X-Gm-Message-State: AOAM531cttMct+/vxlpxJoAPyUtFR+2mUj8g5vcCI+J4BHxKdaSjv9tP
        jHSV15tpj4GI2019EB2DFEa/TGyOhuaCiK6BVhOebAIH4NFGRMdciSN9A3uzZ/I1/KyyFzJCELh
        aP5ktiAQcR87h475QT7X1Xzfm
X-Received: by 2002:aa7:c852:0:b0:42d:70d8:2864 with SMTP id g18-20020aa7c852000000b0042d70d82864mr4622041edt.379.1654167038352;
        Thu, 02 Jun 2022 03:50:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxagkCoICyD4tyHlyBtfQJTn2p3Yp2BOSbtulSpElsl0xzECJsO+qskjhWefExGoeHv99aQBQ==
X-Received: by 2002:aa7:c852:0:b0:42d:70d8:2864 with SMTP id g18-20020aa7c852000000b0042d70d82864mr4622024edt.379.1654167038205;
        Thu, 02 Jun 2022 03:50:38 -0700 (PDT)
Received: from [192.168.42.54] ([109.38.144.46])
        by smtp.gmail.com with ESMTPSA id e1-20020a170906374100b006f3ef214da8sm1651719ejc.14.2022.06.02.03.50.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jun 2022 03:50:37 -0700 (PDT)
Message-ID: <84aa3225-d514-4c08-f6d3-ed8f0423e513@redhat.com>
Date:   Thu, 2 Jun 2022 12:50:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] fbdev: simplefb: Check before clk_put() not needed
Content-Language: en-US
To:     Yihao Han <hanyihao@vivo.com>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220602094219.13024-1-hanyihao@vivo.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220602094219.13024-1-hanyihao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/2/22 11:42, Yihao Han wrote:
> clk_put() already checks the clk ptr using !clk and IS_ERR()
> so there is no need to check it again before calling it.
> 
> Signed-off-by: Yihao Han <hanyihao@vivo.com>
> ---
>  drivers/video/fbdev/simplefb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
> index 2c198561c338..f96ce8801be4 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -237,8 +237,7 @@ static int simplefb_clocks_get(struct simplefb_par *par,
>  		if (IS_ERR(clock)) {
>  			if (PTR_ERR(clock) == -EPROBE_DEFER) {
>  				while (--i >= 0) {
> -					if (par->clks[i])
> -						clk_put(par->clks[i]);
> +					clk_put(par->clks[i]);
>  				}
>  				kfree(par->clks);
>  				return -EPROBE_DEFER;

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

