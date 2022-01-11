Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4157748B45A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiAKRsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:48:54 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32928
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344578AbiAKRsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:48:52 -0500
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E575040046
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 17:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641923330;
        bh=b8unpukURFoj9tYv6hEHKZIOPqKdbI+UT8tS2dxzJ3A=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=feFkn4szcvNFN/VhwFtXLsTqOixJl5WHL7zaniP9SAo3AfMzLwDi6uTrPGuy7AwEn
         h7Vyc4+y+0ZKG6R2EdlaNI9fwn7AiZ3NoOzXhx69i0fFZZSJcWhG53gx3Tvc0Qb9BB
         Z7r4W049G9V3zO9Hy/ejS2H+gi7Rpg59oG9S4NPgZ0hXlf5PRKWLFH0z44A73WknXN
         Stm81Fv00lnOh1jXRe3OxqMhr3pGb4SicDrVLu7Ex2FCLDQLXhxhsGf/IjTBvpEot6
         l5xzXfY6x7CtN0AlgNVm+/pZh8J8dptAVeezLD6573EWFdJdDJx66mcOUXAduNemSY
         zAh+bvHi49Yzg==
Received: by mail-ed1-f70.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so14006598edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 09:48:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b8unpukURFoj9tYv6hEHKZIOPqKdbI+UT8tS2dxzJ3A=;
        b=i1K97yRSudkv76oI374VbtIbyiU+tbWxtcF0azVw0uAGvg0ah40jMfgZWapho7oR01
         lK5rscFBlyRAcuaD/3pJUSkd4YS91U8JJ+YxgIC5EFRDn3AlQY7cvHygYBE8Rk6CGjZb
         +RMxMyg+XG9iEdzcte7CY0PyAckZKMRcpogshXEQh3JZidkl07WTEy3M2ZY87aXQGshJ
         WmZtarShR7PL+/prHXPETn3kHlobX91/eUQaiuHp6zP+MViEntxbJvRTSbRf4EI3KJFU
         Ec0atC/7YuF/r49n+qXrolbuoaR7BvKai46o4ATvTh8GHpzRbO9FcXY2QqupVSz3BFIO
         0uDQ==
X-Gm-Message-State: AOAM533f6xftCUtUWBpZJRgAqYoZnRRpCAKZLyyyqh57LB6AALK7G8Ff
        9Kn/tueNfqPD40jcxED4QBaAddlyfbknXAUrSsQ4h/grQejmxwxR19Fzpj8+2KN4jY5gQmo4CNb
        /Mt5XvU6OpIzbwhTdtqN3LBK/KqwAZvDR67yU+EIuZg==
X-Received: by 2002:a17:906:f214:: with SMTP id gt20mr4859168ejb.458.1641923330637;
        Tue, 11 Jan 2022 09:48:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyAM0/Z9YVcu804le5q3yh75AgpsHjTUH68ArlTniLkfQouy/WQEvSuRTc1ZiHTwflEmE8bPg==
X-Received: by 2002:a17:906:f214:: with SMTP id gt20mr4859157ejb.458.1641923330509;
        Tue, 11 Jan 2022 09:48:50 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id i23sm5224489edt.93.2022.01.11.09.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 09:48:49 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 5/5] MAINTAINERS: mfd: cover MAX77843 by Maxim PMIC/MUIC for Exynos boards entry
Date:   Tue, 11 Jan 2022 18:48:05 +0100
Message-Id: <20220111174805.223732-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX77843 is used in Exynos5433-based TM2 boards and shares some
parts of code with MAX77693 (regulator and haptic motor drivers).
Include all MAX77843 drivers in the entry for Maxim PMIC/MUIC drivers
for Exynos boards, so they will receive some dedicated review coverage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e5f2758531bc..d1f8f312f322 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11693,8 +11693,10 @@ L:	linux-kernel@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
+F:	Documentation/devicetree/bindings/*/maxim,max77843.yaml
 F:	Documentation/devicetree/bindings/clock/maxim,max77686.txt
 F:	Documentation/devicetree/bindings/mfd/max14577.txt
+F:	drivers/*/*max77843.c
 F:	drivers/*/max14577*.c
 F:	drivers/*/max77686*.c
 F:	drivers/*/max77693*.c
-- 
2.32.0

