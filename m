Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9064ACB49
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbiBGV2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239535AbiBGV2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:28:41 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A66C061A73;
        Mon,  7 Feb 2022 13:28:39 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id bx31so21680282ljb.0;
        Mon, 07 Feb 2022 13:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fc7LGrlHAZDYrBuSru9+9ktilHwf1q6a8VpFHoydzeY=;
        b=RjnpxJmOQ3Yl96FT+6GGJEHHKO/BC6bB/Kg9ocFLeXF9JbDAXlvRXUFs5Lr3lFxZHv
         U53mcXmiR/KH21mGciDAJR7sDmPKuDMTVOkQpXMdYCQ0pz790y0Mi6EIpi0SFtUaZQKF
         MYvkblW6YXjMDejP87vf+SMxjSCTey3ckzO5KVWXuAXY+uQEGw4obEjjwFZomHSovxnn
         LBws+mdr8gVOFFUvXGfExbaycqpvi3GNrFT9FWG9x1/QMUZbLNGRu0OLdTnjvo3hdv7m
         byJXhd9STxcw8zsUBbZnQ2cUQZ3PJEfwNdwESv2sEYXayhCnq2LTWI5+lX0ik0D1iHvo
         DKIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fc7LGrlHAZDYrBuSru9+9ktilHwf1q6a8VpFHoydzeY=;
        b=UhZLwHMHZuaeE9xhDlm7mU4UbpDnS5L5krwiUhc0G0siuHqlwURMzAdqbraWs0OpBC
         hz1GYkbZu5HW++yxeW/eVsuynhDs995Gk82Cf6qE4J7I1sXvzuU416h+FrQ/HEJ5IFYq
         rlGWxHhquCW/pyK6PVYm/hBXnmz8JmcnZ2+CWRgh8e8VE5QVBUqoyvaXNzUsZjd8pps4
         wxU6E1XjghQeSfUgLVaSUBDslKS42waWu42VjUiN0TeW3YlijJN/6UxMY4BYAJXw6lW2
         MrWZfB7WYs+0Z7Gp7d4IBx2195crPYyLRoaC/O9rfat9fxpcYcLdmEiG4p6/iMybx3Cn
         5kTg==
X-Gm-Message-State: AOAM530TE3KbEfToDqYWozIEMSO7Vnlu+MchbafDDvnakwKtwDAk6wpu
        8eo1PNYCoxPSKon8svzVWOk=
X-Google-Smtp-Source: ABdhPJxC24uxUihysBcLEcyWbkzB43B1EDdpkLbBlQuGkqZ3/FpGkwwVdM76BMG6c/Pr89/JgL/PFg==
X-Received: by 2002:a2e:9953:: with SMTP id r19mr877682ljj.37.1644269317750;
        Mon, 07 Feb 2022 13:28:37 -0800 (PST)
Received: from localhost.localdomain (109-252-138-165.dynamic.spd-mgts.ru. [109.252.138.165])
        by smtp.gmail.com with ESMTPSA id i3sm1650867lfj.144.2022.02.07.13.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:28:37 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Robert Eckelmann <longnoserob@gmail.com>,
        Agneli <poczt@protonmail.ch>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] ARM: tegra: asus-tf101: Enable S/PDIF and HDMI audio
Date:   Tue,  8 Feb 2022 00:28:23 +0300
Message-Id: <20220207212826.10307-2-digetx@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207212826.10307-1-digetx@gmail.com>
References: <20220207212826.10307-1-digetx@gmail.com>
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

Enable S/PDIF controller to enable HDMI audio support on ASUS TF101.
Use nvidia,fixed-parent-rate property that prevents audio rate conflict
between S/PDIF and I2S.

Tested-by: Robert Eckelmann <longnoserob@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index 020172ee7340..68b0fdb89aa6 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -436,8 +436,16 @@ pta {
 		};
 	};
 
+	spdif@70002400 {
+		status = "okay";
+
+		nvidia,fixed-parent-rate;
+	};
+
 	i2s@70002800 {
 		status = "okay";
+
+		nvidia,fixed-parent-rate;
 	};
 
 	serial@70006040 {
-- 
2.34.1

