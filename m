Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE1C4D1074
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242080AbiCHGqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiCHGq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:46:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AD91DA7D;
        Mon,  7 Mar 2022 22:45:33 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id p17so16197024plo.9;
        Mon, 07 Mar 2022 22:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=RxoMYSVWqmKdTJ9JtZxsMZajUTLQ4tBXg5YP/DDb4Qs=;
        b=guDuy+HNA9f/hYhvPhgOheDOqUoGTyiT5QStRTuUBDVOD/VCQxwCZryvsnvfAmUuDD
         x51C4wGk/Fj+Y5gHJsflrgngh8hNvAPCrWh4pQop9M6kDcj9kH9NEJR441CE7/Z2gnAY
         f3sUUzQSbevw0XcClceiX1f0c7ENIWwtT32Lq5qWfk6kxq59mIHqO0klmg0b2wg0jK+j
         mGmpm+LkiWFJPgBHuewHM8YWXLYu4O4tFd69+Py4kbnX0nT+lBb8iySdXhSLLjXkFKsE
         Mb3FGRjKF6FXq6RURZyOpbYvFw+BZWnrIcYOlnOweIT6mVhcrjrv/IoWEIkcAedr3oE5
         CROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RxoMYSVWqmKdTJ9JtZxsMZajUTLQ4tBXg5YP/DDb4Qs=;
        b=Oxm5KrsLg4SAg4KgFU2yBltVwLLdkPk1fkUhGCw8eKsfvVpYRLZzSDiSHQ/B/MAWmW
         hm6URMsamavE0tHAKFZtAKIKyCSU+pNbZHqVLMCg+9dluQ50NxoeztZ4yoyzMXOXku0d
         oGIadsEzGumDX3bOToOXt0HOTHS/4G1P9391yW/I5/Eaa95uBVysN7w1xjfhwniQCBdZ
         ft13+jdQ16k7Z1v4VLyFriA2rVlgDvDes5q84H6uURQmjGQ2WKN9TEvXB2zbHh05kzLi
         u7XHflIWedeKpY7lElDrOtaFB8Z1i0UfUf0YL5dMCGbkcdrGnLsp5kVH7QU07KvXEgIo
         QHhg==
X-Gm-Message-State: AOAM531WSG6dsSgvEQuU0j1m+coPaOQnTuSXE5dbw0YcVJzgmw0fWbkn
        Yr/J2BWyIobWBrrFWzQlBRA=
X-Google-Smtp-Source: ABdhPJzfG6eeXFTCSWqiJrUR7GipPtdUYjT2+XZzYO/Bc+IA3X1B2aR1pueS3szetAYKMDMdo7sU6w==
X-Received: by 2002:a17:90b:4a11:b0:1bf:7fbe:258d with SMTP id kk17-20020a17090b4a1100b001bf7fbe258dmr3122331pjb.79.1646721932468;
        Mon, 07 Mar 2022 22:45:32 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id d16-20020a17090ad99000b001bcbc4247a0sm1438111pjv.57.2022.03.07.22.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:45:32 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tobias Jordan <Tobias.Jordan@elektrobit.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] remoteproc: qcom_q6v5_mss: Fix some leaks in q6v5_alloc_memory_region
Date:   Tue,  8 Mar 2022 06:45:21 +0000
Message-Id: <20220308064522.13804-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device_node pointer is returned by of_parse_phandle() or
of_get_child_by_name() with refcount incremented.
We should use of_node_put() on it when done.

This function only call of_node_put(node) when of_address_to_resource
succeeds, missing error cases.

Fixes: 278d744c46fd ("remoteproc: qcom: Fix potential device node leaks")
Fixes:  051fb70fd4ea ("remoteproc: qcom: Driver for the self-authenticating Hexagon v5")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_mss.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
index 43ea8455546c..cd220c64db92 100644
--- a/drivers/remoteproc/qcom_q6v5_mss.c
+++ b/drivers/remoteproc/qcom_q6v5_mss.c
@@ -1809,15 +1809,17 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 	if (!child)
 		node = of_parse_phandle(qproc->dev->of_node,
 					"memory-region", 0);
-	else
+	else {
 		node = of_parse_phandle(child, "memory-region", 0);
+		of_node_put(child);
+	}
 
 	ret = of_address_to_resource(node, 0, &r);
+	of_node_put(node);
 	if (ret) {
 		dev_err(qproc->dev, "unable to resolve mba region\n");
 		return ret;
 	}
-	of_node_put(node);
 
 	qproc->mba_phys = r.start;
 	qproc->mba_size = resource_size(&r);
@@ -1828,14 +1830,15 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 	} else {
 		child = of_get_child_by_name(qproc->dev->of_node, "mpss");
 		node = of_parse_phandle(child, "memory-region", 0);
+		of_node_put(child);
 	}
 
 	ret = of_address_to_resource(node, 0, &r);
+	of_node_put(node);
 	if (ret) {
 		dev_err(qproc->dev, "unable to resolve mpss region\n");
 		return ret;
 	}
-	of_node_put(node);
 
 	qproc->mpss_phys = qproc->mpss_reloc = r.start;
 	qproc->mpss_size = resource_size(&r);
-- 
2.17.1

