Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A404ED998
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 14:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236051AbiCaM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbiCaM1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 08:27:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC29120A3BB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:25:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u3so33610629wrg.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 05:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MznjTZcn+Iy7DTY+rcVw1rMxydmdSN5dbN0ljOIvUSE=;
        b=XIlsHRds1+bGX6dMv6KaY/OPYfDYpOm/vmoOfAiAZuLUW2Z6EJU/ZGyNRJ3wWxhG93
         1JwR5ouAKPZMifru28xuvZypQsA2Gfhsq3w9n8XC40RBEW/5e5yzLHqnjjicYLI2pmIw
         7iQE1HkusVKBtamy4wZoAuxf4JXNPsdAKhen0haS3QveT79UcUeVLIeHBgdMgYA1jubK
         pHrutTmcLY3ZbD6tvhqlbIltXhMZlbV1DtMZXk6Gf/T0c9sy43WOt30tzvW0UrhdhG3j
         8hqLejQAi0uJy9aIyZ78PyVEZqmrkykjIj7P5dJxFsGqWrtFpSAJ1ODS/27tiN6onP2Z
         nqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MznjTZcn+Iy7DTY+rcVw1rMxydmdSN5dbN0ljOIvUSE=;
        b=3mk9i1zlo3VvpJW19wePWVSGWIVLLOBApqfVEYTsHAIWOq7tk76/M5aGFWge39YNyc
         Geg9z4YWmiUPeCtt382aWp0JXwMOf/BywpGZh2YncC/1MyiE0fkIbxquCgR2fIHdJMKv
         DCZJww5PZu+WrKsYJ5QrkKogvqXI5P0SXrh7rCj2Cp6Hb86RuzyEJrWPqTcfm6BCGRyS
         fiRCc5R+dzvnm5ViqSEzhbyxHmfkw9ZXSNiTznjCraE13qGiK86FKJISWfEKoBiR5RAN
         4QwR4VmSd+6p1FwbXPPDqdGUCy8O/lBQ156GjtAOwIh2GGpKWhr+EiruGzUlMobH9K/O
         62Bw==
X-Gm-Message-State: AOAM533Ep7ceBPoTdEa5G+O78yG58kuejC/kT9Yu45A+C/uLKtAHPSKX
        ibxhC3PQdveeR1SLialB8jW2l+YWBIxfY6o+PyfaZn7mGsJOtfptmRAzSfqH7wcBZto1zV6X9sK
        6L2BKyYy0DQsg0MpbDNE9nA96RWAivpXRWsmKvPcd5vmyZd4a+WoX/Cn8jo7V98dCMXqxfOpohY
        qg5CWLBw==
X-Google-Smtp-Source: ABdhPJx0EZ844H5axJrPYISeU4kYpOEHVfAGm/h7E78xeG0hBKtIoXFXp1f6MxWcPXDv7ekVf0EnCQ==
X-Received: by 2002:adf:e4c1:0:b0:205:8b74:8dee with SMTP id v1-20020adfe4c1000000b002058b748deemr4010962wrm.225.1648729532418;
        Thu, 31 Mar 2022 05:25:32 -0700 (PDT)
Received: from localhost.localdomain ([95.168.120.40])
        by smtp.gmail.com with ESMTPSA id 3-20020a5d47a3000000b0020412ba45f6sm23498765wrb.8.2022.03.31.05.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 05:25:31 -0700 (PDT)
From:   Vladimir Vid <vladimir.vid@sartura.hr>
To:     linux-kernel@vger.kernel.org, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com
Cc:     robert.marko@sartura.hr, luka.perkov@sartura.hr,
        Vladimir Vid <vladimir.vid@sartura.hr>
Subject: [PATCH] MAINTAINERS: update Methode uDPU maintainer
Date:   Thu, 31 Mar 2022 14:25:28 +0200
Message-Id: <20220331122528.3886-1-vladimir.vid@sartura.hr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Robert Marko as Methode uDPU maintainer

Signed-off-by: Vladimir Vid <vladimir.vid@sartura.hr>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 237046f8a499..c74e99efbb39 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12769,7 +12769,7 @@ F:	Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
 F:	drivers/staging/media/meson/vdec/
 
 METHODE UDPU SUPPORT
-M:	Vladimir Vid <vladimir.vid@sartura.hr>
+M:	Robert Marko <robert.marko@sartura.hr>
 S:	Maintained
 F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
 
-- 
2.30.2

