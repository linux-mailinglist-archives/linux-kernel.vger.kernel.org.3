Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F10E5111E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358527AbiD0HHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352417AbiD0HHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:07:05 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19EE44740
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:03:54 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9E9AA3F1CA
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 07:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1651043033;
        bh=9VqNpTprZO6r11osQd2lD5E9Y+5zRg3ZFWFU2usUlQo=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=suZR2OSfPgi4ZMMkjUG0zv3oDo6wxNzvJycS/N6GHgC/qWSWaWkTXXieEGmHtPHSs
         mxnLOH85z6ChfHNfBBJAb1ImxGDC27qYSntigBKfBOHegu3P6hCl1UPUaGoEAjmYvE
         RYVPAePo6TReW1/XIUeQQS4rYXPVm8lkOTEqDbip6DOh7Hp09LefYBpmIqnw7kg1f1
         e1uH+AmSvUdwE1/D5u7x0qPfEwnu5ApOSgG1H8qJWcPZDcE+Amq6xHUR03i/5qx+gY
         FchMHgzoL47RYYrRF/2akCZ9zjcPtkRftJGW+5sn0arWWBcMTSr5LB1uhLmy1tJsLv
         arniFRW+AyN2Q==
Received: by mail-ej1-f69.google.com with SMTP id nc20-20020a1709071c1400b006f3726da7d3so582629ejc.15
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 00:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9VqNpTprZO6r11osQd2lD5E9Y+5zRg3ZFWFU2usUlQo=;
        b=f/9Wn/pFZ7IXGou+XNlMfNAjejVUIADDpQMXGGvQcEAPixEH/5rRhGH5eUpER9R5p/
         tmm7yN3vvFpN0cDXebwWUtPcGkjb2Pmad+jwQuTVW04Z/6Q/+zov/gwnIelyK7CvQyiY
         8ExWRmfr2kty+zWfvw5ug328LOKuP1sjxth0i6+FfVy8uIjx65Rao7qeiOm0kVWk+kG4
         KGMgkoCVEXXNmoG+O6Ue3LREdjBwJUmNAvG61TuzdqMh/gk9tIXTvuQ/GhhO8Ksd9XBY
         N5sTEkaOmWWYEfXKevq2qzOEAA4iSy2cyCD4B9yhAf8iXRc8TIiBJPZ674SD9/bg5dF3
         Xy3g==
X-Gm-Message-State: AOAM531HVyP+ewGn+iv8KigRlDROpGtU0K1h+ccSKN/bNJFnyAPZ06vK
        pdgJwvIApIQFcYguGOS+4c1WnukCXqrURGx1k3ss+pHX859szA6scuevLazNUqBoVKq9B0G1Qqh
        nUhKT81EDsIJ0Ni4bXokoA1AZiw/xWVQyNUsxtlEW+A==
X-Received: by 2002:a17:906:7304:b0:6e0:6918:ef6f with SMTP id di4-20020a170906730400b006e06918ef6fmr24783978ejc.370.1651043032732;
        Wed, 27 Apr 2022 00:03:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrFUk8EGUe3fb3AcpBFIswj7AowMOHWjWHIYrcKjkN8ERPHWirhsR2qIYx9ugl53V2o0kbHA==
X-Received: by 2002:a17:906:7304:b0:6e0:6918:ef6f with SMTP id di4-20020a170906730400b006e06918ef6fmr24783962ejc.370.1651043032579;
        Wed, 27 Apr 2022 00:03:52 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id h25-20020a50cdd9000000b00425e4075fb0sm4897408edj.33.2022.04.27.00.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 00:03:52 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
X-Google-Original-From: Juerg Haefliger <juergh@protonmail.com>
To:     atenart@kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juergh@protonmail.com>
Subject: [PATCH] crypto: inside-secure - Add MODULE_FIRMWARE macros
Date:   Wed, 27 Apr 2022 09:03:49 +0200
Message-Id: <20220427070349.388246-1-juergh@protonmail.com>
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
 drivers/crypto/inside-secure/safexcel.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
index 9ff885d50edf..8198e70169b8 100644
--- a/drivers/crypto/inside-secure/safexcel.c
+++ b/drivers/crypto/inside-secure/safexcel.c
@@ -1997,3 +1997,10 @@ MODULE_AUTHOR("Igal Liberman <igall@marvell.com>");
 MODULE_DESCRIPTION("Support for SafeXcel cryptographic engines: EIP97 & EIP197");
 MODULE_LICENSE("GPL v2");
 MODULE_IMPORT_NS(CRYPTO_INTERNAL);
+
+MODULE_FIRMWARE("inside-secure/eip197b/ifpp.bin");
+MODULE_FIRMWARE("inside-secure/eip197b/ipue.bin");
+MODULE_FIRMWARE("inside-secure/eip197d/ifpp.bin");
+MODULE_FIRMWARE("inside-secure/eip197d/ipue.bin");
+MODULE_FIRMWARE("inside-secure/eip197_minifw/ifpp.bin");
+MODULE_FIRMWARE("inside-secure/eip197_minifw/ipue.bin");
-- 
2.32.0

