Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ABE4C371C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 21:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiBXUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 15:54:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233855AbiBXUyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 15:54:45 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D211C6EDA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:14 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id k22-20020a9d4b96000000b005ad5211bd5aso2202779otf.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 12:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=w7kYYicECLFYqJJp06iUhZt+dZdvmlULZGafsy+TJYY=;
        b=jZEz+rzkZ3qSK3QIGheoWaMmA3vav7COKy6XwkN2b1xZlR8w8uHw9DU+hsfVrKT2A1
         U+nJo9oYUOhKL2bluBtJc7uA2lL279nyzDvXpMQrF6jfqgRTzBzicWt8M5L7O24AeScr
         c3tANUX7ruj1tgsLIYaMxWfWfMHGFsBUoBh3oTqvs+HCxFWt0HI6kAvxv59aVIEjm5qB
         DHNii3B4lT65JyRyop8S4Ye+rYq8DgmRA7P6XT51vRvnKyAkiODRXBDabFIs6jRMkJ4R
         /Dzfvtw98dOOGyzT0mdluTBhkcSOBAFD5TjzwdK2k/Xz3Fluj/VsS40oZVY+YfhRh8J7
         CwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w7kYYicECLFYqJJp06iUhZt+dZdvmlULZGafsy+TJYY=;
        b=JefeStGUMTxFAMaN7hrWXRH1JCjfqQFwfsSc85oJtcQsW30lJ0bjXhO352UaP+t0HX
         HO6aFlnxt7EWBrc6zWbDqIG5IeKjT1o6UjB2LLWUeqkyEJgL/43dUvqZKhIA/h5hq9W+
         vS8OiNhfMcDf1J8jyPjpu/2zPEZl0/pNBXAlFyKKMWjwN96E7P5/IW93W0qFBOoC2uqv
         WQEfTPY/iXivXe9WZ0ln328jouuA9a8yYuhg3YXhC643ooT2Hpe3LuQxo5FvJmHv8lmb
         kAMcS3wuIbinI50vqI8ywNjGkrc6pb2D6PleZulZs93D8SsbgIM3HY2CXnoX35aPESHu
         5yfg==
X-Gm-Message-State: AOAM532GARMbjYnLF4tHEnb0g61RXN3SL5iCD7JllS1KuWqazEVRM2g+
        /eBcDgMSzN6hCpW4jPpMBDZd5w==
X-Google-Smtp-Source: ABdhPJwqpinof7vCzpo3JsDgvR8WPsKLX9v8AOxpnybjdBazfy5rwg4vCIHUvilq1nJfyHr4S8hplQ==
X-Received: by 2002:a05:6830:1098:b0:5af:a452:2f17 with SMTP id y24-20020a056830109800b005afa4522f17mr1620669oto.175.1645736053623;
        Thu, 24 Feb 2022 12:54:13 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id c8-20020a4ad788000000b0031ce69b1640sm191259oou.10.2022.02.24.12.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 12:54:13 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     linux-rockchip@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benson Leung <bleung@chromium.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-arm-msm@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: (subset) [PATCH 3/4] arm64: dts: qcom: align Google CROS EC PWM node name with dtschema
Date:   Thu, 24 Feb 2022 14:54:00 -0600
Message-Id: <164573604161.1471031.3877884989605040071.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220214081916.162014-4-krzysztof.kozlowski@canonical.com>
References: <20220214081916.162014-1-krzysztof.kozlowski@canonical.com> <20220214081916.162014-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 09:19:15 +0100, Krzysztof Kozlowski wrote:
> dtschema expects PWM node name to be a generic "pwm".  This also matches
> Devicetree specification requirements about generic node names.
> 
> 

Applied, thanks!

[3/4] arm64: dts: qcom: align Google CROS EC PWM node name with dtschema
      commit: 1e49defb863638cde53e48805747271f80f9abec

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
