Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1955D4D5545
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244493AbiCJX0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiCJX0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:26:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 987BD1965D2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646954709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iigEMniBW4cDGKyN9CUUK0j40uMHVCfBaIIQTILpT74=;
        b=f7uLGSnkryLQ1z1ybqA1KBCFpnhHoKgve5Kb6FhyCOTXsuG8pvBYWFDtMMlGpOy4U0d6v5
        cnTAUzeSPQ529HMWezb31MzYpfi/Q9co3oNXjJTajO4ZauM2igYCvdYbbXXfiByt0NTYy/
        8ReOwgt1slQuGbel0Ra7OzwBdLWpBtY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-lp6rQmGeMmm-s2YUGYmbSA-1; Thu, 10 Mar 2022 18:25:08 -0500
X-MC-Unique: lp6rQmGeMmm-s2YUGYmbSA-1
Received: by mail-qt1-f198.google.com with SMTP id bq21-20020a05622a1c1500b002e06d6279d5so5270251qtb.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 15:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iigEMniBW4cDGKyN9CUUK0j40uMHVCfBaIIQTILpT74=;
        b=sj0ddXKE3s1uQYFcjcltX7X8gZj/ZWv7/viley+pSaJLEj88SW7gRpqXGNy+1wh0nE
         +zMUNJEf3gj3IoCyUg40kVWi+J33IBnBmUrNVslt/+mDVlcomONthoX8H4vIq5vhAnZV
         e4iPG+xXJs8V6T9bR5+KGuSxhIIWpFjswxq8MMelXsUOlLSd4oRnWnvFtys/BIQc4EJM
         yI6LjJqViZb0Nr9j1zjPkho4FkpYVd85kV1muRSiWCtzeQQqQDQt0VWuGpT4FXnxrzAc
         hRMUJOISF8cumhIADUSVHpL4LmM1hygiwauikNqFn5z8vi8y5QE2NIEJZzYQ/48d08DR
         mcWg==
X-Gm-Message-State: AOAM533H0AkwmpiWHfPMCGSHjPYtXFHdJ5Twt9fImO4qyeH/YqJ4YyMN
        9fdFI3316njzbDnP18hAl8YkIscMxaRXYKF5C/yLKMP3+Osn0hQ4lwcEQkYK1RdF2rJKy0Lx/Qm
        Px021mZh507ZvZYNFAehfHEhK
X-Received: by 2002:ac8:7c51:0:b0:2e1:a3b3:a6b7 with SMTP id o17-20020ac87c51000000b002e1a3b3a6b7mr6162340qtv.405.1646954708048;
        Thu, 10 Mar 2022 15:25:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzZdYVt/hej+NP9MnBR8KLbsb88RCsWan4ZfQgvzscZnZrchdDUePzbeAIICc8SuT/WZdaawQ==
X-Received: by 2002:ac8:7c51:0:b0:2e1:a3b3:a6b7 with SMTP id o17-20020ac87c51000000b002e1a3b3a6b7mr6162320qtv.405.1646954707747;
        Thu, 10 Mar 2022 15:25:07 -0800 (PST)
