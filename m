Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BAE51695C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 04:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356711AbiEBCSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 22:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350936AbiEBCSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 22:18:07 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEE2393E3
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 19:14:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id q76so7655713pgq.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 19:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=65Eb1HUPdIjM8zVi86DKNREnJ4z9OvkieF1s3FEMLrI=;
        b=B345IU0VvTK7qo4L2LgQUT+cggfg4BJqOyQN463sR2b+Uu1eZsviGZ9eZiGCCjS/V6
         iXHXFutNyRKVe56vH1GFkebCe3/TERU2alBIz8pG4eBnvnB0zULOJj0E1nmAe3x0+UuX
         qDcS9XmeQsxOoK0YOo3CSCPEDbf/tr7kXd2olQEwct0q5SHNiW+UQ8NR4hhNyShIDRfL
         4W2RFkUMbRN5FI10sxLGZQwE2Cw/FO8wVmFYmbUhUh5mrPe2CMaa+KrkyDwa0FMcgaQC
         7rQpkrdeGxwpZ3KCK53Sd5QNXX3XEC41Ez7w5IJs60Wod10bPKorr5MvYLdfT0FKUNRB
         rlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=65Eb1HUPdIjM8zVi86DKNREnJ4z9OvkieF1s3FEMLrI=;
        b=KbR5MUywfMSdg2TiDO6WmL+oCV47TqlXJ1kLU3JCosW0/VZJH7K+fk+s2/PIYxDN9u
         +znemWmxnv7eWv0L8QVStDNyFbk96i5cv6IABX1kJuzEiOwBkbOCbMCyB/QzX5XV8nSV
         11Ok1wnREnu9zMP1UPauv3T75YzbM1NTRdujwUv6TMknGlkziE/PgsLhJgE1Xtw6elVH
         dJcWv0eifpozse3N4exUUoDs9Px5coYX2sF4gBGL9VVcB4JaK5zBGbUvYppxT3+FIFnv
         6h5s3NVHmhayo86rlF7DciT69Wez7PUI5zSZFb+Bhgi0hXcZEgVFqPq5TuFAxPGx7duN
         rW7g==
X-Gm-Message-State: AOAM531VkYsxP9hej7mbLDmwtwdUkEEPxVVvcJwyFqKXldzAXpmuHqgV
        lL24mEfuexlgODsIihdq6fSzlw==
X-Google-Smtp-Source: ABdhPJzpZX/SANfk9fzIJoImd0OuPeTWYoiPjTdB9t141mrs3EryTBoz9+gl41pN50AVEXovjP7hfA==
X-Received: by 2002:a05:6a00:a02:b0:4fd:f9dd:5494 with SMTP id p2-20020a056a000a0200b004fdf9dd5494mr9573958pfh.68.1651457679117;
        Sun, 01 May 2022 19:14:39 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:c18e:6070:88f2:a04d])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090a734200b001cd4989febcsm18714475pjs.8.2022.05.01.19.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 19:14:38 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nishanth Menon <nm@ti.com>, Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Drew Fustini <dfustini@baylibre.com>,
        Keerthy <j-keerthy@ti.com>
Subject: [PATCH 1/3] ARM: dts: am437x-gp-evm: Enable wkup_m3 control of IO isolation
Date:   Sun,  1 May 2022 19:15:07 -0700
Message-Id: <20220502021508.1342869-2-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220502021508.1342869-1-dfustini@baylibre.com>
References: <20220502021508.1342869-1-dfustini@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

With this flag wkup_m3 is able to control IO isolation during
suspend on the board.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 4416ddb559e4..91b67b428a06 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -1127,6 +1127,10 @@ &cpu {
 	cpu0-supply = <&dcdc2>;
 };
 
+&wkup_m3_ipc {
+	ti,set-io-isolation;
+};
+
 &pruss1_mdio {
 	status = "disabled";
 };
-- 
2.32.0

