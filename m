Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0DD53E1E5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiFFGnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 02:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiFFGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 02:43:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E754D10F;
        Sun,  5 Jun 2022 23:43:04 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id a10so12049031pju.3;
        Sun, 05 Jun 2022 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/odkAunXuydx8EZQ5BMPOU7ibi1xgMt6s0TczS8ym3U=;
        b=mQh1Srjv0FcsW3VOBnKPKRd/O9+GeRU8xTK3apsur2wAbIyIVJtcC/RHZPnL6eD67E
         loTbN86zES+T6xq15oqVuqKzVEH0TOHIE8y7i2B532unWnucWR0ukZvo3PFYZPOsEi+0
         SSOY0jrWIkyKZ4225Hqjz+OE9edWZM1Pp10944mxiVFi4n6NoEuMB6qCfLVSMdHSaY6P
         6p3Vx4qKLfw932f5Av6LrJ80j6xlJhDzKkShzHZr/RdDo2zvoCVQQAiFl6KUUm/0UYzZ
         mCKs033EYadAqyVBTYUszMc1S+/htTLZYjwkk7BM/an7RFdefGI8JEvw1wbCmT46JJ/L
         lCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/odkAunXuydx8EZQ5BMPOU7ibi1xgMt6s0TczS8ym3U=;
        b=iPfWE2gfD6blzVkz9ZwJL7OB0ie0BWNHdzO/2sgVCVCeVuOdIFdWfcBPxTSmK+HgW/
         Px135K6zA4YI4O3+eaMNP6LYet3tDOe+/LHq9vgdImlenF3K2eyv5hyebyuVfjTj4f8U
         E6VQYzdGeflZI7yguMhDSY9ptHYqhrYWjI8UsFxELtoJPYjpl7OGfxypHIVEOS/XfrKz
         //m+fN3FN6ZZ8SMjuLE7BqK7ujLY4Accq5W2HzfSMa36xIPSs6fr3G5wLrWwZxkU2zpx
         dVhJGRyZhy+49ZELF5wPu8UyI9kPUlgdZlfPCvrPCGUyRWueATBooktrfZDalQOdT31E
         NKIQ==
X-Gm-Message-State: AOAM53132gnKzSsQgaGYs+ykjGFE+0KpkaMQuV+quzy/AdU0RynAeCQT
        a0M04bj8n9IEEdvJg3jw+/4=
X-Google-Smtp-Source: ABdhPJz0aC7CTMDzPXVuMeG8HP070bLO7Mrv5GjdhBhFQmglv8ky4/K3y6Q0YMn9f1B7li0mSmk8Hg==
X-Received: by 2002:a17:90b:3b4b:b0:1e8:434c:5ab1 with SMTP id ot11-20020a17090b3b4b00b001e8434c5ab1mr15161795pjb.129.1654497783262;
        Sun, 05 Jun 2022 23:43:03 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id v9-20020a17090a0e0900b001e2ebcce5d5sm9250343pje.37.2022.06.05.23.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 23:43:02 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: qcom: aoss: Fix refcount leak in qmp_cooling_devices_register
Date:   Mon,  6 Jun 2022 10:42:52 +0400
Message-Id: <20220606064252.42595-1-linmq006@gmail.com>
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

Every iteration of for_each_available_child_of_node() decrements
the reference count of the previous node.
When breaking early from a for_each_available_child_of_node() loop,
we need to explicitly call of_node_put() on the child node.
Add missing of_node_put() to avoid refcount leak.

Fixes: 05589b30b21a ("soc: qcom: Extend AOSS QMP driver to support resources that are used to wake up the SoC.")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/qcom/qcom_aoss.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
index a59bb34e5eba..18c856056475 100644
--- a/drivers/soc/qcom/qcom_aoss.c
+++ b/drivers/soc/qcom/qcom_aoss.c
@@ -399,8 +399,10 @@ static int qmp_cooling_devices_register(struct qmp *qmp)
 			continue;
 		ret = qmp_cooling_device_add(qmp, &qmp->cooling_devs[count++],
 					     child);
-		if (ret)
+		if (ret) {
+			of_node_put(child);
 			goto unroll;
+		}
 	}
 
 	if (!count)
-- 
2.25.1

