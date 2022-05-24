Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04300532459
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 09:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbiEXHpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 03:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiEXHp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 03:45:27 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23BE74DF7;
        Tue, 24 May 2022 00:45:26 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id bo5so15765622pfb.4;
        Tue, 24 May 2022 00:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WE8ECtKBbnGRy9b4snuHYoLN1QU8z6Hzzxc9CUtUoTc=;
        b=Xy7izo/V1daPixmOFDL9+o47bqTLCqXVmkJpwdW6Bu6aZ1GdGV0Uv2jH200W7X4L2t
         HbhCOI17YL5VKsc4eM+n+KwdFpCC6r4TMru8Y8GRN8mBoruJ0s+hqc2e8hikHtEO674V
         4ur4SQy8yiNry+WUnwgf3xs3k0hLh/+ysXaLGblXH+ZMto44ebbOFCee3ot/62ets94W
         CPLbI9rHKUawzEVj1b74cB07nPJtSMEaPtjtynu3f2qHIUC7JkcrW5bgO+qzR03/rTK0
         LU8iPucnab9r6bzSz+VlRFttw7YoCW7O37aPLU/PRThG/RXb4V/WgdEpGoPvQ3iQv1dz
         a73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WE8ECtKBbnGRy9b4snuHYoLN1QU8z6Hzzxc9CUtUoTc=;
        b=FfMuycEXvD1Zx0JmD7aaTRS/WAC++pm7AZGO7Lcod9JARplQiUVo5gAFi9FxCohMiA
         qpjkOH1v+HC5AMRajp2LYX4qWwNxK9bPhjV03yYZoHLasPJDTyzMDD5CXr7egb7gWbQj
         ll2oi5Z7EN/sHhUwr/HtN5a3bXjjvcyKep5W+ty1nPL+Fqi1YFsGUqyjsjazBcaizPgk
         XUMDpVj1EtlfE5kBuR3JDdhPJ/gJJZ3sSzjp6iuua5WNyCJMdTtTqcoTCINwzQhLZSta
         h6xWJhzLvfwl6XVDEbZPmeRhUkuNz8l14l6MwUwV0H07rWtPMIMAqWsdvKDI9r4C82a5
         MOQA==
X-Gm-Message-State: AOAM530w/xTiV9u/aBlpvwpMTlIBSZ4ObwtYI090eHX0sIPRa1zzYfK3
        B9kl0XgbmEM3QqL9RmP3wK0=
X-Google-Smtp-Source: ABdhPJzDd6wR58FdjkqushS/72CayCU1FIViGtU12UpYsxM/6WUfeQMyNvdxKwcO3wsxeL4MLPO2Hw==
X-Received: by 2002:a63:f921:0:b0:3f2:6c2f:a166 with SMTP id h33-20020a63f921000000b003f26c2fa166mr23506883pgi.124.1653378326143;
        Tue, 24 May 2022 00:45:26 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id f20-20020a17090ace1400b001deb3cbd8f1sm990983pju.27.2022.05.24.00.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 00:45:25 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] iio: adc: adi-axi-adc: Fix refcount leak in adi_axi_adc_attach_client
Date:   Tue, 24 May 2022 11:45:17 +0400
Message-Id: <20220524074517.45268-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: ef04070692a2 ("iio: adc: adi-axi-adc: add support for AXI ADC IP core")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iio/adc/adi-axi-adc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index a73e3c2d212f..a9e655e69eaa 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -322,16 +322,19 @@ static struct adi_axi_adc_client *adi_axi_adc_attach_client(struct device *dev)
 
 		if (!try_module_get(cl->dev->driver->owner)) {
 			mutex_unlock(&registered_clients_lock);
+			of_node_put(cln);
 			return ERR_PTR(-ENODEV);
 		}
 
 		get_device(cl->dev);
 		cl->info = info;
 		mutex_unlock(&registered_clients_lock);
+		of_node_put(cln);
 		return cl;
 	}
 
 	mutex_unlock(&registered_clients_lock);
+	of_node_put(cln);
 
 	return ERR_PTR(-EPROBE_DEFER);
 }
-- 
2.25.1

