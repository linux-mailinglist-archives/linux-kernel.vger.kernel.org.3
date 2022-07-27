Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DF65823C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbiG0KGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiG0KGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:06:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D791B7AD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:06:19 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id t17so14136963lfk.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6IDJ4C5bccFAxeK6xcFNoHFKmsJbrdAcR26crWC790=;
        b=E40hhx8eHoltQCcwgV1s2lHhJD1E4fOiMhzkBsFpZZPMX/7dKKSk4nCywaP/Z4T1H6
         WKAQY44NHZ3ni5KSmOm6zPXj+OqcHI5X6YeSxo3q4/DTJH4Kb14rEp2GC1kY8AY2NiId
         39SM9VN749ErK7Xx54LKCWcka55Ut4JlDBa0VBDF0L+2P+BDC29SO5W7q4V4zE+Lr38m
         cRnjz/YFUZShfeG2uTx7uPzurUwB/0WoVPuIe2bGcgN9yp/53xC8QlYBJ4vKeq7b1BXf
         cIf814COo2wg0GtktE7zRrZxZTbr6WkcLZ+UzYUcJKuJenRcDCcSWa5FSQ6bo6t0GKF3
         /wQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H6IDJ4C5bccFAxeK6xcFNoHFKmsJbrdAcR26crWC790=;
        b=h8rtrig44iP9LKKTTuHIt5fwjKblWTS5hKmyimtiEWXGytHOpXzXPOzk3JQHpB9xU0
         RNbUHoBUVjIjUcOcJPNroriJUng4peZg0Q/XoLlyUlRj9BR/fL2Xr43pnAvwk8JvodRj
         VXUZZkFMH1iUnk/BOk35wrYh6YUWOF2e1K+a7ZxQU9g9XYKRKdjufZ+pxUx3+mTxNEQB
         wAdhPl/t09xI5fz863Z3du3zIf99kfOCEHlOHirGoj5IhRUj8ybwSZwVlgM1G/469HtZ
         8bqYwpnTxzZ+USl70q6pKFRL3nwpYw1Cx3sNgHCER9e3I4vr7SfDysky4HOEiXF/Kiff
         9R6g==
X-Gm-Message-State: AJIora9pASfr9CUmb49wXmljIYJfNYe18KYhgFMnXFyaDk6EiE5Da28e
        lZu77Npvb17mYBm9t6ZonUpC3g==
X-Google-Smtp-Source: AGRyM1uOR9dx5+hwW2p1CfkA3e40RUcouNyUvvVCWkoflGa09VHVX+uy7YmdKgma3ApZjtq9G/gxTQ==
X-Received: by 2002:a05:6512:c2a:b0:489:db52:fc18 with SMTP id z42-20020a0565120c2a00b00489db52fc18mr7628573lfu.99.1658916378062;
        Wed, 27 Jul 2022 03:06:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru ([188.162.64.29])
        by smtp.gmail.com with ESMTPSA id k6-20020a05651c10a600b0025dd5b3fabesm3670900ljn.102.2022.07.27.03.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 03:06:17 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] kbuild: take into account DT_SCHEMA_FILES changes while checking dtbs
Date:   Wed, 27 Jul 2022 13:06:15 +0300
Message-Id: <20220727100615.638072-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to be able to recheck dtbs files against a limited set of
DT schema files. This can be accomplished by using differnt
DT_SCHEMA_FILES argument values while rerunning make dtbs_check. However
for some reason if_changed_rule doesn't pick up the rule_dtc changes
(and doesn't retrigger the build).

Fix this by changing if_changed_rule to if_changed_dep and squashing DTC
and dt-validate into a single new command. Then if_changed_dep triggers
on DT_SCHEMA_FILES changes and reruns the build/check.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 scripts/Makefile.lib | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index c88b98b5dc44..3df470289382 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -383,17 +383,15 @@ DT_CHECKER_FLAGS ?= $(if $(DT_SCHEMA_FILES),-l $(DT_SCHEMA_FILES),-m)
 DT_BINDING_DIR := Documentation/devicetree/bindings
 DT_TMP_SCHEMA := $(objtree)/$(DT_BINDING_DIR)/processed-schema.json
 
-quiet_cmd_dtb_check =	CHECK   $@
-      cmd_dtb_check =	$(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
+quiet_cmd_dtb =	DTC/CHECK   $@
+      cmd_dtb =	$(cmd_dtc) ; $(DT_CHECKER) $(DT_CHECKER_FLAGS) -u $(srctree)/$(DT_BINDING_DIR) -p $(DT_TMP_SCHEMA) $@ || true
+else
+quiet_cmd_dtb = $(quiet_cmd_dtc)
+      cmd_dtb = $(cmd_dtc)
 endif
 
-define rule_dtc
-	$(call cmd_and_fixdep,dtc)
-	$(call cmd,dtb_check)
-endef
-
 $(obj)/%.dtb: $(src)/%.dts $(DTC) $(DT_TMP_SCHEMA) FORCE
-	$(call if_changed_rule,dtc)
+	$(call if_changed_dep,dtb)
 
 $(obj)/%.dtbo: $(src)/%.dts $(DTC) FORCE
 	$(call if_changed_dep,dtc)
-- 
2.35.1

