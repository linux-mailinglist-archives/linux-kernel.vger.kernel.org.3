Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D60B4D104D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiCHGcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237589AbiCHGcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:32:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 921193C731;
        Mon,  7 Mar 2022 22:31:09 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id 9so16177069pll.6;
        Mon, 07 Mar 2022 22:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zPzSRXxZk2VC9jWykSmXu8LF33ueEsQ/fABYAzEXDDI=;
        b=KMJeSAAKr3pqDe84nYoboqzx6SSUVoC6Ne8MLR03OGjLd7bbDk5BCdqkiEpD3OKBz5
         9Jmov3apkDOAHs3pdNu2U4MJKXam7ynjz8Y6smRCFyjW36RiaaOZajxV1UuKMpc18ynf
         jVYwwjc2bBlIGXusgVv/UolUpggiDoD3No/d7v5WLDRbOhtvObXbWq/d4rccE9ZsRh0B
         6ROaBKS3B+oBKG//yNtjzKuHvjM9KuUxfKsnvtHv54SIiWIAIsm3LRbd6hRKZ60c6kwK
         ZNAgoJq1lfOPtt6M1BN422aMu5fkk+gCPvg2ARP8kw/Fq4vKe7IOGnR+bkPebY1UCfdM
         MooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zPzSRXxZk2VC9jWykSmXu8LF33ueEsQ/fABYAzEXDDI=;
        b=sqOXmRcueFxM35lzWkJneYdvB0YBO0Ga85B3pUn0SQ54N0vtzYx4doMPrfKsE3BR32
         6xdJFEPjdpgbYy5gI2VMFAp6a/SbrX9CaceE4X0EGvB8mD4RtyXJaSrSELMUTIYQPO+U
         RYAFuUdjQ3l4weocq1i71qAOJfja4a5/adVTKFUksdxsMpoxmrxqZf1g7qNmIb3taaPB
         2XmPsSgVDsOYDaEc2hUYYQZV+ZO3WHToF264hVmdZy8fzCKt+WdxNiqyQrO+o3Ug+JY+
         IU3DwEvveVXdYoLbxZSbv4GyrMOwxeDHyv2D1S7htcpn47CUkY1YfpT6NNP03KMXMb2f
         YLsg==
X-Gm-Message-State: AOAM533oe3V2kUY/DiZk9zcH9kyyIBmPm89RW1ylK5VhfRRmIYgHx1lU
        nxJNnUaKhoQmHvZxzNNT7Ck=
X-Google-Smtp-Source: ABdhPJxZFsbiWC5NfKH9m8ycoR+aWyya1YCHYsR7qW1MIa3wLSL+XVDCjWig3pm6OBo6+FL2eBF4wA==
X-Received: by 2002:a17:902:d4c9:b0:151:e99e:48b with SMTP id o9-20020a170902d4c900b00151e99e048bmr9077659plg.165.1646721069060;
        Mon, 07 Mar 2022 22:31:09 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id j13-20020a63594d000000b003639cf2f9c7sm13915809pgm.71.2022.03.07.22.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:31:08 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] remoteproc: qcom_wcnss: Add missing of_node_put() in wcnss_alloc_memory_region
Date:   Tue,  8 Mar 2022 06:31:02 +0000
Message-Id: <20220308063102.10049-1-linmq006@gmail.com>
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

The device_node pointer is returned by of_parse_phandle()  with refcount
incremented. We should use of_node_put() on it when done.

Fixes: aed361adca9f ("remoteproc: qcom: Introduce WCNSS peripheral image loader")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/remoteproc/qcom_wcnss.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
index 80bbafee9846..9a223d394087 100644
--- a/drivers/remoteproc/qcom_wcnss.c
+++ b/drivers/remoteproc/qcom_wcnss.c
@@ -500,6 +500,7 @@ static int wcnss_alloc_memory_region(struct qcom_wcnss *wcnss)
 	}
 
 	ret = of_address_to_resource(node, 0, &r);
+	of_node_put(node);
 	if (ret)
 		return ret;
 
-- 
2.17.1

