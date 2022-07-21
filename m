Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C64057C439
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiGUGME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbiGUGMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:12:00 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F3C7AB1E;
        Wed, 20 Jul 2022 23:11:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d7so872257plr.9;
        Wed, 20 Jul 2022 23:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/6bklssnojwIUB7PlTKbvwW+7Fz0WRmqD7QIsHQizsM=;
        b=ib98ZEbOYYyXc+kUyu2sZl/lRw2L/UFUUHjFtpXOAsUSWK7RJMhQkdhIF6vlWKlXXP
         Hk2hE2E66KZ8qltGVGGbdSAr3xTotyYsbs7h0KDMnO8kxyqZdUk9RmpaYuAv1XBVsC2h
         85zQNQMvMmuhouxM4CHvomwkvtqThxdlkwKsfJxAf67jmZU4h7rDO5jubX8E1TtnHg/x
         YzEME3jFhL3R431l8xZGjKOnC4M0lOLJhHaFBbxK+FTaa4TneCGsBuXJsJMv7oCmI459
         pMSlY9wKyTwUbXxDZhBVq6Hllgng3incY0GiW/JWLhy012EMhpgMxQPqxlhgKkrVIYa+
         2KRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/6bklssnojwIUB7PlTKbvwW+7Fz0WRmqD7QIsHQizsM=;
        b=A3i7d7AVjLK+ph5V2gXuxvY6KonBhKXWBH7kRPQgg3pnM2wmfurs1N1yJMEZbpa7zz
         7k4pvFinoGFf0Fj7gy0dojGPMxC8b7nE3yQrO4WYNLG8bEwr868IO/hPoUjQtrFFaRX7
         YMDWKDQ47w3jk20ab38yDnHZ4N+2XgBL2Mqfythbn7PboxjxR5375dhxitfjleIQJmRX
         6wHF3def+LJVtYh+yylTpUjO9R+1njSw9qao5sNjP1dP4QdA00r0g/I6FLdfF1hfyvwJ
         SMujhlYd/prKEK/b5coZn9pq8czaCuQey35q/OwzVbX7vWnuszSpglMY2s4BK0Rhb6OG
         PEZA==
X-Gm-Message-State: AJIora8ZJcruuUwzJvQvuVfNtJL9WM93Cc/3cO31udpPpyIq6HgLjofi
        UBayfpdhA/UcNY7xsRToQ24=
X-Google-Smtp-Source: AGRyM1vOwVfAeQWrdhF6r2NPxaGqAYCsBD4WQRI5rFhY7+qBvGRSTmv/++MJTDNBwz7xSKg422XF4A==
X-Received: by 2002:a17:902:f544:b0:16c:5119:d4b6 with SMTP id h4-20020a170902f54400b0016c5119d4b6mr41796103plf.28.1658383917124;
        Wed, 20 Jul 2022 23:11:57 -0700 (PDT)
Received: from genechen-System-Product-Name.richtek.com ([2402:7500:46a:8b75:f825:a44d:6d0d:6d6e])
        by smtp.gmail.com with ESMTPSA id 13-20020a62170d000000b0052ba782f4cbsm744998pfx.7.2022.07.20.23.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:11:56 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
Subject: [PATCH v2 2/6] usb: typec: tcpci_rt1711h: Fix vendor setting when set vconn
Date:   Thu, 21 Jul 2022 14:11:40 +0800
Message-Id: <20220721061144.35139-3-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
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
 drivers/usb/typec/tcpm/tcpci_rt1711h.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
index b56a0880a044..3309ceace2b2 100644
--- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
+++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
@@ -23,6 +23,7 @@
 #define RT1711H_RTCTRL8_SET(ck300, ship_off, auto_idle, tout) \
 			    (((ck300) << 7) | ((ship_off) << 5) | \
 			    ((auto_idle) << 3) | ((tout) & 0x07))
+#define RT1711H_AUTOIDLEEN_MASK	BIT(3)
 
 #define RT1711H_RTCTRL11	0x9E
 
@@ -109,8 +110,8 @@ static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
 {
 	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
 
-	return rt1711h_write8(chip, RT1711H_RTCTRL8,
-			      RT1711H_RTCTRL8_SET(0, 1, !enable, 2));
+	return regmap_update_bits(chip->data.regmap, RT1711H_RTCTRL8,
+				  RT1711H_AUTOIDLEEN_MASK, enable ? 0 : 0xFF);
 }
 
 static int rt1711h_start_drp_toggling(struct tcpci *tcpci,
-- 
2.25.1

