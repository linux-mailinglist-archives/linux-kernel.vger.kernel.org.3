Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C4754737B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 11:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiFKJ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 05:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiFKJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 05:58:51 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75691D324;
        Sat, 11 Jun 2022 02:58:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p18so1987846lfr.1;
        Sat, 11 Jun 2022 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C93TNgs3tEMkjRGIc4zQyQSLHKj4wajnsAJdSQ715T4=;
        b=TC/HfOrVTyr9dht911B6WyEVEETgffYiwjSdsWhhNbTnqcUq/GmMnj85tfMJpHKJ54
         8lTzTeJR1UQqQbJHSYxhunhJ1eaaS7dnT1NbiiMzzsgRDBKSjyvDJyCX6OwXzmmhHmh7
         OcdG1D00tvereTAB6g317kOi36zTyygl1wiNErlzuIMhO3Dj8DapgNDRihg/tNuI3ds2
         GrQ00+6wMB5J3loW4lWEVflR1QmKYbb627zhLEwgST10z2U5Q2wGWPYmNUAoCZZUWUi2
         9y+Up1t5iqr8N0GanPfJiV2q/pHD8+I2JKuuecwTYih4E2G0N2YBuALQMclz2s05+H4d
         c2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C93TNgs3tEMkjRGIc4zQyQSLHKj4wajnsAJdSQ715T4=;
        b=5alDOfaTwS2H5NEyyFPo3Rz2tNfzbC1wiPDxy4TO/A6PCFQmpmmEKGoXxfktq9TEOv
         /jW130JMZf8gJ+wfH84zgVevsx6JgQsHq+qJodjAgIwsN9w24wUdztqzET+hWgB16o1Y
         UDCfz09XYAi3mY48bulxVKqrRVqFP9vx3TV6A1GbOI3S7L21+Ip4yBBXM2sUhwYc5hsf
         CkaYhMGPJ3kJ9vg5Q9vdhW4Eas2WDjVN9xfb1F6TMm41fOEqbd4KeTkH9xjs53ZK4/Jl
         guYzmuoUwQkxj5bCaYPuyj7G53nWtlgpbDCafcWaV/v3I1Zq3bdm8Tx7jNxBG4GEN5y0
         rsWw==
X-Gm-Message-State: AOAM532bIkooRFXpCLVohxEUsJL4vQ6RU0Rqfua6q9JOcLXLQehtmmEI
        Wc/LTcf8ux+rZ6CxfiER+lg=
X-Google-Smtp-Source: ABdhPJyW9Vpw8JSAMpHkEpi5Oft1TkEZC/FsxY6pbNdui2qL9dmT/mecCiJCFx6hLubZ/sI+6Y9bFg==
X-Received: by 2002:ac2:4bd3:0:b0:479:3cfb:72e5 with SMTP id o19-20020ac24bd3000000b004793cfb72e5mr19651571lfq.516.1654941528155;
        Sat, 11 Jun 2022 02:58:48 -0700 (PDT)
Received: from DESKTOP-GSFPEC9.localdomain (broadband-90-154-71-254.ip.moscow.rt.ru. [90.154.71.254])
        by smtp.gmail.com with ESMTPSA id h18-20020a056512055200b004785060bad6sm200634lfl.201.2022.06.11.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 02:58:47 -0700 (PDT)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     supreeth.venkatesh@amd.com, aladyshev22@gmail.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] ARM: dts: aspeed: ethanolx: Add correct label to flash device
Date:   Sat, 11 Jun 2022 12:58:25 +0300
Message-Id: <20220611095828.1090-2-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220611095828.1090-1-aladyshev22@gmail.com>
References: <20220611095828.1090-1-aladyshev22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OpenBMC code update infrastructure requires BMC firmware flash
drive to have a label "bmc".

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 6406a0f080ee..889b2fdd19cf 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -58,6 +58,7 @@ &fmc {
 	flash@0 {
 		status = "okay";
 		m25p,fast-read;
+		label = "bmc";
 		#include "openbmc-flash-layout.dtsi"
 	};
 };
-- 
2.25.1

