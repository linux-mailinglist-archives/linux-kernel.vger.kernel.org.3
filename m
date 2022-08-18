Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB2F59838A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 14:59:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244838AbiHRM6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 08:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244282AbiHRM6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 08:58:50 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF7F4D177;
        Thu, 18 Aug 2022 05:58:48 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id e28so1016115qts.1;
        Thu, 18 Aug 2022 05:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=vmnr7Oq2CFwtN0XNDBv9DKOFrLf4DdncpkvmIEVLD14=;
        b=fzrUAFugfImQXQOOUfd1cequ6NzY6CKKx0OHX0SaImyMWDuWOHxWw90vo1dB0vvxaV
         8ld9sGkp6NdgRELkfxDJOrxoQH8gXPdLb64nDn2n2EnY6zZ+MhvayFmdabxfTiHZMHd5
         XBDOOV72CRxCkMQexB5jhoQOZXqDbaOBfYw0o4pSs3hnCCZM1yi8Z5OcTfs4+bhAW8Q9
         2CDcm2e21YGd1uufTHHJGD5qcF5//CSfNnSvvcZqT+SC4KUS9hcmEQXrcdpKQ16xpg3I
         GzZWvnKNinI0CT6wi7KmOJjrqJi4X5tRWo6n6iCJ/sEntve81oxaxpPkoBbKFgbHOFUW
         n36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=vmnr7Oq2CFwtN0XNDBv9DKOFrLf4DdncpkvmIEVLD14=;
        b=p3lG5WoX+IwuBwBPclpdwvrMICB91lxT7ZD21VlhvHorsAFZKf8sWJrPaPaLyrSveK
         Bxnq+Xsj3YqKfTcNSazxb32Reyqf9eYiZG0SeL33x5ix95ahSAl9blvQzuV8HojJxPAp
         DUPwaeQgnsFP+11Njn2rHQNiG0ztD+dEkFKdJw1NwH9G3sReP9nU2jEUWEEO9XbGgA5D
         9X5Q3R8vJaAainG2pcjkXh3jAG/9BvsLZPFiJnpma3mBmY4qtU5OCZ05RB+knVuXWTNE
         i9PIlVA68Hjf+b2fv93bPymr9ssD2lY6z7ERRUKRpPnYhhaBWjoBzqt2SNy7SPkjfjcC
         dptw==
X-Gm-Message-State: ACgBeo2IDyB0/AGO4+sO/iqV28earZOYZc73cuMdZzgh1Pzl4VZZKS5D
        rSDQikagK1e+Yj2OszUXGGY=
X-Google-Smtp-Source: AA6agR55/MxUF4h5TTWKlgj+CsV0/if4mHseg+S+ndPN3BNRNhXIHoRIGRZzxDFL4VdtjtP9YxXjsQ==
X-Received: by 2002:a05:622a:654:b0:344:765d:3f26 with SMTP id a20-20020a05622a065400b00344765d3f26mr2430322qtb.142.1660827527743;
        Thu, 18 Aug 2022 05:58:47 -0700 (PDT)
Received: from spruce.. (c-71-206-142-238.hsd1.va.comcast.net. [71.206.142.238])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a411400b006b9a24dc9d7sm1442158qko.7.2022.08.18.05.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 05:58:47 -0700 (PDT)
From:   Joe Simmons-Talbott <joetalbott@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Joe Simmons-Talbott <joetalbott@gmail.com>
Subject: [PATCH] iio: Avoid multiple line dereference for mask
Date:   Thu, 18 Aug 2022 08:58:44 -0400
Message-Id: <20220818125844.60762-1-joetalbott@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mask variable to hold dereferences that span multiple lines.
Found with checkpatch.pl.

Signed-off-by: Joe Simmons-Talbott <joetalbott@gmail.com>
---
 drivers/iio/industrialio-core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 67d3d01d2dac..549f2254c258 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1291,6 +1291,7 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 	int ret, attrcount = 0;
 	const struct iio_chan_spec_ext_info *ext_info;
+	long *mask;
 
 	if (chan->channel < 0)
 		return 0;
@@ -1301,10 +1302,9 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	mask = &chan->info_mask_separate_available;
 	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
-						  IIO_SEPARATE,
-						  &chan->
-						  info_mask_separate_available);
+						  IIO_SEPARATE, mask);
 	if (ret < 0)
 		return ret;
 	attrcount += ret;
@@ -1316,10 +1316,9 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	mask = &chan->info_mask_shared_by_type_available;
 	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
-						  IIO_SHARED_BY_TYPE,
-						  &chan->
-						  info_mask_shared_by_type_available);
+						  IIO_SHARED_BY_TYPE, mask);
 	if (ret < 0)
 		return ret;
 	attrcount += ret;
@@ -1331,9 +1330,9 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	mask = &chan->info_mask_shared_by_dir_available;
 	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
-						  IIO_SHARED_BY_DIR,
-						  &chan->info_mask_shared_by_dir_available);
+						  IIO_SHARED_BY_DIR, mask);
 	if (ret < 0)
 		return ret;
 	attrcount += ret;
@@ -1345,9 +1344,9 @@ static int iio_device_add_channel_sysfs(struct iio_dev *indio_dev,
 		return ret;
 	attrcount += ret;
 
+	mask = &chan->info_mask_shared_by_all_available;
 	ret = iio_device_add_info_mask_type_avail(indio_dev, chan,
-						  IIO_SHARED_BY_ALL,
-						  &chan->info_mask_shared_by_all_available);
+						  IIO_SHARED_BY_ALL, mask);
 	if (ret < 0)
 		return ret;
 	attrcount += ret;
-- 
2.37.2

