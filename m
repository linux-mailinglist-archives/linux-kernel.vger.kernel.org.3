Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2F4586767
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbiHAK10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiHAK1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:27:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B762319C10;
        Mon,  1 Aug 2022 03:27:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id q7-20020a17090a7a8700b001f300db8677so11479659pjf.5;
        Mon, 01 Aug 2022 03:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frVSMV4VhRB7VzLFLyUnxtQ5dfraq7Cu44qOlKTHpGs=;
        b=HYqDPObCoEF46Ks9CpZo0dQbp/b+zny2p7vsC98SS8LeSyDRu031hTVUxMFZeXtvPT
         VMi6P2f0rEHzW1bNA9qsDbSs5CA24TjZR/HRPEk0rW1Meft1rtMH4CX7dG0jqsYZYHY5
         YKRyY8CK68UsBsWX/DH33vLya28bMV6aqffjNnfl9ZnYjiTvR3mCzSfKwUkQq6lusqM+
         1POYcmrtaWU2JzKpEHgcsZ5PDT3kfD2dBvdASSFWb2E1b29Xg67G+t2o+fYPjTEixjOX
         6tD5bznwG5l5VsRwY4pt5Z/dIHHlKBQhoYrRhgFCyXPb47OmfmAAjiiSCBWz5rJ2y8Rg
         FD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frVSMV4VhRB7VzLFLyUnxtQ5dfraq7Cu44qOlKTHpGs=;
        b=Mbx3TmorzCK7Zqzgx7d8Peck9eSEpKXRWJzQ8RK4zwncScXMrLyNah4dxQlcvUQOwq
         5eTgw1eSLq48UhnCntQPLS335rxDVjHEJwIz01n/JmAe7nCQdNeam7k7ksejVaAbvNm6
         jXAYjO9ufVJ2YDc2tAsXV/K4u1A5GE8yxO72HIcWxjUQDsT4DajxHNQc3ZMNngUc1TDm
         bq2ms9BkFZIBKySDFAiGeFC97tSJwlM1NpLMGz5d7LPhXeGNFBaVnB8aEVXXJXlI9HAb
         +zfp9YFM31nJ1u97luQJ16F/CzYo45pbNGfxpvh1sLBEsOJnzGezcFQw8RklpqHxJjj5
         QKcg==
X-Gm-Message-State: ACgBeo0L6WOadT3AZuxba2i4x+fgvuCrF/q2dJSU3drGNw7WlLgxM+5B
        2urbRwdhe/gbZmwRL3b2HHM=
X-Google-Smtp-Source: AA6agR7YuShjPPKdweyXhZC9uAYiud+U8Cm+OkZeaNI6XQuiVt9+ugfDwC32pJhrO5ElGpJG9xj+0w==
X-Received: by 2002:a17:90b:4c8d:b0:1f2:c360:5e6b with SMTP id my13-20020a17090b4c8d00b001f2c3605e6bmr18919118pjb.195.1659349640305;
        Mon, 01 Aug 2022 03:27:20 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:8d46:b2ef:57e3:7c30])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016c6a6d8967sm9199302plb.83.2022.08.01.03.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 03:27:19 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v3 2/7] usb: typec: tcpci_rt1711h: Fix vendor setting when set vconn
Date:   Mon,  1 Aug 2022 18:14:42 +0800
Message-Id: <20220801101447.86207-3-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
References: <20220801101447.86207-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

replace overwrite whole register with update bits

Signed-off-by: Gene Chen <gene_chen@richtek.com>
---
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index b56a0880a044..6197d9a05d36 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -5,13 +5,15 @@
  * Richtek RT1711H Type-C Chip Driver
  */
 
-#include <linux/kernel.h>
-#include <linux/module.h>
+#include <linux/bits.h>
+#include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/gpio/consumer.h>
-#include <linux/usb/tcpm.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/usb/tcpm.h>
+
 #include "tcpci.h"
 
 #define RT1711H_VID		0x29CF
@@ -23,6 +25,7 @@
 #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
 			    (((ck300) << 7) | ((ship_off) << 5) | \
 			    ((auto_idle) << 3) | ((tout) & 0x07))
+#define RT1711H_AUTOIDLEEN	BIT(3)
 
 #define RT1711H_RTCTRL11	0x9E
 
@@ -109,8 +112,8 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
 {
 	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
 
-	return rt1711h_write8(chip, RT1711H_RTCTRL8,
-			      RT1711H_RTCTRL8_SET(0, 1, !enable, 2));
+	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL8,
+				  RT1711H_AUTOIDLEEN, enable ? 0 : RT1711H_AUTOIDLEEN);
 }
 
 static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
-- 
2.25.1

