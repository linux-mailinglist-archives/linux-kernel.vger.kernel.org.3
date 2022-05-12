Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D7D524A5D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352669AbiELKdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352667AbiELKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:33:13 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D51622308F
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:33:12 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id ks9so9334798ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=1cXKpnTu/ZLXUfBczt5nbt9dexjJtFDU54PLSn0k7Lg=;
        b=cInE4pzJ40MvUmXYRlgjXJyoRL41LQ3yButhtEWGFZ7/8Zd06i5srjA1TH9OefEwgW
         sjq37wkE7jsBaKVh/jesKQeY2rrxD4nK7uylhVcSb7XGAmBCXSXwYFzeMgBP5kj0n9lF
         1nv02uY15D5juyGK8jJx633QgbhqKnw6QBh7BDSVoLV6EOTSzscsvTjatbXONURJCAxB
         tquSsQ5RhYnP0vCSEJeB1CnXLYkvfJTNdW4SJI9NYHfH5mEzHgj02Uh1XrpJsQ+I7XUL
         AyTR0uqMagN5HtlXFV6ud1YWKdOoIAiF+OMTI3yDY8mGyMGxVulg9BgArlT/jUHxAT4a
         b7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=1cXKpnTu/ZLXUfBczt5nbt9dexjJtFDU54PLSn0k7Lg=;
        b=bsNMQpaDOY4jSaN8VeuOwxC2zC+UcL6q18pZ5Hvg0VLmpz5h44jj44AQB6zwRdG7Yv
         dHF+7aE4nPiAPXuoQrydSQj82gM3egmJR+/DUqFr7h14PVrkQvfarHKOMcM4Xfc7fMuT
         FbZJxOdXZlqjtTY/JsOYhNHe4ZHkzM1uii0zqALR3F8PXbG4qfFFGj7k53A/FriMx7Al
         rz+1Bu5LJRWMFYt9lnsPsMbHiUk+03PXKixvta14ysM6C8doTM3nZpmYUSWahd86aWYG
         Lm7ZXd5yW3qZa/mtYYjTBnDic0IzOnaXjaUHCqXfgapozmy2smUheYA9OZj0CkXsPyHE
         FgPg==
X-Gm-Message-State: AOAM533LuGg5G9YKMVKSp05gxUheQ2/GpabBZ2usmPfc/8G8Vl8sW9Bc
        g4wgh6nnt42KaNiBb//kRNFtDA==
X-Google-Smtp-Source: ABdhPJznRmMGMeNHo+cuaQf//fXNuvOGcK63Pv0Iq0mM3nOpz8Lcf1qQAMT/baMrFLmAsXXsbW0Dlw==
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id nd14-20020a170907628e00b006d9c6fa6168mr29025209ejc.132.1652351590726;
        Thu, 12 May 2022 03:33:10 -0700 (PDT)
Received: from [192.168.0.158] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id dx18-20020a170906a85200b006f3a8b81ff7sm2019506ejb.3.2022.05.12.03.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 03:33:10 -0700 (PDT)
Message-ID: <eba74198-b78e-1577-846f-f58494fb09f1@linaro.org>
Date:   Thu, 12 May 2022 12:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] ASoC: samsung: Fix refcount leak in aries_audio_probe
Content-Language: en-US
To:     Miaoqian Lin <linmq006@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20220512043828.496-1-linmq006@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220512043828.496-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2022 06:38, Miaoqian Lin wrote:
> of_parse_phandle() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> If extcon_find_edev_by_node() fails, it doesn't call of_node_put()
> Calling of_node_put() after extcon_find_edev_by_node() to fix this.
> 
> Fixes: 7a3a7671fa6c ("ASoC: samsung: Add driver for Aries boards")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
