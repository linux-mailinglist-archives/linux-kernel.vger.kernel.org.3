Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389804D185A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346722AbiCHMyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiCHMyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:54:09 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEF930F55;
        Tue,  8 Mar 2022 04:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1646743985;
    s=strato-dkim-0002; d=goldelico.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ZOvjYMQJYuSAVm7O4zUbUg4wy9kHYFszMrdfygxpWys=;
    b=O8RdOKrMTmwe9zOW6kqefvinD0r7fr3s6gvUeGqRv2GX4fhgZ9U5SeOF0FIGOI79j1
    ly/I034R7Yt7Wv91wG0PKBtH20V5vxOACjIq6Mb9hgjDue/1U4B08EjnPyB36rHN8ktZ
    FL9R+oCO5UkVp4Nfpjew8pWk/h3U+U3XdXyBf5XKjggaZsxacxhaQ8eZs0AUzhoUZcmK
    bgYxLt9RO8k2HOU8FZrSKOncZ7wfIwBaU8svYtdhBueHCT87yw+cTbEQXdw4jLM8gX0V
    7fI5rG57+41O5ubL/kAV7E8+rPVpXEzGbpU5JC+LdavnRvN1XV3mgBMXRYbZlQim3Pdv
    KiZg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbpc9Y="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.40.1 DYNA|AUTH)
    with ESMTPSA id n729cey28Cr4SGq
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 8 Mar 2022 13:53:04 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, linux-omap@vger.kernel.org
Subject: [PATCH] iio: palmas: shut up warning about calibration mismatch (due to noise)
Date:   Tue,  8 Mar 2022 13:53:03 +0100
Message-Id: <1cee45bfc3fa2ab59dcc17242fb52468035360a1.1646743982.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although technically checking for ADC values below 0 is correct,
because they are outside of the calibration values, there is usually
noise which spuriously fills the console log with error messages if
calculated input voltage gets close to 0V.

Ignore small negative calculated values, but clamp them to 0.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/iio/adc/palmas_gpadc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index f9c8385c72d3..bcfa6a7f6cb2 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -376,7 +376,8 @@ static int palmas_gpadc_get_calibrated_code(struct palmas_gpadc *adc,
 					adc->adc_info[adc_chan].gain_error;
 
 	if (val < 0) {
-		dev_err(adc->dev, "Mismatch with calibration\n");
+		if (val < -10)
+			dev_err(adc->dev, "Mismatch with calibration var = %d\n", val);
 		return 0;
 	}
 
-- 
2.33.0

