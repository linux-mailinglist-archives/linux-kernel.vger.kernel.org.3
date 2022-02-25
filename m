Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11954C4A64
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242780AbiBYQSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:18:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242788AbiBYQS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:18:26 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D321EAD1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:17:52 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id t11so7034867ioi.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxmQ2SPW8vIpZXI+C7y1LPYYljU/FZQdxhiSd4nteEE=;
        b=nd5+6GuoSVy/CnCSsiicvc7SE8av31Xtq8uGa/jv8LgI0QGQeBgIdOeuKynmSvbklD
         T+/PQ4KRENFcC84sOGs3hgp5wufjzYKzGy2j5+3hl9TIc+jVmEQOik8IAKsMvpkdgxLy
         KN1ZHuOhkyqHshLqW+QYFCzo4g/Q3KWMwEoSHNN/YQ9VI6p8jsTPSQ5JCJ4nLNUSDnY8
         7mkMiUc9y5YCnvMeGBf/tqWoiwcZ20NTkm5iBxp+VLVlHhY2CD13V/jbqh92AACj10TO
         wwU3dxcojq5oZqD84nz1NcjEftddoVA7a+u2DB8KaECt4RGXT1OlQft92Zo2LEtYXm2O
         rblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BxmQ2SPW8vIpZXI+C7y1LPYYljU/FZQdxhiSd4nteEE=;
        b=W8fHuOK2TC4c2/QtX8VwGb2N6fPI+vzjFOn68aUBbtNfTR8iyUTDfFkxE5Yi+Pfavp
         2cJ1hsY/sNPU7MAhOtuGXOonBX79IXlu1G9ikA478LW5eiKPpMkQPrC2FhZfkelfygUV
         yYOijm4WEEsdKWiROIvIMwnzrtrqP+cUbZY1khY2ICA+XqvtZIfNcD9/O6iDZ0np+bfU
         fwV6qInbwlHww6N5ZLk2hZe3N6SqcER2CcW8Ra/V6LAqBZkl69pFEH5n4KP2wfCDI1hs
         fKFIw2o9gG8omgsJGZNIJjtZ5y+kgGJlqp8xBu9EUvJ1DIfxBeSCPxNzE5feJuxwWIHv
         T0xA==
X-Gm-Message-State: AOAM531DuWc6BKzcMY90JcE9fqzCR2CWuRLBK2HkegHqC/s9RfPJMVnh
        otf9st8bGYgTzbuSdzx5iII=
X-Google-Smtp-Source: ABdhPJwSp6IXoNCgZs8r3RMMnUj6+cAERAjy+foY7d2psuExz/mlUcLViGmUZJe9z5wg39iJhYkDqA==
X-Received: by 2002:a05:6602:1616:b0:641:6dbd:502d with SMTP id x22-20020a056602161600b006416dbd502dmr6016005iow.195.1645805871627;
        Fri, 25 Feb 2022 08:17:51 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:5b80:a4b8:a089:497a])
        by smtp.gmail.com with ESMTPSA id v2-20020a92c802000000b002c1ed616004sm1852132iln.82.2022.02.25.08.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 08:17:50 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Adam Ford <aford173@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx: imx8m-blk-ctrl: Fix IMX8MN_DISPBLK_PD_ISI hang
Date:   Fri, 25 Feb 2022 10:17:41 -0600
Message-Id: <20220225161741.395505-1-aford173@gmail.com>
X-Mailer: git-send-email 2.34.1
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

When attempting to communicate with the ISI, the system hangs.
Through trial and error, it appears removing the two root clocks
fixes the issues.  Since IMX8MN_DISPBLK_PD_ISI enables the
pgc_dispmix, and pgc_dispmix enables those same root clocks, it should be
safe.

Fixes: 7f511d514e8c ("soc: imx: imx8m-blk-ctrl: add i.MX8MN DISP blk-ctrl")
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 122f9c884b38..cacf379aef80 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -574,9 +574,8 @@ static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[]
 	},
 	[IMX8MN_DISPBLK_PD_ISI] = {
 		.name = "dispblk-isi",
-		.clk_names = (const char *[]){ "disp_axi", "disp_apb", "disp_axi_root",
-						"disp_apb_root"},
-		.num_clks = 4,
+		.clk_names = (const char *[]){ "disp_axi", "disp_apb" },
+		.num_clks = 2,
 		.gpc_name = "isi",
 		.rst_mask = BIT(6) | BIT(7),
 		.clk_mask = BIT(6) | BIT(7),
-- 
2.34.1

