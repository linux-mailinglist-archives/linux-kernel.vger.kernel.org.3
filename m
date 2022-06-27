Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D4355CFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239559AbiF0UxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 16:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiF0UxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 16:53:10 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23EE1F1;
        Mon, 27 Jun 2022 13:53:09 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e40so14815909eda.2;
        Mon, 27 Jun 2022 13:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2IA+0VfcVBkch2BU2eYjCNzBquhqaGbstP7Dzuv9Lqo=;
        b=TUVg0HsIqLw4sApAkHjqnkpFHrds7l7w0mQZVXGCjUxtRg9tT/C0Sbb8yO+tjzsYSY
         kj6NfSMrW3R9plL5lGlW+mcCCb7SdvQBZo1fRAPrxIlm3LY8ws+enJl7Q2gFbOvlbY/A
         CZc3kQz7BKYdmhONPxVB8QxIoCs9TLFW1ezxIvteEDCrpx6Y5jE4M5IYLfzQ4p1LFTFB
         pIMAstdeQ8N7xmpOKec/0SxjfkcK6F2erW4jmyBQv9T/L1OtyWymKO5tOG38e17cUtt4
         kX7XcNInyC+5oa262lczEiqFMnYEi/YggipKpwgcx6zUS4dmWa4w/09RAh56/EjB9lzv
         VWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2IA+0VfcVBkch2BU2eYjCNzBquhqaGbstP7Dzuv9Lqo=;
        b=WI2hMxPRC6zBE8WcBzk+xK7hvsEbgwaVID9MqT1S+7G3qK3wwg8jJnTf7rj3cY3cuk
         BVkgU8m/HxvIZsMkMfTZPqNvhu0URRPipTWyPxsiv0nf8Oc8fWcbkmPETv3SrwyQcJGj
         SmERUi2C4Y/UX7WsTPdxFKeZGNpMBf6lCTn60Iaw7TXCX3j9bI4kNV1IWXUDU0tk7den
         RI57O6GBzq70FhQ4UP2T9Hq/zAFRaM4V9YpuJP5xMQdtFr5sS6nhJAmvo9Lcgre4ui16
         FY5AcxK2/u/VRUvl3etQRAu2AAdNaPmVbJwSXgyVssp01yQO2me+z59oe2K4vRbY/eiW
         PxGA==
X-Gm-Message-State: AJIora8h7Z42fzSaGuqzQ7KYiswKT7f3NwU3bTMFUxSfnB5BxEt8iiBf
        ePvasL+9zevdGMHtvnE2qkY=
X-Google-Smtp-Source: AGRyM1sOleAAXiC2Z84z7E23pKGNaf1YN5XBERpRmtfSGUqMPsciG8VWq+vn/Gj8YZVQHS579GHYiA==
X-Received: by 2002:a05:6402:14c4:b0:435:717a:fd63 with SMTP id f4-20020a05640214c400b00435717afd63mr18902564edx.395.1656363188396;
        Mon, 27 Jun 2022 13:53:08 -0700 (PDT)
Received: from jernej-laptop.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm5447202ejd.196.2022.06.27.13.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 13:53:07 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/3] arm64: dts: allwinner: pinephone: Enable internal HMIC bias
Date:   Mon, 27 Jun 2022 22:53:05 +0200
Message-ID: <13043007.uLZWGnKmhe@jernej-laptop>
In-Reply-To: <20220621035452.60272-4-samuel@sholland.org>
References: <20220621035452.60272-1-samuel@sholland.org> <20220621035452.60272-4-samuel@sholland.org>
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

Dne torek, 21. junij 2022 ob 05:54:52 CEST je Samuel Holland napisal(a):
> Revisions 1.0 and 1.1 of the PinePhone mainboard do not have an external
> resistor connecting HBIAS to MIC2P. Enable the internal resistor to
> provide the necessary headeset microphone bias.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


