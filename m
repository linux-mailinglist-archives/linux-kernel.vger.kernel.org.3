Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026A154EB78
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 22:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378745AbiFPUsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 16:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378405AbiFPUru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 16:47:50 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4635C13E98
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e24so2374099pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XVwra5Jeu6S1Tc+iDmKXEaJKrf3EmTFh7lg7Kj/P5SA=;
        b=BOZn5o1JZX2E1bG0fUg9atgQMrqdw3k53mVKCFcA2um+HoyR7D8HE8Bumc4V2ZdXkd
         3BORnzg7HE8jOEKqHvSv7mr5iM4wubZJDbnHkpI5cMbJr9x0KLOyDi8e6ayKDkz5BCkD
         tH8dTym0KTUSYBv2VyeDIHJ+g4wC6tx4mi+NgdvOFcW+v9X2uepqMsa75z8kMSPzQu14
         ZF++eC6dA4ut5GHLn4jko5vH45to7jd17g0RIfuWm686k8AuGRnruBpQ8hr+TB2tiK6L
         ugoZpJJOYTwvW643hHfWcWqtyQ8ys5ALOly80HMqUMVEbtUhD8OWc7pYWriZjd1b/aL0
         7Znw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XVwra5Jeu6S1Tc+iDmKXEaJKrf3EmTFh7lg7Kj/P5SA=;
        b=5hCm7kV4L3u0/LLU+f4zt0FscItAUpEKK3W/OFJjgCLv3UPMYHUMwJ+rCrYOfx7Rgm
         CLFK8XFLv43J/IWl6b6v8SKBRNuDSwRMEEU9Kdiha5ohikZlCZWGluVkjUteX1oK5xDa
         EenexAJHNnCofSjvTCUZGvT2wY8Fz2+rfc8RgWPCp1W4+w6uTPJSTmM0O7iWCqlzvqyL
         wK1H4M5z3j0hxl8SfJQ6Df+nA5VXvHe+THwXximzR+Ic5bxfqM1PZ+T7g72sm+X/BTgw
         OUZvE3fwh9A4m02BG71dGZJwqxFaPK2OpRfmZClDWz+hIuJ4k1dpfFRUusy10U35pIO9
         qcpQ==
X-Gm-Message-State: AJIora+CPsvCbYW2io/zskq30KTD9OR62YKg21BxUWr0bgQfNpDzxzTB
        S4lEdx/ecD8mVsNCG9XgWxP3dw==
X-Google-Smtp-Source: AGRyM1vBvOe842dtXkcTj7+r695JYz6FeRNRJyniVUhNMZO/We3sBNGmksnBAC6hjnTqtKBHotCoow==
X-Received: by 2002:a17:903:2310:b0:167:5310:9f03 with SMTP id d16-20020a170903231000b0016753109f03mr6354739plh.48.1655412468803;
        Thu, 16 Jun 2022 13:47:48 -0700 (PDT)
Received: from krzk-bin.. ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id 203-20020a6218d4000000b0051ba0ee30cbsm2165453pfy.128.2022.06.16.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 13:47:48 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     soc@kernel.org, arm@kernel.org, Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, UNGLinuxDriver@microchip.com,
        linux-kernel@vger.kernel.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: microchip: adjust whitespace around '='
Date:   Thu, 16 Jun 2022 13:47:08 -0700
Message-Id: <165541242280.9040.17940445114530911613.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220526204110.831805-1-krzysztof.kozlowski@linaro.org>
References: <20220526204110.831805-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 26 May 2022 22:41:08 +0200, Krzysztof Kozlowski wrote:
> Fix whitespace coding style: use single space instead of tabs or
> multiple spaces around '=' sign in property assignment.  No functional
> changes (same DTB).
> 
> 

Applied, thanks!

[1/2] arm64: dts: microchip: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/09f4933a4fd9ebe333726dd139bd330843d40f28
[2/2] ARM: dts: at91: adjust whitespace around '='
      https://git.kernel.org/krzk/linux/c/bc5187b427ddbfefd533178c7af6af9fa3a0490d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
