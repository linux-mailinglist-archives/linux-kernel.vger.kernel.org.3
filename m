Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF7959A58D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 20:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350652AbiHSSUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 14:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350655AbiHSSUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:20:22 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A22B9FBA;
        Fri, 19 Aug 2022 11:20:21 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id n14so693829qvq.10;
        Fri, 19 Aug 2022 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=p22/6mglB2ypxlwst5KVNhgWzoj8TxPUFJeRuYhVrUI=;
        b=O8bcs6Vc6NskQYMQGcIwBNPM8x7TBPMuq93c+ZJn1WtVCQUbuoBX9HcnpnTzwIDS2/
         xrUcuIZfDFiQiV9ywPjWWD0ENdzBCJkZ2LTOsKYKFE6elRj4IWplhZtI8ZeOGKxGihFM
         D1W36AyIhPfmB1kLLSex9bbxiYwxeAY75OA5Tx/7dO6sfqsCEjnwRAWhEoVxma59UGgy
         ynn21o95jvjv6EHZULW2Lxsg/aIa2pNNfXQ/AX/tD/jyjpreyloubiLLIW/RPTkDYvTS
         lcE4Z5To1toB6SAl6yZ5nCCXWIVtu1dXLp4XNTIwKkvlQxVYRoFhTuV1rqFyQ5lttyi0
         e1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=p22/6mglB2ypxlwst5KVNhgWzoj8TxPUFJeRuYhVrUI=;
        b=zQr+K+62d+1XusCDutQUvT3MmumcxYjOIABiqP/y+KHzi+pCNHXV0BESaFYGBR9ITU
         adckRZB69O5AnKsDejV9gWEk0U92dOeGli3GStUn3kMpNyvhRMyoWW/MD6SfH8Rym0Fb
         KWmSnQtVL4ECwlMy2E0fMI8I2JmK8Cg4XhM9Zcbad61mSi13p5DwGfUkeTuxlei3Dm6g
         E32Um9FkyDtpcsa1l0BQSlmBFii8T7MmyIk414upTPPo07J2mGtkYb8xK1xS4DZBojoV
         Z1kij9KNoeJ5dl6B/yNbrOLWBAnjpbUypDkZ7zmarq1wR09qGsa1Ia09aEd29zuPdTcj
         lUHA==
X-Gm-Message-State: ACgBeo0CivOrC5gDcHkYI5Pap9XLhxDblQ05KKuBu9XxAKMRkOwwPQEm
        fQ2fmWFDlZSgJvAptyWMMeo=
X-Google-Smtp-Source: AA6agR4oYEvRxhUPdR6vLzZ7Fw/zDC+ctWmsnKyw+4WUuSnnc9Cu+P2xDEsSinCovY9NcP5iFKCeKQ==
X-Received: by 2002:a05:6214:ac3:b0:496:31f9:1877 with SMTP id g3-20020a0562140ac300b0049631f91877mr7660312qvi.12.1660933220633;
        Fri, 19 Aug 2022 11:20:20 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id u14-20020a05620a0c4e00b006bb568016easm4063767qki.116.2022.08.19.11.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 11:20:20 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH v2] iio: Avoid multiple line dereference for mask
Date:   Fri, 19 Aug 2022 14:20:12 -0400
Message-Id: <20220819182012.219523-1-joetalbott@gmail.com>
X-Mailer: git-send-email 2.37.2
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

Prefer lines > 80 characters over splitting dereferences across multiple
lines. Reported by checkpatch.pl.

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
changes in v2:
* Don't use a temporary variable.

 drivers/iio/industrialio-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 67d3d01d2dac..d38623c046cc 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1303,8 +1303,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 
 	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
 						  IIO_SEPARATE,
-						  &chan->
-						  info_mask_separate_available);
+						  &chan->info_mask_separate_available);
 	if (ret < 0)
 		return ret;
 	attrcount += ret;
@@ -1318,8 +1317,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 
 	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
 						  IIO_SHARED_BY_TYPE,
-						  &chan->
-						  info_mask_shared_by_type_available);
+						  &chan->info_mask_shared_by_type_available);
 	if (ret < 0)
 		return ret;
 	attrcount += ret;
-- 
2.37.2

