Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F63D526008
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379498AbiEMK1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiEMK1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:27:06 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4A84F9D6;
        Fri, 13 May 2022 03:27:05 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z19so9414995edx.9;
        Fri, 13 May 2022 03:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIRDh90qLBvm84n6WkVrFxDl6BpgAk2Zm5Bgq5+AFUk=;
        b=b7csS6dQWyR/B4w7/AfPzowZ32axPRW+xaxYY/sD//r5JAT4tOd5ghfxuid99JBOpp
         DRUHa+LPXtBkY7CriVzq/1UOe4uBZACFkzvzVrSV71+GrJ76MY2YezvX2tdosxB0kvWZ
         cuFJtBu75gCjQmA5I9ddoXOTMe6izuGBb583wvwGCclDisEHLWuBie5dWyZFemAbBqb9
         SsM9kOJxYuaZZJE1Q5E2qZsN9O+7yiU/OBqbUcret3qen039LXBBOQ5Z+t9n6bEYdUQU
         R7VX0NUgfkuDzeiqEsX34zAw1hh56277acq8wA9zDBsZHKShJNcbIWqtvOBdDfu+D/ho
         wZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIRDh90qLBvm84n6WkVrFxDl6BpgAk2Zm5Bgq5+AFUk=;
        b=7W8HzXniRFrJMawUu0Mly88lbFyc7xLw1ZPyDpMVFWkRN6qI4e7OcPUMOj4/ph3wwB
         WQWp9LKb5JScl8VGoXX/o+40SXHzZHAmi8O07obIGk+Za+pXwWKwkK+w5w8gy1DVD+4+
         65oUnxnU7BmY+9E/MwBqcCiUQpswjVYXjKrsfYbXpMMfMaiKZgGL/sQEAJCLWGVwihcG
         FMu5WO098U/Qp5trMSaQY5CL0birlqeADp1LRqEEA4k9xaxUpKrY01gfMLwfHQPBVU7m
         Ooy4j3SmBWh5HgN/Bzz3NVlA14wGH5Pw2SQTyBqiQUa5Dj9AP/a4Uu6hAHVtcCbCqOJ8
         SM1g==
X-Gm-Message-State: AOAM530e4inFtu1keEq0oWyZN1vJhrEe8d7yvPXGfZx0SYY/VZ8TK9ac
        VwnInHNBBBDspbXvXxQ9lSk=
X-Google-Smtp-Source: ABdhPJysbC54HVn2cXqVbW7EoCSUGPzri5soUM98ZiXZrliZVoDcfVEn5+a1rJQnXP14c8VfUy9FWQ==
X-Received: by 2002:a05:6402:294e:b0:425:f016:24e7 with SMTP id ed14-20020a056402294e00b00425f01624e7mr39241816edb.111.1652437624212;
        Fri, 13 May 2022 03:27:04 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 3-20020a170906100300b006f3ef214e40sm609677ejm.166.2022.05.13.03.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 03:27:03 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] ARM: dts: imx6qdl-colibri: Fix capacitive touch reset polarity
Date:   Fri, 13 May 2022 12:26:12 +0200
Message-Id: <20220513102616.48040-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220513102616.48040-1-max.oss.09@gmail.com>
References: <20220513102616.48040-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

The commit feedaacdadfc ("Input: atmel_mxt_ts - fix up inverted RESET
handler") requires the reset GPIO to have GPIO_ACTIVE_LOW.

Fixes: 1524b27c94a6 ("ARM: dts: imx6dl-colibri: Move common nodes to SoM dtsi")
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

(no changes since v2)

Changes in v2:
- Added Fabio's 'Reviewed-by'
- Removed blank line in commit text

 arch/arm/boot/dts/imx6qdl-colibri.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
index c383e0e4110c..7df270cea292 100644
--- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
@@ -593,7 +593,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_atmel_conn>;
 		reg = <0x4a>;
-		reset-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;	/* SODIMM 106 */
+		reset-gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;	/* SODIMM 106 */
 		status = "disabled";
 	};
 };
-- 
2.20.1

