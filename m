Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6FE474F82
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbhLOAsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238649AbhLOAqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:53 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BD9C06173F;
        Tue, 14 Dec 2021 16:46:52 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id 14so27235784ioe.2;
        Tue, 14 Dec 2021 16:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=axIDnhUCkWSyZC2JXX7WkB/QvAyzEWjElXHQg9cULuY=;
        b=NzBd6tcqjscgGqumypnEK50e1Cu2lbZbKd8M76+j9S2SDr3kSQkfO7XK91gV2QBzYE
         HFnuLS2L011T+Pk4mN5FuADSVuySFleUARNAwljyE9bEdTEAEK0gcqC9yWE3XPLxpKzb
         nj51C6PqIOejc1YuG0pR8JZAwQffmy96ssU07qv8TcI2VOPTObvJ5gu+nL45ckOusfe2
         SNlvYT2Pj8nRByPLefnETxjnqPXQse3d4w9qM1TUxJiqv/2MqGiVaqxVuchPnXtMs749
         BziYoUfYKqy3HphUr0E8S4DLwZhI3iM6ICw46eva66rKwAAJpbJGLCJLXf27cpnw9G38
         Z5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=axIDnhUCkWSyZC2JXX7WkB/QvAyzEWjElXHQg9cULuY=;
        b=0gdzFea3IjZt2LtLt1+JtTFAmS3lETkgQFyv3uBXydnt4gLbv5npmYNBY3NCEEvuFP
         XGr6QX6+WOH5fio3m9kpYHzT9tq0MLKA7aDlH+dExL0D592JwzOS63P6acQxWDsXc3ha
         uQNA3gfjQQMP2YhO5DrnuQpG/Rvdyp4afxfr3WEAKTCPl4WE3WW0i6+ThqLIHVCmwBDj
         P1rrGPEQBzZccVR6FYj3wvkbRRVQJgC5yykBVaZC3jkeuKr0yoQdUYe/BDOdCfCo9PyY
         YepZWbKdBa+SMeYCgFyZcg2HCOOhNG0fubaqwDa2yzGrTUDs5PXF2jsXIXAHEnkfQYOz
         zbIw==
X-Gm-Message-State: AOAM531zajFqypoWJ/t2thi1pIwWrz0Bf9cl8WRSQe/h+ZZs0xEIMWtH
        WGYkTODYgxSZeTJQYahH1dg=
X-Google-Smtp-Source: ABdhPJzHwsDEVF/pnRxKCzGJBEm9+inO3MtiEh3C5kBKVGSgtz/WjmwMhhGTE1PVmh5cZLoXAlkaKQ==
X-Received: by 2002:a05:6638:408b:: with SMTP id m11mr4568287jam.186.1639529212024;
        Tue, 14 Dec 2021 16:46:52 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:51 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 7/9] arm64: dts: imx8mn: put USB controller into power-domains
Date:   Tue, 14 Dec 2021 18:46:24 -0600
Message-Id: <20211215004626.2241839-8-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have support for the power domain controller on the i.MX8MN,
we can put the USB controller in the respective power domain to allow
it to power down the PHY when possible.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index 52bf32be994f..5d851420254b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -1048,6 +1048,7 @@ usbotg1: usb@32e40000 {
 				assigned-clock-parents = <&clk IMX8MN_SYS_PLL2_500M>;
 				phys = <&usbphynop1>;
 				fsl,usbmisc = <&usbmisc1 0>;
+				power-domains = <&pgc_otg1>;
 				status = "disabled";
 			};
 
-- 
2.32.0

