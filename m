Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164214EAFE6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiC2PJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238268AbiC2PJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:09:42 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643F61E95C5;
        Tue, 29 Mar 2022 08:07:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id p15so35762333ejc.7;
        Tue, 29 Mar 2022 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MYpKknBwdTIHXp3EH6GGOHhFZcaVOITrMZHNhkcAA1w=;
        b=nvWzwn6Kwi8lUvfA2/fNc5u28we559b8GN4u5QymfkMYMrxDtfJ+jWnolKFkHKy2O3
         //1hMuD92JZ24dYqmPyQs7cVtDVZiKyaNj8hDMNOG4RJpRKU1MDy0Xp4WpH8ZMbiBR1Y
         18IJNan6iOhYtugNMSGf6iqqDqsh1Ijl3G4uiARJ6yXFRLcRvrnTxAO4WXEuP57dyFHi
         0xiZAdhlf3EacOwB9VJSrNkCf6B5AhTMPsYiUsbp6FYHxb/smVg4a7HxvHJ70C8PmcEi
         SRyCWf/PI4JPMry08RerDroL5OhGpCIeLu7Wa0L4UAto1/E9lVXX1N0OcbKj4YjAC7AY
         /LRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MYpKknBwdTIHXp3EH6GGOHhFZcaVOITrMZHNhkcAA1w=;
        b=NhX5/oUPhXXSBP4RDgHONpWskw4ae45YTR2Z1Pz5hEcgnSqho5CIcVtrtlLAyjX7TO
         1kYEAHsztjY6+xgkRQ5ymSu15/V3GuBmmmppJB5p378EuUgxNGmwHbQn/mRLTAcqUGV7
         42PQvuLZwqZEJV7Cb3fwK8T0qf2gXLS6KufFfvwJmEL9AeuPv5QsW7QUEyHT755rOTl7
         J9AWl0EXmZuhijdTcSQfKexRzw4zDrEPWlBOpXHAp4HiwoxGXLlYK+MHoewX/yEfMW9M
         8fCZ5KpZ4kz5dqlU4Afx+eNijFhPB+UysVm22buJqwQ+Nw/RsPAK9JMzHyaDBNMcD3KE
         owmQ==
X-Gm-Message-State: AOAM530MsJSH6UdYeXQWlVhflQ2e01ScAj8wJTjrkbQJuEAsbn5EdgZY
        v382QduFIFhxzcMM8rOtVog=
X-Google-Smtp-Source: ABdhPJwnJgoYnTwOGYH2Z0mhJZWq0fYlCj1lQly4mmTbPKZEtCfU3cBVSnflbmJFd/H9M8NdARwTeg==
X-Received: by 2002:a17:906:6a1b:b0:6e0:b38b:f74c with SMTP id qw27-20020a1709066a1b00b006e0b38bf74cmr25710711ejc.46.1648566475860;
        Tue, 29 Mar 2022 08:07:55 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id eq7-20020a056402298700b00419d8d46a8asm3261643edb.39.2022.03.29.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:07:55 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] arm64: dts: rockchip: rk3399: use generic node name for pmucru
Date:   Tue, 29 Mar 2022 17:07:41 +0200
Message-Id: <20220329150742.22093-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220329150742.22093-1-jbx6244@gmail.com>
References: <20220329150742.22093-1-jbx6244@gmail.com>
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

The node names should be generic, so fix this for the rk3399 pmucru node
and rename it to "clock-controller".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 88f26d89e..01c08a2aa 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1413,7 +1413,7 @@
 		clock-names = "apb_pclk";
 	};
 
-	pmucru: pmu-clock-controller@ff750000 {
+	pmucru: clock-controller@ff750000 {
 		compatible = "rockchip,rk3399-pmucru";
 		reg = <0x0 0xff750000 0x0 0x1000>;
 		rockchip,grf = <&pmugrf>;
-- 
2.20.1

