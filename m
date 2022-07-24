Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97C757F650
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 20:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiGXSYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 14:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiGXSX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 14:23:57 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07020B7EC;
        Sun, 24 Jul 2022 11:23:57 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o17so2415465edi.13;
        Sun, 24 Jul 2022 11:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=oQyXUMIVAbLJ1EBHHoaawt/CVRSa2HlkUCUCvMvQHzykdIz4bEivASw7SC12BkhPMY
         fcAaft7Z5AwxI3mGMdww2nFrvAKIsjVi4FSDgaeO90pudPPn+Sw8hqKM0bZJYNgRdC/U
         DUBOF5NYPZQ+1AHGCLJtZKEyKxWzv20ITajRimMeRjgEZkWHkD0Zt+9TlQ5QwEFdFYKJ
         PEnMRP827ChYPQb50IdmQYixEBc1lJgOAtZpF+cgpbCngEi7qY3vGF2JS33d5NJBtuVJ
         zIDp//mnmYxSiic6vHigYs809lKlGF4aKxYVh9XsGm5aCaYjX3hdLZoaN4OTMfM4ikJN
         ewXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JSxzmKxjlNqM9TSDpV5dH/r3annlSczSnTdVT/KLPhw=;
        b=KEy3kHFth4rKrbtCAtRbf4B2KqY0zeHlrNtDcccwwEMug+hgDYtYrSECjTaHzjer3v
         YNiYpkm6+AB88pMzocEylmm6dtbghMtDJR/7Ovy4v8I6jIWzBTri/tZ2uYqD2KVN+iIY
         d6CeDp7xJYFtZbS8pZNsguCcBycGeLNhIhwxl3WrRLi8Pjc1TW0nwLpsn1bMsB69dStA
         Nt8G8cYJq2a/UdMy2of9mQxwa4rAQsrZVqdebchllFZIpi2/uSgnJQWK9PJwA3YEuBpM
         o4fSIWxXhsMY0aNKzm5ckUwmpqV8uazP0va2Ds5EwnX9TNTozmmze3l4RXXxV2oQWcVj
         w+vg==
X-Gm-Message-State: AJIora+xWvrnG15MIQUA7575Axr1jypPjhA3GEqXjfuloh8c4PB7kmNe
        3NUCPSj59znXrkA5FrTG0yc=
X-Google-Smtp-Source: AGRyM1t/68IJCJrHF9d56kGibJqeSwNyNFzzk6XXN4n52qIZNPZTArASZvuowttnthnhro5+p0D4oQ==
X-Received: by 2002:a05:6402:248f:b0:43a:b89c:20e3 with SMTP id q15-20020a056402248f00b0043ab89c20e3mr9956444eda.335.1658687035404;
        Sun, 24 Jul 2022 11:23:55 -0700 (PDT)
Received: from localhost.localdomain ([5.171.121.144])
        by smtp.googlemail.com with ESMTPSA id kw24-20020a170907771800b0072b609d9a36sm502680ejc.16.2022.07.24.11.23.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 11:23:55 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v7 1/4] dt-bindings: clock: add pcm reset for ipq806x lcc
Date:   Sun, 24 Jul 2022 20:23:26 +0200
Message-Id: <20220724182329.9891-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pcm reset define for ipq806x lcc.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
v3:
 - Added review tag
 - Added ack tag
v2:
 - Fix Sob tag

 include/dt-bindings/clock/qcom,lcc-ipq806x.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,lcc-ipq806x.h b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
index 25b92bbf0ab4..e0fb4acf4ba8 100644
--- a/include/dt-bindings/clock/qcom,lcc-ipq806x.h
+++ b/include/dt-bindings/clock/qcom,lcc-ipq806x.h
@@ -19,4 +19,6 @@
 #define SPDIF_CLK			10
 #define AHBIX_CLK			11
 
+#define LCC_PCM_RESET			0
+
 #endif
-- 
2.36.1

