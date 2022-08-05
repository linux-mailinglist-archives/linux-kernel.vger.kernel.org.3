Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDC958A6E8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 09:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240354AbiHEHSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 03:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbiHEHR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 03:17:57 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F41139BBC;
        Fri,  5 Aug 2022 00:17:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id d65-20020a17090a6f4700b001f303a97b14so2028156pjk.1;
        Fri, 05 Aug 2022 00:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9WTjcqdDZvIrd9m4Mp2PI6jdF4as7Bk5HjXH3pJQMAY=;
        b=fcFg+oQ+PIlmNy+t0TMXA2kt/X2BRMRodge2iTGUPLtCdDZk+1dADCiLzsUL4c8yIs
         LYLedsfiXe2+32JYD7TdCh0RAbch2WOBfPzZ5JeJjLwtnQWnsK5FCjjNltOtLm12F/Hn
         saJM2NZ9vkkfkhQs7GDEvqbSfARf/3ES+vzFBD6pEuiwuxgsEAgcEGD4y56JXxLWDDyz
         aQ04vsL0mRqWGSQjsO48rkFpKqQE/3M6tpeq7KdpZBGcereboAmkAyzm9oQ7Xb7okvaE
         jyfINauOe2xbaODyafnBpho+qxoDSRxh62yS9y8bdj23CpSU5tzw+NJp1rEaK6JEByXL
         4FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9WTjcqdDZvIrd9m4Mp2PI6jdF4as7Bk5HjXH3pJQMAY=;
        b=cRaQfNGoNwmeytZCwfXS2w1t7X63EC/CjCIJjSPnO+N3IlihrDRXXTO7x3Uh2CIJ2L
         uDC2/esfDfHOKgwee/+ssyBlhUTjeXUd0RFavcbd0iv0biwRLp+15cx+QEHWtmrSiwpn
         CHlpEcdbNhl6Bn/0xXq9An+JVe/mfjbfxrbuj3GJCjpGRUn/4nH0xw9PzBx3CDSxSoTA
         1NUWxHRcreWEcbgu9RUIDNiyc9Uuc1hiNHXKfCOlWhNEQE+yTo5hrJZ5MsEZWmXtufYh
         PC+NRdZFQEEaJ6nrQsKaH8FHA2xJFhx/QDZd0fsEaFGZ/eFc3U+Hptx/2zxTauPd0yYV
         C+wQ==
X-Gm-Message-State: ACgBeo01XXSX5Lm6XBpkqFPFkuqDShZmpPqNJtoTotURi4yZgYZhoxd2
        dSQoQQFeLSqTkJS0+IP/WtE=
X-Google-Smtp-Source: AA6agR6e1MxYjIpLHRvBco9uxv7WzOENqjp+HKFYy1T2n5ptNIfYViK1+IoDoPTKhV6rf078Kjiq4A==
X-Received: by 2002:a17:902:6bc2:b0:16d:d2c2:7ff with SMTP id m2-20020a1709026bc200b0016dd2c207ffmr5505944plt.87.1659683875579;
        Fri, 05 Aug 2022 00:17:55 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:579:6a6f:254a:2074:501f:264b])
        by smtp.gmail.com with ESMTPSA id z23-20020aa79597000000b00528c066678csm2226147pfj.72.2022.08.05.00.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:17:55 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v4 2/7] usb: typec: tcpci_rt1711h: Fix vendor setting when set vconn
Date:   Fri,  5 Aug 2022 15:17:08 +0800
Message-Id: <20220805071714.150882-3-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
References: <20220805071714.150882-1-gene.chen.richtek@gmail.com>
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
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index 3291ca4..f2f1fb0 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -5,6 +5,7 @@
  * Richtek RT1711H Type-C Chip Driver
  */
 
+#include <linux/bits.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
@@ -23,6 +24,7 @@
 #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
 			    (((ck300) << 7) | ((ship_off) << 5) | \
 			    ((auto_idle) << 3) | ((tout) & 0x07))
+#define RT1711H_AUTOIDLEEN	BIT(3)
 
 #define RT1711H_RTCTRL11	0x9E
 
@@ -109,8 +111,8 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
 {
 	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
 
-	return rt1711h_write8(chip, RT1711H_RTCTRL8,
-			      RT1711H_RTCTRL8_SET(0, 1, !enable, 2));
+	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL8,
+				  RT1711H_AUTOIDLEEN, enable ? 0 : RT1711H_AUTOIDLEEN);
 }
 
 static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
-- 
2.7.4

