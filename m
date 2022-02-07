Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951674ABF2A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 14:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383564AbiBGNNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 08:13:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448050AbiBGNKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9BA3C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644239402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=V7oC2IbMHxE4ZqZeJwr6Nf58KNDsnfkfT9BMAGpj22k=;
        b=h6lS8Fz4cNwT4AsCAA3RCB1f876IjS2LU4EzXGLDnWeemb3pKyMXudGAGbpRKi+6qkObbO
        OzAhBemRBIBLqeVSWC4LB7oQiU3ZkA1OJL0BtRgkjbm8DcQ+WfNAafs2l6LRWcd/DwgT4o
        QIYNKmaHGaf6h2S8XtdVnT5Zn9apF1M=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-237-vLXFKbqlMRuCElNfrA9OyA-1; Mon, 07 Feb 2022 08:10:01 -0500
X-MC-Unique: vLXFKbqlMRuCElNfrA9OyA-1
Received: by mail-qk1-f198.google.com with SMTP id t79-20020a37aa52000000b0047ebe27cb48so8499829qke.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 05:10:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=V7oC2IbMHxE4ZqZeJwr6Nf58KNDsnfkfT9BMAGpj22k=;
        b=xbxBeMYXbIdUsMO14dtT/zeTFLUv6Fk2OBjuKYLMGhM36nLBg8OqZdWtOdzcNY9J1u
         V/WRu5crqdVav0K6MJn2ORzHdRWDrLd2/atkdW0EvB7DXm698xTsjp+MdVudwGqbuCg8
         x/IIs9hhMDFkLrUWjheeXrn5ykEmtS2ItOyzdgVmBOq2Srv8hXkAKsJ+OKbs8vb2S/83
         jJ4C3mVZAnzTQoVr7tyASnGql8xjUCa6SoLthRz6aNcnfC7xroI/9jm5go9cNspKku0K
         Z/dv4t0NXbhh8K7T+NnqAdg4gPksdvuMS0cd3xIizw8w0C8qkn33BjWWGZxihmc0kTaA
         LdjQ==
X-Gm-Message-State: AOAM531iEUXobrOCQ2Kh+hOdcenqyX3xI7ONPGrr8YmvnOQMnIgt84ZR
        T2ltT7juX0ZxrKcAwq1a5E/z5RCF+NEWlZ0/tYaMQwOIkd3eCOIKm2jeCJlLdmphSV4yeT4KIJ3
        RysAdajd9H0NG6e+NrHSxGJjj
X-Received: by 2002:a05:622a:15d2:: with SMTP id d18mr7677802qty.627.1644239401252;
        Mon, 07 Feb 2022 05:10:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy+Acrc8l3BriTnb/PGx/7S9Rqo1TwqYskoIJ3XUtcvnqkF1igAg71HbsgBsm352B5BsBWvPg==
X-Received: by 2002:a05:622a:15d2:: with SMTP id d18mr7677790qty.627.1644239401106;
        Mon, 07 Feb 2022 05:10:01 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id x3sm2937241qkp.54.2022.02.07.05.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:10:00 -0800 (PST)
From:   trix@redhat.com
To:     thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] soc/tegra: bpmp: cleanup double word in comment
Date:   Mon,  7 Feb 2022 05:09:51 -0800
Message-Id: <20220207130951.2059795-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'or'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/soc/tegra/bpmp-abi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
index bff99f23860c3..53171e324d1ce 100644
--- a/include/soc/tegra/bpmp-abi.h
+++ b/include/soc/tegra/bpmp-abi.h
@@ -931,7 +931,7 @@ enum mrq_reset_commands {
  * @brief Request with MRQ_RESET
  *
  * Used by the sender of an #MRQ_RESET message to request BPMP to
- * assert or or deassert a given reset line.
+ * assert or deassert a given reset line.
  */
 struct mrq_reset_request {
 	/** @brief Reset action to perform (@ref mrq_reset_commands) */
-- 
2.26.3

