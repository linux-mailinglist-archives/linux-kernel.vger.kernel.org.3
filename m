Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62992493FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356670AbiASSMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:12:36 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36508 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356655AbiASSMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:12:35 -0500
Received: by mail-ot1-f41.google.com with SMTP id l64-20020a9d1b46000000b005983a0a8aaaso4229542otl.3;
        Wed, 19 Jan 2022 10:12:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KhnGgRppULmhUr9DM7eE177qZR72yiD2dlY3z/aqigQ=;
        b=ZaaHwVdiPG+KTHBrdaKF5bIRpJcdz8ywkUgZ7NN0L9mbmTLHYmt5qs8vVaKPWaSNbS
         rEAQx6ZiVjs/We/LEU0nlw4qXeAaZprgTtdNbmPmS1E7w8y7AawwwTVqpI46oN4HOAKk
         7sFF8iuHlrD6NLen11SvwKA7BnXqJfOG3Km/lNx2tdPk02n2isDJP+38D7J/Nc2/YOcO
         RWkCgQPGNZrC9PGP1Qnh4dsJsjWm5eCaFHjnDJ5o4AF35/Vg9zUJFfXVdFyYZ3MHzlBi
         g551gLrEXZeF++so8WlfuiSxsf56r5VfIUlHPE6YAjlgMuP57LKeqLBja2mEvcuspjA0
         k2Zg==
X-Gm-Message-State: AOAM531WCcVQpiAfGE3JRlndMC8Hh5+Ac2Tp41UXoE8r7Wn5QzNL5QrV
        xqPNnQGRJ8fjtyYWmSwu5Q==
X-Google-Smtp-Source: ABdhPJzsbITfBARgU7b1i5+U3tC7JZJlZvXyEKRNEEAVQxSrK4IGBg/+pZtb+Z7s39J19P337Vlgkg==
X-Received: by 2002:a05:6830:1be9:: with SMTP id k9mr13572805otb.217.1642615955104;
        Wed, 19 Jan 2022 10:12:35 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id v22sm228657oot.10.2022.01.19.10.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 10:12:34 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: remoteproc: ti: Add mailbox provider nodes to example
Date:   Wed, 19 Jan 2022 12:10:54 -0600
Message-Id: <20220119181053.3846613-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to make the 'mboxes' property in the TI remoteproc examples
parseable, mailbox provider nodes are needed. Normally, the examples
have a __fixup__ node which can be used for determining each
phandle+arg entry. However, for this binding the arg cells contain a
phandle, and the __fixups__ information can't be used.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v2: Fix the example rather than changing the schema which was correct

 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml   | 8 ++++++++
 .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml   | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 4323cefdf19b..cedbc5efdc56 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -142,6 +142,14 @@ examples:
         #address-cells = <2>;
         #size-cells = <2>;
 
+        mailbox0_cluster3: mailbox-0 {
+            #mbox-cells = <1>;
+        };
+
+        mailbox0_cluster4: mailbox-1 {
+            #mbox-cells = <1>;
+        };
+
         bus@100000 {
             compatible = "simple-bus";
             #address-cells = <2>;
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
index 0f2bb06cb7b4..0868154a0364 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -238,6 +238,14 @@ examples:
         #address-cells = <2>;
         #size-cells = <2>;
 
+        mailbox0: mailbox-0 {
+            #mbox-cells = <1>;
+        };
+
+        mailbox1: mailbox-1 {
+            #mbox-cells = <1>;
+        };
+
         bus@100000 {
             compatible = "simple-bus";
             #address-cells = <2>;
-- 
2.32.0

