Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211314E80B7
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 13:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbiCZMLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 08:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbiCZML3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 08:11:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B408B62A1E;
        Sat, 26 Mar 2022 05:09:51 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c62so11906633edf.5;
        Sat, 26 Mar 2022 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M61AFRbLUdMV7oXCOaCCHm47RW/KqcD8CWFb8D1XXr8=;
        b=OjI0mWSkh8IF18F/TSsJ8MJss9uNPfHXlbT1L61y23JeWnLf2gAJCMA7VsFeGKVXx/
         kouG/ev3S77WOrCw2HAnmKAVgFOWnawYlFbbIsH4DOmTtb50+DfTgxCNs3po2rx+gWCL
         tZv8w6uJOSkH+iq7F2o9zwUU00c1Ghw8ASeERc6XfqqLBxfWBYHpUDHuexfxotmoR8Mo
         jyXGT1jtq+wanQ6Aw7wikR//M+kyJ3cN07GVbAtUqAnAFaO02hIVEP4tYq60W3+SiAfh
         s/xMKKNwntvuqRLMwMf2f1jiRMw+2vOoVtehrD/XERWsagWg3w0bZhmMaYfnMcgHSxFM
         36vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M61AFRbLUdMV7oXCOaCCHm47RW/KqcD8CWFb8D1XXr8=;
        b=0jV9nSyM52Cc7RkIutK8MauRw4bsgCvhCzLI6JlQ5Ncrar4lBFhKQZM4BsU75SFmBl
         /mNrbfQLEECj9kkmpW8cH7RKrt9gCiK+wU4FjNmp1dSDtJDIfSNtzP2hKcTr2y+rhIXa
         Z1XqQmWbYpmtHVCLK8KLpN+JKIrYpvhrlNd/PJyXlN7xBiy+EuNcSl/1MFh/+zQj6VJr
         g9W4R05dfZDcC8bEOs4ybqmgED6RIyL+zsZZRdiDXZHNBGmfUc9rM4SlLixVG/thW7Ni
         Beqwgd5OUt+dr/iltYMUyNwacbHBZP1lFPyxt3Y6Yb8vZ6bdcU/p24z0lXqsnMMROWOP
         TW2g==
X-Gm-Message-State: AOAM531MI5yRiYmiHsZWzxh5gJLkw+EsDqFpu3KXIP+bMo5WYbgsLgBE
        UF995T26A/EokJ3sp0nemH0=
X-Google-Smtp-Source: ABdhPJxZ7fNDA9cRLndFfVEfAHwP3Hdtn2XRwJWm9oe/0TWDoVGrU/0hP95piDM/ll+gLVzl/M5M+w==
X-Received: by 2002:aa7:dbd6:0:b0:408:4a31:97a5 with SMTP id v22-20020aa7dbd6000000b004084a3197a5mr4159348edt.186.1648296589901;
        Sat, 26 Mar 2022 05:09:49 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cr19-20020a170906d55300b006df6b316e29sm3559920ejc.208.2022.03.26.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 05:09:49 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] ARM: dts: rockchip: add clocks property to cru node rk3288
Date:   Sat, 26 Mar 2022 13:09:42 +0100
Message-Id: <20220326120942.24008-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220326120942.24008-1-jbx6244@gmail.com>
References: <20220326120942.24008-1-jbx6244@gmail.com>
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

Add clocks property to rk3288 cru node to fix warnings like:
'clocks' is a dependency of 'assigned-clocks'.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 26b9bbe31..487b0e03d 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -862,6 +862,8 @@
 	cru: clock-controller@ff760000 {
 		compatible = "rockchip,rk3288-cru";
 		reg = <0x0 0xff760000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-- 
2.20.1

