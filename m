Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099934C13A0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 14:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiBWNMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 08:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbiBWNMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 08:12:07 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81015FF23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:11:38 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 77A7E3FCA8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645621897;
        bh=6ItdzAIC73ba61SL64woNZZ4z8ugfh6dQKurjioqyaA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=qzX3zyq6FDUpmt9Z+UyAlUTqAONdi3E+Cro7BbQq2noecR+uw7ZiCc4zk1IqcWLyp
         J5GadaKX4lABewfAvfybqsdGCdrVCswvxokrgPHHZcLYsElteZl298Zeg2aGKi9cbH
         JuIDsc+CfEkLpx+X1H6kklRlIAufHrxKZraHL8CkHItI+qrFFsjTvsSpvo9djA2Ay0
         6nrQ00t07wnoG7cMvsU2euDbC2/ubyFHCw/18FctoEC/U54EM/qnBhOs/5pJh7ug/X
         djAM698n3OWg6nlmwyd7tbfsExSqNJhQcMZR2T5UqBGuJpxKMCc4VJpywtVpySjXTR
         HStD3YAk+Br/A==
Received: by mail-ej1-f70.google.com with SMTP id go11-20020a1709070d8b00b006cf0d933739so7115398ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 05:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ItdzAIC73ba61SL64woNZZ4z8ugfh6dQKurjioqyaA=;
        b=H0JzQLvIeIlCM3w+ao9FsPG3mib4RIEf7dFsYvFpkdTzUAOw+s7xUTkKd6lKqkPLSu
         yJa23on7w9YoX9G3UcMqnL7McQrKNmc8zS99+E8alWvSOL4j5cN7VNhfeWDxW0Yr5hfM
         zMhHg7OQcf6OGbcd1HPDJ8+gymyeYH4fJNXL6ZJYBFNsyNiRrPk1e12zuGuwmiiMGdZR
         gH1mt46agJwPrzUg1eMYWUoHVZIaBIc7zQ1Ajzivn4q1NpnLHorAtvT1pI2JcwSiURBd
         y3iy6ba0r8vzIbMb5EevFwNrU1bE/QibqER1cTpjzzx4aZnpGpN6hzUfNRIgGd3bfBZ1
         oWYQ==
X-Gm-Message-State: AOAM530Q7cSj15vrzVNwM5LzKaDPFR81WPvGSViR6yp9LEofX99Ks8NR
        2UCD6F4HjZ8r7bNwGUcBwTiV1gDSyeUgPhYgHRH3m3WaTLA2/rG3iOZRMc366IRWKRni6VvPXr7
        IFurX/3ojGK6wQSjHdOVVnDOLzeCKHQqcRbFJkD6/2Q==
X-Received: by 2002:a17:906:e13:b0:6ce:21ca:1b91 with SMTP id l19-20020a1709060e1300b006ce21ca1b91mr23486660eji.193.1645621893963;
        Wed, 23 Feb 2022 05:11:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzqN7LLprVP7W7VK/4Uq3spoFQPaiet9FLARrRJrnw6k3jKocmQL3RLligIlXMbw8qEbieF2Q==
X-Received: by 2002:a17:906:e13:b0:6ce:21ca:1b91 with SMTP id l19-20020a1709060e1300b006ce21ca1b91mr23486648eji.193.1645621893757;
        Wed, 23 Feb 2022 05:11:33 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id h7sm11800293ede.66.2022.02.23.05.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 05:11:33 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     David Virag <virag.david003@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org,
        Sam Protsenko <semen.protsenko@linaro.org>,
        phone-devel@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/1] Initial Samsung Galaxy A8 (2018) support
Date:   Wed, 23 Feb 2022 14:10:58 +0100
Message-Id: <164562185401.52450.9639221721231378939.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220221194958.117361-1-virag.david003@gmail.com>
References: <20220221194958.117361-1-virag.david003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2022 20:49:55 +0100, David Virag wrote:
> Add basic initial support for the Samsung Galaxy A8 (2018) smartphone.
> This phone is also known as "jackpotlte" and under the model name
> "SM-A530F". In its current state this should work on most if not all
> Exynos7885 phones/devices released.
> 
> As of now, it supports I2C nodes (all disabled by default) and UART
> console with basic clock support in place.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: exynos: Add initial device tree support for Exynos7885 SoC
      commit: 06874015327ba7bf6aae49ca825a492a2679237f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
