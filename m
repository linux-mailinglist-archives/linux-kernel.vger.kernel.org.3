Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5E1529826
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237283AbiEQD2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiEQD2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:28:16 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201803FBE4;
        Mon, 16 May 2022 20:28:16 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id hh4so13495736qtb.10;
        Mon, 16 May 2022 20:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PdMLJHGeYL3BkhQ1IKPvlOorpUAGvppwW+eNkTKAgQY=;
        b=epVeU20/PWITUh/PnZQO4gV6FOnPwRd3wuGGCHycYRbslbbSXVxdItsjxJJS5FoCDY
         m/Q4JfToGoRu9DGDMz9Khxn/QfnB9ap8f8DSUEiRs46YOazpmedmJv6d+UYYCxBfGdEi
         TICDdsa/yw4Ph5BLLQqNxnTL/mFwPzlKuyyAem+WI1mRSwi7Ac1DygQdMYjQ1rM0fwpV
         Nvl6JH+K66D4GbEoqtuhcp4gDoPZpQBcrQn8A/D6625KiuBbb716dRQd6f23nt2wAyml
         tRdyDNA4YgAKrbRMr7BLUGpUr8FJDfRq+PTIHF8BSBD1O548zVggFEdp0Mt5mfpDt4NI
         oTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PdMLJHGeYL3BkhQ1IKPvlOorpUAGvppwW+eNkTKAgQY=;
        b=wpAoHocFEiCp2WJPUiztGhfYx40pKkXobv3pTqNzArcKTkYiaGD8cvUPbqalywrg2U
         APEMGMQYXV/XDv4DXNWszQsbGDvhy/gnchQYBDODs+JJoF3Bkmwr2fgncLTMOMc/5DIr
         xxxt6xyijDYxB9ViKraVIMKOFFtzP9JuOjtW6h1KFKvLK33UUi8X9Y2c4J5OjDAVX9rp
         BhINe6MmkE49AjBe7N/LY+Los98eqmaoLGKRVelMr975l+99mjoOEsDhDsiDvAtHu9un
         1poNRSGhHCv8Jn7r1gfuEcpEgPPQHmgPv3IHZwod5R1Xd3wmbbVQyRBwFMLhzNyIlrju
         wAfw==
X-Gm-Message-State: AOAM530ZEUvhkWd0lYXYCRfU5c+bpoxOLhYv1EQMo+tHhJPf99E8tVnJ
        UPfYwO0tUQYEMPYnwU1BafU=
X-Google-Smtp-Source: ABdhPJxhDCOOwtl7muxq2EoiLkbbJ3pSULu366CSCoCkoPrUpdovla0DLB8Xkq4oYUvZSpAmqX9neA==
X-Received: by 2002:ac8:5e4f:0:b0:2f7:b5bf:7541 with SMTP id i15-20020ac85e4f000000b002f7b5bf7541mr10075787qtx.59.1652758095266;
        Mon, 16 May 2022 20:28:15 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id a19-20020a376613000000b006a098381abcsm7079535qkc.114.2022.05.16.20.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:28:14 -0700 (PDT)
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
Subject: [PATCH v3 08/15] ARM: mach-imx: Add support for i.MXRT1170
Date:   Mon, 16 May 2022 23:27:55 -0400
Message-Id: <20220517032802.451743-7-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
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
V1 -> V2:
 - Nothing done
V2 -> V3:
 - Nothing done
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
2.36.1

