Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B54B4A745A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 16:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbiBBPNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 10:13:38 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:40976
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345376AbiBBPNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 10:13:32 -0500
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3842A407C6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 15:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643814811;
        bh=duSAVgvelNICvdKrcx93NtKcQsfey6iTKnfcyqiY3yY=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Glw3FTXzWUWX+Qx+Y5dsWBc6dTEGpgNCoHy3GNWFfFmhhOWrjdZBsGZ9TJ1BKeAJ6
         KFZ6/Z7nvcDVhS7m8S1BMwmloW+6bwGTOPynzJW5qPdo4Ek+oex0aKvJ6p40it17kU
         PGpPdg8hTfQIeGsnIQOR6fFI20kp1cPQFmB7wK2FfFYbSmmwVBxP3SjMopLT7ZNYEh
         6GcTUwBdtSJ2Cd0S96J6gEhY4XZtG1TFreSJmKbHZM6w9YQCkmWW8jAnNnCxeAvqV3
         ibT2aIDWZzF4SBfXT8f3rhndFvp9mjQPVC1HeIicMMVuOQMSahWKB0ue6pK7Jf7+BX
         2+isMMI2k5cCQ==
Received: by mail-wr1-f72.google.com with SMTP id a6-20020adfbc46000000b001d7370ace6eso6938491wrh.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 07:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=duSAVgvelNICvdKrcx93NtKcQsfey6iTKnfcyqiY3yY=;
        b=8SJyCEgC4RiUrUb92Mom+4M7smHC7KbYUDRhGcExbIzu1aws4Bv5hNTCD6Y+3IeOdr
         6B9QTAEDKkF7pq7d6VIvChdhY8f5xzFPNEpSu0ujajE+GU/pqeaKEYfA9V8bYgKRs09b
         JJwsLRvrtHmdSl2Wy+vU6n6WbQM6/6ItVjB89Ao6BG2FmL73qA704pAFS79P8iYtrv/S
         8Ec8qOrPwBoyXa5e669FIybNqrdLLtzggQJ4g8eS6uIB2ihytX0SoDJFsANa8FfcNwCA
         74hLovfVlRie3coqbZCU9PChGQECAMctPVdE2Xd+xoHusVys/Dp0/dcJkwYiKWElJihi
         N95w==
X-Gm-Message-State: AOAM531zw+BHyWcjywhhcHwt7y8MBg26qJKr+tp1p62yTe3Da7yxR4l0
        PR7u7iHDFvAu3XXjtRtp+dMZWFmD9G/1h4HjMvREMi8Lsok+qmMAueTRfo8Gxm/qeBgnkaF67jc
        G3n1aXRZPa2Ry1wGW8UIfiPTnPC5K+I2PRyDwpRPkOQ==
X-Received: by 2002:a5d:5986:: with SMTP id n6mr25028462wri.574.1643814810950;
        Wed, 02 Feb 2022 07:13:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcQvlGtuGDsOAUNuOny5cBjriPqSZIg0IJGHnbFOwypEQNWRpEICVNmvDV+loDy3xq4zaoPw==
X-Received: by 2002:a5d:5986:: with SMTP id n6mr25028444wri.574.1643814810787;
        Wed, 02 Feb 2022 07:13:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id p7sm5098872wmq.20.2022.02.02.07.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:13:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v2 2/3] mfd: exynos-lpass: Drop unneeded syscon.h include
Date:   Wed,  2 Feb 2022 16:13:09 +0100
Message-Id: <20220202151310.285561-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202151310.285561-1-krzysztof.kozlowski@canonical.com>
References: <20220202151310.285561-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscon regmap is not used since commit addebf1588ab ("mfd: exynos-lpass:
Remove pad retention control").

Fixes: addebf1588ab ("mfd: exynos-lpass: Remove pad retention control")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 drivers/mfd/exynos-lpass.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index 99bd0e73c19c..166cd21088cd 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -15,7 +15,6 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/mfd/syscon.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
-- 
2.32.0

