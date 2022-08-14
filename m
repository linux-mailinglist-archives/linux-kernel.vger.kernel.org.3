Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9EBA591EF5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 09:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiHNHq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 03:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiHNHq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:46:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE7D1EACD;
        Sun, 14 Aug 2022 00:46:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id x21so6126440edd.3;
        Sun, 14 Aug 2022 00:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0ZqIRQWJDcAC5WtbT7TgFRmcMUbjN/uJOcvXh/zp784=;
        b=gxLU9r/njC15ZNa7u6wmpTydgDAmpZqNMGimY2taEyzEHjjMII7wiFB+6IgXe8E7Tj
         tEiKi+U/UOWI5BgH/N7PCzqY5Do6hz8mQ3uKO2ptcCp7hy+PGyH88inR6MuKIdA/usqX
         ofY8vpWAhNCh7o50QyseDquZ+A3VyEKw2hqIwB64vW8V/sR+stgRWaL3TfVysNs9Bw2h
         sLn/NLo7rTFRCVaQkz9t5NHfjvBNXXBlI1H2ToZQT7ar+86To1Ol2M0G8wM01rc8UAMC
         EP404fnL3P2vDtpig9tQU+cSAZakASLZfRp36Os/ODMalwIl7Wru2Udldvs7qG62w6qv
         em5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0ZqIRQWJDcAC5WtbT7TgFRmcMUbjN/uJOcvXh/zp784=;
        b=RV3FP/cTkRBYLUh6zM2AC8CxPYjYV1UKGMEBOQkzn1ShyV+CQVDAGWV714jkiUO8Sy
         YySwiCmHZKUkV4Qcht3L7D/XVEOm3trNcR5/9VdC0flPBy0vFhD00IvC0quTMJ/SBQ5/
         N2kwvpqnwW3LzkFCHxOAmZ/P5nQgYXj4vvUoXriMTYspnBW1eJID40Ng4T/0bSbmCzFt
         YMSGdZWfMSLLt0kXPidejv8o5phqGELs7oe+rsZ7kb6d/6dEhiK4oHwumNPmFYa6fStG
         Dap1qfawbl09VP0HiLCDLBExhR8souzFxStLybRsRyxp5L7Gr8AhO3CtUTnvFHATj9sa
         JXPw==
X-Gm-Message-State: ACgBeo3W2vBqItZ9r/ienimk1uwTM1ZYtJlyniU1dFM80ibHIQuUV9Iy
        zrle0ma1FaH79FKqLRoeahU=
X-Google-Smtp-Source: AA6agR4PqI308kOBU328tJjNj3BJGJwFneQKD2OMYaR6Vh3pmZvoBbypevpZRbQBhX87/O3h9QhLAg==
X-Received: by 2002:a05:6402:4029:b0:443:a5f5:5324 with SMTP id d41-20020a056402402900b00443a5f55324mr1351235eda.51.1660463213805;
        Sun, 14 Aug 2022 00:46:53 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906201100b0072f1e7b06d9sm2667073ejo.59.2022.08.14.00.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 00:46:53 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/4] drm/sun4i: dsi: Add a variant structure
Date:   Sun, 14 Aug 2022 09:46:51 +0200
Message-ID: <4731474.GXAFRqVoOG@jernej-laptop>
In-Reply-To: <20220812074257.58254-4-samuel@sholland.org>
References: <20220812074257.58254-1-samuel@sholland.org> <20220812074257.58254-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 12. avgust 2022 ob 09:42:55 CEST je Samuel Holland napisal(a):
> Replace the ad-hoc calls to of_device_is_compatible() with a structure
> describing the differences between variants. This is in preparation for
> adding more variants to the driver.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


