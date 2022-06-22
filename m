Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2F255478E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbiFVKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239629AbiFVKSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:18:02 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB3B3B55E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:17:44 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z7so23172076edm.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 03:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQPzhLkCcJI8ldGFjIADNQSWV6EO/+ffmPDrz1yeX30=;
        b=PGx+Ahz12NaRmeCr+O6B3+4SkuZekFVrMgWXLrvClujp6p4uz6e5KJLpNskB7H9VTI
         Mr2vRO9JMOba7JS2RgS+aoRDrU0OKkiaK6VOTFdUzI8bXlkc+a72jpJu2DnEqdTzQONi
         uddKlIavldLx/OPlnYNXtJU35UIs2kMECZYhJsEAO3AGgc+RfSCQ5ccsl8vz5ZEMk2Ws
         CiAtNIwM5Z+LoaBMRL6noPvJsWaq3hjl6XOFDwEyssECJlA17SjtRXzz85I1okmRH+mT
         k7UItd/agz3gkBZsygAWGeirEdxjhU4AOFSQ7GgcZVrkcz0m18Xiqk8CVMSLV6muI1g4
         /mmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQPzhLkCcJI8ldGFjIADNQSWV6EO/+ffmPDrz1yeX30=;
        b=pmZEAc8mkb2LO1F2thGeIdPljU4zC1iKX+K16qq3pJ4MmHH0AL0CXMPGrSBb62jsWa
         rUqNAMjVJ5VdRMvY2G7JOfyGnRb2LsoeuoERP1fZ+h3gW2IrbFBAG93sja+Z2JI3zy4n
         OEn8+CpMKZ6Lrg3NSqKSUakSXiwMGNW5OhNzlLc1hYXPpFJXdtA2MixyA56ChiCohqGf
         uk+6ASmL9WLF76jUmkIsn/wka8j7bWdxuOqyphyx8JGb2wvwFdCg6VFPNDQzIlwKhbmh
         +kcfNdivZN8u4qlFSOAk9oXEjuxoQhALUvfciGI9JNgMOVLoQnv4AjnwA2lYzniCJl/b
         Qbow==
X-Gm-Message-State: AJIora/7elq+4jqMZfBO2ijyDEuJmATHo/OFHDmIKi/pDmWezhQo7Z8K
        xwCPIhJZXfD96TumV9rHy/+SSQ==
X-Google-Smtp-Source: AGRyM1tsEWhNXd63w2o3Kp41hvPXfubp4BEke76zLyoZkQZIYZom+EPX59smbU4/AUkHkbRmZgW3Hg==
X-Received: by 2002:a05:6402:27cc:b0:42d:de10:4b6c with SMTP id c12-20020a05640227cc00b0042dde104b6cmr3361673ede.424.1655893063381;
        Wed, 22 Jun 2022 03:17:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b006fe921fcb2dsm9028707ejc.49.2022.06.22.03.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 03:17:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     steven_lee@aspeedtech.com, linux-kernel@vger.kernel.org,
        andrew@aj.id.au, joel@jms.id.au, krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        chen.kenyy@inventec.com, linux-aspeed@lists.ozlabs.org,
        robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     David_Wang6097@jabil.com
Subject: Re: (subset) [PATCH 5/7] ARM: dts: ast2600-evb: fix board compatible
Date:   Wed, 22 Jun 2022 12:17:37 +0200
Message-Id: <165589305701.29629.16558823726381499116.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220529104928.79636-5-krzysztof.kozlowski@linaro.org>
References: <20220529104928.79636-1-krzysztof.kozlowski@linaro.org> <20220529104928.79636-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2022 12:49:26 +0200, Krzysztof Kozlowski wrote:
> The AST2600 EVB board should have dedicated compatible.
> 
> 

Applied, thanks!

[5/7] ARM: dts: ast2600-evb: fix board compatible
      https://git.kernel.org/krzk/linux/c/aa5e06208500a0db41473caebdee5a2e81d5a277

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
