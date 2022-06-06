Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E353EB02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbiFFJXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiFFJWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:22:52 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A579A452
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:22:45 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kq6so14687756ejb.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YRul4En+zUsvPscyNur2BYtLJ2pA1uRWUnvIRnDGwd4=;
        b=pvyIsI7n6qmT9178HKdHJ+asUjScObVc4OEl1M7mzVYo4ABDlmCZMmwt4+NEkQi3dY
         Tqr4aGLjZwyhmHZqYpzAWUewSdELp4B8lhQxwq0hm0dynLQFf/PmlGooGA5YxSfoZAV6
         NqSEUpEbhK6NCZgUGPmMsnb80byIWbiH2Jd2rl1PxEFNG8iyy8LqeZna/kno2f2RorEI
         WIsHR/EnSH3X5XslvgYyd4VUixl3jJ+KXU6nU+Ec2j8/uwKxxUdAxZPQYBNtVArh2qMf
         ALNrMXO6+9woEyca3X7h1am4Bt4J0z2cWDteO5KKuZBtCPTh2lkfK293+hmIT0Jemm7q
         mQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YRul4En+zUsvPscyNur2BYtLJ2pA1uRWUnvIRnDGwd4=;
        b=5sC2VJGHOjCnngvSkB15bZ7xoPjarmaqb8Mpj8DwvGOeZWXoEYHTQDvwTy+ctv5edr
         v1LB7QRqLSnb/+kGlI3QJT5bzbqY8nCOXP1p8ZE7ApqL1aau6mITug9MZs4/rDMKPTP7
         /ibiVl+ltE8gsI/ow42sH8pVj23QhXpn2sUveZBF+uY+Crv5CwiJeAfCCaIMP0mboLx+
         pOIWdT6isNr0DIE/p5ceEuUB7mzsSz/4l41iQi9ohJpJ140mdCH8Dk+PL6yZYSby85tu
         d4zFvdQOrtEd0WgBJSeCm2k2N0mmT2Rh/Gq10+DBdC3axv0EJ60762L5SYSOSVj2Rqp4
         xVYQ==
X-Gm-Message-State: AOAM531YB6ygF+DOcsTjduCPGcuI+qjwZF1n1YS7fzakIVX7WGkLO6Tp
        mRYe2YUyLQVYzj2U6ZV0sf1Y+g==
X-Google-Smtp-Source: ABdhPJwKE3yxHKkpb+wb3yYnG20dDaj72u4ByxtQEbBoT8JgvyXTD9DJ5O3+EtlrYr2h87XGF3eF3w==
X-Received: by 2002:a17:907:6e12:b0:6fe:c2fd:89b7 with SMTP id sd18-20020a1709076e1200b006fec2fd89b7mr19647703ejc.581.1654507364209;
        Mon, 06 Jun 2022 02:22:44 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u21-20020a1709064ad500b006f3ef214e14sm5956397ejt.122.2022.06.06.02.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:22:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Martin=20J=C3=BCcker?= <martin.juecker@gmail.com>,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 3/3] ARM: dts: exynos: add panel and backlight to p4note
Date:   Mon,  6 Jun 2022 11:22:35 +0200
Message-Id: <165450734050.62970.863137205835285072.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220516193709.10037-3-martin.juecker@gmail.com>
References: <20220516193709.10037-1-martin.juecker@gmail.com> <20220516193709.10037-3-martin.juecker@gmail.com>
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

On Mon, 16 May 2022 21:37:09 +0200, Martin Jücker wrote:
> Add configuration for the LTL101AL01 panel and a pwm backlight to drive
> the display in the p4note devices.
> 
> 

Applied, thanks!

[3/3] ARM: dts: exynos: add panel and backlight to p4note
      https://git.kernel.org/krzk/linux/c/6c52573bf4c3a0f6e7142264fb36b31ae2c3707a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
