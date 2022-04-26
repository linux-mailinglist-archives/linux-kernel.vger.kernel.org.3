Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF7C50FE8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244443AbiDZNOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350717AbiDZNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:14:32 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3171A606F3;
        Tue, 26 Apr 2022 06:11:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u3so25431852wrg.3;
        Tue, 26 Apr 2022 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oeT1FvLOa8JEDQeobwvTwbj2GX9Dxb+xKllSoYkKFP0=;
        b=HQgPxqwYMJMHhDFF7wulVElHGuAdUOtvSREJBMZb9pOJPag9E6FRflMwHcM77eNN1O
         A2Hqw3Jrvxw1DjYrWELKPZJlmi7nm3xdqHe38ZXtYR6Cg5WqsjLjeGvQ2cGytaupVIka
         uhl1nYFdY0ZouE/Uvxxl7L/LZ1oKNr4wF/macgg1i7QUdyhJDKW+LCaD9pjX+KJPDE1c
         ZxjTARXytdkXHd54uvAjCf8kCbwA/WRQgjgQYI8oZR3BXfN1uV9NjyFJIkLPMoZ2GVOh
         zXdDoDUB5x3tLjka3+PeLKYDrBqSnCILrx4SUb0rZPOEOVlybhxuP3mw24BZZNAlMvqY
         oa7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oeT1FvLOa8JEDQeobwvTwbj2GX9Dxb+xKllSoYkKFP0=;
        b=vTNdTWe0Y7RAJZqbPmKIi4FL5uJbXXHQixye6zHZAURS8sbQR52bKUXOxDdimV43tq
         MWSiqa6LrX/u23VS9PyS6uB7g3oYasmX8yiwFvToOS7TSuOQZrZ0hL5TBCsze2w46erS
         nLSeyMIGgDySg3ebPFvTly+jNlaWSrnZ6QsBPmxJQwJy9BVulnGETVG2iskfHZ5hNOfa
         gH0VGl6DwWSHO7lyBXS1uuZtzFvJ0hTvVBecbEnvuEz8rRqM1vjsoVgIpCFwbdBoIYyz
         ULCrPpIqrMiHgb/rtHzU8JI1haDJ+GSS65KfKiKXGE/DlVTO/nx2BpV6e7y3n6W+mOH2
         +uNQ==
X-Gm-Message-State: AOAM532X8EUuN8It3GIyhQHBTgETYQ8WsnMNbMs2kyrydE/wEf+5Mt7l
        CnG4OVugjp4SEGsPqX8pEx2c1inpcEuAgCtA0iA=
X-Google-Smtp-Source: ABdhPJwFY8Qid46Jvyj+d7MJyQJ8hm3Nxj2yZ3crTgtSo3Lo38HW2oFa3qTsNnIFxwDCkkP/Epl5gw==
X-Received: by 2002:a05:6000:718:b0:20a:e310:664f with SMTP id bs24-20020a056000071800b0020ae310664fmr3659312wrb.22.1650978674782;
        Tue, 26 Apr 2022 06:11:14 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b00393f01c8f00sm3262910wmq.47.2022.04.26.06.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 06:11:14 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v5 07/14] iio: add support for binary attributes
Date:   Tue, 26 Apr 2022 15:10:55 +0200
Message-Id: <20220426131102.23966-8-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426131102.23966-1-andrea.merello@gmail.com>
References: <20220426131102.23966-1-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Fix this by making the IIO layer take care also of the binary attributes.

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

