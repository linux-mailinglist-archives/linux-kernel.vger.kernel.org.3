Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D940451EA0C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447035AbiEGUef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447022AbiEGUdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:33:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402F42656F;
        Sat,  7 May 2022 13:30:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ks9so13705187ejb.2;
        Sat, 07 May 2022 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IhLu74thlxvdtZ6PoXv16+RYMNbrfvW/XJPO9PzMT/w=;
        b=JFsvwzcqD+FK0GuRDTTZXjf0V3Y2jdm+6u0rAJXx1W03SngQiS7eN32lsEBChVRSsT
         PJWYyhIbZDqDLizcepjMNDZiJR90N3ZUTFntBiB3YNQDeBKJLboAY8PJpq4CvXGwnMXG
         j3e0lP8MhvXxbNKdjyB0HgAhQzESWMkdHkeyfPzZxN/TPVN9XGECz/iQR4a2Y9UC9m1v
         g8tC2CAGMvjqkfqyCqmOdXDkbwWcrFdmYD30q/XbAboSUXAIBXty6uK7qgsBgQ4A12g+
         5Pu00SEb+nIQPaauJuGFhjZjRFZ1cvK5wnHpUEvPkzlVX5nT95pzCXtiPddyPXmZk0Ve
         0c0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IhLu74thlxvdtZ6PoXv16+RYMNbrfvW/XJPO9PzMT/w=;
        b=blEZlBjXPUGgDc19vlh10aU6/fbetw+UOl9apuQnfIML8iHSVccqe56VncY7oZtLrt
         GXLlpll/kNqusNrh4Cp8j+/NBjVRzpTcQUdca5eLkmLXx9KHzlFxzXfHJb9kQImhiRWj
         cERZnxIaN2PkZOdv5xXDF2KdpCmNF8cv8ILTok4dyeoFD6tsvP5zfyRlwvv/MsXhyaQ4
         3+N3t4TQ/o66E7DXiCuFjUxYQZ3r8eqtUm980m1Pbyt3rgBFJuAfHYNj38C2MDmUDFoy
         kG6BSBVLHEbon/YL68ZoNLnk2KmbqBZQYqRE+hVMfYUKfDStnVr5KnyZDUN6y0ETbsJJ
         gpKQ==
X-Gm-Message-State: AOAM533/5ijVKPzBujE8UrFdAGrFm3UYtgqjY+fHfxK+p7lGF0oh8Kod
        eTVaIvn9tjYb/11Tkdqn5mY=
X-Google-Smtp-Source: ABdhPJw+6Xl7Du6p1ZntvzqiNpRRIPhTla8diTbyzwTWsm6GzNMDDQBr3WRzJeOka5GsV8IVSwQgWg==
X-Received: by 2002:a17:907:8a14:b0:6f4:4365:dc07 with SMTP id sc20-20020a1709078a1400b006f44365dc07mr8144857ejc.693.1651955403461;
        Sat, 07 May 2022 13:30:03 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id k11-20020a056402048b00b0042617ba6383sm3900777edv.13.2022.05.07.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:30:03 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 08/11] dt-bindings: clock: qcom: ipq8074: add USB GDSCs
Date:   Sat,  7 May 2022 22:29:45 +0200
Message-Id: <20220507202948.397271-8-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507202948.397271-1-robimarko@gmail.com>
References: <20220507202948.397271-1-robimarko@gmail.com>
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

Add bindings for the USB GDSCs found in IPQ8074 GCC.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 include/dt-bindings/clock/qcom,gcc-ipq8074.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq8074.h b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
index 5f0928785d7a..e4991d303708 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq8074.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
@@ -368,4 +368,7 @@
 #define GCC_PCIE1_AXI_MASTER_STICKY_ARES	130
 #define GCC_PCIE0_AXI_SLAVE_STICKY_ARES		131
 
+#define USB0_GDSC				0
+#define USB1_GDSC				1
+
 #endif
-- 
2.35.1

