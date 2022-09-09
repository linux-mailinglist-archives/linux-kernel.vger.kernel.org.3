Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6AD5B2C00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 04:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIICO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 22:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIICOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 22:14:53 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272261582B;
        Thu,  8 Sep 2022 19:14:39 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-127dca21a7dso452983fac.12;
        Thu, 08 Sep 2022 19:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=x7cyzmPJRGxBZQlAz9Z1QZA/JLGMm0SYGiGBH3bNhVI=;
        b=d8U99i0j+TgEZ5Wpcr/CldmVP+uwq19VJNbujQF1/uhKb+fy5EnBQ3xFta/ipaGZLK
         xf2kd8rG6M29k3QR6AWyZUsFcKLIlDqXvRZst8kjkLplMlRxeSjd2UfAaODFiT6R80l+
         x1WaYWWwzDiiZDknFPBOIvrRku3IQ8syp5M6iunjJzaoykd8S7WR/mfh5578I1m1Rbfh
         bkwA0XVcm5Lh+QqtuVfX7yW+BvJ6ieHPXXXVsIWjCo1g48CBYOPWPEU05cLsE2TkYW1W
         PbWkvIt+TqIN4EjNHyPnmV8inEK8so9Ub2Ap9ZWf+h/SPNpDsOzul6UBgMdxewXPvsyh
         2R7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=x7cyzmPJRGxBZQlAz9Z1QZA/JLGMm0SYGiGBH3bNhVI=;
        b=ZD0rlYo6IqQNLDxK1ojAxEu+xuCHUSdJ+GK7HJRpIzO1lQ5dpwR5LUxuB2orskCPov
         hmrB9P5mmQe4cNnHlvqTeTDB0utZHmYQ5COJvS/wZ+bIgM3H1JNXSjPBDd97/mT0BJad
         veWeNsEfxBbnUKIn1wyScZDn0Pkk8qj01FstNVU9f/E++cmn4N7lqiFwloeU7Y0NrFqG
         /P8Ba7mXy4x+MftHEq4BV+LDrvNHM+HesghvzXBqg6m/dg1YbdxZ3iXI2qGnPyYklD7X
         BTGcvFsHHXg/jt3Klni/S18obqgVoSnT74U0GTjk0q5timGdXOcjXquovHwDQdB1B9iy
         0l6A==
X-Gm-Message-State: ACgBeo3wxWwv3u9uq6jKyJXojS3gBU5TDeWQfNkMYIisaInP79If9egh
        43z5vLYU6yRcZesawGq2g/0vRAJL0H4=
X-Google-Smtp-Source: AA6agR6OVS3wSSTbLQHnN4JcMxTBHqCmnT0GnvqlXUEMORWZbOnFHOsFG3jlR/X/4trwlwnm2z60mw==
X-Received: by 2002:a05:6870:ea92:b0:127:b4fe:85b0 with SMTP id s18-20020a056870ea9200b00127b4fe85b0mr3772438oap.247.1662689678656;
        Thu, 08 Sep 2022 19:14:38 -0700 (PDT)
Received: from macondo.. ([2804:431:e7cc:ed0b:fde6:d0df:8e59:d84f])
        by smtp.gmail.com with ESMTPSA id e26-20020a9d561a000000b006370abdc976sm367325oti.58.2022.09.08.19.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 19:14:38 -0700 (PDT)
From:   Rafael Mendonca <rafaelmendsr@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     Rafael Mendonca <rafaelmendsr@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: PCC: Fix memory leak in address space setup
Date:   Thu,  8 Sep 2022 23:13:47 -0300
Message-Id: <20220909021348.472674-1-rafaelmendsr@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The allocated memory for the pcc_data struct doesn't get freed under an
error path in pcc_mbox_request_channel() or acpi_os_ioremap().

Fixes: 77e2a04745ff8 ("ACPI: PCC: Implement OperationRegion handler for the PCC Type 3 subtype")
Signed-off-by: Rafael Mendonca <rafaelmendsr@gmail.com>
---
 drivers/acpi/acpi_pcc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
index a12b55d81209..fe5ab0fdc3bf 100644
--- a/drivers/acpi/acpi_pcc.c
+++ b/drivers/acpi/acpi_pcc.c
@@ -63,6 +63,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 	if (IS_ERR(data->pcc_chan)) {
 		pr_err("Failed to find PCC channel for subspace %d\n",
 		       ctx->subspace_id);
+		kfree(data);
 		return AE_NOT_FOUND;
 	}
 
@@ -72,6 +73,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
 	if (!data->pcc_comm_addr) {
 		pr_err("Failed to ioremap PCC comm region mem for %d\n",
 		       ctx->subspace_id);
+		kfree(data);
 		return AE_NO_MEMORY;
 	}
 
-- 
2.34.1

