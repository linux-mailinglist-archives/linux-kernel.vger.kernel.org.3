Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679D0502A9E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353958AbiDONDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353896AbiDONDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:03:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BF037AA4;
        Fri, 15 Apr 2022 06:00:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 11so4835266edw.0;
        Fri, 15 Apr 2022 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SrualZDK1OeE+hHxc9yzBP5rZp89ReUARUf6Cm3BX7M=;
        b=Sj0NLUY5duNggwuEyy+54BJqTQ4hnqX52g9r+pUbfn1tAnvrrhlIAuLAIBag6IjbfI
         FKNSNNZWxV/DfXgDdeqJEwLPrhpncNSdUfVbwAdVKIjC/Q2wObssqtbdnHXBO8iV4aci
         fC7JPMcBARyJie/u9gGKXujU1yYiynBD3oF43iRXxMRTd2Sgtqj4CpJKmIFxodMfepqj
         lIOlCNVEX/I+FDYFzvLznY6hwfq7jTiK4Nd8UgiJQczV9n9sHY2yUIDw4e0dUFFbdAjX
         xoKOT/910z5H8kGreNdDuCJGWOiUOBNem1NUh34XIY4pKB2/TlMQWigUFtlWPNiMalID
         Z5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SrualZDK1OeE+hHxc9yzBP5rZp89ReUARUf6Cm3BX7M=;
        b=QhaOREF+tG3j0qKuhsnhUFeM9CkzOTMn+iLNfJ4N2wH62qB0ntzXLIFRiH4nwOruPa
         RZhVuuiZQl1vuf3qYs57jnvyRzlZRyCnm3szVwILsncyWE45x9YoRxjq51LsIYuXcqOc
         FAKkzbH4W3j1/WAQxyicLjNruoVBtvgOdPH19ggqlVV1HM6V6DHQS1BPpxxwflqUm6mr
         7oS5zhqW2uRzIgNY+XUEC+xi6/7psm1fjnZ4P1ulFrX07BM6Fz1ytYO5ud7uafRSPG6s
         fCG+w13Hmia0CZdMFOHTuJmGZnS/uoRUkHypwvZnaNBVek9qMF3ze03HwnFolW0KUijq
         JN5g==
X-Gm-Message-State: AOAM531rWz5NUitILUc4yvf2ViHj7iGgoI8eP6FR4AvSJ3ZIYe1Po66d
        wWDCwaJSiMvj0qqVQi2fcMk=
X-Google-Smtp-Source: ABdhPJx/8zp1Ctsac5+9TUZU8TEgvdXtVPDJDXwzTDByDEcWGfn/D+0z36rYuYtNSuYRkzAtP0gLZw==
X-Received: by 2002:a05:6402:14b:b0:418:d06e:5d38 with SMTP id s11-20020a056402014b00b00418d06e5d38mr8009093edu.90.1650027630786;
        Fri, 15 Apr 2022 06:00:30 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:30 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 07/14] iio: add support for binary attributes
Date:   Fri, 15 Apr 2022 14:59:58 +0200
Message-Id: <20220415130005.85879-8-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
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

From: Andrea Merello <andrea.merello@iit.it>

When a IIO device is registered, the IIO core creates an attribute group on
its own, where it puts the channel attributes, and where it copies the
attributes in indio_dev->info->attrs.

Unfortunately it doesn't take care of binary attributes (i.e. it only
consider indio_dev->info->attrs->attrs, and it ignores
indio_dev->info->attrs->bin_attrs).

This patch fixes this.

Note that while it is necessary to copy the non-binary attributes because
the IIO layer needs more room to add the channels attribute, it should be
enough to assign the bin_attrs pointer to the binary attributes pointed by
indio_dev->info->attrs->bin_attrs.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/industrialio-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index aa5f98d3b334..aef30f0b9465 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1567,7 +1567,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_clear_attrs;
 	}
-	/* Copy across original attributes */
+	/* Copy across original attributes, and point to original binary attributes */
 	if (indio_dev->info->attrs) {
 		memcpy(iio_dev_opaque->chan_attr_group.attrs,
 		       indio_dev->info->attrs->attrs,
@@ -1575,6 +1575,8 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 		       *attrcount_orig);
 		iio_dev_opaque->chan_attr_group.is_visible =
 			indio_dev->info->attrs->is_visible;
+		iio_dev_opaque->chan_attr_group.bin_attrs =
+			indio_dev->info->attrs->bin_attrs;
 	}
 	attrn = attrcount_orig;
 	/* Add all elements from the list. */
-- 
2.17.1

