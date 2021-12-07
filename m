Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C8A46BD2F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 15:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbhLGOHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 09:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237529AbhLGOHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 09:07:08 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4282DC061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 06:03:38 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so57084242edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 06:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QaFJr9Kj7W1E5J0O0glmrUNqwId/EqvnwB8+dCfYBU=;
        b=QrCmwezXgDffYu3BYDFeZy4MmR2Bcvm/db80gHwidFga+NwxX3y+rcY846l2UQdA9F
         uQR0l0gkJConYz8JyaPYkdCoeqml2PcMm+HRWvsJ5OWJhLEjTKwnQ1993B2TwqJaIUJC
         qVgrZQQF08nhrZuXpSeha15CpfCFQetTqqcHCEzMRpX+ftTjhR+0igzGere/eweQRSp7
         0h2rssfxGJvXtnkAusZ6KIle3uX41hQL5XG6+dLl+EiIukCFtIxUGd7JROI1RBLDef55
         PC2ei026in6pMihQjWFpxRsYT07bIokDyl5DnDr9XlIOUrBe/y4SjW5nROtUmeJX/moX
         /W6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4QaFJr9Kj7W1E5J0O0glmrUNqwId/EqvnwB8+dCfYBU=;
        b=XVl/1ILH/J8x9ERWPWa+T4NoE4AYaXgt9APdSDAchYu5l02T2TOZL84WHjLR2Za3VP
         g8AZ4z4M4N1tNvcLTrXMrF9Fzgb/EDwZtlobqogrqJ+fhmEoLlRyEzeShQGeJVMP4uMm
         DnGLqQoHFpXsxsHOmZGiQy6ZdvuwQNKd+bg3WwkNFxuL+Av15Tk9TuFwHyBBNptTsVsd
         mLpj33LVh/Qhb5eraCnD+/zqeCDrKKU5xraTrTLPiolmKoddAxHjO3DmWj7vEYc/THQM
         o/egutaA/JfbArY3g05wCICQ7lXOhwGD/s01OstMkYnTmpOsKyXNRIzeRTg2QYi2w3Zg
         ZxCA==
X-Gm-Message-State: AOAM533rmZvUlraVR8x2iP/hPkXmo5QR+vCbVdIyKYVseUJfrXy1Rh5e
        XttoPa+rXLOSdru9UZeMIVR6QQ==
X-Google-Smtp-Source: ABdhPJzbnSFGpYaz1Y0yAN5niqLJAa8lYqVYXK9DdlHCE5yqsGkSEplPM3PLY6SPPooXRSpN84dB7Q==
X-Received: by 2002:a17:906:ae48:: with SMTP id lf8mr53950076ejb.451.1638885816143;
        Tue, 07 Dec 2021 06:03:36 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id sg17sm8644501ejc.72.2021.12.07.06.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 06:03:35 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH] kbuild: Report enabled nodes with duplicated address
Date:   Tue,  7 Dec 2021 16:03:34 +0200
Message-Id: <20211207140334.10461-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Duplicated unit address is a normal case, as long as no more than one
node using that address is enabled. Having duplicated addresses is
already allowed by '-Wno-unique_unit_address' in DTC_FLAGS. But two
simultaneously enabled nodes sharing the same address is usually
incorrect. Add '-Wunique_unit_address_if_enabled' flag to report
warnings for such case when doing "make dtbs_check".

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reported-by: Rob Herring <robh@kernel.org>
Suggested-by: Rob Herring <robh@kernel.org>
---
NOTE: After applying this patch, a lot of warnings appear on "make
dtbs_check". I'm not completely sure if it's ok, so feel free to Nack.

 scripts/Makefile.lib | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index ce6142238835..2f00c996d2e3 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -315,7 +315,8 @@ DTC_FLAGS += -Wno-unit_address_vs_reg \
 	-Wno-alias_paths \
 	-Wno-graph_child_address \
 	-Wno-simple_bus_reg \
-	-Wno-unique_unit_address
+	-Wno-unique_unit_address \
+	-Wunique_unit_address_if_enabled
 endif
 
 ifneq ($(findstring 2,$(KBUILD_EXTRA_WARN)),)
-- 
2.30.2

