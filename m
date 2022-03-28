Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487304E9FB3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 21:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245563AbiC1TV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 15:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244720AbiC1TVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 15:21:55 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9595DE4E;
        Mon, 28 Mar 2022 12:20:14 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b13so11762221pfv.0;
        Mon, 28 Mar 2022 12:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GJEJWucPHfNfh0owOSh1kHfEuPNtGB0oLcBX/58o8qM=;
        b=JP/IsseErt3A3GaLZ07OVojIgAwMlkKQXJbU0k6teFguY4PSuv5O56wntHbS7cQX8M
         ygcQ6cP8WIS0Oe2g9kgoYbVhd8a6t3rkAW349ZzBJVb/5xDkScINNk6VtNUf4fFLXf7l
         MOKxSppY//7Wm1FNURCk/MdfjSzRBSxBZkg7bZT8DxtUeOp1w8uP/24JIM16Bn1fw7bh
         8sLIsZi+o3DMg0VPJZwvau0LqCUve5dgtRttgqoVqmmpzUdQv0+o+C9eszP9egtXRt9X
         UH6I5aTsqmQ4QwCY0uw/FSHFWrv2FpMv6+o+sUda7CtYZp7bITnlqF1nE+ypDgwRqjof
         nexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GJEJWucPHfNfh0owOSh1kHfEuPNtGB0oLcBX/58o8qM=;
        b=mj+VxfjPN6MKQgobI8EM6U1wj+BhrVTvRxnWrkwE0nt8w4OwaHM4z9I6IitusGDmMg
         W3GzgfRwIY7gbn+LofPfKzObY6/BdR7EsldqP5exGwqRbJqdVPTWeb6rrPTpuSuwXPKM
         iDYtHEJ+9QoP6i7S67WXE728IMyhROzjakclx8sqoxh23dA74qAVB9HmawAsKSO4JVk2
         KEb6XijqAXRUykw8YZHDTATnyoHqJPVQlfz/YHGpX+7S4FxY5H6jLchAunJxfzYxi57H
         dPqDfheWB4aHu+aDNkQjn7x/KYvz5gG4kzL5oXYq1QcO4q5eyXq9lnZ5PXQtiDTFj9Nw
         KC/Q==
X-Gm-Message-State: AOAM533WPk0Lhlyt5KaEm9GsI/DeMUXO4HVsaoEh2JlvKHL6Z8WM8ikS
        wyLG6/jOEXrHFCBlF8ytZljMrPAzk/U=
X-Google-Smtp-Source: ABdhPJwR9Pf/sSAf0tS1ztVneZEH22dR8Gn749LLOhJ7HmycSZ5LiQpEf7U7uAqx2SXRA97/1JMA+Q==
X-Received: by 2002:a65:56cb:0:b0:378:82ed:d74 with SMTP id w11-20020a6556cb000000b0037882ed0d74mr11408905pgs.491.1648495213750;
        Mon, 28 Mar 2022 12:20:13 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id nn7-20020a17090b38c700b001c9ba103530sm265339pjb.48.2022.03.28.12.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 12:20:13 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Mukesh Savaliya <msavaliy@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: spi: qcom-qspi: Add minItems to interconnect-names
Date:   Tue, 29 Mar 2022 00:50:06 +0530
Message-Id: <20220328192006.18523-1-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add minItems constraint to interconnect-names as well. The schema
currently tries to match 2 names and fail for DTs with single entry.

With the change applied, below interconnect-names values are possible:
['qspi-config'], ['qspi-config', 'qspi-memory']

Fixes: 8f9c291558ea ("dt-bindings: spi: Add interconnect binding for QSPI")
Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v2:
- Reword commit description

 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
index 055524fe8327..116f3746c1e6 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
@@ -49,6 +49,7 @@ properties:
     maxItems: 2
 
   interconnect-names:
+    minItems: 1
     items:
       - const: qspi-config
       - const: qspi-memory
-- 
2.25.1

