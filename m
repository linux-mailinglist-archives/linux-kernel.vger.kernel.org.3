Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5D474FE046
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352479AbiDLMk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345714AbiDLMgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:36:52 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D340F193C8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:56:42 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q189so7161501ljb.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=emlid.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgIIvpemCWdg5vSX2cf+d9JF6FbXIfktL4Qg29qJSHE=;
        b=bDQcc/Bd541oj4qJkkHHIIbhQ/KeKBkYjiIjv42sNMh0auQyBY42LkbAGYrjSu6JMn
         mIUHulLNPHWdXKMv01a6fpH67IhKu/zh/CzDVK66ZOKIeFadXT9utkbZR5BBfHdUfHjS
         jkVwJSU1IVg1TLw9qQ5bAVgTh4Y91qrLUnXenT9cFukDhSBC+XZWA5LHBA+BYbU/OKLY
         L4I7plpZMDJvqHhF1AY1jsqlI+N99QJ2n5CJfsEGm7yGG3GtV46DRFa+CCQ0p7iB72fM
         SRFVY3BiOImjtvZr7p/I/nLeDYOQO50uDnjz8nka8ToVDrWrQLDq7IdtpnkfmEWk5Rpy
         4nmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qgIIvpemCWdg5vSX2cf+d9JF6FbXIfktL4Qg29qJSHE=;
        b=nY0fzb871RgVMYxWZQFms9qecAcZvWDmnZsb+sEtzKfU3TYXl/EcBNzQOItk/t3gMB
         gPRIKlckdRUL/Rowqq8xMRMYZSTfCShCWqO3dq2mdKayW9RHGI2exQSIv+ZKFpF1bcOQ
         pZ/ZfKxczo/9CH5aPnsDT2iErwEkaK6zkiGPYeeePKwUPF29duiNc4p11WsX3opSQ2rB
         /ONRzgbFpsAFM4v/kBuN6bkvWWoxLiQ8nO6mYGFTa9sORfPrWKxrwTXUyMh8Z2KMPLtk
         pSYEtvRmAQvdgvV2gMAJY4g2GsYY5RSTGcz60bMCzSx79deGUqhOQTX9taB1uNv5vzFc
         0bVA==
X-Gm-Message-State: AOAM5337nqnak4QoD2oYGq8TLOg7IY47bZdmZu3U2GaLKWs/OKEYro1F
        7fr0+Wgj8Qxf7x2e2kQyFLGYKQ==
X-Google-Smtp-Source: ABdhPJzqrEWkFE+y/lQDuRSF+F68eJPXDtXdp7YTJXPtE5zVJwpxeLJvScUQ0/HRtkJRxe+Lj7TTNQ==
X-Received: by 2002:a2e:860e:0:b0:24b:68ff:1443 with SMTP id a14-20020a2e860e000000b0024b68ff1443mr3875341lji.408.1649764601116;
        Tue, 12 Apr 2022 04:56:41 -0700 (PDT)
Received: from emlid-ThinkPad-E480.localdomain ([85.143.205.202])
        by smtp.gmail.com with ESMTPSA id y20-20020a2e7d14000000b0024b44fb9a9esm1609575ljc.51.2022.04.12.04.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 04:56:40 -0700 (PDT)
From:   Andrei Lalaev <andrei.lalaev@emlid.com>
To:     angelogioacchino.delregno@somainline.org, bhupesh.sharma@linaro.org
Cc:     andy.shevchenko@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrei Lalaev <andrei.lalaev@emlid.com>
Subject: gpiolib: of: gpio-reserved-ranges interpretation
Date:   Tue, 12 Apr 2022 14:55:55 +0300
Message-Id: <20220412115554.159435-1-andrei.lalaev@emlid.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Hello guys,

During the discussion of the patch
(https://lore.kernel.org/linux-gpio/20220411063324.98542-1-andrei.lalaev@emlid.com/)
I had the question about DTSes, which you had maintained some time ago.

AngeloGioacchino Del Regno, you added "gpio-reserved-ranges" in the commit 9da65e441d4d
("arm64: dts: qcom: Add support for SONY Xperia X Performance / XZ / XZs (msm8996, Tone platform)").

Bhupesh Sharma, you added "gpio-reserved-ranges" in the 5b85e8f2225c
("arm64: dts: qcom: sa8155p-adp: Add base dts file").

Could you please help me realize how you interpreted the elements of
"gpio-reserved-ranges"? Did you mean "start size" or "start end"?

Regards,
Andrei Lalaev
