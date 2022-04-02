Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6558D4F0643
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 22:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354059AbiDBUtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 16:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352856AbiDBUtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 16:49:18 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE7F8CCF7;
        Sat,  2 Apr 2022 13:47:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1648932421; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=nihu8V19QaTY3A1DHEfmbMHpwTfr6fklzwyPyR//HyTfNtcaea3LzZokSVmcY5oaBptJ5D8o5kMVJlRmCLRcqCfdscZIuUeiMfq3V4XG8s+RoyVWBQCz3w661IIWo7CoyUHD73+3mORzPIXHAJFOiITC4uYC+Qv+9oP60Al2HHA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1648932421; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=bSwaktXDNruqtbX+QJHg8iKkRy38ngDxwv9CUEXzP/U=; 
        b=b76ALCZI9D7C/wXY+jC6rlqt9iuSGQPgtk+V2/oA80oy42LHqL8ESaXSqT0zWNcR96zj3MpaH01B+o53+vWeMFOfKnlo/YmDsxhE+GsRmoTDIrgCazPpURHs3S5jGRF0cNluLmfzu9vX66iZBcu3vjtAHIOkmRhpODBJei+3CTE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1648932421;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=bSwaktXDNruqtbX+QJHg8iKkRy38ngDxwv9CUEXzP/U=;
        b=SaG1uTV+dbsE5sWo9UEIX5uwFIyCevGOpM6G2PfpklN3h7B9UftQ1rmgma27lfwd
        pfXwIvG6sVjJ/EWnWjsfDQ4T4m+FZkRolu6g+jI2slvy00KRCHtgouWgpouK3elsniZ
        J4kX9vW87s1CpYRhDzYazyfb6XAh2eAmKjKuQAbY=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1648932416782554.5196652849005; Sat, 2 Apr 2022 13:46:56 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rob Herring <robh+dt@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
Subject: [PATCH v2 1/4] dt-bindings: arm: bcm: fix BCM53012 and BCM53016 SoC strings
Date:   Sat,  2 Apr 2022 23:46:19 +0300
Message-Id: <20220402204622.3360-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix inaccurate SoC strings brcm,brcm53012 and brcm,brcm53016 to respectively
brcm,bcm53012 and brcm,bcm53016.

Fixes: 4cb5201fcb5d ("dt-bindings: arm: bcm: Convert BCM4708 to YAML")
Fixes: a2e385f5374d ("dt-bindings: ARM: add bindings for the Meraki MR32")
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
index 434d3c6db61e..f0e2a20d22d5 100644
--- a/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
+++ b/Documentation/devicetree/bindings/arm/bcm/brcm,bcm4708.yaml
@@ -84,8 +84,8 @@ properties:
               - brcm,bcm953012hr
               - brcm,bcm953012k
               - meraki,mr32
-          - const: brcm,brcm53012
-          - const: brcm,brcm53016
+          - const: brcm,bcm53012
+          - const: brcm,bcm53016
           - const: brcm,bcm4708
 
 additionalProperties: true
-- 
2.25.1

