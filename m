Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05450DE3D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 12:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238421AbiDYK41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 06:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiDYK4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 06:56:23 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1575814B7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:53:14 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id j9so10443343qkg.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 03:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nng+cuOZXEHqgBLxg+EFCILX+xKl20bMRqTLzQmAT+U=;
        b=pHDouWVUlROIktaXFvN8miGDnrFxxKbLC4wFfNzrdcs7nhlsxn8uGOENdcPRua02x0
         r6W49/A7A3WcoC84dlyrB3ux2fUaXrDZtAGW9s+bC1qwTNTfNv1bLxp+p3voQNetpXKp
         WW6EPzErPQyHVbyfg37Nz8pekw6R4O2cCa9jOh6sSx2kOY6oDf497+IbjcTn22mpmrir
         zRPztjgffzc4o634TPWGJwOxLusEabIzkHxm4kONyUeWieObTOyXVFaSwXngSx+YmD0a
         jjS3NsRNVIC20ZEx9q4lmJ5yEJ2bhdJsbGSm3KYuNiwwn3O9h/6TFsxdKXGaIVNqIHt0
         DbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nng+cuOZXEHqgBLxg+EFCILX+xKl20bMRqTLzQmAT+U=;
        b=HMYl2nLCrpFDG5Ct8s/Z5kege0xfiJ04b33rMOLTWvEQueTyohe2ItRooQgOaeq8H2
         HXgnYBpG2fPsVzpEOAoC8FL1bNQYyAN3tIahLdqmRmMKrsz/ndHYZlUyffYA2w859ZNA
         YiodKOmO1FBspAr2iRKYXqSuvwIVzlBeUgcANSpe77dkNpsmwnaAlZcjEPUwO8sm2GLu
         dFIsgKCqua7YduJibdgrpYtHkn4W4hzFxPJ+1N2J93lugMwkezZbEy5JMDCLpi6lv4Mh
         FlzxYnOx/A8V2gP4N64dP76SdbKVZUAcYm1I9LHFIUGc8saUJL3mwHrnvbldVwXqgRBj
         v1hA==
X-Gm-Message-State: AOAM530r61lp6RIt/7sEMAM3QKTmSX16br4VOyRirubRsi8OUUD08LJG
        DDR4Amt4kOcClqi6FC3ihJw=
X-Google-Smtp-Source: ABdhPJw4mgvJV9J7kPiDJloD9/keX1rjWVz5uMEwpVFnuDTiR37Bbvktx8338MASzNtnoiv6tNU1Aw==
X-Received: by 2002:a05:620a:438e:b0:69f:5296:fac with SMTP id a14-20020a05620a438e00b0069f52960facmr2671788qkp.719.1650883994069;
        Mon, 25 Apr 2022 03:53:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h20-20020a05620a13f400b0069e7ed38857sm4679973qkl.103.2022.04.25.03.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 03:53:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
        Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] device-dax: use kobj_to_dev()
Date:   Mon, 25 Apr 2022 10:53:07 +0000
Message-Id: <20220425105307.3515215-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/dax/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 1dad813ee4a6..aebe884f5d99 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -512,7 +512,7 @@ static DEVICE_ATTR_WO(delete);
 static umode_t dax_region_visible(struct kobject *kobj, struct attribute *a,
 		int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj)
 	struct dax_region *dax_region = dev_get_drvdata(dev);
 
 	if (is_static(dax_region))
-- 
2.25.1


