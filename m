Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2001953EAA3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiFFJU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbiFFJUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:20:52 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EBE837A16
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:20:51 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id q1so27704782ejz.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zoHlWTM0mh72u63WTDkrFJTCMvo9HZydx381A5IP8W4=;
        b=fAp+mLefPWSXPVw2gR16yejLON+sGRvH+uoxH7R5Xn4PRMiw7fUb+GOtXbO9tB1YBm
         Euiv8jhzT9G4gzVuRjouOcFw97lOQmqYzdwVIUFvIHBbYE7wUd1IDic+47IXlZT3jF9l
         DpGMw5uGIGNO11RdIypEQk1hZa5iuxSvBQzMtqgjl6e/hruhDsMPb2EEmP7dw2gpldFO
         kbZ/CauE0DZxBSg+3l2/fo9jo2x2t3vl1GnTxH+175H+ow2QijiKmeYR/m7yUZVujjar
         XlML2hWGe201Dq+eiaueSfJ0gnLyOLnfVPAA3h8dfh4UAxCRAcPY7IxyB+/yy4lLtgTP
         E5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zoHlWTM0mh72u63WTDkrFJTCMvo9HZydx381A5IP8W4=;
        b=Nf1+9HOsXacwaTVZ1Uz7hpjhPSoTpW3vhUgCkU7Kx9F3iELD0ij+k+CcYEb8BFNdLV
         vR6PTS/Ty44izl1FpQ+NqSHKvN34fdUnPZwuhGIwnpNty6+pVMN29nQ9IlrplK7l8VG6
         R6r0oG/2c+iPbFRVHDLbgmXA56k7dItehGSRYDpGaJP8QJBgi8n2SkDsVoKSW1SXSDlF
         VlMVeIzSOzkL6imjG7KtqNzP9fwF/aIxUtB+goYt3+EhwQ2NORd8fxD88NEb7Evzw7aj
         heCTJt5X0oX2lNbgpJsu9uDyEMGwMIq5kojjaVCc9wezwpNFgOG4oFpQl8JhlxfZOJ1h
         dYZw==
X-Gm-Message-State: AOAM5337DHctpv1MwzPC6O039cgCyQfK9bQhSMzXrKNLJlQ6c0bAd94g
        uZZPReG0ppXV7eUQuOpBuynbDbEYzSyUiw==
X-Google-Smtp-Source: ABdhPJz4EadSpCFcDPBbGQ9J6jbCva0Tb1Iy0T24C2zZl7EamP7i01FChZZW/ERhuc8Ca3iSlUf9Xw==
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id hs6-20020a1709073e8600b006f5091710ccmr20045928ejc.53.1654507249751;
        Mon, 06 Jun 2022 02:20:49 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090636c600b006feb6dee4absm6067412ejc.137.2022.06.06.02.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:20:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, yong.wu@mediatek.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        kernel@collabora.com, konrad.dybcio@somainline.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        marijn.suijten@somainline.org, paul.bouchara@somainline.org,
        martin.botka@somainline.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] MediaTek Helio X10 MT6795 - SMI Support
Date:   Mon,  6 Jun 2022 11:20:44 +0200
Message-Id: <165450724182.62574.9805820724956534003.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220518091038.22380-1-angelogioacchino.delregno@collabora.com>
References: <20220518091038.22380-1-angelogioacchino.delregno@collabora.com>
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

On Wed, 18 May 2022 11:10:36 +0200, AngeloGioacchino Del Regno wrote:
> In an effort to give some love to the apparently forgotten MT6795 SoC,
> I am upstreaming more components that are necessary to support platforms
> powered by this one apart from a simple boot to serial console.
> 
> This series introduces support for the SMI common and LARBs, found in
> this SoC.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: memory: mtk-smi: Add MT6795 Helio X10 bindings
      https://git.kernel.org/krzk/linux-mem-ctrl/c/a24394059a1bde7c630352827543d50034f03180
[2/2] memory: mtk-smi: Add support for MT6795 Helio X10
      https://git.kernel.org/krzk/linux-mem-ctrl/c/0d97f2176dec9c1e070215c4e28ba87e036458c9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
