Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4725953E8BF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbiFFJNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 05:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiFFJNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 05:13:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BF248C3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 02:13:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u12so27683074eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GTGE/yPhiMfGC/b+fJcRmLCKJqzzVAKQP/zluWR+o5Y=;
        b=wskVau+S5g9jlGLIreKhMxcQGm6nZd4V0ixNnC3IBW8EbcafMTxexQbeRX+KtSkjgx
         alyI3t2kcltmrGBML2xfeAg2XSZ36JmGUMPkLmIwGGUHuxwtj5F9RWYsjdatuUYEbe5w
         xp4d8fjAgqTLaru6giDv8sWrX+1Vh5w3AfEo7sYumBRESRrHaf+OdKxJxATMFsLhi7E+
         j/lzWKmrUgsdDNkz/nAxENCEh+AkMsaB9mSy9djV85ENAmwa3uaiSgq9yVO4ENiUwTCi
         Bm464LhxccQLaurwfa4W4nAd8Hqr8Jf1iqAtOe1SEJ+YmPlP8c8yQT1ZMQcK3TXjw/nj
         7feA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GTGE/yPhiMfGC/b+fJcRmLCKJqzzVAKQP/zluWR+o5Y=;
        b=0L7dBe+ly0qfBRm2nIt2S88/BG5mlLSaZbz30Hp+uH/VCNxtY2/bF0dcm/FLZ98yYw
         odw3JXlcGbrTwyRawNvX7pkdqBelquq3gTwOz7RW+a48Z3Z1r+lWBUGuFIT+NIzBtDoO
         sWe+P27Lpt/eOiuSo0sGWHkHIcOj9bpNNuxFxDuX7HYa2Brz+aV+FKch9P1ygTKldaHl
         nAc2/GOfTgUYPLNkRNFnP1E0XLWojhPsKP3a/uIPTcYQAvn3bkyMnVS8Gp6zK+C/4/Vy
         X3vL8wjBEzBnKV0bR2NXtVFjaHWYasayVjUFNwT2dUc7ekU3XVkFPbzw6yQc7CugTRRq
         99tw==
X-Gm-Message-State: AOAM533cVvEHGraH+3TRgzv1C3R5xznqb2lYRZXpybHzbI0AREhYcX1r
        AbmJr7VzrPl1qfnUup5CncCjWw==
X-Google-Smtp-Source: ABdhPJwqSCgEsCT9Z1p/mMNB4b89O8XpB2k+oqR0bo8ggCv9Pto2AYGFkTuZ6dc3HrJ+d6Wg0QNBEQ==
X-Received: by 2002:a17:906:4fd1:b0:6f3:be23:7ad5 with SMTP id i17-20020a1709064fd100b006f3be237ad5mr20729432ejw.264.1654506818749;
        Mon, 06 Jun 2022 02:13:38 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x25-20020a170906b09900b006f52dbc192bsm6077534ejy.37.2022.06.06.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 02:13:38 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Juerg Haefliger <juerg.haefliger@canonical.com>,
        linux@armlinux.org.uk, alim.akhtar@samsung.com,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@canonical.com>
Subject: Re: [PATCH 0/3] ARM: s3c: Kconfig: Style cleanups
Date:   Mon,  6 Jun 2022 11:13:36 +0200
Message-Id: <165450679893.60702.4773704114108524411.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220523064252.11938-1-juergh@canonical.com>
References: <20220523064252.11938-1-juergh@canonical.com>
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

On Mon, 23 May 2022 08:42:49 +0200, Juerg Haefliger wrote:
> The majority of the Kconfig files use a single tab for basic indentation
> and a single tab followed by two whitespaces for help text indentation.
> Fix the lines that don't follow this convention.
> 
> While at it, add missing trailing comments to endif statements and replace
> tabs before comments with whitespaces (which seems to be more common).
> 
> [...]

Applied, thanks!

[1/3] ARM: s3c: Kconfig: Fix indentation
      https://git.kernel.org/krzk/linux/c/076702da7e8a2472f8ac86f1179ddcc5e90febae
[3/3] ARM: s3c: Kconfig.s3c64xx: Fix indentation
      (no commit info)

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
