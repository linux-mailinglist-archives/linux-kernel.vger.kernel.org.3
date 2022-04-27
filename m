Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A43D5112C1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358993AbiD0HrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356434AbiD0HrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:47:11 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC31F2FFCE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:43:57 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D970E3F6FE
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1651045435;
        bh=8jXf4hJvUNA7Zgo2Xy9fULH0xSDw50tBXLQ5NxaCPwc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=tz7EM3y9eXOS59Ku6qCdubLxcdytS+ZWbicKdZj9tB25+63bP6qscCEyoiSU1LLPe
         jDl2oEPW4WzE0wH3Y8gPToez6f/h056WNAZaeufHG3dJwcVUlhlIqY5Xnm7tftW3SN
         11lZKGO1q01/a0/Fp4LShyzfd3T0U4BB4yMHrk8G4dq0GYoR9tBm0c8OXy1cOVRZrn
         nekSck/hy/Tw4rNO7QQDbZn+LgfyeXp/9xQuYF0uj546kyiHchSUt0zPib0Sj5iR9z
         HKqJLV8BGVJxnDEuAdvfMSqySMR3Bt9eGC/EpJtkfWFVImS8cz3vu9Up5SJGgh01rT
         l05+ZSk3qIa5Q==
Received: by mail-ed1-f69.google.com with SMTP id h7-20020a056402094700b00425a52983dfso544875edz.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8jXf4hJvUNA7Zgo2Xy9fULH0xSDw50tBXLQ5NxaCPwc=;
        b=X3obTwaFNVRzoUAd4rf426OaVxexM7nZ3YApn6wGoxUbgBZ74oaBwrOTbzIcxqPieW
         /pTIIEmQlWvnSTP2w1SUBqhXcHM7GFN/02zpt9yCQsqQyn4YpYcKP3QP/dRdi5mwZjsA
         T/1g65cTWkXmbyB3PGUbZu5euUAKPYUBzMC73k9PxuvI0hYA7ociiZs0/DVRmHhmzms3
         z5xWA0SQz+09PmTuSwHhqfMDsgnXksBXaM99XXyUXCFHrpaMYGxWAWTOslgf+L27M0BY
         QVXKFY3hZ/g17AROOLYECVZSbQvWCw53L9pdLhI8OLcN5s8rRl6Bag+s5aZXyIe8k8q1
         bxRg==
X-Gm-Message-State: AOAM533OC8bKf08rdEJzlzVJ6H68YuHK+EEFR7vRaRYPxIxZl2tz0ZzM
        b7sOlS0igC2NdH0c69bIi3VSyWIYmgxDumc69KU7mDtcAysn7sA9FtHxCs52015ikE523jPtJYP
        JDCZ+KHCrS0FttS7F2Pl2lGML+DQ6xcIR7uKSVw0IcQ==
X-Received: by 2002:a05:6402:4305:b0:423:f73b:4dd8 with SMTP id m5-20020a056402430500b00423f73b4dd8mr28872564edc.218.1651045435587;
        Wed, 27 Apr 2022 00:43:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9qGwbmj4RQdcIrM402uZX33x1RmjKuotIbf3u96QABOyiSqGny7stvH42Ubp0YmHhK/i+ZQ==
X-Received: by 2002:a05:6402:4305:b0:423:f73b:4dd8 with SMTP id m5-20020a056402430500b00423f73b4dd8mr28872550edc.218.1651045435434;
        Wed, 27 Apr 2022 00:43:55 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q8-20020a056402040800b004227b347ee3sm7902998edv.56.2022.04.27.00.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:43:55 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@protonmail.com>
To:     atenart@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@protonmail.com>
Subject: [PATCH v2] crypto: inside-secure - Add MODULE_FIRMWARE macros
Date:   Wed, 27 Apr 2022 09:43:51 +0200
Message-Id: <20220427074351.391580-1-juergh@protonmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The safexcel module loads firmware so add MODULE_FIRMWARE macros to
provide that information via modinfo.

Signed-off-by: Juerg Haefliger <juergh@protonmail.com>
---
v2:
 Add legacy fallback firmware locations.
---
 drivers/crypto/inside-secure/safexcel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 9ff885d50edf..9b1a158aec29 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1997,3 +1997,12 @@ MODULE_AUTHOR("Igal Liberman <igall@marvell.com>");
 MODULE_DESCRIPTION("Support for SafeXcel cryptographic engines: EIP97 & EIP197");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CRYPTO_INTERNAL);
+
+MODULE_FIRMWARE("ifpp.bin");
+MODULE_FIRMWARE("ipue.bin");
+MODULE_FIRMWARE("inside-secure/eip197b/ifpp.bin");
+MODULE_FIRMWARE("inside-secure/eip197b/ipue.bin");
+MODULE_FIRMWARE("inside-secure/eip197d/ifpp.bin");
+MODULE_FIRMWARE("inside-secure/eip197d/ipue.bin");
+MODULE_FIRMWARE("inside-secure/eip197_minifw/ifpp.bin");
+MODULE_FIRMWARE("inside-secure/eip197_minifw/ipue.bin");
-- 
2.32.0

