Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC95AB5EF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237657AbiIBP4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237534AbiIBPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:55:05 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72B133A2E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 08:49:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u17so2856120wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 08:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=drLF7rfbGFyvXeY1M1WJL6CSV1JIiJp9EbWQRGL1rFU=;
        b=L4zK3wUsOSYWO2D6udR3jh53vvOUpkrY72t8pY2Inain5vBUzHRmCuk6TqgV41wEFc
         NKmSOlvvZFCnlW5uqwOcMVVFxUY9G4DMSggUHdyLZTV/Y4Hcg7xld6pt3muuI4+6Miyd
         gMtDzY3akBcj5CDkx9uqquZOr98wJk7wS6fJzr1kCjracINbB967usKKCz28X+uE4v4m
         R0CQNKkqE9JxZR+XUNaInP8vbEnM6B1twKJpKlkOKJd28X9Q0qrQftc0VHzRrUpUslx7
         Iqb9tW+PpcDsfiU70vyoLlZ5trqDn053ODgxyNb8KgmHMr1/h9J5AVUpbYvolckt46ki
         qIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=drLF7rfbGFyvXeY1M1WJL6CSV1JIiJp9EbWQRGL1rFU=;
        b=R023FYSwdbkAoWss2AvmT6Osl3oUz3JDlfRjKTPxp7o3k2e0kXih7sREYd/no74eJs
         JG8ISDLI9okkLeHQv1jFdD68dEKxV5Z2GHHtRDPgGPH0znZML6IiYieJhauIpVcpO8pU
         ZM+THc6AbZhlX1TzNBqDtgtULlSvNxVZKctHj2dms49bJdgamhbgCexca44EV196btXm
         4DWoKwrr1rx9gsn4rA4h00oCN2or4WBdCuqQcIxIBNMtPgbODJUdHc1JT2BESFwpMrC8
         7fRBd97Hu1/YCnfnYjmwJWjhnOQa7kof7gpA7naXLkL4e2KZNm3tT4QNtFIclvt9oGdc
         ia6A==
X-Gm-Message-State: ACgBeo1EbyCueUCA1x2+e4hKWX4zniku9Mmbis+TR0zZQGyopJOk/uDa
        t5/zCcrSd2EI86WqXcsniRWGLg==
X-Google-Smtp-Source: AA6agR4Yzu+PZZQwSvEdh8nFN3CVVRDlQxTSDV0CEoalg6Hjtc2AfwoRDOy0C85kPxN5NBLq19yzcg==
X-Received: by 2002:adf:dc83:0:b0:225:738e:bb54 with SMTP id r3-20020adfdc83000000b00225738ebb54mr18670591wrj.513.1662133766207;
        Fri, 02 Sep 2022 08:49:26 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id b1-20020a05600010c100b002250f9abdefsm2046741wrx.117.2022.09.02.08.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 08:49:25 -0700 (PDT)
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
Subject: [PATCH v2 03/10] dt-bindings: misc: fastrpc: Document memory-region property
Date:   Fri,  2 Sep 2022 18:48:53 +0300
Message-Id: <20220902154900.3404524-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220902154900.3404524-1-abel.vesa@linaro.org>
References: <20220902154900.3404524-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add memory-region property to the list of optional properties, specify
the value type and a definition

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
index 5ec124b138a6..3dd02aaa7ba7 100644
--- a/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
+++ b/Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
@@ -17,6 +17,11 @@ other tasks.
 	Definition: should specify the dsp domain name this fastrpc
 	corresponds to. must be one of this: "adsp", "mdsp", "sdsp", "cdsp"
 
+- memory-region:
+	Usage: optional
+	Value type: <phandle>
+	Definition: reference to the reserved-memory for the region
+
 - qcom,non-secure-domain:
 	Usage: required
 	Value type: <boolean>
-- 
2.34.1

