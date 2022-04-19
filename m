Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2580A507139
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347464AbiDSPCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353566AbiDSPCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:02:43 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ABE13E2D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:59:58 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 21so21686943edv.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=27PI2y+Kj3EM/yCTP+HU3QtzK4PZZymWrObhrHc1GL0=;
        b=qoI5VlxuWNCsCYqVEXP5/gQ0LrfBfO7rOEsIooFDWLODD4GnBDfffYudWyd5em2sV4
         RGOcQ3PRp1mLkPfppa+LeMq2r5jEBE2I+HrgOhhXoPD4p0KaxAIl4kBrerS3NS2tAPRv
         B4KD+IGD0zdFhHdJh95SqxwOCSSnWJ9u4Zk/dT8LN03RYHf2PvBWX+OqW8+3TV0NVxOS
         U8Y78CcmnkOT2towNQERWO5iESsH1kzy4EKTWhyRP5Fxpfh3Ucdqu9h+Nmgky/kJG7xY
         FirIXEL6v5+SvxEGfSdXhAxqshqgv9d7fTWScWM6bag+CivT5QRHEZlk0zUSqLFxo/eC
         TAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=27PI2y+Kj3EM/yCTP+HU3QtzK4PZZymWrObhrHc1GL0=;
        b=7A40PZIwS5c2kkrJUu+YESno7PzfdaAhUe0tZ8Y8RXTbeoQ9jw08P0FmZlBOEhL4OB
         I5mcH0pJcvkRf5Nq/SNZ43qw8ELb1drs/fx79cmcZ+J6/ubkjjnitF4fZ0+h+KrRkGcN
         b8ngNzVtIvfukDyWsYA3v7JdWJQ9iPOFxzCCImkjU2fS0eFCgM5PTG/3z1desJfycK5q
         bqhgq15D/1pMmG4RY0KHIA/MOL8cObJ88s8VdAdggwkYKh0/5AmyhL+qgp9peESyX3LP
         /k/8G4uV2TrlkQhUlNfZMG1zR7cLjTm3V3Uf/qfky/L+ErY11QFFD8H1EiihTtDgd8ln
         pckQ==
X-Gm-Message-State: AOAM532HtrrWz8jPeGj/R5jR24cH71O4gKOOWES8+D6HpeWcSnBWne5S
        5h/tk84VmFzYD0zqqlL+mNg+sg==
X-Google-Smtp-Source: ABdhPJwrEf6P7FM34tikCNG4Q2fnKhvwphZhOQYKin6JoY4dJSGVtYihUf+fBIUiNrr0QniJT6dFFg==
X-Received: by 2002:a05:6402:330a:b0:41d:9477:4ee4 with SMTP id e10-20020a056402330a00b0041d94774ee4mr17967626eda.41.1650380396948;
        Tue, 19 Apr 2022 07:59:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bo14-20020a170906d04e00b006ce98d9c3e3sm5751685ejb.194.2022.04.19.07.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 07:59:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     cgel.zte@gmail.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lv Ruyi <lv.ruyi@zte.com.cn>, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] memory: Make use of the helper function devm_platform_ioremap_resource()
Date:   Tue, 19 Apr 2022 16:59:53 +0200
Message-Id: <165038039034.384424.3835385598984569848.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220418020147.2556925-1-lv.ruyi@zte.com.cn>
References: <20220418020147.2556925-1-lv.ruyi@zte.com.cn>
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

On Mon, 18 Apr 2022 02:01:47 +0000, cgel.zte@gmail.com wrote:
> From: Lv Ruyi <lv.ruyi@zte.com.cn>
> 
> Use the devm_platform_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.Make the
> code simpler without functional changes.
> 
> 
> [...]

Applied, thanks!

[1/1] memory: Make use of the helper function devm_platform_ioremap_resource()
      commit: d37b07897e5024088b2170b8e6e1c68d567b9be6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
