Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7507E50E81D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244356AbiDYS0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 14:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244352AbiDYS0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 14:26:12 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7B8112449;
        Mon, 25 Apr 2022 11:23:03 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so6217755edx.9;
        Mon, 25 Apr 2022 11:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqD7UOhZCtWdKNLvjvzBP8sV3y6BYgIA/pnNxZjz8oc=;
        b=gPvnxTLlvLR8cTTUXmjcl1R9wSZiNpgICF2IyBg6eezIoDI/QZb9sNe02E2peEg6Zl
         B4OZrlq5PScSUaMoLo74jDHXFO9P5DSsM0rXvHmCXzKnIYQsTv0pQj84XuNuknGd8O9E
         vuABKLEr52M7GWYi/eGoe6zcGsmOjazA/oQaoxhnJ3P703O/x4t+XERyO07eV2GMggNS
         amCewNSoN8rPp+57j7lQnAvqHrm74i2OvpxuaDnz+hWkRhQ/I1qmF9/cK5mHTqeYFHc9
         v6hJzKbQNaej4wMOR62pNNTCEL8582/iTpNUzZ4AiWU4nS7SXPo3tTTHHJkrT7jVb80a
         ymwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqD7UOhZCtWdKNLvjvzBP8sV3y6BYgIA/pnNxZjz8oc=;
        b=AhI19RttwrQgOsKXEn2oRwO1d0PcxsQ/FmW+obNfSwaxhQSHZ1Kl4SA/ME9RfQ2H0l
         JiuwIyE9SfGlsenz15iBUe/EC5PyuzlNeYGRHHci6+5xanykEBM8qALmGR5QUsOontZf
         1JhTQtTHw0JBB4phzGhfAXJgnWmkn6qD6oKX9OwlOAAs5go16SvZqbcpSIeS0PO3Gg3T
         o+n6fIEMOngQUc//VxQ5YvCdZMcDPbZhN6vuFD5xkO+FMkPVsYdys/r4JHjANjkVjI4q
         LOV9p17QCeZQJZuXsTULf82RLEth2Zk1xleyd4ASpuxI8j1RG1rMa3cpRimlaxAnYmS8
         fUHg==
X-Gm-Message-State: AOAM5308vpq9kn1mNsFbLc3QVzdfy7x70b6eHtrwOcKr/8GshXYohtwZ
        VFXL6JGLRevqft9Woehrtg/dSgH0/Rl21A==
X-Google-Smtp-Source: ABdhPJzVLO9S/2ivLHgLiR+ZbsKq/+AUaDHJSmuxinNEjlWRlLnYSk+IYmvc6LtVVr6jL/Du+x1tdw==
X-Received: by 2002:a05:6402:26c9:b0:423:d545:9d49 with SMTP id x9-20020a05640226c900b00423d5459d49mr20466407edd.242.1650910981728;
        Mon, 25 Apr 2022 11:23:01 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-91.zg.cable.xnet.hr. [94.253.165.91])
        by smtp.googlemail.com with ESMTPSA id h13-20020a170906590d00b006f39021e683sm1677210ejq.12.2022.04.25.11.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 11:23:01 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, absahu@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 6/7] dt-bindings: clock: qcom: ipq8074: add PPE crypto clock
Date:   Mon, 25 Apr 2022 20:22:48 +0200
Message-Id: <20220425182249.2753690-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220425182249.2753690-1-robimarko@gmail.com>
References: <20220425182249.2753690-1-robimarko@gmail.com>
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

Add binding for the PPE crypto clock in IPQ8074.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 include/dt-bindings/clock/qcom,gcc-ipq8074.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/clock/qcom,gcc-ipq8074.h b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
index 9b1c42bc430c..2197185cb1a2 100644
--- a/include/dt-bindings/clock/qcom,gcc-ipq8074.h
+++ b/include/dt-bindings/clock/qcom,gcc-ipq8074.h
@@ -233,6 +233,7 @@
 #define GCC_PCIE0_AXI_S_BRIDGE_CLK		224
 #define GCC_PCIE0_RCHNG_CLK_SRC			225
 #define GCC_PCIE0_RCHNG_CLK			226
+#define GCC_CRYPTO_PPE_CLK			227
 
 #define GCC_BLSP1_BCR				0
 #define GCC_BLSP1_QUP1_BCR			1
-- 
2.35.1

