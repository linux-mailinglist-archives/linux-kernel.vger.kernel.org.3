Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071F156A8C1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236318AbiGGQ71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236183AbiGGQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DA1B86B;
        Thu,  7 Jul 2022 09:59:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g4so19616649pgc.1;
        Thu, 07 Jul 2022 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xLxczcJVOgE/FdoCqhxa5viyVGxpBFORTb2+ALl7/sk=;
        b=EnsomdrlsFIc+9VOx9G5+PL+tmUvq7FCx2fjNufQ3zHH6WBo4Iuo6+oIa48K8XBG61
         Kevhs4OZMQfqzqONKm2sKTpXQYEDGmf1KBfDikghjX2wnoLG/8ST9KObJFJn7V6MbyQn
         zthx4sw5QBk/e/7KZIvf1qyqzA8m27XEIvaAjQIq1zrwiOisl5nyGUFicz7rtwevvmEU
         bvH6Gnk3FtO7PHdV7t6rX5xS2A45WvUM0w6SByFLjou2D2Joi5ThfQiaAsCl0GXV8y7O
         sLmU07OzK+/e54PjUnIXp2UE+CgwOjAIG/KBBSkd3nb9PTjjIK293JbkYOgZEPXUI/AF
         ThAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xLxczcJVOgE/FdoCqhxa5viyVGxpBFORTb2+ALl7/sk=;
        b=qXhDKnOFh30fl61BQ/8fMhZLL5wd9IbYQ8uZvYrpQUZh+4IVJNf0muALfKJW0OFJDo
         K0x5oBQwczfzVMefGneVKwdG+1SG8lz1zWvL2UsmXypnxOg0FuW4UZdmTTDKk6AeDDWl
         w3WGCvSmWIZftjcTlxTp8NG1LIAa2+4UiEsXUoW1/IDpVfzLdlU0udczjT6MEvfAtcU0
         kHr7ruzxrCyUDu8H+gslKQhCVuA2ln2fv/K4TWRFjmDvlnkr/rx7Gya6GmLKQP5vx/zZ
         FY3Qs5GO4MrfyVvp1YZjss6tD8pKuWLBGJwNNBdJWb+1HicOYOYz32QF3z4WHaccVuqq
         BQ/g==
X-Gm-Message-State: AJIora9kET9MIrOVKIhdRYCKMn+X3LZzFS8CUsxb8vKdDQeV2GfVwHLS
        QPqxd9RbVvJw6N2LTTVVrNfZ3fjNJ+ICRw==
X-Google-Smtp-Source: AGRyM1vlxfrC1bW763DGjq3CmBGzp76w0O9+VB/oCxDN7P8WhKc/CDD1ugcnl21LFCYv4uLLqOydbA==
X-Received: by 2002:a17:90a:e547:b0:1ef:95c2:cefb with SMTP id ei7-20020a17090ae54700b001ef95c2cefbmr5988976pjb.225.1657213163847;
        Thu, 07 Jul 2022 09:59:23 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:6a04:c27c:dcee:eb11])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm28184185pff.148.2022.07.07.09.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:59:23 -0700 (PDT)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Antipov <dmanti@microsoft.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v5 1/6] HID: Add BUS_SPI support when printing out device info in hid_connect()
Date:   Thu,  7 Jul 2022 09:58:57 -0700
Message-Id: <20220707165902.3184-2-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707165902.3184-1-jaschultzMS@gmail.com>
References: <20220707165902.3184-1-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

If connecting a hid_device with bus field indicating BUS_SPI print out
"SPI" in the debug print.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 00154a1cd2d8..22f313716a12 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2219,6 +2219,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	case BUS_I2C:
 		bus = "I2C";
 		break;
+	case BUS_SPI:
+		bus = "SPI";
+		break;
 	case BUS_VIRTUAL:
 		bus = "VIRTUAL";
 		break;
-- 
2.25.1

