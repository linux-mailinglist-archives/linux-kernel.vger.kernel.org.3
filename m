Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE514F8FB8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiDHHnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiDHHnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:43:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B901AF50E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:41:40 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so5022155wme.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qoPzgwCZVz+2LKUZVk8VaJ97LNpuXNUCKEzLwfvX/Zs=;
        b=vlKCcWfQTZaMrcyeYxoOCOY6TXXsu+qwQrEq7qk51SBgnnEVkDbtgKaVDqNSFdiD8l
         Ftkm7NLTV4iZ/cp7EfmDlDHgPX6rKUDNz7xBd+0hO9j1uhc3lylzLWz89V9lw1xmmXDx
         HxSGY19iCzpy9hq65yDrWd7ycKD6XpFDWuR1lWSjy5VneKRF58+UHQnFpcyzSKfX+hFf
         i0jdA2hb1rhpmOlLh3i4ZI3HzkI8CSFYyRGtBhHb9MJCslKgyXFclXwsKZV5QPBFQbmL
         qJMmiuBe/3Rw089sYDNgpiFr2L9BcXyOSPDRpivX9LKtFO/hZUOot7AL4p8iZzpzemAA
         Jc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qoPzgwCZVz+2LKUZVk8VaJ97LNpuXNUCKEzLwfvX/Zs=;
        b=rdyVrJ2UcknRl2v1/yQ7BG2tVBnxWm6WEUuES2J9IvkUyWrLWP8zpwa7yu2RVMusDg
         N6sp3qeck2syN1QFeiPseoSPcdR4yul/b99gg3ydD6SdTKEQdN3+tDXlXNV4A0IzQdBQ
         QPac2Q3yNCQ+Lr3hWEjRe6dq2rAgOzKmpV94BRadaxjsu+OIRYEf/6kaCMhQJg/mgAKm
         /KR0F8wWW0slaNcxYbgj18r82yly7ZuuOOYCvPRbkkhPfNuGopmYk40pJjaUADYVpXk6
         hM9W7HiRoMLbN6DhrdvSnbLxcQDlfQgwNfLWeTIW2x0gHwVjzc9WCzm+LvmyDKMe322B
         GsMw==
X-Gm-Message-State: AOAM532INU2qVEpgKsKLzHLsnLQC5jfNqvr4HVAMEKRY+OX5kgf0BqJC
        qdiUOPr0e993p0UZ1sHFrLP6Og==
X-Google-Smtp-Source: ABdhPJzRCiav6MWIkNLMa3QPaqs79EK0a2VND7pVXpHUhajmSBRORWzCxAN6YlQhwrfcO/nqZqgn8w==
X-Received: by 2002:a7b:cb46:0:b0:37b:dd79:e1c4 with SMTP id v6-20020a7bcb46000000b0037bdd79e1c4mr15472282wmj.39.1649403699091;
        Fri, 08 Apr 2022 00:41:39 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:eacd:ce6:e294:acd1])
        by smtp.gmail.com with ESMTPSA id w8-20020a1cf608000000b0038c8fdc93d6sm8890630wmc.28.2022.04.08.00.41.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 00:41:38 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson: align SPI NOR node name with dtschema
Date:   Fri,  8 Apr 2022 09:41:36 +0200
Message-Id: <164940368411.3649905.11710562197285417365.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
References: <20220407142159.293836-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 7 Apr 2022 16:21:58 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and SPI NOR dtschema expects "flash".
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.19/dt)

[1/2] ARM: dts: meson: align SPI NOR node name with dtschema
      https://git.kernel.org/amlogic/c/e8662d0832431a069f0138da72c638cb6a377bdd
[2/2] arm64: dts: meson: align SPI NOR node name with dtschema
      (no commit info)

-- 
Neil
