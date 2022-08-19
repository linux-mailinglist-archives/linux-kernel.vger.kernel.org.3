Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D07E599518
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346673AbiHSGJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346541AbiHSGIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:34 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F416C27FE8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s11so4418533edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yl5HiiR2MPe2XyH1/doPUo0B2YDbGGjz3okpkZe5cBw=;
        b=Pum09WMTwwxEjt2KUmuHdzsnw7jsrL2CGGbZKHZtJltod/goEUD2MgIyKf/4WJV/T1
         cQz+JQmSIefTBwgyBfj5ouRMUurR9EDpUbMaGkIvzowZYpIf2JJ+KaD/CFkT7p1XtUmF
         w6FA9YMnMGjmaO+g5lfrO6RSNhpxTXzwncFD7ZQs9lQ7hKOU03Uu3zlKw907272MIrTO
         sZOoeR2QMYVYCRsXW5Ba2ThEarlsMGTpqqpg2NaXx+6oyk79f3Sdib9TaK6yMfKinuwU
         z7D8O8/Nu0ARAFM1SVr8uFuwVGQk+DM0+9q+UCuiGnS5rKb1qp3HX3GYi2vptAUb3gpg
         meJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yl5HiiR2MPe2XyH1/doPUo0B2YDbGGjz3okpkZe5cBw=;
        b=7FYl/HlVRtm9xN7630jM0ultE4k/eW8d7i+dJO1BVKVLblBA5fZl1qIsV4cdjXWbu8
         3m7lyam78v2NvlLOC26c8STfOcGJkGZ89g317ZXgB41VSWExNzUygde0tEGrCiU0kc8s
         0f1QUF2qJfWGVVK8K4+6X/0EajocNmysYUKqKlzTeOD6iwg/5AD+YFhzH7M8maQoUpl6
         hit+bFDznbRt3FV8uUN3x7b1/tWuc7+udPF5MbSafYwZOI1TH/VGVJWAtqa9ebMSUfWf
         bhmfVfMRcEOk2Zq4pj0Nianvt1KrYhEMeLO/JMhlJX8y5DwQTOFQ/gQOpUpnzgtiNm/3
         jwJg==
X-Gm-Message-State: ACgBeo10a1Y10Wg/ySN3wRMC0eES1nYRdrEQaX+P3fhajdVzoqEKkSOV
        Seq/ZAEtgu9ButNT54MJZaMo0tWFz4fwRGQy
X-Google-Smtp-Source: AA6agR6owE29frw+Rwu3yMsFrK1lO2my17nU39OeqLDkxjzvWeYJxzu4oKmOGSnitPmZDiyCB61g2A==
X-Received: by 2002:a05:6402:1d4e:b0:43d:9822:b4d1 with SMTP id dz14-20020a0564021d4e00b0043d9822b4d1mr4910403edb.212.1660889302387;
        Thu, 18 Aug 2022 23:08:22 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:21 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v1 12/19] crypto: ccree: Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:54 +0200
Message-Id: <20220819060801.10443-13-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, and dma_map_error is not supposed to use
here.

Cc: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/crypto/ccree/cc_buffer_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_buffer_mgr.c b/drivers/crypto/ccree/cc_buffer_mgr.c
index 6140e4927322..9efd88f871d1 100644
--- a/drivers/crypto/ccree/cc_buffer_mgr.c
+++ b/drivers/crypto/ccree/cc_buffer_mgr.c
@@ -274,7 +274,7 @@ static int cc_map_sg(struct device *dev, struct scatterlist *sg,
 	}
 
 	ret = dma_map_sg(dev, sg, *nents, direction);
-	if (dma_mapping_error(dev, ret)) {
+	if (!ret) {
 		*nents = 0;
 		dev_err(dev, "dma_map_sg() sg buffer failed %d\n", ret);
 		return -ENOMEM;
-- 
2.34.1

