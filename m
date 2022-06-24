Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FE35594D9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiFXII7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiFXIIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:08:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12557314
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:07:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id cw10so3135026ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X1v3jnVlP/mkMDeaBNnd4ZrW67KDgsY+NuxPosiszbo=;
        b=PG3saZzZvFqQS5YG62Jct39n09PPGFpKK4rg8yhHjZlcr58Eb688Atv5oZA8CrbMIa
         /uNLGTz1xQJYwfTfpXgQMuFWKvYwGFHQSp8/MJGYoEVhKSVTI9IrNBojSDMfI3k8wv30
         ShanHh/VUfLmncyLyecPV/uI+z65arfIS5YypW+GQMCS4uFw4w7T18Ypfx7gTzsXCF17
         wr+VH50DiCC5A+7GeXI5btP7X3TV0n+kNgZnPSbLnfPkDCQeKKbqljDLnJNCNQRZ7ulD
         rn/s65Qxdp3o87EM0q3tc1ALdI4eqEKku7fruZS4gcbXKm344QOUoaXjreRkJ8U/whjR
         tcog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X1v3jnVlP/mkMDeaBNnd4ZrW67KDgsY+NuxPosiszbo=;
        b=aryKKdnAdicyXRLqMw/ziluzjYcDgYlgMlDbOMXZWxeX7hWg6Sw21EEifrM6MXgdCe
         2VcZ07n9zo4TKwuq9EGNAdPQO4CxZbiRXo6tL+lHkXwRMkxSagOzZfBQ1YegfKF1mpNL
         rQ+zhrWzhjkA4UcnnuWavIebwadwd8s9JQbq9mrg29jdCwpWaNbG6xSGlINdJPhMneDa
         Ua12Rwg0BfShWZNv8ivY1vbsds7+9E0zsWFODLCcwNzZYHMGEaNSaSjgzu8cTGiMdhKw
         X0jFroYVESkgITGJjjXJkavHzCQGJVz4PKzg9ztfoEMODBIdSyeIoh8A+e19Jb6xyzwy
         RzNA==
X-Gm-Message-State: AJIora8eof7scQaybzZae+s6vT/W04d9ZCvQmOizB6DPQHLJfvEe5F2u
        5itbglQcreyJjAZiwuGv4W/cb/Q7xAlj8Q==
X-Google-Smtp-Source: AGRyM1s63JpgKSSIp1pY2f2HsukfHxKxAzSpCfc9LDVmJdRLcfncSWs7ufV7VmZYc5bKtYzYSCBE7g==
X-Received: by 2002:a17:907:1c0b:b0:711:cc52:2920 with SMTP id nc11-20020a1709071c0b00b00711cc522920mr12372748ejc.301.1656058071669;
        Fri, 24 Jun 2022 01:07:51 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7ca4f000000b0043559d9e8b9sm1363573edt.53.2022.06.24.01.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 01:07:51 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/3] ARM: samsung: mach for v5.20
Date:   Fri, 24 Jun 2022 10:07:46 +0200
Message-Id: <20220624080746.31947-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220624080746.31947-1-krzysztof.kozlowski@linaro.org>
References: <20220624080746.31947-1-krzysztof.kozlowski@linaro.org>
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

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-5.20

for you to fetch changes up to d1065293010a010261f0b1478daff40d5a3dc241:

  ARM: s3c: Kconfig.s3c64xx: Fix indentation (2022-06-09 16:10:09 +0200)

----------------------------------------------------------------
Samsung mach/soc changes for v5.20

1. Use preferred strscpy() over strlcpy().
2. Kconfig indentation cleanup.

----------------------------------------------------------------
Juerg Haefliger (3):
      ARM: s3c: Kconfig: Fix indentation
      ARM: s3c: Kconfig.s3c24xx: Fix indentation and replace some tabs
      ARM: s3c: Kconfig.s3c64xx: Fix indentation

XueBing Chen (1):
      ARM: s3c: Use strscpy to replace strlcpy

 arch/arm/mach-s3c/Kconfig         | 14 +++++++-------
 arch/arm/mach-s3c/Kconfig.s3c24xx | 26 ++++++++++++--------------
 arch/arm/mach-s3c/Kconfig.s3c64xx | 16 ++++++++--------
 arch/arm/mach-s3c/mach-mini2440.c |  2 +-
 4 files changed, 28 insertions(+), 30 deletions(-)
