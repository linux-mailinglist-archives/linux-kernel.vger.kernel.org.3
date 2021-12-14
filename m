Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68366473FD3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 10:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbhLNJvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 04:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbhLNJvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 04:51:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E252C061751
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:51:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d9so31414106wrw.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 01:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UoqofvZsTLn3SZWgvUrY2g8UHV9XmLPJnkQk172OXk4=;
        b=hB68tQoQD6wtqjDpVCKgTzURxRcRL4C9GdnxcUZvBu6+I4BxO6ifeDBvAuZgmGzzhh
         gbjn1KsaxSiHFhAkN/I1uJXEM11WgNkO7jr+tNlJ4e12NdNigaTM04CqZSFr+K95iRrL
         xmlwuEjCqD7y7A5BKn9sagG5I3qsehYHDBUQGFSsiN8tTsmuT7UkJspiEsk4OFLojuvl
         FXNNHtwLVoUSbIk5s7S2rX3NU/fl2BPgtDYhI3rzAw57UJTH9VueKbpEqKgOD3FZRkDK
         94f5+6DX8H0ktrPEh0lBgU3kfXbK9dzMaClQHYrMv3FCoHkc6EWsu3tPffBKy73Qg4CF
         cTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UoqofvZsTLn3SZWgvUrY2g8UHV9XmLPJnkQk172OXk4=;
        b=zxkrmi2tGgLUQLX3Z0Dlp6RSwaUgSBET1UsbgR8beeNE8XwDLd5a4OXrPqfnBuOnbm
         q6adG2l8qfKUWcbU90eEqMomUx+R/9+LOw5TRbzDmROrOTMZIGhQxm4x2psqQl99hPAY
         Kuk/jwQzGsiY4xGiDRuNl/JBw8K/l9qP8xokTvFdZCRurvnQKXnXx42+as5t8dg2BDzV
         zi902GR9juIiCloh81JBkbSmry0VSzKUCi9ohuscJV3Nt28vC1jC5FJeWBNIfe9UikV0
         +zibwX02SQv/NgeegsVV+JtrrATfwxb9Xj3nh6lbg9z/9hvPc+t7Woq/hOTRJZ/NZPX8
         Frsg==
X-Gm-Message-State: AOAM5300aafjkgcJJOn689DNwKzgj2GiLqthk/SSDcPicK84THz430v4
        tyJgoPqjEX7BFpSQj3Rdb0tAMcNEa5fXMg==
X-Google-Smtp-Source: ABdhPJynnWm78M3TOb/T++5wTbkaJyEvCtnZXR+VoAoezYTUy8+XaDPydAauILAsPLk+jz38YwylZg==
X-Received: by 2002:adf:fb09:: with SMTP id c9mr4578324wrr.223.1639475458598;
        Tue, 14 Dec 2021 01:50:58 -0800 (PST)
Received: from fedora.sec.9e.network (ip-88-153-139-166.hsi04.unitymediagroup.de. [88.153.139.166])
        by smtp.gmail.com with ESMTPSA id s24sm1522757wmj.26.2021.12.14.01.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 01:50:58 -0800 (PST)
From:   Patrick Rudolph <patrick.rudolph@9elements.com>
To:     Peter Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: i2c Add regulator to pca954x
Date:   Tue, 14 Dec 2021 10:50:20 +0100
Message-Id: <20211214095021.572799-3-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211214095021.572799-1-patrick.rudolph@9elements.com>
References: <20211214095021.572799-1-patrick.rudolph@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a regulator called vcc and update the example.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
index bd794cb80c11..5add7db02c0c 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mux-pca954x.yaml
@@ -64,6 +64,9 @@ properties:
     description: if present, overrides i2c-mux-idle-disconnect
     $ref: /schemas/mux/mux-controller.yaml#/properties/idle-state
 
+  vcc-supply:
+    description: An optional voltage regulator supplying power to the chip.
+
 required:
   - compatible
   - reg
@@ -84,6 +87,8 @@ examples:
             #size-cells = <0>;
             reg = <0x74>;
 
+            vcc-supply = <&p3v3>;
+
             interrupt-parent = <&ipic>;
             interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
             interrupt-controller;
-- 
2.33.1

