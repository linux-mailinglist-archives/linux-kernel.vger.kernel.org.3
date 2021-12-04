Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1527D4682CA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384342AbhLDGOj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:14:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384196AbhLDGO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:26 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950EFC061751;
        Fri,  3 Dec 2021 22:11:00 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id t83so5825883qke.8;
        Fri, 03 Dec 2021 22:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RFI6Hwm2cozY9KFaKPS+db9qh1JW0JzTLHG991yW9HU=;
        b=V5OvZw01aDhPy1jgV9zz53pKIqUCsjS+d6hEXLI/ENaqvVY1BUFrlnSIAySJDTqWrs
         WkTJJ9ptXPaZ/ULjTU7PoCrav7gWzQPBiD48YKaIT1aCHaO2/Dn6bmWL9ZqNB7jJASnX
         1LLN4qoFNSQEiYqNh7eFWDoBM3YQ7P2JDR21s3FMQ3ecu6rPePa2Qd8mrlWhn79Fz9Rg
         994QMLdkunNviLRdnJ4CcJ7Wkwja0VxO1KppZIfvyVccmfTeCBKIDYMPUiwYZC5eDAvC
         kONul944oVl+Mq23z2HWie78MId+gv32ueQBAIM2R0x33ayLqWQyvRPATbBTam/HTauD
         fK9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RFI6Hwm2cozY9KFaKPS+db9qh1JW0JzTLHG991yW9HU=;
        b=rvTxjzNme/VqxE82a59Fa8MomjWiLC2MFHxXQfAxgErNl+IY5KK+nJXpkDQqjJsXN/
         dbqTpkeNxXV/09m0QPvfjPZ0pk8Ytl8bd5AwHjAT14E0L4fkx3hQij2aZh4wcqibNI6M
         1iP3UBdiRzDdW3ErFUpMRZLY85rVEfoWuVsJvfF+1r7Z5lmVBBPE6eFpwevn5v8bMpRC
         QKwNYV6qL+OPEpfrrL9VMQ8H6RIc5+bnmsgoa1pUvAVnxR/tAFHGi/BegAuzEf+Gi1xH
         ktKjFTtf2Qjt3PbF0v5cgCd9PZMKcY+ZSkksL/klhireX+CPuvrj5fnHxNTegqtNGOX9
         T0Cg==
X-Gm-Message-State: AOAM5332zGvY38/c0l4CUfsTSg6RJVRBZoTZqFJgnqN2Hj9X2ueIdcBu
        pAQdvSYuO6Q7O05c+h7Tpd8=
X-Google-Smtp-Source: ABdhPJzJHYPgvoPkYu9fKpWodxkkzl7c4qjcH+7Y1XMpysETBsdh8oqWhPRMbd9uWE35BXXdZKmvYg==
X-Received: by 2002:a05:620a:2886:: with SMTP id j6mr21563682qkp.316.1638598259809;
        Fri, 03 Dec 2021 22:10:59 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:10:59 -0800 (PST)
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
Subject: [PATCH v4 10/13] dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT compatible string
Date:   Sat,  4 Dec 2021 01:10:39 -0500
Message-Id: <20211204061042.1248028-11-Mr.Bossman075@gmail.com>
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
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
index 19621a2f8beb..0912055b4089 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
@@ -34,6 +34,7 @@ properties:
           - fsl,imx6ull-usdhc
           - fsl,imx7d-usdhc
           - fsl,imx7ulp-usdhc
+          - fsl,imxrt1050-usdhc
           - nxp,s32g2-usdhc
       - items:
           - enum:
-- 
2.34.0

