Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDC553125B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237592AbiEWPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237581AbiEWPL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 11:11:56 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355F24A3E4
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:11:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h5so20702388wrb.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7h/KQt7Gzc3HQkbNCwwgoLtjOZYGEyw/thG38+Y/9pc=;
        b=yD4Dk5reZabRrlBn67GpBQPnumgx2fGYw9o8ZEO5TCyXqPollokxS0ADfya/iNX4oA
         DYdpe3Gy0FlgOGMdMRQwDPh6XJXt90IbeQ2+Np20oK3MfGP4gVCaMiRcTRYyP/YcXEc+
         u1uV2Uzk6Lasp2C5wTRsSyDQhs7UNs1XCs5Y2Na7PVAivClyMsq9QHTHzrGTNSinQ/xx
         DVeqRC8DTPeCiGcREFR9xd6VhHIsMwIFxmkNxS+/dZSKUK2+WG4cndcJuqjz44yC7DVr
         j60q5lfpnSCDeLENH7hdGnszpCeHEY31GbegypiJZYyJSy+mdNFZ4XvDZr28F4BUWe4j
         yfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7h/KQt7Gzc3HQkbNCwwgoLtjOZYGEyw/thG38+Y/9pc=;
        b=19tocW8SK2EXrj97LqPYwqjTaLHTHEJUjYWaLIJCD/OE9XoLxUIly8QRx4Q1AOE0E/
         Ccq0m31g186N44PAvm9ynHoFS9abBb1+CPrdkbvBKIjhsX4pIpPPXvRvGL25DuO+dBwF
         nvLjhDQsWWVa1m7DV3usw1K/SARR6CKcmwvclmyscXJYRvZ9Fn0oLOJo30/i6CnFzqfX
         dOS1huzZQbIjfB8/n05cjk+0LeKWdvNkceu/cqaNflfwFTohj2Ele8yKvTC4g8qxSHmc
         KCKV379kJIOL9/FAo26q7WYpjKkvAViYri7gmuFHOWLK+7f31+/KW5Ckj+qJs5AUrVfX
         ZOpQ==
X-Gm-Message-State: AOAM530erWJ0FGRBCuwX7EVSvKqxjppE8lUTaXvoEjcN3MXG9DmJcudC
        wcj3QEHUdmy8xx6HVY0ewo7oww==
X-Google-Smtp-Source: ABdhPJxVUeEdhefzEjlzSC8eYKT+NZnwnK0Pe8cKjJGa59wR4aefUSfAV1iaw6NG/VT/vOtL6bXSPg==
X-Received: by 2002:a05:6000:18aa:b0:20c:7ec0:b804 with SMTP id b10-20020a05600018aa00b0020c7ec0b804mr18431525wri.128.1653318713774;
        Mon, 23 May 2022 08:11:53 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id q11-20020adfaa4b000000b0020fc6590a12sm5607184wrd.41.2022.05.23.08.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 08:11:53 -0700 (PDT)
Date:   Mon, 23 May 2022 16:11:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Craig Hesling <hesling@chromium.org>,
        Tom Hughes <tomhughes@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH v5 1/3] dt-bindings: cros-ec: Fix a typo in description
Message-ID: <YoukN2uCpL3rmMsQ@google.com>
References: <20220512013921.164637-1-swboyd@chromium.org>
 <20220512013921.164637-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220512013921.164637-2-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022, Stephen Boyd wrote:

> A 's/pf/of/' on rpmsg-name description.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> Cc: <devicetree@vger.kernel.org>
> Cc: <chrome-platform@lists.linux.dev>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Craig Hesling <hesling@chromium.org>
> Cc: Tom Hughes <tomhughes@chromium.org>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Tzung-Bi Shih <tzungbi@kernel.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
