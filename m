Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 874F04D10D2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 08:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344558AbiCHHUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 02:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236167AbiCHHUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 02:20:44 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93FFB3388C;
        Mon,  7 Mar 2022 23:19:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso1451605pjj.2;
        Mon, 07 Mar 2022 23:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=bJptSTi3wmq/WALdzNGbJYlN+KScQWUjoq18Pv8tDiM=;
        b=jjjgESX7uvjSVyCZ8NiQZY0kwOKy+J9yOdX/rvYBDs9FLhAgYYqVd/TTT60/uQQ+HG
         wF/HHCXT9bssGgTFwv4BZJZWdhzgJJ3SmMVZdX5lmxWNEH9PYH85keqWP/bnG0OrKxBz
         tEAPcEqOoEasjkkCcOaNBIjyu1gEynMN2KCjU2pOTjInt8tVhhjNZ1tptWYyr/stUtGp
         i9iA2UPNXqi9h5nL4wFcDbdiDXKp91cYYvLu4IzjW6uOZA9sVRHoRO1lVhhvQmEgaukL
         hwEyp8XDCvEbyty8afUGzJT4WPFEmiZ5I6mNxDNOapBaK7NNj9StiPSHcMCsNVVuQ3kd
         yX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bJptSTi3wmq/WALdzNGbJYlN+KScQWUjoq18Pv8tDiM=;
        b=D26p9tf2DUjYYAEHuPxA92+n3IXyzkIYWcuvy0vmIwXnN4ErnzF0RTaiXeM5yBkjC8
         Ru99HYHUtnYCeDSsxFEROwIueKtOJ8SK11tPUir4DbZKp5zGVGWXvFkOXD2LbgeMbaIf
         8EIpEcz/L/GnqAo3adKdaGMDqirFJt4EZRqQ+6hbRbbE83v3/+Cl3DNXTzdcdCkz/M7t
         i059WBZ8kwRGLpvoOM1luDok/KdWWBZZIz/kXygAxbTUH9CbIUwG5UKA+Rc3KjGgPjpU
         HBKtmIebYVF4iPLQtrPMe5pQw/IKcE6whJ+FmtkeOKmtHdoOMaQ/Z9wlhhtxpDTKYrE6
         ISjg==
X-Gm-Message-State: AOAM531fGLKs+IOn2Z6TZzs9dZns8N7Exjli7nSrMclbDTBw62Sv6nxr
        Yj6IPeamquU85dFAKl5WQaA=
X-Google-Smtp-Source: ABdhPJwic/5X6Aj/5QFUbR3EEe+k6Ko1+rwsSWCiCmrkpbGqSul1OfxO812Q5UglKvvWj2NO7v6FNw==
X-Received: by 2002:a17:902:8491:b0:14e:dad4:5ce5 with SMTP id c17-20020a170902849100b0014edad45ce5mr15909670plo.76.1646723988083;
        Mon, 07 Mar 2022 23:19:48 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a0b9700b001b8f602eaeasm1600590pjr.53.2022.03.07.23.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 23:19:47 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] soc: qcom: smp2p: Fix missing of_node_put() in smp2p_parse_ipc
Date:   Tue,  8 Mar 2022 07:19:42 +0000
Message-Id: <20220308071942.22942-1-linmq006@gmail.com>
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

Fixes: 50e99641413e ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/soc/qcom/smp2p.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index 4a157240f419..59dbf4b61e6c 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -493,6 +493,7 @@ static int smp2p_parse_ipc(struct qcom_smp2p *smp2p)
 	}
 
 	smp2p->ipc_regmap = syscon_node_to_regmap(syscon);
+	of_node_put(syscon);
 	if (IS_ERR(smp2p->ipc_regmap))
 		return PTR_ERR(smp2p->ipc_regmap);
 
-- 
2.17.1

