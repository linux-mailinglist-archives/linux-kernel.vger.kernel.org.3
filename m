Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764BD48712A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345814AbiAGDUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:20:37 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:34358 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344897AbiAGDUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:20:36 -0500
Received: by mail-oi1-f181.google.com with SMTP id r131so6539469oig.1;
        Thu, 06 Jan 2022 19:20:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xcznktkJ1RYJEtl2X8NHggtUN6UgM0jAUxrx7u5OfmU=;
        b=XgQqy2ECMu/4C2hMfET/OPYhMmtV1NOMNdBFgg79a4nHctocy63VoC/HRK7jMeF1JP
         scLZGcjuHB5hOG53B+zWxVi1SkqVBehKfzoc24Kxr3XcSCCCvNoWK8HHA4z19d8rYI+x
         qVPDQyoKwqvZiabzzdun9obJZXaAVUvKz/2rV/HG3VTH6nq71Y2PjGQHysY0kA3frUbR
         RwEywcxcfpcaJok88Zsdm7dDgLBDJaAsH/y4YxohfIfW/X+bXeHZXLxRkKv7ncqiczGJ
         BL3tLBs9JiUWTuvmJdEVmpCveNE9ZB6dCgJyMvJdURJuIxmLkri0zbZtG34cYQ/W8JmB
         /VWA==
X-Gm-Message-State: AOAM530oHLsoxJ2qm4s0r+EHty/GE/N0PSAq1vLa+MrWp4E6fTD2DLX9
        JBGrNIXczhGYdCNkeYeql2w+jZJxzA==
X-Google-Smtp-Source: ABdhPJzkfDZsJe0Ec4+qpKI0hXa2NFntKTcAzP1stxz5Nm4ujZoYDwby6QDk1u9/7k8pSZln1obcKQ==
X-Received: by 2002:a05:6808:208e:: with SMTP id s14mr8803729oiw.170.1641525635296;
        Thu, 06 Jan 2022 19:20:35 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id c3sm820747oiw.8.2022.01.06.19.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:20:34 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adi,ltc2983: Fix 64-bit property sizes
Date:   Thu,  6 Jan 2022 21:20:26 -0600
Message-Id: <20220107032026.2408196-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The '/bits/ 64' notation applies the next <> list of values. Another <> list
is encoded as 32-bits by default. IOW, each <> list needs to be preceeded
with '/bits/ 64'.

While the dts format allows this, as a rule we don't mix sizes for DT
properties since all size information is lost in the dtb file.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/temperature/adi,ltc2983.yaml | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 0f79d9a01c49..722781aa4697 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -448,17 +448,17 @@ examples:
                         reg = <20>;
                         adi,sensor-type = <9>; //custom thermocouple
                         adi,single-ended;
-                        adi,custom-thermocouple = /bits/ 64
-                                 <(-50220000) 0>,
-                                 <(-30200000) 99100000>,
-                                 <(-5300000) 135400000>,
-                                 <0 273150000>,
-                                 <40200000 361200000>,
-                                 <55300000 522100000>,
-                                 <88300000 720300000>,
-                                 <132200000 811200000>,
-                                 <188700000 922500000>,
-                                 <460400000 1000000000>; //10 pairs
+                        adi,custom-thermocouple =
+                                 /bits/ 64 <(-50220000) 0>,
+                                 /bits/ 64 <(-30200000) 99100000>,
+                                 /bits/ 64 <(-5300000) 135400000>,
+                                 /bits/ 64 <0 273150000>,
+                                 /bits/ 64 <40200000 361200000>,
+                                 /bits/ 64 <55300000 522100000>,
+                                 /bits/ 64 <88300000 720300000>,
+                                 /bits/ 64 <132200000 811200000>,
+                                 /bits/ 64 <188700000 922500000>,
+                                 /bits/ 64 <460400000 1000000000>; //10 pairs
                };
 
         };
-- 
2.32.0

