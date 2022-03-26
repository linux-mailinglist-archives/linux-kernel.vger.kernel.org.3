Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6E4E8191
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 15:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233431AbiCZOpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 10:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiCZOpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 10:45:12 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBA620E942;
        Sat, 26 Mar 2022 07:43:34 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id g8so8114671qke.2;
        Sat, 26 Mar 2022 07:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVMBwba+OFGRWQLxhmJNkbLVJBAIF3Hcu3hVj+hPIDU=;
        b=FniufBSCFh+91j1tpQbTWPp8uemvOlCHmjXSXLtwwlllmSJZinICj9WIcDaJg/xx24
         eWOcnNkO5xGyB9yKf85d+2EjF1pdUeldMgzyD0hAW9QVGP7sJBQHICjxLH6qClFEXs80
         k/K68QOUerpigmnLyPLKk6vHDfMwoTbQsfbtVbb8AJz1JkvrHVTNU2CysV3xJ7tLSO6Y
         Fw0q5K8KBNNFWFIVJblHZmBbQAQTKyAIiysLSy1j1596lMrEayK3hVF1KQUZh75YTA3H
         BmQlqJPHz+pZmE+QGMCzto5Il8THsOCGr4KOY3wYqKuHXvHQGL31UojtQ9OoJactgGAC
         9Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVMBwba+OFGRWQLxhmJNkbLVJBAIF3Hcu3hVj+hPIDU=;
        b=DdUjV8g3YAGs9enedA3prhcwgI0AXMcuN+VhFgY4jdlb9U+QZX0J32Qnd2Uazef38U
         yc8FLabCSEVceNDKKDOEmHmA1AU4MLql7P8XGF0i9yzp1sejGeDLPw5mdnat0EuKpCkz
         vFuvU3if4iMbJMe0G5Yq7E0D3tXyRXv8xrMUN+Js6B3MtqItaiKFrbyTBOy49QKkiHDP
         hDYSXvw+zj24ZSsmefW48Y50EtiHcKjth22Hdz/03zix66a3PH5u1UTd9OG8k2XwUOZT
         V25B5sPm4sJpOJaVLyrdWB2ciDqAFFlLvPputCmaduBJOqzCGLl+rRMlg8SZQy7tKsgv
         5hrg==
X-Gm-Message-State: AOAM530GsEcpHaY27DJS4S5hVcImg9Pj72M7jgacuDLWABKXr3uOxof7
        tUAtEmku9CrpL3Ly1oma09Y=
X-Google-Smtp-Source: ABdhPJxoO0y4Sx6UvlWtKljSwWMgKXTv+3rXp+vP1+NOfQ21036bAjvNWvhasa3Dnc/U8OYO1uTHFw==
X-Received: by 2002:a05:620a:199b:b0:67e:ce80:e414 with SMTP id bm27-20020a05620a199b00b0067ece80e414mr10522894qkb.209.1648305813727;
        Sat, 26 Mar 2022 07:43:33 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id 70-20020a370649000000b0067b4cd8ffbasm4908918qkg.60.2022.03.26.07.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 07:43:32 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v1 05/12] ARM: mach-imx: Add support for i.MXRT1170
Date:   Sat, 26 Mar 2022 10:43:06 -0400
Message-Id: <20220326144313.673549-6-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
References: <20220326144313.673549-1-Mr.Bossman075@gmail.com>
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

Add "fsl,imxrt1170" to imxrt_compat

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
 arch/arm/mach-imx/mach-imxrt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/mach-imxrt.c b/arch/arm/mach-imx/mach-imxrt.c
index 2063a3059c84..0070214feb42 100644
--- a/arch/arm/mach-imx/mach-imxrt.c
+++ b/arch/arm/mach-imx/mach-imxrt.c
@@ -10,6 +10,7 @@
 
 static const char *const imxrt_compat[] __initconst = {
 	"fsl,imxrt1050",
+	"fsl,imxrt1170",
 	NULL
 };
 
-- 
2.34.1

