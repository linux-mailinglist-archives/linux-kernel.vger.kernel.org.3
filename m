Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2FBB56428D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 21:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiGBTlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 15:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiGBTlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 15:41:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB334BF48;
        Sat,  2 Jul 2022 12:41:48 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z19so6738978edb.11;
        Sat, 02 Jul 2022 12:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9eJyVdQ75UuSyrcb+kBiYjzcIzQ1vy3xUCOP9RbRlaI=;
        b=HXHFFIcaF1yjAuE0nLejioKWHb0s4yjkGonYkF4PC1P8B/mO3HIkXVI4zifz+XXpcA
         B9ohvtqCZPic3oA7vjxMM3OR7y17hyUADFqeas8+MKwpM4czc9hc5zfBTq/GX8ISGxlk
         IOYFIcDqSrExHv8F//dF/kLEUxRHEgqQ2SgMJ6v0Ux4CWpGoVN+Sxc7GXxvi8Peb++f8
         Msae8VoF0iMN6iggQ3Ocu+j1vv/CaLZ9hvwyj9UTDS2LF0IxYMpX7LtFlDdqvdg20BAU
         ykaTqRmsIs0+ZL2mlTnoz/HCvy9dxawe4RmnbpsTehq+jR52WOBEEAa3bTLK/voYyZwx
         geyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9eJyVdQ75UuSyrcb+kBiYjzcIzQ1vy3xUCOP9RbRlaI=;
        b=Auh4Gc7L/B3knEn2Wpc//jzgDzaBGDZWnP8FrUQmhObjih9jU+vO3/X5mleRcGYVUI
         fTE8Ui1+nbSun14YD1Sh2vZ7aKUXfVgF1vq9HAAMX8lxMGTql1Az46NG1oIkV//P2veA
         gjHJGhZshnAIXnctrxlhYP/2jYc5v/emY0nJZtxJq20t1nqR/L4dd54dwkhkUsGrRpXG
         4oM0N56DwLYe5gWZvCySrmalfAy2fRzpBpIyTNLS3gK8Z0S0ygw5TaevL6oUwZ7fxz3F
         sbG5aDnCme3/Nvhvro91LFr9q2bM9XkJs+3eMaiCVmt30MYQC8/hAn9yhAnwxFVRqVaO
         rrBQ==
X-Gm-Message-State: AJIora/KAwp84W/f+qSlh668voUk0Kb71yDHZapn1LHhN+OcBi1XnICL
        KvCBrQt1lopmWlSWIQHoXiA=
X-Google-Smtp-Source: AGRyM1uB9edGY7x0ZwaipiwmVWzoA+aCM9tfI2GpMYREv65LtjFJqq/yRHMBOYOz4oE2dA5LduOghQ==
X-Received: by 2002:a05:6402:104a:b0:435:c7cd:11dc with SMTP id e10-20020a056402104a00b00435c7cd11dcmr27382503edu.335.1656790907483;
        Sat, 02 Jul 2022 12:41:47 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id k20-20020a1709063fd400b00722f66fb36csm11959562ejj.112.2022.07.02.12.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Jul 2022 12:41:47 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Default to the full MBUS binding
Date:   Sat, 02 Jul 2022 21:41:45 +0200
Message-ID: <2114031.Mh6RI2rZIc@jernej-laptop>
In-Reply-To: <20220702042447.26734-1-samuel@sholland.org>
References: <20220702042447.26734-1-samuel@sholland.org>
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

Dne sobota, 02. julij 2022 ob 06:24:46 CEST je Samuel Holland napisal(a):
> Some older SoCs use a deprecated MBUS binding with some clocks missing.
> Currently, new SoCs must opt in to the complete binding. This should be
> the default, so new SoCs do not accidentally use the deprecated version.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


