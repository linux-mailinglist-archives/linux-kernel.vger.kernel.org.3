Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1ACD585913
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 10:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbiG3INK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiG3ING (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 04:13:06 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105A53ED6F;
        Sat, 30 Jul 2022 01:13:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ez10so11971408ejc.13;
        Sat, 30 Jul 2022 01:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HaIkTEML2/Uw1dJQ6HkKFPAniOMQ8pl6JjcKhaa8iHY=;
        b=cvRsUTffQLxDnzof/9PJuKrbd9YA5lX3n2Le75GSCMPhxc41hYTSKPoLhNk9EG7u6G
         WZ1ItHNY1PYt7kYXl14MmlmneMuh3FLRkfXvkmVeE4jgoLQ1jULhDLK8JHREWZkw5UcJ
         LCcI2AI04lL+B72HMXrrqwlwURjaVy10kuZyM7AJjmKNxJjtePkW8XpdPsiFEeaAFmTq
         UzOJ61AWHJUGGa6q3n4jcvn6jcq3iEzGwfkaRJlIGVp1Ac4g5wkjPKepoNa/t2mng6mx
         k6rhP9Lnwb+v7GL1+MymZI0P9ow/ZQtIA+q/o/nT9UkO5YXhXEbzWWv/ebB2uFytzvJE
         c4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HaIkTEML2/Uw1dJQ6HkKFPAniOMQ8pl6JjcKhaa8iHY=;
        b=Us3UT98le1LpkgcRpZGdf7o6ZVPbqh1/9ERg/AOu0TUodgFiv+r1+E9sRO7KG1tYRt
         U2i9v4XsgAYn6Faft+X5hZ+3076YymauazfLQemVJFGsIF35bJj0rUGeoa0ZHCogHSPO
         BAaZJKQlgxRddicP1EGK6oJ+SeSXYAavc96HJPKMVby4K6ePMXTp+mQvGz4N2Hvg9fnj
         PTOr/nhjEpEV5Kjg9aLk0m5pp4xHyQ1XD7iAsBh+bPd8irYqj1lzy1CLhP/78dJLf+Zo
         e+nqpTRrCtzWJ1eSHE2RsnCLm7Wbn6o7IdqQ0IPSBJejrdNcrn5DJiDq4DjHfciA4zxE
         0OXA==
X-Gm-Message-State: ACgBeo2etpj0mkt1PR4hkLxS0P2CVcfAtXFzFzc+RnTrkfy4+DXbfu0P
        73JoJoLI3sr1/RYdYg27dbg=
X-Google-Smtp-Source: AA6agR5/EZ8OQLb69UR35/gl3wbRuRTOuclXZVF3uz0YS4Rt8UUYAFw8Muk3IUawfrEG2/5YUwEnlA==
X-Received: by 2002:a17:906:98c8:b0:730:4fbd:1624 with SMTP id zd8-20020a17090698c800b007304fbd1624mr800985ejb.612.1659168784282;
        Sat, 30 Jul 2022 01:13:04 -0700 (PDT)
Received: from ainazi.fritz.box (p200300d09725550031ca3b9b629d79a8.dip0.t-ipconnect.de. [2003:d0:9725:5500:31ca:3b9b:629d:79a8])
        by smtp.gmail.com with ESMTPSA id s10-20020aa7c54a000000b0043d1eff72b3sm2199955edr.74.2022.07.30.01.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jul 2022 01:13:03 -0700 (PDT)
From:   Shinjo Park <peremen@gmail.com>
Cc:     peremen@gmail.com, David Heidelberg <david@ixit.cz>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ARM: dts: qcom: msm8960: change the device node of sleep_clk
Date:   Sat, 30 Jul 2022 10:12:32 +0200
Message-Id: <20220730081232.14181-1-peremen@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f0a4790d-7739-3bc5-b877-2dacbdb5158b@somainline.org>
References: <f0a4790d-7739-3bc5-b877-2dacbdb5158b@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the device node of sleep_clk to sleep-clk, and add a label. This
follows the similar convention as qcom-apq8064.dtsi.

Signed-off-by: Shinjo Park <peremen@gmail.com>
Reviewed-by: David Heidelberg <david@ixit.cz>
---

v2:
 - Rewrite commit message
 - Rename device node to not contain underscore

 arch/arm/boot/dts/qcom-msm8960.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-msm8960.dtsi b/arch/arm/boot/dts/qcom-msm8960.dtsi
index e8cd1c9c0924..e1f010c9643e 100644
--- a/arch/arm/boot/dts/qcom-msm8960.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8960.dtsi
@@ -71,7 +71,7 @@ pxo_board: pxo_board {
 			clock-output-names = "pxo_board";
 		};
 
-		sleep_clk {
+		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
-- 
2.34.1

