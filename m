Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4166B4E5F71
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 08:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347922AbiCXHbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 03:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348570AbiCXHbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 03:31:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DFE99682;
        Thu, 24 Mar 2022 00:30:03 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d10so7311307eje.10;
        Thu, 24 Mar 2022 00:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=41pszt+PybnYgUfx9vODac1IhLaztrq7kY7kXvf9mWE=;
        b=W75d1bj3/HxEocX67AESJvny7BilgO6/7lbivPiE3r4fOBeapIiA75UE/w4WB2mj5S
         rV4FrD2YP1BuVYTq5QIsCmFhcdwSQJpFIjv7aV1akR0ZF/U1krZMcKAr5LIQ6XAMPM1w
         35SUvw17LHJvsy4eJtBTsKu2nqf3HlTN+lIePzCOovyk2sTlcFSQ4TY3BVPV+vbZT8Dq
         EKTP4dcw/q1zUg6OhJaA4WAZ3K8dd4zGKcxf/slB0oiPhPx9qmRKkDNufV1LEJbMf0Vk
         moAnOYySm5bSqtv0NQQ39Yb5TqBR0rGOodNmG+U99BXGHOv8oie3O5rvCKYGcYLjSByn
         O/Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=41pszt+PybnYgUfx9vODac1IhLaztrq7kY7kXvf9mWE=;
        b=7cBJl6sOMmXIOxD78gHtT4LZyis5S4vKwRrujqgCfTetxqihJvpK3ONx2a8QxJn2uE
         55HKnmzKlLkp2rLFZqudL9aRJirqCfCiCUrRoKJ107CCA3IR+r08wLZWb5G4LdGRxrVA
         yXrlHHlvz9cuUNcE0foxtVw07EabeQXn8Z2obnMDJubb9yN0eC47gLV2003sSXzWXUiS
         6wtanMail0xIzbnJPA41R+OmygoSA4RfIbqhD1GH1g+dJ1sC38B8gRa2tgGtSboOjSRa
         yz+JhVLL+yxGA//UzwUX1MdlCV2MOWrgfbXMT4be/sl8AEamJTltWqLNZoN9AjPmdWkt
         cDOA==
X-Gm-Message-State: AOAM530YrgVlrlaUpDOFXYU6PeMptdIGTaWOLwS2wa8vUnmTFlR/qBld
        Dg7P26uCLoSDlMEwQ3bX3YInL0PmbOC7CRyl
X-Google-Smtp-Source: ABdhPJypvh4h6q3BYO/WNfs15tnV/nCxMBcLKYfEtbu2nrSmu2Bj2OEgrzj3UAcqRGrX+RJ6G4I3+A==
X-Received: by 2002:a17:906:2a50:b0:6da:ed06:b029 with SMTP id k16-20020a1709062a5000b006daed06b029mr4301820eje.506.1648107002288;
        Thu, 24 Mar 2022 00:30:02 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id q9-20020a17090609a900b006cd30a3c4f0sm787085eje.147.2022.03.24.00.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 00:30:01 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Zou Wei <zou_wei@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>, nvdimm@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] tools/testing/nvdimm: replace usage of found with dedicated list iterator variable
Date:   Thu, 24 Mar 2022 08:29:52 +0100
Message-Id: <20220324072952.65489-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
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

To move the list iterator variable into the list_for_each_entry_*()
macro in the future it should be avoided to use the list iterator
variable after the loop body.

To *never* use the list iterator variable after the loop it was
concluded to use a separate iterator variable instead of a
found boolean [1].

This removes the need to use a found variable and simply checking if
the variable was set, can determine if the break/goto was hit.

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/acpi/nfit/mce.c           | 11 +++++------
 tools/testing/nvdimm/test/iomap.c | 18 +++++++++---------
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/nfit/mce.c b/drivers/acpi/nfit/mce.c
index ee8d9973f60b..6d11506e871e 100644
--- a/drivers/acpi/nfit/mce.c
+++ b/drivers/acpi/nfit/mce.c
@@ -15,7 +15,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 {
 	struct mce *mce = (struct mce *)data;
 	struct acpi_nfit_desc *acpi_desc;
-	struct nfit_spa *nfit_spa;
+	struct nfit_spa *nfit_spa = NULL, *iter;
 
 	/* We only care about uncorrectable memory errors */
 	if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
@@ -33,11 +33,10 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 	mutex_lock(&acpi_desc_lock);
 	list_for_each_entry(acpi_desc, &acpi_descs, list) {
 		struct device *dev = acpi_desc->dev;
-		int found_match = 0;
 
 		mutex_lock(&acpi_desc->init_mutex);
-		list_for_each_entry(nfit_spa, &acpi_desc->spas, list) {
-			struct acpi_nfit_system_address *spa = nfit_spa->spa;
+		list_for_each_entry(iter, &acpi_desc->spas, list) {
+			struct acpi_nfit_system_address *spa = iter->spa;
 
 			if (nfit_spa_type(spa) != NFIT_SPA_PM)
 				continue;
@@ -46,7 +45,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 				continue;
 			if ((spa->address + spa->length - 1) < mce->addr)
 				continue;
-			found_match = 1;
+			nfit_spa = iter;
 			dev_dbg(dev, "addr in SPA %d (0x%llx, 0x%llx)\n",
 				spa->range_index, spa->address, spa->length);
 			/*
@@ -58,7 +57,7 @@ static int nfit_handle_mce(struct notifier_block *nb, unsigned long val,
 		}
 		mutex_unlock(&acpi_desc->init_mutex);
 
-		if (!found_match)
+		if (!nfit_spa)
 			continue;
 
 		/* If this fails due to an -ENOMEM, there is little we can do */
diff --git a/tools/testing/nvdimm/test/iomap.c b/tools/testing/nvdimm/test/iomap.c
index b752ce47ead3..5d3d6b0fce2e 100644
--- a/tools/testing/nvdimm/test/iomap.c
+++ b/tools/testing/nvdimm/test/iomap.c
@@ -227,8 +227,8 @@ static bool nfit_test_release_region(struct device *dev,
 		struct nfit_test_resource *nfit_res = get_nfit_res(start);
 
 		if (nfit_res) {
-			struct nfit_test_request *req;
-			struct resource *res = NULL;
+			struct nfit_test_request *req = NULL;
+			struct nfit_test_request *iter;
 
 			if (dev) {
 				devres_release(dev, nfit_devres_release, match,
@@ -237,18 +237,18 @@ static bool nfit_test_release_region(struct device *dev,
 			}
 
 			spin_lock(&nfit_res->lock);
-			list_for_each_entry(req, &nfit_res->requests, list)
-				if (req->res.start == start) {
-					res = &req->res;
-					list_del(&req->list);
+			list_for_each_entry(iter, &nfit_res->requests, list)
+				if (iter->res.start == start) {
+					list_del(&iter->list);
+					req = iter;
 					break;
 				}
 			spin_unlock(&nfit_res->lock);
 
-			WARN(!res || resource_size(res) != n,
+			WARN(!req || resource_size(&req->res) != n,
 					"%s: start: %llx n: %llx mismatch: %pr\n",
-						__func__, start, n, res);
-			if (res)
+						__func__, start, n, &req->res);
+			if (req)
 				kfree(req);
 			return true;
 		}

base-commit: f443e374ae131c168a065ea1748feac6b2e76613
-- 
2.25.1

