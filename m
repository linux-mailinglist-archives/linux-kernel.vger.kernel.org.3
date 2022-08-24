Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECCE59FA08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 14:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237664AbiHXMbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 08:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbiHXMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 08:30:46 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454265E645
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:30:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c13-20020a17090a4d0d00b001fb6921b42aso1319955pjg.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uAW+kjtQa+80IfCy6IL5kC5fYW/7yUQfz0e6h9eDx6U=;
        b=sg+4drdGaUY0LXCOCdgTnN/ZEnFNJJMEUKPl/nG8dXzi/wXDo0Cy9Qcs0OZWYXWujr
         ANjd3KDHuAwF03KxA/R0ZkrhVe8EJskcMxn217hk4RFVNkwcRaf2i3OMk71GWXrBC7GI
         tAjBBv5Uf4jQoopGGauAR7XBmBY9loYhnvKpqTYh4lJSWMqJONSmQAu3MCF2oXI9U3Ma
         E3MT1K7nrp3gAK6js2fYyPaK5gLHjhL1NDXs1NGry2v5B6MuS2bQNJdeFV7ol4c8yDnx
         xhYT/BqjxBvf0ttvlVkMIAOs+okRT3NOO+K9dqu33H/a5XttQLO14caGiIfzJegCfVha
         aD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uAW+kjtQa+80IfCy6IL5kC5fYW/7yUQfz0e6h9eDx6U=;
        b=rMr9ElUGwL5pI/g6nNhJHDTLj8Q/f2P47T9x3Nb5aPHIs3BkLJlc7P0jSmw9Ph8kcz
         jH1JD+eMDocEDI0AQSwLGY8FMNaALcfHrHTg1tzUC5dc0msQJ3RFhY38OWUI5DRgUJte
         32Y6yJeSJcsx6M7n6PkcAAngUKgdHj1Fe5vWR2MDMs8eT0ri5Fw8Q0uBCjkicNIaxw1j
         ZICqiab0/qrf9HE8WS08g9sv0qgIEmTU82tiLSz49WeOFba+whVoOIeiyNRptS+gLcdO
         uk28HRw9EbUfi7fk2cNYJ5nfnudVEprnkKwGeQmLKMjKzvFEWtqp706/obkHDYDCErdC
         NOSw==
X-Gm-Message-State: ACgBeo0mHyonisbYcR5W4Thwpsvj2lOh9c4UQZMcSaizCB3P20981rvf
        cpn7bwqD31EygmxXpxOpV1P1
X-Google-Smtp-Source: AA6agR5czQel5mWzZi3n+4qNkTWGh/vvxmu8AqiAYTsY5T9G0kG5EozYuvL3RIFF7LCc1/tkLt0KNg==
X-Received: by 2002:a17:90b:1d10:b0:1fb:e7b:270f with SMTP id on16-20020a17090b1d1000b001fb0e7b270fmr8180054pjb.192.1661344238634;
        Wed, 24 Aug 2022 05:30:38 -0700 (PDT)
Received: from localhost.localdomain ([117.207.24.28])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b00173031308fdsm3539220plm.158.2022.08.24.05.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 05:30:38 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, gregkh@linuxfoundation.org, lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mie@igel.co.jp, kw@linux.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 5/5] tools: PCI: Fix memory leak
Date:   Wed, 24 Aug 2022 18:00:10 +0530
Message-Id: <20220824123010.51763-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
References: <20220824123010.51763-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory allocated for "test" needs to be freed at the end of the main().

Fixes: 3f2ed8134834 ("tools: PCI: Add a userspace tool to test PCI endpoint")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 tools/pci/pcitest.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index a4e5b17cc3b5..a416a66802f3 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -157,7 +157,7 @@ static int run_test(struct pci_test *test)
 
 int main(int argc, char **argv)
 {
-	int c;
+	int c, ret;
 	struct pci_test *test;
 
 	test = calloc(1, sizeof(*test));
@@ -249,5 +249,8 @@ int main(int argc, char **argv)
 		return -EINVAL;
 	}
 
-	return run_test(test);
+	ret = run_test(test);
+	free(test);
+
+	return ret;
 }
-- 
2.25.1

