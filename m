Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929D34BCA16
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbiBSSnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:43:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242890AbiBSSnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:43:15 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F7275C8
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:42:41 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4BEF7407C7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 18:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645296154;
        bh=Yp6ZDVV8RuEvdp6hHMI16oZzyQVBXO+fcxhml4rBHaw=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Skl7sjGdElSgFUb+BGf+eV9+omYgvMDKgF/4uLlFUlEJnxwz5f8M6UjAb8JZ87vs+
         ION4cj51MWVjx0tTSz2T5BjXrMVSzkP/MgivpSXp3fnaS3/qwV9eZQZGEP85fVTs5t
         vz0oh5x6LVRO7rhcmyFYNgfacxS8TtXfylaL5KQFvuVyjDX5QW04eBURuiAdxLuPqW
         /NFkF69XEjGs9TDafeFDEfsZIp7dN5lLX1SJgPZShTx2EcOIM21NbPNq4pzaulqilL
         YtZBO0J9rER4mkvIvDTq4eA2ZlcPqEzWoy9KxeB/qKjrdL8yuhXdcZ/gRxpO4PHFHu
         9/n/5Fump2WtA==
Received: by mail-ed1-f71.google.com with SMTP id m11-20020a056402430b00b00410678d119eso7550024edc.21
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 10:42:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yp6ZDVV8RuEvdp6hHMI16oZzyQVBXO+fcxhml4rBHaw=;
        b=tk21VOwfW+RdxLrKy7Wj92rmSWSfmlYiblcyuShm2rwO7FTGDl1UqrVx4v5gqqZn+N
         Zj4SPki0qhUkMPEp1JvIxOc6aN1DmiI3jspYvDxZ1TfxLnV/2MZdGwgoxR2VPEfdYiAR
         V/OkHwh0hkNlM0DlX8EzvwFPk4JkCpKcUrtEqENmWA3JvZ73XiIzmsDqABiQVN5O3am6
         nY+C0DO/GRZEOqwLlnSefw39saShec6V69THYjpgmVekSLDC9Fi0OEouoOIE1L7Cy5pY
         sRnWvN8jswUsJqjUYqSzn+STTIO0y65El2kaHypTX16G8qTV9IF1+bBpMlUDJl3q6wyn
         hVsw==
X-Gm-Message-State: AOAM531zWHxGPstoko0z+Bs8V1m+qJzVlfRPH5wU26BQSmSiKAJngeL7
        eZWGbKUV8QvgVOeIV/z8wWN6Juh4a32S65hmRc1oSvHisoWzIGwtdeENfrENF7oAmGoOlqjHRvm
        iMGZ6Yg/FNJXFKENfYGSEannzut8zkQgb5DpGe4t8Zg==
X-Received: by 2002:a05:6402:1101:b0:40f:5e73:5205 with SMTP id u1-20020a056402110100b0040f5e735205mr13379898edv.257.1645296153598;
        Sat, 19 Feb 2022 10:42:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzihHyyQD453+4jTvxERpvF04T5eHUo/H9b//fa08OUYH6m/rvV7hmav6CIPGVETOvexJF/8g==
X-Received: by 2002:a05:6402:1101:b0:40f:5e73:5205 with SMTP id u1-20020a056402110100b0040f5e735205mr13379880edv.257.1645296153425;
        Sat, 19 Feb 2022 10:42:33 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id j8sm6680745edw.40.2022.02.19.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 10:42:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Wei Xu <xuwei5@hisilicon.com>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jan Kotas <jank@cadence.com>, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [RFC PATCH 4/8] scsi: ufs: deprecate 'freq-table-hz' property
Date:   Sat, 19 Feb 2022 19:42:20 +0100
Message-Id: <20220219184224.44339-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
References: <20220219184224.44339-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'freq-table-hz' is not correct in DT schema, because '-hz' suffix
defines uint32 type, not an array.  Therefore deprecate 'freq-table-hz'
and use 'freq-table' instead.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/scsi/ufs/ufshcd-pltfrm.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd-pltfrm.c b/drivers/scsi/ufs/ufshcd-pltfrm.c
index 87975d1a21c8..2b192477d158 100644
--- a/drivers/scsi/ufs/ufshcd-pltfrm.c
+++ b/drivers/scsi/ufs/ufshcd-pltfrm.c
@@ -47,8 +47,9 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 	if (cnt <= 0)
 		goto out;
 
-	if (!of_get_property(np, "freq-table-hz", &len)) {
-		dev_info(dev, "freq-table-hz property not specified\n");
+	if (!of_get_property(np, "freq-table", &len) ||
+	    !of_get_property(np, "freq-table-hz", &len)) {
+		dev_info(dev, "freq-table property not specified\n");
 		goto out;
 	}
 
@@ -57,7 +58,7 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 
 	sz = len / sizeof(*clkfreq);
 	if (sz != 2 * cnt) {
-		dev_err(dev, "%s len mismatch\n", "freq-table-hz");
+		dev_err(dev, "%s len mismatch\n", "freq-table");
 		ret = -EINVAL;
 		goto out;
 	}
@@ -69,12 +70,16 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 		goto out;
 	}
 
-	ret = of_property_read_u32_array(np, "freq-table-hz",
+	ret = of_property_read_u32_array(np, "freq-table",
 			clkfreq, sz);
 	if (ret && (ret != -EINVAL)) {
-		dev_err(dev, "%s: error reading array %d\n",
-				"freq-table-hz", ret);
-		return ret;
+		ret = of_property_read_u32_array(np, "freq-table-hz",
+						 clkfreq, sz);
+		if (ret && (ret != -EINVAL)) {
+			dev_err(dev, "%s: error reading array %d\n",
+				"freq-table", ret);
+			return ret;
+		}
 	}
 
 	for (i = 0; i < sz; i += 2) {
@@ -99,7 +104,7 @@ static int ufshcd_parse_clock_info(struct ufs_hba *hba)
 
 		if (!strcmp(name, "ref_clk"))
 			clki->keep_link_active = true;
-		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table-hz",
+		dev_dbg(dev, "%s: min %u max %u name %s\n", "freq-table",
 				clki->min_freq, clki->max_freq, clki->name);
 		list_add_tail(&clki->list, &hba->clk_list_head);
 	}
-- 
2.32.0

