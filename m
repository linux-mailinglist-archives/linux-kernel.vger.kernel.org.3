Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE78504E10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbiDRJA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbiDRJAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:00:54 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D26112AAF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:58:16 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id t13so17770144pgn.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bgQnFmcjl9+IwN+gQlxLVi8ouAKrKmz8WNF5PV3MyU=;
        b=ASbWLxm5SrXl6FJEnCnY7ypSb9qbPSfASDR0vvPiA9At237Dcenk6TB/pzgGPPOcl8
         GnJBP7IjWVS+x1pu5WJTda8BBdKW2qsgL/oJZJ5EdHNO6a5mCg5y2JhkIV9yD4tOJkQS
         A7xUWcNqrT6XrUT2XvapYZdsP8Mx/Sgp4SfVOZQd6iw/LM0PABTV8QxIWbU723o9QCow
         7WfP7O1uqRH4DBQtHnfm93EITaBucDW0vo5ZsMaMmzJnUjTlM1HTNPGMllj85ZWQ8AN2
         70IbsHguG8RlUgW3ngGirYEDXmpD2h52lGy7s5bXx03itOEws56sz8nSEmaPSSAK216q
         wg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4bgQnFmcjl9+IwN+gQlxLVi8ouAKrKmz8WNF5PV3MyU=;
        b=I0lbYXmyRc5L+AW4aaAskUqpHwx5/ry9X/Vl+1nG4P34ft2T39yM046TApFOAF4aeJ
         9EmKjimGbD/6Gvowfq2YbNSktUPGz6at+9Iyhy7zxpi915zJps/tAj12CVEUFQ7tuj+t
         q50Xly+tr71KVz9wPY4Vc4g4ZbSVlOrvO1eltUxPETX/cWM3szgyAZRvDnoGby+rMf+5
         nllUn6olbneNxwiZECiIZOTXTIzNLUA8krqMiUu/kNwSeQ/oAYKU2j/NH71la58IDR4p
         /6WjxyIXI/KasnxJTJISgWUwqmC4BuFnc87WDZuvHntjKgtn0pgXMuTXEC8Cc5yCf2sQ
         0D3A==
X-Gm-Message-State: AOAM532YII9pw8tIXFuWbRQOjUEql27z+oKOMgjZbKUK52Oxd9gLlpSE
        H+aEzCc5/yCMHRDYxogoZzI=
X-Google-Smtp-Source: ABdhPJyByd0/9Szc/ZHoK0EFbvgxrGROm82aX2DRv5sN8jN6OTmTBcOt/v1wrdF5DDX9RY3E4fscfw==
X-Received: by 2002:a05:6a00:2181:b0:4f6:f1b1:1ba7 with SMTP id h1-20020a056a00218100b004f6f1b11ba7mr11227274pfi.73.1650272295573;
        Mon, 18 Apr 2022 01:58:15 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id c15-20020a63350f000000b003992202f95fsm12209697pga.38.2022.04.18.01.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 01:58:15 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     fbarrat@linux.ibm.com, ajd@linux.ibm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, mpe@ellerman.id.au,
        alastair@d-silva.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] misc: ocxl: fix possible double free in ocxl_file_register_afu
Date:   Mon, 18 Apr 2022 16:57:58 +0800
Message-Id: <20220418085758.38145-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
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

info_release() will be called in device_unregister() when info->dev's
reference count is 0. So there is no need to call ocxl_afu_put() and
kfree() again.

Fix this by adding free_minor() and return to err_unregister error path.

Fixes: 75ca758adbaf ("ocxl: Create a clear delineation between ocxl backend & frontend")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/misc/ocxl/file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index d881f5e40ad9..6777c419a8da 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -556,7 +556,9 @@ int ocxl_file_register_afu(struct ocxl_afu *afu)
 
 err_unregister:
 	ocxl_sysfs_unregister_afu(info); // safe to call even if register failed
+	free_minor(info);
 	device_unregister(&info->dev);
+	return rc;
 err_put:
 	ocxl_afu_put(afu);
 	free_minor(info);
-- 
2.25.1

