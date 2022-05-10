Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2627D5215DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241999AbiEJMxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241976AbiEJMxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:53:39 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5384B1A4926
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:41 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id p18so19854264edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78JVcYS1OPNy0iMprMf44gcnodWCbP7TdZbHTmipSOU=;
        b=yam/lZolxWe0UsoR5j8vWTXX8ffBtQDSM4Q5cOe1VgTDvnrGJvgWHb+HSxCHbPJp24
         wI47EfWndInVOK9RJY5EdFjCSaKg8FQhE/ncyyXx+P3lSME1kQjVNwIFXu9NizSi+csy
         I75Trj4uun8l2Qd/LvEUlpRZmkJH/u8c5ohPq/PZLfzN8zsG3xKx6DdMbu2QqVSSTuLg
         G1GhCjcgoxvW4DBGZWlCC0Yu3FJsUD7nJsMECvMQFlrdtLrfXfj7Mvg0SXK2c1wqxnZD
         C26oEv4Iy35dHEHRS+UTx3UCilCjmmIXDpooje6s7u7ddB7Wh3Yvocxn5TZ3WmJQfMvT
         Kl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78JVcYS1OPNy0iMprMf44gcnodWCbP7TdZbHTmipSOU=;
        b=Sp/969af91YDogBsMJtg/2a2NJUC7fA4a7KPkqwvJx89STmq/oYlXfol720In9VLF4
         VjFjlTxSO+DpBB1pIjhgk+q1aF6Ik2OsgPJA88kUiNgkP60S9MKOinB93Nhmf3FsaCZr
         0xCWRdZxCL8NkNZq0wdSTnIDD9H4eQGvcDcvPCdXw9t+0pBPPPGLsOHrDj8ysIWvDMXs
         pp3uxTLKS/psmuN1UESDUh5NE7TQ6sjF5sIZSZpb/aTLFmO1cpZSfAXPbzJZXjJZ6puA
         7t8Y+F21DYnB0Tr7COmLJMkWRpL+BhvpU5zIaugehsfEEMbF0+ZMEMJ5iHoRfkdQPuFx
         eZ6g==
X-Gm-Message-State: AOAM530wAqNjCi8JohlSqa/CcuqenXiGYoy/DTdguCyghhfdWcHq+HZL
        UCNUv2Rf/hRFSJ+m6CvYDtSO3A==
X-Google-Smtp-Source: ABdhPJyerG+n1CTZ4ZSoKDj2W1kCFP2vV0xqAjbQcR9cY7KOeDNQ8BIbjwZLzF2aq40oAbzAizvE/Q==
X-Received: by 2002:a05:6402:2709:b0:428:3ed9:abe3 with SMTP id y9-20020a056402270900b004283ed9abe3mr23203650edd.51.1652186979918;
        Tue, 10 May 2022 05:49:39 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-75-cbl.xnet.hr. [94.253.144.75])
        by smtp.googlemail.com with ESMTPSA id gz14-20020a170907a04e00b006f3ef214e62sm6094290ejc.200.2022.05.10.05.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 05:49:39 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, pali@kernel.org,
        marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 04/11] arm64: dts: marvell: uDPU: add missing SoC compatible
Date:   Tue, 10 May 2022 14:49:22 +0200
Message-Id: <20220510124929.91000-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220510124929.91000-1-robert.marko@sartura.hr>
References: <20220510124929.91000-1-robert.marko@sartura.hr>
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

According to the bindings, all boards using Armada 37xx SoC-s must have
"marvell,armada3710" compatible while 3720 based ones should also have
"marvell,armada3720" before it.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index 1f534c0c65f7..62fce6f2a3a7 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -16,7 +16,7 @@
 
 / {
 	model = "Methode uDPU Board";
-	compatible = "methode,udpu", "marvell,armada3720";
+	compatible = "methode,udpu", "marvell,armada3720", "marvell,armada3710";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-- 
2.36.1

