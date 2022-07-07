Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0A456A8E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbiGGQ7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiGGQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:26 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58318B86B;
        Thu,  7 Jul 2022 09:59:25 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id b9so4566456pfp.10;
        Thu, 07 Jul 2022 09:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XTGQ5LbEyZu2f55IFJvbgPNJTNxn86SqhC5DP56QZFg=;
        b=loY1OkrabwiXHrmpFWtRljLitiSUlun3zzEHHFMoKSYeiV4DkbeIuZbsKgXBp8uOMb
         fLqlpccwENup4eoO48pUhXY4vqf0taD4aySRXaoG8zLA5QPKhdoUO3aS/xRre2vr9ZTz
         hTdgbxd5xtZBcheLQBFKIMFKxkTLkUnxxw7/k5fBimjxj4r6eGuUUj/y8bQQEn655G71
         7M96moy5N9VmW5BlkZPaWE7COXX85yYHgAEpmy2sO9BGvBbORmTRz5ijhZCzrT5vlNrt
         2Ffx6sj629KxgdoEyuremMld1xTjRwqM1kehUI2HxDvIRTNUYqVF6/It6iv/mlbkmp/X
         EZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XTGQ5LbEyZu2f55IFJvbgPNJTNxn86SqhC5DP56QZFg=;
        b=0FKerzxIJlar/tPQmaTUPKbC/enn75EfXzO0XUyRVTfhX6fo3BjeoI5mQvJECTU911
         BmkgsZo+lK/PuI6N2vhSJskTOXZD9W8XiO86W7SEySbEvX8rfvJ1SxosO0Kf7f0a1sE8
         55Sno+wBTrmHtJF76uXrERh7luLP6NTHvV6raZgvxwj4zjtureBGc+7+n5Qne93TnlCI
         uzZ8+G3LMoSsRnkYyqzZfKo4Z0QzJMfvV1v/4WAyEYgVXZ7fVwv/Eyq60dWB55ER7H3Z
         PsfghRc3sKqpbbBzhY+jUUInVD9KZ9gAf/qcLJCioyfaR+jQHYA+Ca8kpteQexX+JSsW
         0g0A==
X-Gm-Message-State: AJIora8oC0BQB10oWTDoA0ci9z4CBfev+lVDFDciwTqJo6A64sEckZuH
        9iSh3k6oprVxFU35nDxPqqA=
X-Google-Smtp-Source: AGRyM1utogy8hlSzhnn4pDGsFmihEZc+ODN2o0jVhfJdc4COi7HXij1z8PItPcadIg/+DAAjv64EdQ==
X-Received: by 2002:aa7:8703:0:b0:528:c4c7:35b1 with SMTP id b3-20020aa78703000000b00528c4c735b1mr6366829pfo.38.1657213164933;
        Thu, 07 Jul 2022 09:59:24 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:6a04:c27c:dcee:eb11])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm28184185pff.148.2022.07.07.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:59:24 -0700 (PDT)
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
Subject: [PATCH v5 2/6] HID: define HID_SPI_DEVICE macro in hid.h
Date:   Thu,  7 Jul 2022 09:58:58 -0700
Message-Id: <20220707165902.3184-3-jaschultzMS@gmail.com>
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

Macro sets the bus field to BUS_SPI and uses arguments to set vendor
product fields.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
---
 include/linux/hid.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/hid.h b/include/linux/hid.h
index 4363a63b9775..7923fe1b51bb 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -715,6 +715,8 @@ struct hid_descriptor {
 	.bus = BUS_BLUETOOTH, .vendor = (ven), .product = (prod)
 #define HID_I2C_DEVICE(ven, prod)				\
 	.bus = BUS_I2C, .vendor = (ven), .product = (prod)
+#define HID_SPI_DEVICE(ven, prod)				\
+	.bus = BUS_SPI, .vendor = (ven), .product = (prod)
 
 #define HID_REPORT_ID(rep) \
 	.report_type = (rep)
-- 
2.25.1

