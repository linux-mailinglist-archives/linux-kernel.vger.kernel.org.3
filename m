Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ED85A5E41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiH3IgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 04:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231449AbiH3IgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 04:36:11 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A76C276C
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:36:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u18so512007wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 01:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=7s4lILp9cgE/VG98/TN3p3rL3NeB7y+YGCWWz/Ak6qo=;
        b=f8vJlaQIaOD0LhgkU6RImXqEPI+WgCAqwQAigvfLBKFYbgeH2rlKl0k8DreR70zh+w
         0C8641L/YrYbXe2uHosTogQlDX+CodlwCwKvvxOZPuJ7wqtB7SU/sVMp7Vz8A11GTENW
         BiMkFO2VKDV1xuFaOyFYRhr9KrAa37hNCUmNf9Q3fdRhNq2YKzbzhv/3zU+pvjkgGaK9
         fgjdT/I+Cc9xwKdsxiylIuc0OC1bD8TF4EXzH6X39WyZCbVbkfqo14vI3O+z5AEHMjD+
         TYa4+/l0DlOFsrkUktogRI2vO+YUUUYhwkCa/JRcBEvhZhhZTJvGl2m4oID3dNzJGrq2
         g2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=7s4lILp9cgE/VG98/TN3p3rL3NeB7y+YGCWWz/Ak6qo=;
        b=Lm0Eku/ANJ5CXWz4d5dzODAZnYyUScuqVgROsYCGIREA6Tji6zDlyWbALwpKqYSCEM
         1CWSLtdUEiy81XJGiQ8ojwVCcBP7onRdebs3xgPIfvbjjPQtkZova+cxLzqetkEJ8hCC
         Lm9+6UbkVVYwPnXZg+029kQgPZrX10yMKpes9T1bAszqG3NYEwGosOLalsewbBwgyUHk
         GIAhMI76kZsI70+Yv3dZv6KLp/S8GOGGyrl+YIMqeRyuJltIzK9LNec1NFKHQNAkfH9O
         m9tFDSZvZryERsVJ/D5DYk0kuw59cBJpwjCOXCHXDCVaMEBaR1n1f0okB4BKAhDlqM/o
         4g8g==
X-Gm-Message-State: ACgBeo0pirIIZKY1TwOWVRCxOQm3njNhNHza5rw6PFz/bsYEzcSc6t5k
        xYXIYulxN6G/GNcrJ2tbhmIDQw==
X-Google-Smtp-Source: AA6agR5q3TtmuYX0WKLzHbeJm8JxO08jiubOnZgNqy61AvpeJ26B2/whlTWLVxv2LWR+oHv6O3ovqw==
X-Received: by 2002:a5d:4d0b:0:b0:226:d4d8:c3da with SMTP id z11-20020a5d4d0b000000b00226d4d8c3damr6604794wrt.370.1661848568754;
        Tue, 30 Aug 2022 01:36:08 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id c66-20020a1c3545000000b003a4efb794d7sm13129915wma.36.2022.08.30.01.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 01:36:08 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, greentime.hu@sifive.com,
        conor.dooley@microchip.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] dt-bindings: sifive-ccache: fix cache level for l3 cache
Date:   Tue, 30 Aug 2022 09:36:06 +0100
Message-Id: <20220830083606.1681385-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829062202.3287-1-zong.li@sifive.com>
References: <20220829062202.3287-1-zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With newer cores such as the p550, the SiFive composable cache can be
a level 3 cache. Update the cache level to be one of 2 or 3.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 Documentation/devicetree/bindings/riscv/sifive-ccache.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
index 1a64a5384e36..6190deb65455 100644
--- a/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
+++ b/Documentation/devicetree/bindings/riscv/sifive-ccache.yaml
@@ -45,7 +45,7 @@ properties:
     const: 64
 
   cache-level:
-    const: 2
+    enum: [2, 3]
 
   cache-sets:
     enum: [1024, 2048]
-- 
2.35.1

