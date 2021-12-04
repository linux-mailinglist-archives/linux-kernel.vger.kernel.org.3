Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B524682C9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384320AbhLDGOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384188AbhLDGOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:25 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5EA8C061D5F;
        Fri,  3 Dec 2021 22:10:57 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id m17so4922159qvx.8;
        Fri, 03 Dec 2021 22:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OlA3SRDh8Lj1S0TYSsQxoHgqVKUSBF5/ViXVM/bBDp8=;
        b=TtesSlYKU/KqnKBFS25VdgJXKqndSIcuzO2weuxUGi0rzjR9bOoviObo/pprjwI25n
         689/bFh0gZnuhyEmoX1yyIxCxnoyUIG3dHJFyY3BZnyRyhoCQK5vuKwyc8V83GoAUJQX
         y2X8zeGagVyw3x0MpPqSc5FBNOdLX/Q0HN8mKuSpw1cOODdMQyV6cvmfGZUHH8b3Pl5E
         UVTvUUrwmmTVtjVlzQUOJ4DpsLgB4qZbluGY6vltZRNH7u/HiILUt6TXlJkSJcbnNAuj
         OnqfYGs83E77E0cuBsn0YfeUANQlLLGf7YyUUIYSXxUi2khSJdKYzhuzMS0faxfJh+ls
         6ggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OlA3SRDh8Lj1S0TYSsQxoHgqVKUSBF5/ViXVM/bBDp8=;
        b=wid+RkCYvNQIpndlREcPeDlzCvSo6AX5FuEfXYl2ZwlV/j/GDa0IG0qm2URZmyR0lz
         Wsig2t4VXFBk1NiIHJLnuAHdLJKKLRWkCFJVAVpTlo8yFZSbmzskEjaor0ZhTMGIgzLW
         s4epeyp0cO9cUCRjZnQvCySpaxyD9XG0WB5X9N47xM7+J8L6/VUFOPxCs2BIrHoRtNmV
         ixOWikFfQR1OIjwSXyeIFezC7NWaQnvs+hanGvH0++3z94EHksVBGL8NSXp4lsgX25VX
         7tbwP9/hqRHKlVmLvBpEAUNMuGrCXR15+Fkjjr34pL0xMDzxKKXuDQmhKtCOiqvtW6um
         GETg==
X-Gm-Message-State: AOAM532CzIs6FWyhMi9x/XHRLicXiOSecCz6TIZlueWISSFHAaI3EC5V
        L0fIr7XGdBhgkkdPjNO5kXg=
X-Google-Smtp-Source: ABdhPJxJndG4d+9CcgqNpYBw+OJgcqd7kTs5AL/U/yr5dldZ7HGLihzkWCEfLBXqolgcVLNyGbdnpA==
X-Received: by 2002:a05:6214:1c0b:: with SMTP id u11mr23581628qvc.2.1638598257088;
        Fri, 03 Dec 2021 22:10:57 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:10:56 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org,
        Jesse Taube <mr.bossman075@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 08/13] dt-bindings: serial: fsl-lpuart: add i.MXRT compatible
Date:   Sat,  4 Dec 2021 01:10:37 -0500
Message-Id: <20211204061042.1248028-9-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Taube <mr.bossman075@gmail.com>

Add i.MXRT documentation for compatible string.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V1->V2:
* Nothing done
V2->V3:
* Rename imxrt to imxrt1050
V3->V4:
* Nothing done
---
 Documentation/devicetree/bindings/serial/fsl-lpuart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
index a90c971b4f1f..c37085804c5c 100644
--- a/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
+++ b/Documentation/devicetree/bindings/serial/fsl-lpuart.yaml
@@ -21,6 +21,7 @@ properties:
           - fsl,ls1028a-lpuart
           - fsl,imx7ulp-lpuart
           - fsl,imx8qm-lpuart
+          - fsl,imxrt1050-lpuart
       - items:
           - const: fsl,imx8qxp-lpuart
           - const: fsl,imx7ulp-lpuart
-- 
2.34.0

