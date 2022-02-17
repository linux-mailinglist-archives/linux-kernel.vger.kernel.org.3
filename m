Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0024BA5E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiBQQ1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:27:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243105AbiBQQ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:27:38 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1259AD9B;
        Thu, 17 Feb 2022 08:27:23 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q17so10663196edd.4;
        Thu, 17 Feb 2022 08:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSuUmbEeDLXS2kqjz3k+0c9MegG2g3h/fyFjY4bgFs8=;
        b=mSxm2wBBQzSJV97jikv7wxwCMeufivfazFsWydlImISPPEnfh857cWA76sowIR3aja
         fWJWAulXIkG1xOp3BpwqiBYVbHbCWKFFTY6DLpDdV+BBjdtT0O5FuxVftg3VjrdfS97r
         AtqlGZfyab+WbEQYD5RCoM6LEF5uDBag3AjlcHcrKxGfpFUXDTUMjrQebqd+33SR7doV
         G1RURDhxW4CUsGDpyTYHHKI1CyCau6XCYnSFgug+6/pkAm7SBxwCqH6LStIyqGij0QLo
         MwhCax51GKjbtV/6fD3Z/mU8ceb6u/gofePHvlDTbLrfo6aFDRZI3lg8lSn30ZMI+uss
         LFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSuUmbEeDLXS2kqjz3k+0c9MegG2g3h/fyFjY4bgFs8=;
        b=4AdJkfpW7IiXPunMAxZD3MuZvYUi+vVdhRoEDgRdBQTPoC3cc3UH54Wn5rzx3YI7fy
         //m/FrJ6vVnof41fBgimI9K2lamXVSrO4+HFW8bdCXdM1jSnOMpnRtiWpwGUHn43+zAT
         PaeRB16gTFsqJDRoaRAVjUfapZFLlI5jbhMOzT+qqg2ibh1WxtJNVNJtG/DxCyC2CWeV
         lo6vlfjGK2JbIfDOZCCwrHVz1XVUUVLN7JiXBj0i5TzGOycwSfloXN0MIRZ7gGVdLYFJ
         vWOa799Ft6PHeu6ACESpJNeGSpiFJ1i7Vfc4pJ/obQYaD1e3hRBi0A5WmWnecwF+FfA1
         mczw==
X-Gm-Message-State: AOAM530zQUT/bLyiwiQpTfeW2Hch1UvRLhhbsyLJHXlrzdJl/Y/qzHO0
        mZWeJmadPsOmg1J1hfmR6bU=
X-Google-Smtp-Source: ABdhPJzkLQa3VdybrilYvKXCKp+OQHX1LXQ2FfusdVo0VE/2wF9mlpVipP1dalBvEXpMNqYLAtU1Ig==
X-Received: by 2002:a05:6402:5110:b0:403:dbc0:2a47 with SMTP id m16-20020a056402511000b00403dbc02a47mr3555636edd.197.1645115241997;
        Thu, 17 Feb 2022 08:27:21 -0800 (PST)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id j13sm3653742edw.24.2022.02.17.08.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 08:27:21 -0800 (PST)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@gmail.com>,
        Andrea Merello <andrea.merello@iit.it>
Subject: [v3 01/13] iio: add modifiers for linear acceleration
Date:   Thu, 17 Feb 2022 17:26:58 +0100
Message-Id: <20220217162710.33615-2-andrea.merello@gmail.com>
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

This patch is preparatory for adding the Bosh BNO055 IMU driver.
The said IMU can report raw accelerations (among x, y and z axis)
as well as the so called "linear accelerations" (again, among x,
y and z axis) which is basically the acceleration after subtracting
gravity.

This patch adds IIO_MOD_LINEAR_X, IIO_MOD_LINEAR_Y and IIO_MOD_LINEAR_Z
modifiers to te IIO core.

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 drivers/iio/industrialio-core.c | 3 +++
 include/uapi/linux/iio/types.h  | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index e1ed44dec2ab..252dbe3444cc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -134,6 +134,9 @@ static const char * const iio_modifier_names[] = {
 	[IIO_MOD_ETHANOL] = "ethanol",
 	[IIO_MOD_H2] = "h2",
 	[IIO_MOD_O2] = "o2",
+	[IIO_MOD_LINEAR_X] = "linear_x",
+	[IIO_MOD_LINEAR_Y] = "linear_y",
+	[IIO_MOD_LINEAR_Z] = "linear_z",
 };
 
 /* relies on pairs of these shared then separate */
diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
index 48c13147c0a8..387a1b5cd1a9 100644
--- a/include/uapi/linux/iio/types.h
+++ b/include/uapi/linux/iio/types.h
@@ -95,6 +95,9 @@ enum iio_modifier {
 	IIO_MOD_ETHANOL,
 	IIO_MOD_H2,
 	IIO_MOD_O2,
+	IIO_MOD_LINEAR_X,
+	IIO_MOD_LINEAR_Y,
+	IIO_MOD_LINEAR_Z,
 };
 
 enum iio_event_type {
@@ -114,4 +117,3 @@ enum iio_event_direction {
 };
 
 #endif /* _UAPI_IIO_TYPES_H_ */
-
-- 
2.17.1

