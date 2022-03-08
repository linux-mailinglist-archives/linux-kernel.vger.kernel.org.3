Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918684D0E36
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 04:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiCHDN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 22:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240534AbiCHDNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 22:13:24 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EB81160;
        Mon,  7 Mar 2022 19:12:27 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id c11so2845093pgu.11;
        Mon, 07 Mar 2022 19:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=T4Ldh9wP6NrK55uA0+WDFo63kUJzzU3JlOSL2h2P1mk=;
        b=PDQt0K+4JI0d9CJfngLON56gnSZBseP33imtVIA1IINB0GjO2bpqdMaSsP5N3ge9vT
         pJLJsCWuKCEEzA44XZTqDlySXahQgCh1cvuaN+0QPWMoi7GBKgIqL6I9h1Dvf+ZDFUM9
         ImTTZ1DI+ipqKDy5PBhdQ24EaPsM0MYsCZbwgJGFDfMUqdZ+fpqwAyMlG8oWtP2xUVxs
         yoh+AIU8IuAkgnpBBEWPhr10WHVZiZqpbbulzPHytr+HhiN30FOEkbvMAI7gxRzM8Ip4
         xIQNTAh9n9JIiua9cU0aApWEiHmZWBpNc6hklNCsKnJsCmNGYRacdL+4Vgcebh4v6edN
         qy9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T4Ldh9wP6NrK55uA0+WDFo63kUJzzU3JlOSL2h2P1mk=;
        b=MgF/gCMIRSKnMLIZawHhIv+c3cLKRmuP70KB5pELH9/TV5b1d8fv8rQoPgtJjwjP7N
         mfRxg63IUwJC/02G4J1VtV7M34QY4fBi69kkTXzZjOAXK/Q/ES6dk/kZN8FAA/NwrwkH
         MUqIeNB7mJR+H5ZoEnrPa7mNecpkQYpbt5NYQYs61MRPaay4mAVMAw8kQges0gZAazGE
         xnYIABntUdGrqaYFNtCfuICpVYplnyahCtMXReu42U9PSYUXBo69RuC/PEtcjIUIy1WT
         cWcf1Yo9LkMpuvm50722b5ku26svjfSFmTQtNKvuPQSMTfE3x8otG03RBzZkIgH5iB3c
         d3DA==
X-Gm-Message-State: AOAM53021HJa8AtMYBh9biFuujt80neY0eafzPayTZloZe7MZLXCWD/x
        Kv2OYqgE+kBRmQBKyhlZZLY=
X-Google-Smtp-Source: ABdhPJw96EciYF9gDT4HQ7IT8e1ZtgTYP/ty/zMjL8Ml8IqRNfwzcDPsJul8Xt25SBl+X7u3zzKffw==
X-Received: by 2002:a63:e60:0:b0:374:6620:f372 with SMTP id 32-20020a630e60000000b003746620f372mr12423978pgo.557.1646709147212;
        Mon, 07 Mar 2022 19:12:27 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id bi29-20020a056a00311d00b004f6fa51e70dsm5445580pfb.196.2022.03.07.19.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 19:12:26 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] remoteproc: qcom: Fix missing of_node_put in adsp_alloc_memory_region
Date:   Tue,  8 Mar 2022 03:12:19 +0000
Message-Id: <20220308031219.4718-1-linmq006@gmail.com>
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

Fixes: dc160e449122 ("remoteproc: qcom: Introduce Non-PAS ADSP PIL driver")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/remoteproc/qcom_q6v5_adsp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
index 098362e6e233..7c02bc132247 100644
--- a/drivers/remoteproc/qcom_q6v5_adsp.c
+++ b/drivers/remoteproc/qcom_q6v5_adsp.c
@@ -408,6 +408,7 @@ static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
 	}
 
 	ret = of_address_to_resource(node, 0, &r);
+	of_node_put(node);
 	if (ret)
 		return ret;
 
-- 
2.17.1

