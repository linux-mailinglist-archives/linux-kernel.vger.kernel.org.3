Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6FB4F09F7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358870AbiDCNdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbiDCNdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:33:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3D85D33E30
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648992673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VDYAftsuMOi1oo0i/R8Jb9mhdL4m91TdJTqR4mm4wiA=;
        b=KjT8RixPJEY70GgY8Zt/nLJOIzU69Ga/21fKILIAd3luQ9TCjteqJkMlSutrOC2EI4teox
        RdNX8FF3/Cf7WBFuRR5JGtbYIcaavfqoN7bLllTTMXXH01Kp7GumqH10DsngUw50/5HHCB
        wOiDez1OZiNOU236u/u5CbFZuYQDT60=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-ctiNfAhZO1Kt_i-pmdnYww-1; Sun, 03 Apr 2022 09:31:12 -0400
X-MC-Unique: ctiNfAhZO1Kt_i-pmdnYww-1
Received: by mail-qt1-f200.google.com with SMTP id p6-20020a05622a00c600b002e1cb9508e8so4795614qtw.20
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 06:31:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VDYAftsuMOi1oo0i/R8Jb9mhdL4m91TdJTqR4mm4wiA=;
        b=KkD9Ew5r8Z27mZK8Od2ongtIAHfgdDiaC3dv4/4fN2rBAaFRMEfgPhJyEV/eRn6ykK
         6btkCB7XQV90q8oMCV5Hw6KvWe5PKnJtx2/izaf6Yu0UGPvQsnXglaLBdDxZCpdq7fT3
         N/4YMOcOAJ+yDUq3WEPSZhbahSuJRaRi01SFEITJGNPkqPLcEqV1E7pEV1d1YDyKvFZP
         ZBvc4imwMPG15Y6fcXxFVdfHj+7B7myWRYAnn3U8IsneltcNNDdGNeMsQg1IIaAsaeMt
         92Nb1MFE0cZjH1ijQjYEEoTq2zCirG0/IltWZ0+HgdQbjwpJcOjS0STztqxowGr2CP6/
         oaAA==
X-Gm-Message-State: AOAM530DJKDE0kI3AX1eoFLo89SKjhgvqBkzcdeoKVebm89aMYx0/dLp
        OZH70QHiUM3lm471mP1du1Fad5pnP1hhHRUfYemdf6pNbtKwkD65Vy5R5Sx/nB5kV1OYaisc6Sg
        TWSZzs3hVtBTxXCHifp+4wDZL
X-Received: by 2002:ac8:57ca:0:b0:2e2:131b:6f0e with SMTP id w10-20020ac857ca000000b002e2131b6f0emr14428087qta.664.1648992672234;
        Sun, 03 Apr 2022 06:31:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6Iqoonrf1l2NpFOddPCh9YWDHIgeM0/FaT+c8ZCrvRKqTogSOEz6yRGSG2RNsYUniKGNOTw==
X-Received: by 2002:ac8:57ca:0:b0:2e2:131b:6f0e with SMTP id w10-20020ac857ca000000b002e2131b6f0emr14428070qta.664.1648992671981;
        Sun, 03 Apr 2022 06:31:11 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b00680af0db559sm4810834qkb.127.2022.04.03.06.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:31:11 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     dan.j.williams@intel.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] raid6test: change dataoffs from global to static
Date:   Sun,  3 Apr 2022 09:30:51 -0400
Message-Id: <20220403133051.3751572-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
raid6test.c:21:14: warning: symbol 'dataoffs'
  was not declared. Should it be static?

dataoffs is only used in raid6test.c.  File
scope variables used only in one file should
be static. Change dataoffs' storage-class-specifier
from global to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 crypto/async_tx/raid6test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/async_tx/raid6test.c b/crypto/async_tx/raid6test.c
index c9d218e53bcb..d2d5fb154cda 100644
--- a/crypto/async_tx/raid6test.c
+++ b/crypto/async_tx/raid6test.c
@@ -18,7 +18,7 @@
 #define NDISKS 64 /* Including P and Q */
 
 static struct page *dataptrs[NDISKS];
-unsigned int dataoffs[NDISKS];
+static unsigned int dataoffs[NDISKS];
 static addr_conv_t addr_conv[NDISKS];
 static struct page *data[NDISKS+3];
 static struct page *spare;
-- 
2.27.0

