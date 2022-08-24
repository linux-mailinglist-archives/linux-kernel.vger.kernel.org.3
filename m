Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0987659FA05
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237529AbiHXMak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237508AbiHXMa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:30:29 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2F949B58
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:30:28 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bf22so16863816pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=MXeTFOPwaEYUnBKivNI6IIvkTRiGbL/Q2wJpJf6zbRo=;
        b=HQHBOY5lZpaZ+qTObtvVlZeS+Hz5VZapvG+JueRbRZDAdpGvaYCj8c8/syiQFxHkwS
         kVHkbTjUtEvgd+t5P7OHQKd39CRHrxnCDEE71shIBzXXimjpRJE3sOrdX3wjls23Bf3j
         dbaie1+5oEN2rUmiC3EN0HLElzS6rylQQq4pRPg8jhmzoIV88zduw4VhZe+0Vslu2f68
         qgu33LfbfuQ+A0S4YHSWwCWmKuweh8DdKNx0/kFCxhBItfCbISadP6td2FUU+zXAAKpe
         EJWh3vAGs7le17ILFjUc3Q/dVU2t4HsCWE6fANFYtVqxMiiKEFMYwbo12tGNZIDxkRPx
         47+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=MXeTFOPwaEYUnBKivNI6IIvkTRiGbL/Q2wJpJf6zbRo=;
        b=Oy24M+X70Kum1tgew8B4kmCuk3UOh88ZD07mrol6WYb4+ojhiCHqVVrXaykFAVsgXh
         YfAOUa/NxIOGSYPXuhfoYXoy3BaeM7slmPvPwYxZAFywODyeOq7ymZQY5cOEDJWzt/jW
         GCfpfDDzZ2oxyhalqxknCXyYU7YpJxuQ/kKLp/Q0T7wpqrcSdlKs60+70q4Zx5dY0SP1
         DlJzkShFMSQRtZew1lGZkwrUkloNtb18/2H1QYbH3gMBmLHSVGML/jj8+o6ItyzkpJg4
         C/kfLPvB/xPV3Vyr6bomc5YdaPGtRHyWnz1N47UmILXWRXIW8mQSJbwp3h7fGE3sPxO/
         /TQg==
X-Gm-Message-State: ACgBeo2BPY7E83EZOLRFWLwLJ+quI4gDTy+WaIhdeKNjObTg5EM2sZk5
        xvNyrQB0utVdBPZICsBHDr1n
X-Google-Smtp-Source: AA6agR6x9GSi2J9BABOsuQCyB8ynh29Q1qxfh7AhFPTdGC0DNCf+hHeDlhOUt8BK0F2Wu0IjKfJxSw==
X-Received: by 2002:a17:90b:1b10:b0:1fb:7baa:ce1c with SMTP id nu16-20020a17090b1b1000b001fb7baace1cmr4015390pjb.131.1661344227690;
        Wed, 24 Aug 2022 05:30:27 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b00173031308fdsm3539220plm.158.2022.08.24.05.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:30:27 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH v2 2/5] tools: PCI: Fix parsing the return value of IOCTLs
Date:   Wed, 24 Aug 2022 18:00:07 +0530
Message-Id: <20220824123010.51763-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
References: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"pci_endpoint_test" driver now returns 0 for success and negative error
code for failure. So adapt to the change by reporting FAILURE if the
return value is < 0, and SUCCESS otherwise.

Cc: stable@vger.kernel.org #5.10
Fixes: 3f2ed8134834 ("tools: PCI: Add a userspace tool to test PCI endpoint")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 tools/pci/pcitest.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 441b54234635..a4e5b17cc3b5 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -18,7 +18,6 @@
 
 #define BILLION 1E9
 
-static char *result[] = { "NOT OKAY", "OKAY" };
 static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
 
 struct pci_test {
@@ -54,9 +53,9 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_BAR, test->barnum);
 		fprintf(stdout, "BAR%d:\t\t", test->barnum);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->set_irqtype) {
@@ -65,16 +64,18 @@ static int run_test(struct pci_test *test)
 		if (ret < 0)
 			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->get_irqtype) {
 		ret = ioctl(fd, PCITEST_GET_IRQTYPE);
 		fprintf(stdout, "GET IRQ TYPE:\t\t");
-		if (ret < 0)
+		if (ret < 0) {
 			fprintf(stdout, "FAILED\n");
-		else
+		} else {
 			fprintf(stdout, "%s\n", irq[ret]);
+			ret = 0;
+		}
 	}
 
 	if (test->clear_irq) {
@@ -83,34 +84,34 @@ static int run_test(struct pci_test *test)
 		if (ret < 0)
 			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->legacyirq) {
 		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
 		fprintf(stdout, "LEGACY IRQ:\t");
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->msinum > 0 && test->msinum <= 32) {
 		ret = ioctl(fd, PCITEST_MSI, test->msinum);
 		fprintf(stdout, "MSI%d:\t\t", test->msinum);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->msixnum > 0 && test->msixnum <= 2048) {
 		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
 		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->write) {
@@ -120,9 +121,9 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_WRITE, &param);
 		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->read) {
@@ -132,9 +133,9 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_READ, &param);
 		fprintf(stdout, "READ (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	if (test->copy) {
@@ -144,14 +145,14 @@ static int run_test(struct pci_test *test)
 		ret = ioctl(fd, PCITEST_COPY, &param);
 		fprintf(stdout, "COPY (%7ld bytes):\t\t", test->size);
 		if (ret < 0)
-			fprintf(stdout, "TEST FAILED\n");
+			fprintf(stdout, "FAILED\n");
 		else
-			fprintf(stdout, "%s\n", result[ret]);
+			fprintf(stdout, "SUCCESS\n");
 	}
 
 	fflush(stdout);
 	close(fd);
-	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
+	return ret;
 }
 
 int main(int argc, char **argv)
-- 
2.25.1

