Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31E953F62C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 08:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237037AbiFGGc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 02:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbiFGGcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 02:32:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202A3286CA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 23:32:48 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c2so21595708edf.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 23:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=rjBKgMIA6DGjXMFlTzioHivCQZHzgMmQu5iLSH46BUc=;
        b=BLyMiQRupKbvR9AUUboy9Pt5ayM9ZIe7cNWJcqRPqOsQKsJzpZLytl/mwGuTTVEFCq
         C7sFEYDPNMKR/OYZAO0oHb69gM2hwijtLlkUCrt7LeLoUbsBRDXd5VqzscVAUf48DwD3
         riE1w+MjGsh8rIUZG3efW3sEQlJql2teTYBC2EJEYVEeBub8ZqU5Wv6WOw5KNm6DOp9M
         pD9DWdSUMA0QdJP0T+jsv5f0q02Nb7fnpFRSt/++H9q4Wv+2oxDxtSzIxeaNQBnKCiVU
         YN/B4IMzdTf1yYwz19BO8XffdbmzpTcSCRyQsYbkZ2XKQ1jVytbIcXqLl81mCAJUKlPI
         sqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rjBKgMIA6DGjXMFlTzioHivCQZHzgMmQu5iLSH46BUc=;
        b=fQjeRImTvcPAsU9lM5QK1yuFDWzKSXOFDeewwgWYijLj+W4uqOoPA1LMdclONWkNUe
         0dtPDaf7FogM8d3+m9Ic7fhPUDYx18MbqtQresTmaI49ms7nZVCslvBRxu5+QL8AloeA
         cyTNFi7jUCKOe/fMIac1zuHOaHZ0zflLy+OgzTPfwivF5W7NXWhCkr08Pw4d/CzdN6Fs
         4ujxu/9r1MylhlJGBbReobPKYbD4AK2ipgRcA6olet2V9jNlg5xA5ZBFZPYTna9wBzbm
         YsDhunPlNnUpoHpIaYpowtFJQxWzrfj+Hzc/77myznqD7PeSr8V5nyONHmJYwnl0E3rw
         4h/A==
X-Gm-Message-State: AOAM533O66NndKcwUlL4KJk/2t0PByLUKsK0lHwyggEmTtW3fG/ofVFr
        68M9jhCwDTHZY06YV1E3KRnJxg==
X-Google-Smtp-Source: ABdhPJyhkA7arn+z+7Ax9NSTsao2M4Cz7kf0NVphYJ4xQdeibZCmD6IZbYRvLy2gQ4YY4/ezmk0wLg==
X-Received: by 2002:a05:6402:3586:b0:42e:2a6a:218b with SMTP id y6-20020a056402358600b0042e2a6a218bmr25306770edc.208.1654583566694;
        Mon, 06 Jun 2022 23:32:46 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id eg13-20020a056402288d00b0042dce73168csm9796349edb.13.2022.06.06.23.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 23:32:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-mmc@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 1/4] ARM: dts: exynos: align MMC node name with dtschema
Date:   Tue,  7 Jun 2022 08:32:40 +0200
Message-Id: <165458355453.6489.13773336622161446502.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220605163710.144210-2-krzysztof.kozlowski@linaro.org>
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org> <20220605163710.144210-2-krzysztof.kozlowski@linaro.org>
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

On Sun, 5 Jun 2022 18:37:07 +0200, Krzysztof Kozlowski wrote:
> The node names should be generic and MMC controller dtschema expects
> "mmc".
> 
> 

Applied, thanks!

[1/4] ARM: dts: exynos: align MMC node name with dtschema
      https://git.kernel.org/krzk/linux/c/a07cadf80c85a3ee6a1688fafb71b8c5cabfa904

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
