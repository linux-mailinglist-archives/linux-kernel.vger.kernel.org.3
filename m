Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C715159950E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346544AbiHSGJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344838AbiHSGIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:31 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74AF6342
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:16 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gk3so6973794ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yWNMa8gEmIcjnbw10IXxxPNQFxmc0oHgvkM31hQzFRc=;
        b=CdNssv8VREdsltNyexSeWPxtCS+nM5OPHWwJ/DSZPjxo9HvCIhCPo4pIEnMVin3ocB
         lIoNLX+272S7PDpn/zyspH5zx2u/9uwxomOxtZWEDkeXwXo6Lb2Fs55Fp6IrcVytGCTH
         iMlwQ1Gh6l8DySPqf4b5z72BI0EvCpqMRcNeNq5ywdG1jkwv2900Cb5TUF8EhHMcD71y
         4XYHW2G/mqKVWCNEZEXVz8jUi4aZlclonPEMvTQGQ8S2GOrxTNummF5KE4t/5hZ/CrnS
         q+BsiH4mAo3zpQ/LeDXYGDft/0J84YQnjLSMw6AwmbKjILi02+f4XTqjlOtwJ6cV0Agu
         j2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yWNMa8gEmIcjnbw10IXxxPNQFxmc0oHgvkM31hQzFRc=;
        b=CIimxW1HxRDp3V093+/Hyks3LiCm/bKbCz5geJA7Qkwr9eTfoSPWeIMWpSMGO9tBnR
         PieziFsLRvp14+MdymTbWhNi5rpD1TM8aTxAKOSOKtDfTtslfedfJDbmR3LOKtEC7fLo
         0+YrOmOwBUCTuAxxEXML4eTkgW6gbzMH1MdZaOEDeV74m46SVkPN6zU7yzFRGPWaWsoX
         U3ENkPF1DrkcxCICwpgMLehVrS65lw29xBUK1e78m9lqIPhcTEj5NC6Y8YOEkSihNdyi
         MmCH4+1ouSTzq0lp6CbzNyn675KMSYF0bWLuOKVJzfDhCZZtFW4TBJqw36hpZxDyT0t8
         3CIw==
X-Gm-Message-State: ACgBeo1XY0vPbLtBRUKQtY5obf4a8de6a3GcktKL4VqsggkyCR95V6v6
        VZQKOQK2lVxn8Qyr5H6yRIeuwszEpF+duD7e
X-Google-Smtp-Source: AA6agR5mnj3Lntlfg+nOscK9RMkuTgHH3g812bGxQFy1YxoIMbulcNh2VlnvdCAgFkRskbSY09yKWw==
X-Received: by 2002:a17:907:6d06:b0:731:5809:ec67 with SMTP id sa6-20020a1709076d0600b007315809ec67mr3867186ejc.195.1660889295385;
        Thu, 18 Aug 2022 23:08:15 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:14 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: [PATCH v1 08/19] crypto: sahara: Fix error check for dma_map_sg
Date:   Fri, 19 Aug 2022 08:07:50 +0200
Message-Id: <20220819060801.10443-9-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, it returns the number of
DMA address segments mapped (this may be shorter
than <nents> passed in if some elements of the scatter/gather
list are physically or virtually adjacent and an IOMMU maps
them with a single entry).

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/crypto/sahara.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/sahara.c b/drivers/crypto/sahara.c
index 457084b344c1..bb71aac30e2c 100644
--- a/drivers/crypto/sahara.c
+++ b/drivers/crypto/sahara.c
@@ -487,13 +487,13 @@ static int sahara_hw_descriptor_create(struct sahara_dev *dev)
 
 	ret = dma_map_sg(dev->device, dev->in_sg, dev->nb_in_sg,
 			 DMA_TO_DEVICE);
-	if (ret != dev->nb_in_sg) {
+	if (!ret) {
 		dev_err(dev->device, "couldn't map in sg\n");
 		goto unmap_in;
 	}
 	ret = dma_map_sg(dev->device, dev->out_sg, dev->nb_out_sg,
 			 DMA_FROM_DEVICE);
-	if (ret != dev->nb_out_sg) {
+	if (!ret) {
 		dev_err(dev->device, "couldn't map out sg\n");
 		goto unmap_out;
 	}
-- 
2.34.1

