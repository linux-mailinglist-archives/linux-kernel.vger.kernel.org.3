Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB82B4869CC
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242856AbiAFSZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:25:41 -0500
Received: from mail-oo1-f52.google.com ([209.85.161.52]:36513 "EHLO
        mail-oo1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242786AbiAFSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:25:35 -0500
Received: by mail-oo1-f52.google.com with SMTP id k15-20020a4a850f000000b002dc3cdb0256so448146ooh.3;
        Thu, 06 Jan 2022 10:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fiswExMz6XFGwtuBLNXXr8Y61t2eLKYq11RSjSYGFgI=;
        b=Gd/H38f/3UqJXiwoHcBsgrqqq4zm3keBeAlaXw8gmXASHW8N49b87od4eO4LrjTNlx
         PrtNGclheQ6J7+VeNh36PyjFXWzjq5GDE+9+w3Rrs1OB7LlOLELpanSa48JHKDmn6PiH
         Oxqk1zeKV+3Pd7rIw8/6vdmyIXWQgwIBsxe+0VScAUOFam2v29eKGvoiYuqorx4aZaHd
         AfR7mkaqnIZc1Nfi0ykkaN5jEvX73OJ2NRWM94SvwxOj1OUsPitjH77QqUKEc+PVd2ZY
         Ni/T6tMPnTwsSKhDw5U2OUfqTzdu8u+kuBIJdrlU1DNB4yveoKb/XDG2+3U+ewVl3UCC
         wvLQ==
X-Gm-Message-State: AOAM5300oVzo6msdNLkuKcisIhTdWrPFlma0oheymU4Azs9gOGNbnhzK
        CFaPS68ei7Ly+aa1RaPQYQ==
X-Google-Smtp-Source: ABdhPJwB9iT6Wzc4bAEqj5n+FhrYY/F4LxNj/hGK1fvAB2ejuvOQ7IDy/GkuKITHAGLet0tK5Citsw==
X-Received: by 2002:a4a:7c85:: with SMTP id v127mr38877986ooc.79.1641493534925;
        Thu, 06 Jan 2022 10:25:34 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id r13sm484949oth.21.2022.01.06.10.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 10:25:34 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: arm,pl18x: Make each example a separate entry
Date:   Thu,  6 Jan 2022 12:25:14 -0600
Message-Id: <20220106182518.1435497-6-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each independent example should be a separate entry. This and dropping
'interrupt-parent' allows for 'interrupts' to have different cell sizes.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
index 47595cb483be..2a64cffbe6ad 100644
--- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
+++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
@@ -167,6 +167,9 @@ examples:
       clock-names = "mclk", "apb_pclk";
     };
 
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     mmc@80126000 {
       compatible = "arm,pl18x", "arm,primecell";
       reg = <0x80126000 0x1000>;
@@ -188,12 +191,12 @@ examples:
       vqmmc-supply = <&vmmci>;
     };
 
+  - |
     mmc@101f6000 {
       compatible = "arm,pl18x", "arm,primecell";
       reg = <0x101f6000 0x1000>;
       clocks = <&sdiclk>, <&pclksdi>;
       clock-names = "mclk", "apb_pclk";
-      interrupt-parent = <&vica>;
       interrupts = <22>;
       max-frequency = <400000>;
       bus-width = <4>;
@@ -208,6 +211,7 @@ examples:
       vmmc-supply = <&vmmc_regulator>;
     };
 
+  - |
     mmc@52007000 {
       compatible = "arm,pl18x", "arm,primecell";
       arm,primecell-periphid = <0x10153180>;
-- 
2.32.0

