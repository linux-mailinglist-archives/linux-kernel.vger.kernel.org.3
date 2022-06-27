Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007D455C708
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241361AbiF0UeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239299AbiF0UeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:34:05 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA046340;
        Mon, 27 Jun 2022 13:34:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id o9so14690887edt.12;
        Mon, 27 Jun 2022 13:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OLWwuKwhDGZ5AVt1p7fFud+w2xnXRC2cyekV81w3MDU=;
        b=dheqE6WHwvec6tvb6t2RbF5VQNheGf73O7aOBbWBM90uPgRY7rjxLwdopKqx72QETI
         9+X7x7jSPVLe35HXCDQldILySK6vIaAFKfnX3HPBP0/j95N8DUoKhHp7021brMu9adLG
         yQGG2iTCry+dnpBEIfhwqQI3FsMWrs6gaWN1SzhlRdwlpU7TA0f87EBVzhZUvyEl9p+v
         naGmnvUsNkzChfpTJPj4aM2kXkZNXpdjNvCCAz1DtdjOEQXU3H55lUVo3BTVg3PJr9qn
         krDTRJOYoa/gMT7+yRFcL+eTIiPJv1z1iYTuQSFygvCy6I+O2QDSnCP6uUX6MCdwidHK
         IKVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OLWwuKwhDGZ5AVt1p7fFud+w2xnXRC2cyekV81w3MDU=;
        b=npCC/2A/rRewfTLLDahvlN07iqT6//+Cc3df09bfNy4n561wVLfxK0mjlTJrAqtgEg
         xYWLSlwE2HtxaQcXytTcEKBvL+QIcpkvFcxTvbeIv3lnYfxcBqDoi94ZXEVk7dykap0F
         H+blwsmATO0h6qHamCt9GMCQnW+tZUNGwou3OllmGIbH9/GlO+ZiWvOBeK3OPLNKutbN
         r18JWkNxTuy8Pp73Hh8nN3iGiMbhNT6aTMPIiiU177VLQxCR4kHQIp9eF1J5Tp3gQFZa
         CY+FpSQBuY6RT9eyJXtuicJQYIsCV0CySeDR2dvY/1ENrfnbI9Rc9q1SeD4R8l2QEfTn
         aFIQ==
X-Gm-Message-State: AJIora+5I/NoKCkc4jsfstWAuDdEiYKYYdG8u2lPD8RTzgPDBjMifSKd
        cJDdv+CtSG+Tm6cAjXNseiYrC2jOjYo=
X-Google-Smtp-Source: AGRyM1t+7vYQ+AGGmRmAHAA6HQWSIKQ56fM95D1r6YAj+WD+1Y+PPYMi6z7Zq+alDcC2KC05jXGFig==
X-Received: by 2002:a05:6402:280b:b0:437:9efc:a065 with SMTP id h11-20020a056402280b00b004379efca065mr5648487ede.3.1656362043648;
        Mon, 27 Jun 2022 13:34:03 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7d489000000b004358243e752sm8120949edr.5.2022.06.27.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:34:02 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/6] pinctrl: sunxi: Add I/O bias setting for H6 R-PIO
Date:   Mon, 27 Jun 2022 22:34:00 +0200
Message-ID: <4405996.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20220626021148.56740-3-samuel@sholland.org>
References: <20220626021148.56740-1-samuel@sholland.org> <20220626021148.56740-3-samuel@sholland.org>
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

Dne nedelja, 26. junij 2022 ob 04:11:43 CEST je Samuel Holland napisal(a):
> H6 requires I/O bias configuration on both of its PIO devices.
> Previously it was only done for the main PIO.
> 
> The setting for Port L is at bit 0, so the bank calculation needs to
> account for the pin base. Otherwise the wrong bit is used.
> 
> Fixes: cc62383fcebe ("pinctrl: sunxi: Support I/O bias voltage setting on
> H6") Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Did you noticed any improvement with this properly set? In theory, 3.3 V bias 
should always work, right?

Best regards,
Jernej


