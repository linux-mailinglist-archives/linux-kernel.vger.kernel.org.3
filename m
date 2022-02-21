Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04A854BD803
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 09:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242471AbiBUIXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 03:23:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiBUIW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 03:22:57 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EAB10E9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:22:35 -0800 (PST)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2BBF14001E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645431754;
        bh=hlIj3vhV71SSbB5w21H5u6H9YDo8YKgOZoNaxfo50oc=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=oTXzH178PWNE2HcxfI1Ub6Nv+6RnICxPsnTN0pXOfs3rdneoZsGHXEhGRTlLcJy7A
         NpbeTXIB/6lSs7x6dJVS+It0cWBIRUVvJpKtiuxDhmbtzaOghoxTAk3ohniHTzG19Q
         coK1i88c3yG4pHHBXJNZ21G3AXjUjuQcfPeUbjNLPiTLsyflAFoIS5D4zFkk7EL/8l
         D9Iq+HgZUBVZ+80ENTyUvuH1zkxMCqFk1TzxXf3qCzxgVGsXVOvF2ImfroV80TmFTf
         ucO+7he8p/mFEs0N+yuLMgwl0w520iP+o5mSNxyIuzZo/UdqI3ZN+8EV93msvdMJ4R
         1kepIuDT3k+MQ==
Received: by mail-wm1-f71.google.com with SMTP id o24-20020a05600c379800b0037c3222c0faso3946907wmr.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 00:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hlIj3vhV71SSbB5w21H5u6H9YDo8YKgOZoNaxfo50oc=;
        b=qmvTb6mEcGTvZ2IOLEtS2DnzC3/IloOyD6azUQpH4OkmO4XYyiXaCgUZE3uSmjPLyu
         Nj1Qca06HtVpRxKtHrrdLBA/oyFuH6fFR8Y2ixUYyLfg50zrp1PGj7+tNP+dPdD+Sqp9
         441M8VnJBol13yINUHD+UdCI+DjqZbW6AosPmcRZ6hDXA++jPvdhFArmRm9ACubOWLS9
         hXvqDHCpYM/7N2HZNl0d9ocb1X0wl6TfgRd++68JEy1bZ746FRtWuq3i0QBA1kwbsXUd
         /zZNclbp5hZZYBIoc8IifNx3NUBJIQj8dC1sDxy/CPjbXxZxegTgv6tXjeQFWTgIva8B
         A2ew==
X-Gm-Message-State: AOAM532UKCWcv7QyHiukzUkxenret7bVAvV6u1I9hbWlHBUE/uV0p5SP
        l9xmK44p31MoyMNNnEAbNX/HuVGxgt1+KBG3DS8ThicfLdLOFVyYKPbo5/hkZ7c0RleAUgk2U/I
        pnztzhQNYdL3fICadAh5VqmnhTNiyQKehIoF2XYNJuw==
X-Received: by 2002:a5d:64cc:0:b0:1e8:f4ad:bf85 with SMTP id f12-20020a5d64cc000000b001e8f4adbf85mr13862936wri.630.1645431753280;
        Mon, 21 Feb 2022 00:22:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykaiGNU5Li3aG1FyjXURj4iFwPk3GA+YI6LrQsfKHNOWgUmrUefkO9/8NaVDTBak7lyE72kw==
X-Received: by 2002:a5d:64cc:0:b0:1e8:f4ad:bf85 with SMTP id f12-20020a5d64cc000000b001e8f4adbf85mr13862922wri.630.1645431753107;
        Mon, 21 Feb 2022 00:22:33 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c410500b0037bc3e4b526sm6727615wmi.7.2022.02.21.00.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 00:22:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Roger Quadros <rogerq@ti.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wei Xu <xuwei5@hisilicon.com>, David Heidelberg <david@ixit.cz>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: add second HiSilicon prefix
Date:   Mon, 21 Feb 2022 09:22:26 +0100
Message-Id: <20220221082228.34407-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are few boards DTS using "hisi,rst-syscon" property -
undocumented "hisi" prefix.  The property will not be changed in DTS to
non-deprecated one, because of compatibility reasons.  Add deprecated
"hisi" prefix to silence DT schema warnings.

Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: David Heidelberg <david@ixit.cz>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

See:
https://lore.kernel.org/all/61AF1E3B.5060706@hisilicon.com/
https://www.spinics.net/lists/arm-kernel/msg887577.html
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ebe294516937..79a172eaaaee 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -505,6 +505,9 @@ patternProperties:
     description: Himax Technologies, Inc.
   "^hirschmann,.*":
     description: Hirschmann Automation and Control GmbH
+  "^hisi,.*":
+    description: HiSilicon Limited (deprecated, use hisilicon)
+    deprecated: true
   "^hisilicon,.*":
     description: HiSilicon Limited.
   "^hit,.*":
-- 
2.32.0

