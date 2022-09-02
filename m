Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6A85AB5F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237672AbiIBP4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237537AbiIBPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:55:05 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CE82A975
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:49:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n17so2848475wrm.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Fd4lSn+qZVzeO4qkwAmVHFeGiK8e6ML8+dOEILHHB/4=;
        b=XiV//UgpdOLwA5FX375zPaEh5uHJ95nETjCvXbD5RHNoziJSjUVMvjX/7MheUFKdWv
         4XgQiHLoK4mKo3DGKbgTviuYGki+Ffli7yUjOCk/N49S8VmaYIR0xjrNLxzInk2JWXak
         Zy8Qg8jHarHXavYlIz322H9E5ylJpOxb58uypOxaJq6H8cX0V6PlIb5vY6OsqxSRbK5n
         Bp4bOztqwMZJo5Xv2fJlJ1JLRwaKsuIWPnqo7UIDgiX87KVFSHRxBdKPbD4lLxLXhY3E
         FXFGhq3shhVEEpKrTQS4SgbT5mRbThwkJULLBeD4i0UTaeUAmySXaoJZExEDvmuFW9UG
         MVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Fd4lSn+qZVzeO4qkwAmVHFeGiK8e6ML8+dOEILHHB/4=;
        b=QuRxXXxkuqptmuZKfw01+DWVKFdQ2wUk0uU37P+YJkvLfWXoVwGrjkfmLr9kB/jSkK
         yefH84qDDCngMw8936xw7K51X/DNGVoAi7NDkpD5DzsonFw+4A10FLxLigCU14XpNeSq
         BMoG21gMMB2ZElXba8Gyiz5aryvB9VZZb7ojJ9W6bnXQXXoJ7I+BPlaSe/yETd+lSOBY
         813E8pugICUeOzPFJEvhr0R1sp+k9AvX6CQpui9MdQsFFDrwUffnndmwS2SagWRCM7ux
         bPodXKwgjDP9cIUFf+0etYRdbVxif8aU8B6tRJiuRRQQhw/cHgGJW70ieh25T3fU0+OB
         cIow==
X-Gm-Message-State: ACgBeo1UhrMBDtUV76ctelewjFdnhUQsZBvND4V/rDhCb6n3DxS9whlO
        ihEncwTcdylkMeyffpYSqq2zdA==
X-Google-Smtp-Source: AA6agR5G+03+f8b9dEBvjINXiGpiy8LUXZ+MRQyPsER25T7sdZv7lh1PrW+WhiXD62s+5ONKcoJMJw==
X-Received: by 2002:adf:d1c2:0:b0:226:fa44:bab7 with SMTP id b2-20020adfd1c2000000b00226fa44bab7mr4552046wrd.195.1662133764174;
        Fri, 02 Sep 2022 08:49:24 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600010c100b002250f9abdefsm2046741wrx.117.2022.09.02.08.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:49:23 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ekansh Gupta <quic_ekagupt@quicinc.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v2 02/10] misc: fastrpc: Add reserved mem support
Date:   Fri,  2 Sep 2022 18:48:52 +0300
Message-Id: <20220902154900.3404524-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902154900.3404524-1-abel.vesa@linaro.org>
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reserved mem support is needed for CMA heap support, which will be
used by AUDIOPD.

Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/misc/fastrpc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 8d803ee33904..52271f51800d 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/qcom_scm.h>
 #include <uapi/misc/fastrpc.h>
+#include <linux/of_reserved_mem.h>
 
 #define ADSP_DOMAIN_ID (0)
 #define MDSP_DOMAIN_ID (1)
@@ -2064,6 +2065,9 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 		return -EINVAL;
 	}
 
+	if (of_reserved_mem_device_init_by_idx(rdev, rdev->of_node, 0))
+		dev_info(rdev, "no reserved DMA memory for FASTRPC\n");
+
 	vmcount = of_property_read_variable_u32_array(rdev->of_node,
 				"qcom,vmids", &vmids[0], 0, FASTRPC_MAX_VMIDS);
 	if (vmcount < 0)
-- 
2.34.1

