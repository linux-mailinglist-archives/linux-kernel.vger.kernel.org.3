Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA734870F3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 04:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345619AbiAGDFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 22:05:10 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42579 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344950AbiAGDFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 22:05:09 -0500
Received: by mail-oi1-f169.google.com with SMTP id w80so6460097oie.9;
        Thu, 06 Jan 2022 19:05:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zsx3qDj2DvypF3b69YZdJxriNNUsp6EFVMJrxgh19EU=;
        b=ncRfCPat9M1evSjlCAUbZljvzSbEoHMnK4E+6vAAwIxlEK+sjVn8/9FDGqUjDXgorE
         AYHrtZF1AQ3pNxazZQCoXR71L2wjzVyyzWdWjw9UCiDBO+4dwJPQ8YmZXai0n25fUYn+
         0eObE/hXL70l67kr1l5mtGcOAL3KKQXmOaLPzwaI+4RQXsQLzv18yrX6NksU6sQwpBea
         AMvFv9aVGR4IC8mO20QSsed5TnUD7okglsX/yf+fwBicjPoMB4tzDZ6eI/nmyxlucgVt
         GQfHO1mJRh4/7KjtG4tiBbFuzi7zvdoVGVng9i++mpODCe1CRaO/wVfOskTxz4hCYpZi
         DfCg==
X-Gm-Message-State: AOAM531TO51SQZnrINZSMpU510KGyAu1ssLhKonniMWdk2viaNidMXw/
        AYNJCHCNAj+uOlDcWrI4qQ==
X-Google-Smtp-Source: ABdhPJxoO85v786P50dk73DP0YuhspO0BtdFzkoW3DJQcQ3BmFECERFl6LAlAPvElshDGjsrHV8TSQ==
X-Received: by 2002:a05:6808:19a5:: with SMTP id bj37mr2597227oib.132.1641524708699;
        Thu, 06 Jan 2022 19:05:08 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id p7sm665573ots.57.2022.01.06.19.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 19:05:08 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suman Anna <s-anna@ti.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: remoteproc: ti: Fix the number of mailboxes
Date:   Thu,  6 Jan 2022 21:04:55 -0600
Message-Id: <20220107030457.2383750-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the example, the TI K3 DSP and R5 have 2 mailboxes, but the schema
says 1. Fix the schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml         | 2 +-
 .../devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
index 5ec6505ac408..648144fa1582 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-dsp-rproc.yaml
@@ -53,7 +53,7 @@ properties:
       OMAP Mailbox specifier denoting the sub-mailbox, to be used for
       communication with the remote processor. This property should match
       with the sub-mailbox node used in the firmware image.
-    maxItems: 1
+    maxItems: 2
 
   memory-region:
     minItems: 2
diff --git a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
index eeef255c4045..2c5f91ea5296 100644
--- a/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/ti,k3-r5f-rproc.yaml
@@ -135,7 +135,7 @@ patternProperties:
           OMAP Mailbox specifier denoting the sub-mailbox, to be used for
           communication with the remote processor. This property should match
           with the sub-mailbox node used in the firmware image.
-        maxItems: 1
+        maxItems: 2
 
       memory-region:
         description: |
-- 
2.32.0

