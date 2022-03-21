Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC564E3141
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 21:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353181AbiCUULU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 16:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353092AbiCUUKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 16:10:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12AB184609
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:09 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r133so58906wma.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gMoepUVOvRDAwTmdAmkWkLiyH53f2JJghRF0kAYUp8=;
        b=RDx+GXVUtpQmfbr16DO6Yq2LL7DbfVvfRBqBwtb6SSusIn9ZBx50PKSTikg0mRz6tc
         6oxmv4dy2wKCWPdKx9D7rxLiZbRgyRs/vQu1V2merbLQjyFP/G0iT7zz/q3t9N7A6jt3
         YLFAynrGGAnpEVVGUhBzCoA6t5wBknbzxTFFi0Gdy8lpKDyGwBOK3bdgMY8oY4/hMxB9
         fOXBdOAkwGQhaLdRNWRHd66hiC+vndiHtkb158AufTRG3S2JhvwCYPagu93Xie5VkfJr
         k7eDzzS4x/f6cQ8uj4b/dNiRFrPoEyy+9+s1/r+A8XFZh+aXGywRjmweWthRxEpScRA+
         QbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gMoepUVOvRDAwTmdAmkWkLiyH53f2JJghRF0kAYUp8=;
        b=1cOdLf0QDtB4/rRA0sg5r7tR017yPpJffbiwsulSUQuc4Hte4Zji9LtPMWjX3ZukOX
         WJgUETtfUkOp7pze2Kw2bEe/qWIFl2008xNnaOgwZH9SS4G1rPz3dRf6z7tBHElmZV0v
         dSwFJBu/9td9yYAFIbCwOSgZuDeYdKJ/uXleJDz/AcwAz8up6KPfA6TRbQEQnQ3q4nYg
         +ZuSQ8DgWIpoRrRtc3GIkpzvWLQjUirmt0BCtCbRkCRsye+jATQ/oQF/y/q+eJpc/2oi
         SCo/PfcsSCHFDpsBA0Li8d6eJ32yOLDxHSxL7eXjQxIG66nYetLlhLD2/n71EWnLIUtm
         l0hg==
X-Gm-Message-State: AOAM533R6rfs1K8AiQM4KJtK01oqLAZbq4RQOCIRMgKy1zp7d9e05CLm
        KvLB1VwTXq5q0IsZAvgXZ2pkbQ==
X-Google-Smtp-Source: ABdhPJwulLc2e95bjKUvggoQfu0QNbRnAFa6ydl55NbQ/vrr36S8Y+UYDhSh6EwwXvT6NSWfbKDUdg==
X-Received: by 2002:a05:600c:5110:b0:38c:9521:8ef1 with SMTP id o16-20020a05600c511000b0038c95218ef1mr650466wms.107.1647893288443;
        Mon, 21 Mar 2022 13:08:08 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm24426988wry.72.2022.03.21.13.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:08:08 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 24/26] crypto: rockchip: add myself as maintainer
Date:   Mon, 21 Mar 2022 20:07:37 +0000
Message-Id: <20220321200739.3572792-25-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220321200739.3572792-1-clabbe@baylibre.com>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nobody is set as maintainer of rockchip crypto, I propose to do it as I
have already reworked lot of this code.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c520915a3222..df4c72d37116 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16937,6 +16937,13 @@ F:	Documentation/ABI/*/sysfs-driver-hid-roccat*
 F:	drivers/hid/hid-roccat*
 F:	include/linux/hid-roccat*
 
+ROCKCHIP CRYPTO DRIVERS
+M:	Corentin Labbe <clabbe@baylibre.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
+F:	drivers/crypto/rockchip/
+
 ROCKCHIP I2S TDM DRIVER
 M:	Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
 L:	linux-rockchip@lists.infradead.org
-- 
2.34.1

