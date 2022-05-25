Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EF0533C2F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232191AbiEYMB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242212AbiEYMBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:01:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F14DFDD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:01:50 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3DCC13F1AA
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653480106;
        bh=vEyRu3gyoMBvdd4Z8NDlxfvzdwpR2dJGXySAtqBJ85Y=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Dg4UHwh3ewgEIKc23GYfgRL2UY+hiROrMW9PdPdVc0QEbrHqTYIaI+oklUX8OOqPC
         YjP3K5vCbbt75aPGhceljGfYHiYCpkCluuX5dCbXlEO7IZykWrSou41ymRUDL6Zon/
         oAx5qcNJquHw4sgc6u8UyZ6TtdcO3Q/PmOekdXsezWWHE5XFdQrJ2EaatGCmtj9Ndi
         Wuh2WMnYtE8pMworGNl8//270XpCkegg0bGoFgNCJmIIb5QZKPLgLSEozbrc/xUi5p
         jCaLJsElsaURl9mT3MrWbs92+BfOGEbBK+fhHZWIfg7iWnhRgHFWRJ1yqdPzRX/J3i
         GYT9R7N4fb79A==
Received: by mail-ej1-f72.google.com with SMTP id gf24-20020a170906e21800b006fe8e7f8783so8998224ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vEyRu3gyoMBvdd4Z8NDlxfvzdwpR2dJGXySAtqBJ85Y=;
        b=d3LKp+BqwtwL3wYqB8cKBMvVYJdKHxx1IwswypUpPAYT8KGMQMianBHEVnFGeMwmtt
         kCAsWh2qbq6jeI2l0hjq8QQi1R36VJPNBoPzwJ6an52GB6PEKgRWFwhB13+TP6uP5jjL
         vSnCFIN1ybf/Z+HEgMSns8RnpwtdlE665KqTPlPiRV/hWZXw36KWr61C0u0UrvlsFYn8
         jVZOgu6SxW/KLcaKRVLNIlJ9DArMjVCRnvaTSECEj1f7jDKM4w82cnDRlz+CtwM3Grzf
         ujt3QdUdpE8c4RzlSKw28n/g3rhXer8+sNI13w6YGvBrSjqR2QEeVZn+biJU4BOrj6b+
         ahrA==
X-Gm-Message-State: AOAM530p9I/woKAsp9JN58TA3GJxtYQ5VGno6JXj6oW04eRp9sfRXSQS
        FD/pS37gWHSxG3UBl5XL44kLZFWR8jgZBqzs8S7cyPGMbjOgAmtN0qGRZ2PV0tEOT8rerqHzorw
        LBS9+B6GmQjag+dRlB+HtoEdwTsI2pJUxUw54ltFxzw==
X-Received: by 2002:a05:6402:b8e:b0:42a:c086:11cd with SMTP id cf14-20020a0564020b8e00b0042ac08611cdmr33974612edb.166.1653480105966;
        Wed, 25 May 2022 05:01:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwL7IQSCfk7dw7Rhxy+BNIoQlgtSODxXBakXaluBUCASNADG2UAzgu1tC5VXb0qfQbABuoOmA==
X-Received: by 2002:a05:6402:b8e:b0:42a:c086:11cd with SMTP id cf14-20020a0564020b8e00b0042ac08611cdmr33974591edb.166.1653480105786;
        Wed, 25 May 2022 05:01:45 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id s25-20020a1709066c9900b006fefd1d5c2bsm2093389ejr.148.2022.05.25.05.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:01:45 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/2 v3] s390: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 14:01:40 +0200
Message-Id: <20220525120140.39534-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <Yo35NdfKlGwu5Trd@osiris>
References: <Yo35NdfKlGwu5Trd@osiris>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v3:
 Change author and sob email addresses to match sender email address.
v2:
  Drop trailing endmenu comments.

---
 arch/s390/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e084c72104f8..543e859905df 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -736,11 +736,11 @@ config VFIO_AP
 	depends on S390_AP_IOMMU && VFIO_MDEV && KVM
 	depends on ZCRYPT
 	help
-		This driver grants access to Adjunct Processor (AP) devices
-		via the VFIO mediated device interface.
+	  This driver grants access to Adjunct Processor (AP) devices
+	  via the VFIO mediated device interface.
 
-		To compile this driver as a module, choose M here: the module
-		will be called vfio_ap.
+	  To compile this driver as a module, choose M here: the module
+	  will be called vfio_ap.
 
 endmenu
 
-- 
2.32.0

