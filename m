Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D0B4FBB9B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345944AbiDKMFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343710AbiDKMFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:05:35 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B338BC6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:03:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id g20so18065342edw.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sryDvYgEFOGv4IJF4K9rpE4qtbHpyGvRB0BObkRxaW8=;
        b=ZeuqxHL/xUOhw5sAPzbxJiW+mJhv3tLnVd1zttqHoikIexQgEMDzM+4xsDCWR2apar
         oI7AhLc2by1lLL6ho7hSn8JKR0sJPmgqjVyY6s4nvpRusOCaM6VuF8awJGJy5DwRtODF
         aHOKshJCRPSvu3Rw3gD5QAC2273wgiNYnNUnXFnSIlgev7KYQOMwOhwS20E+aF/Z2FHW
         egUy+D/7mLCVl6M3fTm2PM15/ePGufZF1kt8lTTt20B25HTcm7jCI6sZhOiteX40Nqpk
         UdJMYBTyZ78iouZsh8cblU2innmiGIr3OJGCPQwRU9bLivSpl2avqwiu5C6YQ7aBxsqb
         afIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sryDvYgEFOGv4IJF4K9rpE4qtbHpyGvRB0BObkRxaW8=;
        b=rGwbwunQWeVCs38ayWpjKIqYSELO3TDO6EkezCHhinDG9fC61hr+Pr+V4oCKF3CprK
         RdIxj+pFaKLyj54J/4FRPZrOEfItLuiMZu15VQ7R27ORmgHtVgjxRNONPlYezFpf6pU+
         a1iogiMUnHVze2y50sY6J+TXq8kBuF2qrNQRhInXdwAlW8fo712r495REZfEOq95sVu2
         9RF61tlTpIFpqZz+rmeqdeFWIbhUAagau2m+ssmxEFUB/98ELLTvvtiw5ffXESyUOuSp
         7EwGoO2hePjn1A/uxSyu/oxJ2eSROEFzJmQUETOOsGyJzzhcxg0sqCq3TCNITNB0l5av
         FmHg==
X-Gm-Message-State: AOAM533WHmQhfAqMcGwYBJNXvVPckkExwKkak5iDcks4C0mt0yeodBKA
        /IP0zbXIqiYGGETz4pJ1EVoDoQ==
X-Google-Smtp-Source: ABdhPJwfxX3gqy6wbrPbt0StZfR/zFoOxk9BdsKT3mp55beZn2LBapIU+Ud3zwIytSzkgcRx+Htamg==
X-Received: by 2002:a05:6402:1941:b0:413:2b7e:676e with SMTP id f1-20020a056402194100b004132b7e676emr33445108edz.114.1649678600506;
        Mon, 11 Apr 2022 05:03:20 -0700 (PDT)
Received: from [192.168.0.192] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id vz13-20020a17090704cd00b006e86ff07609sm2854334ejb.33.2022.04.11.05.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 05:03:19 -0700 (PDT)
Message-ID: <9e168479-9fcd-d3ea-3c06-8d186e53a18b@linaro.org>
Date:   Mon, 11 Apr 2022 14:03:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 05/13] pinctrl: samsung: Switch to use
 for_each_gpiochip_node() helper
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220401103604.8705-1-andriy.shevchenko@linux.intel.com>
 <20220401103604.8705-6-andriy.shevchenko@linux.intel.com>
 <d1f873c6-150f-5f4d-7aa8-7bb15823d991@linaro.org>
 <YlBXSVyj88CqjGj4@smile.fi.intel.com>
 <3b527700-444e-1f6e-fee1-5cd6ed2ef7f9@linaro.org>
 <YlQXZ3Ye13rObMy8@smile.fi.intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YlQXZ3Ye13rObMy8@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2022 13:56, Andy Shevchenko wrote:
>>
>> Makes this change smaller so it's easier to review.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel.git/log/?h=review-andy
> 
> That's how it looks like. Tell me if it is what you have had in mind.

Yes, thanks.


Best regards,
Krzysztof
