Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 948DD4EB39E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 20:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiC2Spf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 14:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240643AbiC2Spd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 14:45:33 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A97E595;
        Tue, 29 Mar 2022 11:43:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id x34so21707700ede.8;
        Tue, 29 Mar 2022 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xBJkwvNeki5PfTqOsvfJ8a7WGcSaDHdZIXo5PFl9ZH4=;
        b=Fh+hp3c9C56wxdRXyU/NFIsIQjB5m67Zkizv52Y6yu4n8bg7nWzMMIg2fGM0Y4alnn
         KxbxZqTc9BYKE1IDQrQjujvTv/4adFFCrpFPT8oq6Ou9IqqiNs2u8aPQY6PhflBxrGnz
         0na83mlgrmzHeNCw6AaehTXklkDtbO9uAljp1XyRDJkRUa7e6rjC5wJi8PzE6DGVt72D
         zNpf9nq94iB7Ulmqbz1rn639u/YnVWavAj7wBxVd2SEt2UZkG5cj0xpB6apRnC5fhe22
         75SdMFI0NER9HpiZO0GXG9f6pKkdTHeIDapwWHEQ1OU+eD3fPxorrQ761X5M40La5j7P
         hsUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xBJkwvNeki5PfTqOsvfJ8a7WGcSaDHdZIXo5PFl9ZH4=;
        b=QsJHgUPmOw3EqDK88xD9S1RKAwANJI6HmjX2VB9NOxlGapLUeqw2X7V8uHodPzh/WJ
         Wmp/bf9yuYH5ZoBbgzdz29sr3mH87hrB7j9CgZXFXSe1hZ6tHmS1CRsIwct/PeeNMwNi
         qe+cT3SClMZa89vDBkM4vmSmmwP2qJ6hRIlf72e84TOjflH5kLg5krG184El7HKEkYC/
         hymd+Q+kiJLXUmC5Ls1q7QvVtHuVrHR2YH2lGywfbpVXlpnxI5WjaaugBDawo68eQ400
         OEgsydaSqduk5YUDnEKSCQlZO9xNUI//aWb9Qid5Yj3uiOmNja454xAlsF4p7N49ftHx
         ISAA==
X-Gm-Message-State: AOAM530tza6mssgYYkG0rFszAa5iiWlyKgGn5HkVLmD+E4aKPTRx280J
        mgTQq8SV30ZzCyr11673A0w=
X-Google-Smtp-Source: ABdhPJyrlb3mvXOJgIqbuaQuQYalBaoCxOz4mvbsmiTDPBplEVYFMP3StxTyydNuVperBtbUNHBuhQ==
X-Received: by 2002:aa7:c748:0:b0:418:f0fb:83a1 with SMTP id c8-20020aa7c748000000b00418f0fb83a1mr6395176eds.350.1648579428630;
        Tue, 29 Mar 2022 11:43:48 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z12-20020a17090674cc00b006df9afdda91sm7138714ejl.185.2022.03.29.11.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 11:43:48 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] arm64: rockchip: add clocks property to cru node rk3308
Date:   Tue, 29 Mar 2022 20:43:39 +0200
Message-Id: <20220329184339.1134-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329184339.1134-1-jbx6244@gmail.com>
References: <20220329184339.1134-1-jbx6244@gmail.com>
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

Add clocks and clock-names to the rk3308 cru node, because
the device has to have at least one input clock.
Also in case someone wants to add properties that start with
assign-xxx to fix warnings like:
'clocks' is a dependency of 'assigned-clocks'
With the addition of new properties also sort the node properties
a little bit.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 1cbe21261..2dfa67f1c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -745,10 +745,11 @@
 	cru: clock-controller@ff500000 {
 		compatible = "rockchip,rk3308-cru";
 		reg = <0x0 0xff500000 0x0 0x1000>;
+		clocks = <&xin24m>;
+		clock-names = "xin24m";
+		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-		rockchip,grf = <&grf>;
-
 		assigned-clocks = <&cru SCLK_RTC32K>;
 		assigned-clock-rates = <32768>;
 	};
-- 
2.20.1

