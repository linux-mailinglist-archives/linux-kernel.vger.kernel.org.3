Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917E8596470
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237513AbiHPVPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237468AbiHPVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:15:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D466A5C
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:15:00 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e27so9337972wra.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pOKidRu+yxajr1o110Z9rt8XpJh4zLytmd2a75/kdaY=;
        b=eycbJA9QimgNmj6FqsedtUpws9mFwuQMTmqmi7bWPB+Slec+QuQeQnPnlbNjGETRb1
         iFK24JTcpfKfIOLgLStWto0lUa6i9zdJX2y5OpLxjITVHkpf3YAV5aiu5QUJe423RM6E
         VqG/wmJ5ao2urhXB2WF/MYw6B4qZTCeco1FEn7VPcV9cusG5BSPeEWECdL6OW1l23s3o
         awJH3tZDVx+NYYD9dgpREKunb8LFursJ2bvKsH6EQWMWydKNys4vfr61VepPWBIwQvKK
         So2lKq0dgmIIDZ21IG5o3aZJQP6uzPn5+dTTnTnMXeJ84+bcw/7Z2fntv6PR42PjAkf0
         zb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pOKidRu+yxajr1o110Z9rt8XpJh4zLytmd2a75/kdaY=;
        b=SIwKxSrZDN+1c8u8P58hBMOGzEzgSof1V1B2BNFFWJRcO/pleU6vhLUgwzOz9FeMEo
         LlKcfkhG7em5YVuB/TJ2Pxv+X6qx7x/u8mWo93ehHKgEnXkrao3eA5yR35NLX/wsbLik
         mwrc3KVS/n2YqLHtsZGR9MJ9QMI+MtOObHWxuhqdzD4vs38s/KkUisJsQMIyqFZGv6ma
         BaURu010fnevuQn+5ixrNXUUIX9eg+vLb0skleS8q8Y79hcZ+WaBBDSzbKU3kXQY6aMu
         hem1qPx1/23Tp9L6B7NqbcWoUtnNBPe6oGG82NlNUk3ytxJFCNDzH2Q1WbJSxZ/mzN/5
         hrnA==
X-Gm-Message-State: ACgBeo2/Q1OGLeu3ujqbP2VeN07GhocBKPAasFiWdr+2ncNOdJ3i5aCQ
        QSiIiH97gclnaHUkzOAO2ix5ZQ==
X-Google-Smtp-Source: AA6agR4jnXSmm1WE3xmPat9hSfuxaHd1ndKNlueu8VFQO7Wz7awB0kB/CNbeG6zrxQ95PDBr1wAvew==
X-Received: by 2002:a5d:4201:0:b0:21d:7b63:1b43 with SMTP id n1-20020a5d4201000000b0021d7b631b43mr12129030wrq.225.1660684498400;
        Tue, 16 Aug 2022 14:14:58 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id r4-20020a1c4404000000b003a3170a7af9sm23913wma.4.2022.08.16.14.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 14:14:58 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [RFC v4 02/10] pwm: dwc: allow driver to be built with COMPILE_TEST
Date:   Tue, 16 Aug 2022 22:14:46 +0100
Message-Id: <20220816211454.237751-3-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220816211454.237751-1-ben.dooks@sifive.com>
References: <20220816211454.237751-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow dwc driver to be built with COMPILE_TEST should allow
better coverage when build testing.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v4:
 - moved to earlier in the series
v3:
 - add HAS_IOMEM depdency for compile testing
---
 drivers/pwm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..3f3c53af4a56 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -176,7 +176,8 @@ config PWM_CROS_EC
 
 config PWM_DWC
 	tristate "DesignWare PWM Controller"
-	depends on PCI
+	depends on PCI || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
 
-- 
2.35.1

