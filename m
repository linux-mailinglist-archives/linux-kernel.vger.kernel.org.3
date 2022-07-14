Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AF0574D49
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238808AbiGNMSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiGNMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:18:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B53DBFE;
        Thu, 14 Jul 2022 05:18:05 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id r6so2155377edd.7;
        Thu, 14 Jul 2022 05:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z8FXPQ2HFsdQUAT+K94K5LqC4oPDIoYE7B3AmbxBbmI=;
        b=fzmSn9/0x8bBpW8nEI3Fg9gdUlqbZV3NJ1Ga577qdd9juU5LLRLDsVpsnF9eve16qO
         IAHT20iruWgksIAS26sdrKpyIXdjRdg6k1RVPUFWOcF6wv22nEXx9gh6ATGsOHra0tB3
         kt7b/azZLQgTMRht51dENVUdXOwTGI0vmnUYZMqlymsT1HXfpRHZ+VtTmtNvi+Q3PQFW
         10rzDoz1GKz1HrwvBUbXHYY/43Hy5PLf7tJCOqL/MJ/820FCt16Tf+5Ns7tmYoQq9lPA
         86//5VL1abd62POh/EAbV1Vmv/p1vymTQIkcE75arO4BBBm+mAHYxpowLv9ravmW9Y7z
         jVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=z8FXPQ2HFsdQUAT+K94K5LqC4oPDIoYE7B3AmbxBbmI=;
        b=LvmEySddXmXb/Oghzr2n/EIuFH6jSACO+lPkE+sMXwxwXF/y51eR/sTLqiZFZcEwno
         d/y6q0eJRgRG+w2lH0H+bIH4Trmcjtph9SVF3yYBCQRRrMywRIPlF0+MGHIDsMtH8NLU
         Z/ArD9ef15zKjcf10pDL88AQuSU/SsLsLM2R6VS2MVJpmwFrU83XXcpXw5ZnjPn+N2KT
         q4hBBJs3G9h1ddpLl8F+alAiatJXycFs0LbwJW8BFKl134T4kL7dmjb0Ay9nbQBPSGzg
         ruuDNwkcv3VhVN9tcjMuat2W2FCFUQDgkj59ejIMQnR5nwNS6L4vfZCz4ErjW4ET7b1V
         0jXw==
X-Gm-Message-State: AJIora/4fjsZ6mUprEURQ/7MPzHYuaj+SB8XKUKlWMIgQfqRytD81Yfo
        LfUsnKIy3KhAffc2NgDZ7Is=
X-Google-Smtp-Source: AGRyM1s0FLooPPofTKzsmTjW38dN7FmunKqAOFb5+ZQWmFsV95mTK4M5ORXv2xU0JZ+JtCFtyk79Ow==
X-Received: by 2002:a05:6402:3886:b0:435:643a:b7ae with SMTP id fd6-20020a056402388600b00435643ab7aemr11823103edb.4.1657801084100;
        Thu, 14 Jul 2022 05:18:04 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id b6-20020a170906038600b00711edab7622sm636692eja.40.2022.07.14.05.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 05:18:03 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH] crypto: lib/arc4 - expose library interface
Date:   Thu, 14 Jul 2022 07:12:21 +0200
Message-Id: <20220714051221.22525-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Permit to compile the arc4 crypto lib without any user. This is required
by the backports project [1] that require this lib for any wireless
driver.

[1] https://backports.wiki.kernel.org/index.php/Main_Page

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 lib/crypto/Kconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 2082af43d51f..2dfc785a7817 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -6,7 +6,11 @@ config CRYPTO_LIB_AES
 	tristate
 
 config CRYPTO_LIB_ARC4
-	tristate
+	tristate "ARC4 library interface"
+	help
+	  Enable the ARC4 library interface. This interface is mainly
+	  used by wireless drivers and is required by the backports
+	  project.
 
 config CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 	bool
-- 
2.36.1

