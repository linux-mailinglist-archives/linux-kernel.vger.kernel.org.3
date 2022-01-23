Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7200849737D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 18:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiAWRK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 12:10:57 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:59222
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239160AbiAWRKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 12:10:47 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3042B3F17B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 17:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1642957846;
        bh=CZnbftvymvuP1q3lGZEsnRQ2BDlI+Mk2wJMOXZ8zt6U=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=oeJhrna2/QerjGj8l0ZcJ9dmVP39wp8Bne7o/mi1EAA4W/8/my4fIF8qXPCVlvfjB
         ftYFgJAtJoOP1XX7Z/4fhe+t2NfnySNlgJyvm7DIdCXx7z+Vmd37jhbw5aTev+9fHe
         Yjp16m8/niKjmT14ddpMCIS6I00oj7B0l3/4kN9G83Jg8frpJ9diGn1Fdhf4j/I5ja
         672CJTe/XV5Up9q/oJEAw8FVKRzOoTt6RK+pIs02GOwpvAyM/2j9GR318/Xb13zZxi
         6690AY7rL93hA+rE84mHmiB0mTGgwpwTehND2WnHNfEgBp6BqWoIaZeDzcvf+qFnQs
         P8/U6l8keghgw==
Received: by mail-ed1-f71.google.com with SMTP id o25-20020a056402039900b0040631c2a67dso5355483edv.19
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 09:10:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CZnbftvymvuP1q3lGZEsnRQ2BDlI+Mk2wJMOXZ8zt6U=;
        b=zLR/9mvG8L8Ig+HGI9DLiNr4zqaJNKNeW0cVTyDlSq9Evy8JraVe3cZo/55fOpomsT
         pM7UkVTd+08ioAuFUxwQJ0shhW0pQ79CM5JGl6MpIMpUNZnP1hClByM+WsmGdYpvoziU
         +HhWmYSNBteCUkgXZOaldxjp4PpBBmemKUZ2lkfP8JuchJ683jWb/bHpPn9Cq6MdSa86
         T/H2queR6T5FZiZoyX8LGK89NQBmimEMi7UPA56p05Z4hz2TJdbI6XWwssRA1a3PnvrZ
         qEBqVfZYAN9ukQIetKg+2FuQfQVkydWtW5W1R1lw/5Gc7jeDy/rt7T3JEyDojfTUWNUB
         jC6A==
X-Gm-Message-State: AOAM531kewMMv3NGg99WH7PWLYTBuAXVDJY+D9PdDeKVgsm08gGuYinU
        bEYO+FeKIDmYi8GYePgDkyeJNCNHrsiSDz/CTX/fpvHkANtH4M9Gh3qfX0N+l4la4dekDPJsaiF
        F2SoCSXhqFk7BA6HZ39NRtKobKK7U1FVQZIaKGCsGXg==
X-Received: by 2002:a17:906:6a81:: with SMTP id p1mr9514636ejr.379.1642957844828;
        Sun, 23 Jan 2022 09:10:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+nJ5WREK9LKclmPPHtd3xIWumFe6W3mBEhOYrTUeoyk6BgVmPqiVeHq2VMH9reyQgkB13CA==
X-Received: by 2002:a17:906:6a81:: with SMTP id p1mr9514624ejr.379.1642957844691;
        Sun, 23 Jan 2022 09:10:44 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id l2sm5208665eds.28.2022.01.23.09.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 09:10:44 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 1/5] arm64: dts: exynos: Align MAX77843 nodes with dtschema on TM2
Date:   Sun, 23 Jan 2022 18:10:37 +0100
Message-Id: <164295777264.25838.6451252879069426520.b4-ty@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174805.223732-2-krzysztof.kozlowski@canonical.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com> <20220111174805.223732-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jan 2022 18:48:01 +0100, Krzysztof Kozlowski wrote:
> The newly introduced dtschema for MAX77843 MUIC require the children to
> have proper naming and a port@0 property.
> 
> This should not have actual impact on MFD children driver binding,
> because the max77843 MFD driver uses compatibles.  The port@0 is
> disabled to avoid any impact.
> 
> [...]

Applied, thanks!

[1/5] arm64: dts: exynos: Align MAX77843 nodes with dtschema on TM2
      commit: 7638d3c945beb6c781acf5dd0a78e04c76f1c32f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
