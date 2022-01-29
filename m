Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757964A3134
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 18:56:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346206AbiA2Rzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 12:55:53 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58920
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239168AbiA2Rzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 12:55:41 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DCC683FE09
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643478939;
        bh=6UCbWYiKKRFJ4GNkVkqU9F02DF7gUG1QeWQTYvnZiYU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Ce5WAeETr1bplK2OcWU3skAV93u81dzHRsBH7AKer9VbxV+gaTMh65y+c4tm69j1p
         N4MaMKRDdsLIAWP+/BRgE1TonXmp/L06pK2kkopOClPMJwrdSff9qkjHJRqhkY2JKz
         hhkjRlVFQz+tndcC7I3TeyYQzAH5+F3IiPdaCVO7aFR0l03U8B35vRmb4TQr2kowm8
         s4T1UqGVfpVHIDdwLEW5to5nTt7qdbL+rFq9mqMODjaQx+UYhVYAefdZfSAxEs8TUY
         aoKPOxX7ULYvDxwVTYgommweF/f3I4S/5iKiPPYsU/Or4s2uJY1yYslUwDzfQ76sij
         W/q9XV9obzuVQ==
Received: by mail-ed1-f72.google.com with SMTP id h21-20020aa7c955000000b0040390b2bfc5so4678489edt.15
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 09:55:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6UCbWYiKKRFJ4GNkVkqU9F02DF7gUG1QeWQTYvnZiYU=;
        b=f91GJTtMMXHW+hpD1OI9LkInYBstkHJCVx1U6k3eyXjqYKWZ02zsVPypwEE8Vm4KCX
         jHpE9RA50YpYlfX6zQpRy26rQjlXf7E2VPuCLiaNM8/o3yxPpAENR0uk9xRyM4vgeZfa
         kP9yEpxUZdwRevgnK8EAbvVDwgWXKXAJKI6otGcotUdp/t8V0VQP59sRzJE9h3Ei5VI/
         QDshZiLGYXF6YNOfvGwF4NEDROFVPbJ0Ik2b+72KAMGPbxk5tKp0PNgW932j9E+tFdX5
         ElmALgFYlndJIr/kh06li15NmyBMo/AVjx3FWQdotnAWXNEiuKM8BB72vIEkJIuRPoeo
         FZqA==
X-Gm-Message-State: AOAM532Hx1Ybu45ou7dSfmJOeEAgT7cURcYLdIWAA369J6J82F8EwGLz
        ZNETlCyHhSSnpSKoGeFhnu7yMve1jvoCqxRiBvsXbX03buOseGorUtYqYDGbJfkwr+xo92bQ/7c
        NKSPQWWNK3LDqT5lYvDW69K6NFRcaVhMfbnjkUUXLvA==
X-Received: by 2002:a05:6402:1c94:: with SMTP id cy20mr13801136edb.150.1643478938574;
        Sat, 29 Jan 2022 09:55:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKvB83jqP3K2T2I6v2B5chVPVzPblBKfLDT1BmTW5XXbjw1MdNw4Gx//5CPwbzswPPF1Hsdg==
X-Received: by 2002:a05:6402:1c94:: with SMTP id cy20mr13801126edb.150.1643478938446;
        Sat, 29 Jan 2022 09:55:38 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id oz3sm11327756ejb.206.2022.01.29.09.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 09:55:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/2] arm64: dts: stratix10: align pl330 node name with dtschema
Date:   Sat, 29 Jan 2022 18:55:34 +0100
Message-Id: <20220129175535.299035-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes dtbs_check warnings like:

  pdma@ffda0000: $nodename:0: 'pdma@ffda0000' does not match '^dma-controller(@.*)?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 4124021768b1..da032a6f71da 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -333,7 +333,7 @@ ocram: sram@ffe00000 {
 			reg = <0xffe00000 0x100000>;
 		};
 
-		pdma: pdma@ffda0000 {
+		pdma: dma-controller@ffda0000 {
 			compatible = "arm,pl330", "arm,primecell";
 			reg = <0xffda0000 0x1000>;
 			interrupts = <0 81 4>,
-- 
2.32.0

