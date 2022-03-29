Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFCB4EB2A1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 19:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbiC2RXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 13:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbiC2RXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 13:23:12 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFD121547E;
        Tue, 29 Mar 2022 10:21:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qa43so36489021ejc.12;
        Tue, 29 Mar 2022 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qre6Vt0QXEHJoUrJyLYRkmAZzTcsk9d55fusii4auUE=;
        b=OiVbNmNqgh7FknQiabRAfUo785zvcvAqFpksoKBUdH1qa6PEj/jM5us8RWTGQIfOBb
         AMWInWfn6JF5I9beIXy+2YpY3oFtFix2U5qEqi+sIaSBCyshJOu3mcUoRuQRbvkgfnae
         tLqDxRvgyeGnZSVcGYIMybtV7LEmIqCsE8cQjDDFr8VZzhhH73+wEdJj7OlUUzi3glqc
         HJnHT1XA4lb7+aJlp87C+QaQbF/WYC9/tNluYcXYhe+ueozIPRbX2Py7nUQoQK040YO6
         UvwITM0thybsywWuQA5xNagmCx0mRgdwoQ+QZHZVAm8HGNTdIYhzM6N+VXNCImHsxU+i
         UAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qre6Vt0QXEHJoUrJyLYRkmAZzTcsk9d55fusii4auUE=;
        b=QfGlLjNR1Vf90uYuF6vG/hHIbJlthUAKRp7GpV8Eif3UJr1gQvzihdrGV/pAStobpT
         dw5q74iYfqevat+WG2QCuNp+ESj1+3XlEYZ89mR+45FX+tUOJO1vJ123xDFaZirDKGqq
         8rBQGkIiV7yNqZebdQQnNksk33IRBIzeXHyqdvqMnVanubxx96t0xOzPuIKd5t3dhqiu
         jmjSqHEkbl4YoXUMsRQTJ3+GBblx9Qxnem+4NRQ/AtRYlzGifX5ySTH7v8hhewALjIN+
         Zj5VBFApoLeml/GR/FubkBmYsTfNvMFOAk89SdUJ8J0TONF66rx7OL3539JTtIFhpNpv
         lFRA==
X-Gm-Message-State: AOAM531oYBGUQ5YfGyDUeTNlqqXHvfNDEANYRAQ+MNihoWwRwKzoR8jG
        0NLiMunVg23pPrBy3h5fEoU=
X-Google-Smtp-Source: ABdhPJzy7vYrXGn3YQ6LfVt6hEyN25kBTXuv1sG55bQRrDHJPr3wJKVyg5dJkgiol/OonXj2Sk0b/g==
X-Received: by 2002:a17:907:168a:b0:6da:9177:9fdd with SMTP id hc10-20020a170907168a00b006da91779fddmr35634465ejc.757.1648574487675;
        Tue, 29 Mar 2022 10:21:27 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm8707089edu.11.2022.03.29.10.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 10:21:27 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: rockchip: add clocks property to cru node rk3368
Date:   Tue, 29 Mar 2022 19:21:20 +0200
Message-Id: <20220329172120.30328-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329172120.30328-1-jbx6244@gmail.com>
References: <20220329172120.30328-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks property to rk3368 cru node in case someone wants to
add properties that start with assign-xxx to fix warnings like:
'clocks' is a dependency of 'assigned-clocks'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index c99da9032..4f0b5feaa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -747,6 +747,8 @@
 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3368-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1