Received: from xps13.. (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id x6-20020a376306000000b0067b32a8568esm2962230qkb.101.2022.03.10.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:25:07 -0800 (PST)
From:   Brian Masney <bmasney@redhat.com>
To:     bjorn.andersson@linaro.org
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: qcom-rng: ensure buffer for generate is completely filled
Date:   Thu, 10 Mar 2022 18:24:59 -0500
Message-Id: <20220310232459.749638-1-bmasney@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The generate function in struct rng_alg expects that the destination
buffer is completely filled if the function returns 0. qcom_rng_read()
can run into a situation where the buffer is partially filled with
randomness and the remaining part of the buffer is zeroed since
qcom_rng_generate() doesn't check the return value. This issue can
be reproduced by running the following from libkcapi:

    kcapi-rng -b 9000000 > OUTFILE

The generated OUTFILE will have three huge sections that contain all
zeros, and this is caused by the code where the test
'val & PRNG_STATUS_DATA_AVAIL' fails.

Let's fix this issue by ensuring that qcom_rng_read() always returns
with a full buffer if the function returns success. Let's also have
qcom_rng_generate() return the correct value.

Here's some statistics from the ent project
(https://www.fourmilab.ch/random/) that shows information about the
quality of the generated numbers:

    $ ent -c qcom-random-before
    Value Char Occurrences Fraction
      0           606748   0.067416
      1            33104   0.003678
      2            33001   0.003667
    ...
    253   �        32883   0.003654
    254   �        33035   0.003671
    255   �        33239   0.003693

    Total:       9000000   1.000000

    Entropy = 7.811590 bits per byte.

    Optimum compression would reduce the size
    of this 9000000 byte file by 2 percent.

    Chi square distribution for 9000000 samples is 9329962.81, and
    randomly would exceed this value less than 0.01 percent of the
    times.

    Arithmetic mean value of data bytes is 119.3731 (127.5 = random).
    Monte Carlo value for Pi is 3.197293333 (error 1.77 percent).
    Serial correlation coefficient is 0.159130 (totally uncorrelated =
    0.0).

Without this patch, the results of the chi-square test is 0.01%, and
the numbers are certainly not random according to ent's project page.
The results improve with this patch:

    $ ent -c qcom-random-after
    Value Char Occurrences Fraction
      0            35432   0.003937
      1            35127   0.003903
      2            35424   0.003936
    ...
    253   �        35201   0.003911
    254   �        34835   0.003871
    255   �        35368   0.003930

    Total:       9000000   1.000000

    Entropy = 7.999979 bits per byte.

    Optimum compression would reduce the size
    of this 9000000 byte file by 0 percent.

    Chi square distribution for 9000000 samples is 258.77, and randomly
    would exceed this value 42.24 percent of the times.

    Arithmetic mean value of data bytes is 127.5006 (127.5 = random).
    Monte Carlo value for Pi is 3.141277333 (error 0.01 percent).
    Serial correlation coefficient is 0.000468 (totally uncorrelated =
    0.0).

This change was tested on a Nexus 5 phone (msm8974 SoC).

Signed-off-by: Brian Masney <bmasney@redhat.com>
Fixes: ceec5f5b5988 ("crypto: qcom-rng - Add Qcom prng driver")
Cc: stable@vger.kernel.org # 4.19+
---
 drivers/crypto/qcom-rng.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 99ba8d51d102..11f30fd48c14 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -8,6 +8,7 @@
 #include <linux/clk.h>
 #include <linux/crypto.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -43,16 +44,19 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 {
 	unsigned int currsize = 0;
 	u32 val;
+	int ret;
 
 	/* read random data from hardware */
 	do {
-		val = readl_relaxed(rng->base + PRNG_STATUS);
-		if (!(val & PRNG_STATUS_DATA_AVAIL))
-			break;
+		ret = readl_poll_timeout(rng->base + PRNG_STATUS, val,
+					 val & PRNG_STATUS_DATA_AVAIL,
+					 200, 10000);
+		if (ret)
+			return ret;
 
 		val = readl_relaxed(rng->base + PRNG_DATA_OUT);
 		if (!val)
-			break;
+			return -EINVAL;
 
 		if ((max - currsize) >= WORD_SZ) {
 			memcpy(data, &val, WORD_SZ);
@@ -61,11 +65,10 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 		} else {
 			/* copy only remaining bytes */
 			memcpy(data, &val, max - currsize);
-			break;
 		}
 	} while (currsize < max);
 
-	return currsize;
+	return 0;
 }
 
 static int qcom_rng_generate(struct crypto_rng *tfm,
@@ -87,7 +90,7 @@ static int qcom_rng_generate(struct crypto_rng *tfm,
 	mutex_unlock(&rng->lock);
 	clk_disable_unprepare(rng->clk);
 
-	return 0;
+	return ret;
 }
 
 static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
-- 
2.34.1

