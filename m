Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9651246DEAD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240947AbhLHWyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240911AbhLHWy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:54:27 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51684C061746;
        Wed,  8 Dec 2021 14:50:55 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id m9so4670576iop.0;
        Wed, 08 Dec 2021 14:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrNumwISLUpkzDEc0TVgaptJcWoPniM3pmiYzi2RbfE=;
        b=Fj6VpvXikYeBpUY3sac3yJ39RVxk5IUonJwvZgE62hZzJh1g8rF1GAOIhXAWaSkfiE
         XmJlE0U6MQJ1fG17Nfa8iqI+RmfFhq7IzckfnyQJJVvGJRhFtobH7ZnL9N8cN5/51k1g
         Xt4QA95/53ihaR8NBmcrYngNnoKhVZsxJJHCO6uFsCr+5WkxjgHDOQxW56G9K0FRn5Xx
         8UH/gsESc/zJi+ObAZ1Bd9ujFD0uTC4gyI7jw72C/b47isugWCc3OsWbK+PAUqD6DZiI
         ZvXHF+1hkgxNORUBJTNz1eb4Nma4dfz6C8dS5yssc0IQco2UE+8dyUUGlEj92s+hmD5h
         4BEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrNumwISLUpkzDEc0TVgaptJcWoPniM3pmiYzi2RbfE=;
        b=a5bURRrWOxZaclC7agrFWFLZltQgYq31+lhsC+miCWRPOIy3gurNauHKJe975plSd6
         U3pyvFF2Wushfq8ZUIp/i1HWXeCVYxN+MTJvrAgUOsNXFZH+WQMPS713er6CV/bDm7DQ
         YZoBddQH2lo2dG6lo6I79y0jQElw7C4w90+NW2cHd9P3FyvGosKlGjhOjaPwnkIztZ5i
         4yWJcAodbxOistIeFKOrZ3ra/OjaFZf4mDlSL7yIn3p6GiW7M7IYSfH5g9eCqiqeJD9S
         ha6ATRtCDWVNDgPO2dNewgL8wB+CCJSR8OclYEMD7Ge4pk7BqELJsx394EqcKo/BoqW6
         uUVA==
X-Gm-Message-State: AOAM533wQsYWY5reBLD8zhv1hHHGQPRESn2Z59KZxVOTSoFl87uEP/cf
        MaiJ54FoEQf79SpDCe7V6EMiTOn8KRbUOQ==
X-Google-Smtp-Source: ABdhPJy3Fw9s3P+tqSX21rd0Q8PHUJ8JDm/ujxjgd6QaaXBU9HU3PzKf3iIs1q8oTPSXKUJpcKLmdQ==
X-Received: by 2002:a05:6638:d46:: with SMTP id d6mr3444633jak.129.1639003854249;
        Wed, 08 Dec 2021 14:50:54 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:269a:1aa2:f1d9:8dbb])
        by smtp.gmail.com with ESMTPSA id t6sm2378751ioi.51.2021.12.08.14.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 14:50:53 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
        aford@beaconembedded.com, nicolas@ndufresne.ca,
        Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 07/10] arm64: dts: imx8mm: Fix VPU Hanging
Date:   Wed,  8 Dec 2021 16:50:26 -0600
Message-Id: <20211208225030.2018923-8-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211208225030.2018923-1-aford173@gmail.com>
References: <20211208225030.2018923-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vpumix power domain has a reset assigned to it, however
when used, it causes a system hang.  Testing has shown that
it does not appear to be needed anywhere.

Fixes: d39d4bb15310 ("arm64: dts: imx8mm: add GPC node")
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index c2f3f118f82e..f13d31ebfcbd 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -681,7 +681,6 @@ pgc_vpumix: power-domain@6 {
 						clocks = <&clk IMX8MM_CLK_VPU_DEC_ROOT>;
 						assigned-clocks = <&clk IMX8MM_CLK_VPU_BUS>;
 						assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_800M>;
-						resets = <&src IMX8MQ_RESET_VPU_RESET>;
 					};
 
 					pgc_vpu_g1: power-domain@7 {
-- 
2.32.0

