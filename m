Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A544BA5D5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiBQQ2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:28:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243147AbiBQQ1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5859BB8A;
        Thu, 17 Feb 2022 08:27:33 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so10729385edn.0;
        Thu, 17 Feb 2022 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/GuBSZT3gYUl9WUuyRcBD5kTPc3HH/CTyiu6CHm9clg=;
        b=Wm8FALi5Hf4NclLp1g8m3iDtxtl6w8nxMgEgI0RyE85tZBf/JzcCJM5F95qY6pW9qf
         oNw3POdVmOrNecKK5Tm6j3C3P8VzZbBU/XX0/TkyPXgOQeQMyXVwshIR9lMqNQBAKlDM
         ON9EmoBVc7LoZsF5FFov5dhGo526GzjobehxQora6mdcCgP9FGr5l9QdnIxgCj3MzVjT
         WUaBn++cNiSNrYvpSjn7qE/4nPNfzSGXFQvTUi6Qnw39Y9uFHIVvF1sGv/XUDxk0+yAB
         DTTO+1+c8XHAPiCxwRYBQ6U20u/2coUBcSBwTU+sgz5T79ZV5A+ew7zyhSQsAihi+zs3
         kI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/GuBSZT3gYUl9WUuyRcBD5kTPc3HH/CTyiu6CHm9clg=;
        b=XN0lMV9RMJrXffMPl0lENgG2As5zKcdkhHcv3CKDwRjnjrC1A++emYpAxsbSt9gYmV
         EOAZiirjLpyXQI59DpHlef3WSA6mIQMGnC+B8cUOq4eAUh07W+Jam0+dOqRZd6fKZ3QB
         43A37WDV8JtiDSeTzPTZh9gyftbq+akRGLTngKl1pECxhbS66vTOfsV0Sb75kRhFyUth
         5P4nXRajjcdoOsUsC9V1SmRZKHc4XuKX8L1TzCBzQFlEITYfLhcgfp9R9J2V6WRkYUei
         x3LKUG1H41GDv0ynvlo4Zo2NGI7rbdrE3CCmwemTGqb/CZCFNmyB39BmBNckCsEWqNmz
         oatw==
X-Gm-Message-State: AOAM533cp97/ETeG8Qk+AwesFNtLRe8L4fBBm2zzsYlBLVDBDR+MgJjw
        Z5LhZT0vBhrPxCK48K5m17EnB/m5DFJEFC8F
X-Google-Smtp-Source: ABdhPJzUMjNQN/re+jPHV80Ub6x2ggTg2L7tiNQTBIFCtX39CG5GroijnFzdEuPZKjwpxYpwvaID2w==
X-Received: by 2002:a05:6402:cb:b0:410:8094:872b with SMTP id i11-20020a05640200cb00b004108094872bmr3402607edu.378.1645115251649;
        Thu, 17 Feb 2022 08:27:31 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:31 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 09/13] iio: document "serial_number" sysfs attribute
Date:   Thu, 17 Feb 2022 17:27:06 +0100
Message-Id: <20220217162710.33615-10-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217162710.33615-1-andrea.merello@gmail.com>
References: <20220217162710.33615-1-andrea.merello@gmail.com>
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

This patch adds ABI documentation for the new "serial_number" sysfs
attribute. The first user is the bno055 IIO driver.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 1b8d77577608..224585f00147 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2017,3 +2017,10 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		Raw (unscaled) euler angles readings. Units after
 		application of scale are deg.
+
+What:		/sys/bus/iio/devices/iio:deviceX/serial_number
+KernelVersion:	5.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+		16-bytes, 2-digits-per-byte, HEX-string representing the sensor
+		unique ID number.
-- 
2.17.1

