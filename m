Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0F85A9EF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbiIASd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiIASdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:33:54 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5AF7E32B;
        Thu,  1 Sep 2022 11:33:52 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id j17so14132103qtp.12;
        Thu, 01 Sep 2022 11:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lCAGnK1kDCXBFkNV/1zrCVbUY1432OK/jCC+gvVTzH0=;
        b=bNV4/zxxKsJX0M5jTO2fJdkvSfds7AFBZAcXW+ZFzS4klkDHs5onKIfxORV1IhSjdY
         iz7WVo5kkbUVSnBFlCZ6EdqLB5KZpWsu6Xyks2pXrErRbc2sOf3fnpht7IgcTS1yf0Xr
         ZcHfmMw5kLxuCAC/4yoTAZpHIm4lqsvjONwsJ5JmWsMJ9qRDqTQ6+I/YOf6U62s8qEWy
         iUXOLueaJtzuIzfwKICO8uQZzACm7n9R2Ee3lhnVvnkE61wkRFZfgoa04ZkKTuniLtuM
         NnI24t1vWm9t6r16Y42oG+4PZUI96kwKptTNYsnAkZ+HS0oiKL0MYprCMtMOyBGz2m70
         z6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lCAGnK1kDCXBFkNV/1zrCVbUY1432OK/jCC+gvVTzH0=;
        b=jNMamySCM1aySTEzOaFl9U+tdYQnlwdDBWiZp5n/S4gMCxyqW0bd+SE5vKuyTMjPIW
         pBwbnPvrrQxQX563R1+dn1kqZNAuyt21eEfLiN1RdMoY/Oxbva6tzGj7zO2uWPdlUzQV
         QMn8PhqFlTcgIqxusYKWEZu/Qn4KQU9yjXCOrHSHSYm3jR9to81dZBRtzJKdarYFFAMi
         3B7teW43GORg6ILDv1UyFLv48roboSmbQYUg6r/hv/NVyDqfk7AE+2X8y7/0JRj0KJKZ
         taMcjmPQ9LCFDAqF43sY7mrBzjzfhxwXD619mLSatjHgscZrg0S8HAMtS9NiwlN42c+Z
         mq7g==
X-Gm-Message-State: ACgBeo2bEehWiMI5Ubb6WM1SB9Go8trckf3zzekq1e13P7zfTVobwrCV
        jwHNJjXwRqxhwRmgtFBdorU=
X-Google-Smtp-Source: AA6agR4fkaeC2CPBfxL+OpE52/j5kVPD419IvXn5pByNQhdnvbaTdhLH+7HLtGml/Lgy58nNbLwDrA==
X-Received: by 2002:ac8:5acf:0:b0:344:8f3e:5f08 with SMTP id d15-20020ac85acf000000b003448f3e5f08mr24629950qtd.207.1662057231240;
        Thu, 01 Sep 2022 11:33:51 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id u20-20020ac87514000000b00342e86b3bdasm10563343qtq.12.2022.09.01.11.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:33:50 -0700 (PDT)
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
        linux-gpio@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v6 02/10] dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
Date:   Thu,  1 Sep 2022 14:33:35 -0400
Message-Id: <20220901183343.3188903-3-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
References: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
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

Both the i.MXRT1170 and 1050 have the same GPT timer as "fsl,imx6dl-gpt"
Add i.MXRT to the compatible list.

Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
---
V1 -> V2:
 - Nothing done
V2 -> V3:
 - Nothing done
V3 -> V4:
 - Nothing done
V4 -> V5:
 - Nothing done
V5 -> V6:
 - Nothing done
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index a4f51f46b7a1..716c6afcca1f 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -31,6 +31,8 @@ properties:
           - enum:
               - fsl,imx6sl-gpt
               - fsl,imx6sx-gpt
+              - fsl,imxrt1050-gpt
+              - fsl,imxrt1170-gpt
           - const: fsl,imx6dl-gpt
 
   reg:
-- 
2.36.1

