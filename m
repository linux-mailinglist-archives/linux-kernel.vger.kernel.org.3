Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF89B561763
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233966AbiF3KN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiF3KN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:13:58 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D18644A20;
        Thu, 30 Jun 2022 03:13:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r66so18061619pgr.2;
        Thu, 30 Jun 2022 03:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yHS730e4vBBXm7TzAGTuOdImtTpJ1+sTID/QkZphy1Y=;
        b=QednnHhV8MfZXVkfpPnF/2EDXwk3hWGuh8w4qVSLxaEI9Vi8S/VygZMjopq6QHH+/0
         UG6ZglWPVwR/vfNVT+v8/DcUCSO0taqAyE4dRWo6WZlnczZzXeJECeDjluQTIU2YiGzN
         BhziIkcdSy0Z2u2ET9Rm0urj4BGOF5z+ueZRT9vfeK+sGMiId7GKN4Y97v3zV6dkxIdH
         OItGIo9RU9Y6vMBH5+Uvc9nbTSQpKwQ7u07WXA5EABGvpkF8fJSFNZdY1djMYhIYu0ZF
         mUIabd8D1fli6bzVVzGPPjoplsOu5IylZskWPem5rjLUgaxP9eZC1JaMke/SBME/SGud
         yyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yHS730e4vBBXm7TzAGTuOdImtTpJ1+sTID/QkZphy1Y=;
        b=f3WP2li1HC49xl1Ea4h1GV5qSBT1ctQlCmAvTHGTj2rcucGrx8wC7UdI8rVvFMtf6z
         gViJAFwEahJGOOuy9Z+kDbGz+d0ZzDmved1MSWPwJ2fGwrcFDxzmUremqErty2yK9iIO
         yA6EffvXijzxqDD9nFX3l8fzKA1ucZHufUyfzv/MEX52mpQe+K/S1if6fJqi76uD2EXG
         aIYfQxv4AkiTsc0H4z7HUlz78COrSNn1KQse16QYs3YsaVmxQEjbgSEGQVHCjvhG442F
         fJUs/uK2ebtgCVThAjbnVkALxj9EsTUIROtUYDpHcDC3jlvjwCrcrf5RFunK94je8yl0
         BAKQ==
X-Gm-Message-State: AJIora+3pusf/aQuVDWSe0U85yphnyRPb7wPQVxyKFjeGdQd1tQy/DaI
        FMBp7i9rLkygKxwKMota1ds=
X-Google-Smtp-Source: AGRyM1uhJ9hpMKkSHpSlnFoGHFrFu8+IvkcXxYGmxVIhD72S3fLnguDrTs6neMjBXaIuaq7eoTWC1w==
X-Received: by 2002:a05:6a00:2410:b0:522:9837:581f with SMTP id z16-20020a056a00241000b005229837581fmr15105934pfh.11.1656584036579;
        Thu, 30 Jun 2022 03:13:56 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-27.three.co.id. [180.214.232.27])
        by smtp.gmail.com with ESMTPSA id y11-20020a170902d64b00b0016782c55790sm13043107plh.232.2022.06.30.03.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:13:55 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 77EA8103901; Thu, 30 Jun 2022 17:13:51 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH next] Documentation: coresight: escape coresight bindings file wildcard
Date:   Thu, 30 Jun 2022 17:13:17 +0700
Message-Id: <20220630101317.102680-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell reported htmldocs warning:

Documentation/trace/coresight/coresight.rst:133: WARNING: Inline emphasis start-string without end-string.

The warning above is due to unescaped wildcard asterisk (*) on CoreSight
devicetree binding filename, which confuses Sphinx as emphasis instead.

Escape the wildcard to fix the warning.

Link: https://lore.kernel.org/linux-next/20220630173801.41bf22a2@canb.auug.org.au/
Fixes: 3c15fddf312120 ("dt-bindings: arm: Convert CoreSight bindings to DT schema")
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Rob Herring <robh@kernel.org>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/trace/coresight/coresight.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/trace/coresight/coresight.rst b/Documentation/trace/coresight/coresight.rst
index 529b7c80e6f353..1644a0244ad10a 100644
--- a/Documentation/trace/coresight/coresight.rst
+++ b/Documentation/trace/coresight/coresight.rst
@@ -130,7 +130,7 @@ Misc:
 Device Tree Bindings
 --------------------
 
-See Documentation/devicetree/bindings/arm/arm,coresight-*.yaml for details.
+See Documentation/devicetree/bindings/arm/arm,coresight-\*.yaml for details.
 
 As of this writing drivers for ITM, STMs and CTIs are not provided but are
 expected to be added as the solution matures.

base-commit: 6cc11d2a1759275b856e464265823d94aabd5eaf
-- 
An old man doll... just what I always wanted! - Clara

