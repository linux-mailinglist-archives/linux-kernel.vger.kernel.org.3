Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B3652B979
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbiERL4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbiERL4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:56:19 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B71E9E;
        Wed, 18 May 2022 04:56:17 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dk23so3308118ejb.8;
        Wed, 18 May 2022 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bDVhsYhcH84aV3iRdTGGmIFJ0IE7KSrLpx2SeKM1fdE=;
        b=lH9VMsyVl8qTRJwQvmr3mFQlz3jrJ3x40HwM5yg7Pta0C5oBdhVDXKcw6gWcXZkXVT
         wfQk/CbUTB2/rlsKyJlTDFhF/WE1M1nnUVeDmMReRXIfWmuy8QLD+nn86GHVrseWLkqH
         VGUwTtdA/wMHQk3kO+B3VGKLtO9taH1NkqijqBC9aKSYcJ5dI9jChu5zm2GzbnwfO9ra
         z31S+FZKexYikA9yKw28U+OOjyz6EucQL+J3tWlwnns0ss5FNaESXB70/ZM9eCGGkIfH
         OtObyA1fPXzluO2G/b8UlByYFjmmhdwkkpzdnGG5/HY+jmJN/z0OqKhlvKcjM/w1HXnu
         JFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bDVhsYhcH84aV3iRdTGGmIFJ0IE7KSrLpx2SeKM1fdE=;
        b=3lFIgIv5lQA1LGkMGKXdrFgo8EEIsk+5nPeZF8v3E6QHD5dXekkAFyfAhe9+lsRPGm
         1DR6RwA2DiP7yylnLvdu39eGR8pXAqhBE+6N/QDnGn+Tv7T0TGu1+yjjnMY7XbJJ78/K
         sJjkrJsQ9OZ2v9TIIhfmpAy2NLmZpPft1NIj6hbq2pffzDl75aVUcmsl5U+NwLIiQa5G
         Q+OpcP68vue+cW7/rk81OBGoy0/mYZvdBQIoUAf+2aD3ONhpLjJH9ro9rrArPwVFMlmS
         o/n6bKJEUbzxv8O81YVhNzUYzHf3k2RnUWAlEtACtgk+8AlXPm8fgTobDfcwSqdPapZS
         mi9g==
X-Gm-Message-State: AOAM532yvZsazL84XfDnq0+51TldgDiexue920fYxt/YCW0spdp0u1/d
        TqI+dcpYTJFDOkgGOhpgArs=
X-Google-Smtp-Source: ABdhPJzzkEqdp3Q+ON2NhyqKQVUmBjrQFHhrDta4Qq8v8UNA5ECXxP9dmsraf+dBf51ngGrUihZCpA==
X-Received: by 2002:a17:907:1c8e:b0:6f4:e24f:20e0 with SMTP id nb14-20020a1709071c8e00b006f4e24f20e0mr23516272ejc.227.1652874975853;
        Wed, 18 May 2022 04:56:15 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id dq20-20020a170907735400b006f5294986besm873999ejc.111.2022.05.18.04.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 04:56:15 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Nikita Kiryanov <nikita@compulab.co.il>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: display: startek,startek-kd050c: allow bus-format property
Date:   Wed, 18 May 2022 13:55:39 +0200
Message-Id: <20220518115541.38407-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220518115541.38407-1-max.oss.09@gmail.com>
References: <20220518115541.38407-1-max.oss.09@gmail.com>
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

From: Max Krummenacher <max.krummenacher@toradex.com>

Allow to specify the optional bus-format property newly added to
panel-dpi.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
- New commit

 .../bindings/display/panel/startek,startek-kd050c.yaml           | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml
index fd668640afd1..05306713044e 100644
--- a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.yaml
@@ -19,6 +19,7 @@ properties:
       - {} # panel-dpi, but not listed here to avoid false select
 
   backlight: true
+  bus-format: true
   enable-gpios: true
   height-mm: true
   label: true
-- 
2.20.1

