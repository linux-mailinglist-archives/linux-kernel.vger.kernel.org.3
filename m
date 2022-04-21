Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72C450A214
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 16:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1389137AbiDUOYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 10:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377277AbiDUOX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 10:23:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9A013B54E
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650550866;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=H5k1rgXE1P7IbK6cMqND8jHr8Tf+eEFak/sZ9mPOKJY=;
        b=XnHKpQdEXkj8ZazcxeVavhPMFNJYF9xNggM9ZTKcavrsWLHdWRvWFPAkujCELGrrCYZeyq
        GHlP+n/R+cT+c7YVocEoqIZbk9/Wvvz/jXiZWOh4PSFFUiS1qYVgZ1JjjPHHeimfbcEzw5
        xaM8c3pr5T9LPZQj5VQDXC6iuSfmmW0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-Z9VWvBWrMk66fPw5j7arhw-1; Thu, 21 Apr 2022 10:21:05 -0400
X-MC-Unique: Z9VWvBWrMk66fPw5j7arhw-1
Received: by mail-qv1-f71.google.com with SMTP id kd13-20020a056214400d00b0044c066d97dbso2273855qvb.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 07:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H5k1rgXE1P7IbK6cMqND8jHr8Tf+eEFak/sZ9mPOKJY=;
        b=EPjr6R1u1153nfsS8aqbIeY3rNwTDEyfVEtK86+0VAzShO4MBHO/47sGRQW3BFpLr1
         W8Gw/GDRF5DbUlxhNHmI7yvGP9e4PM54fTTmg6rh+BS6lNWMxNLrXUSYok+Tn0uJXqJu
         LOYmYBROmKByFjQ8d5Q1xuzN/syJluw+ddpxW+FG4OIF+tihE1jGTjAs4p3PnY2S0rAQ
         yxWoL0+SL0yYfGbe0kj7zHVdJLYyIIbtRTsyPQs51qjzJYybrNnUFoD5UML9EhYy4hAH
         e60DYu/eNi28wY+2UIawJxZPpqcGiAwrR1SLuE1TvZWhAaCi7m/QmAEANq7Jths0AqtJ
         LJHg==
X-Gm-Message-State: AOAM532UsONTELcbKiJ8kQwsByLAZpYpD75IUoN+YUiQyJ7fSIZfj9Aw
        GfYm/0/iD5de/aaNDFWodSZ5RNLWr0+6WkPs46E0Q8VUu9LgBALkiushjy5D31T4vocgr2XW4+U
        C5D+h81QJmX0jkqBizGyQ6vQ6
X-Received: by 2002:ac8:7088:0:b0:2f1:e898:2971 with SMTP id y8-20020ac87088000000b002f1e8982971mr17388772qto.152.1650550864999;
        Thu, 21 Apr 2022 07:21:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxT8nLASqLzLkqUhCnNzC+DSX/0wzDIp2IM7/27GwXj/kq8GhqiNKzl6Dba3zy6dUouhyaww==
X-Received: by 2002:ac8:7088:0:b0:2f1:e898:2971 with SMTP id y8-20020ac87088000000b002f1e8982971mr17388760qto.152.1650550864784;
        Thu, 21 Apr 2022 07:21:04 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id j131-20020a37a089000000b0069e7ebc625bsm2881419qke.78.2022.04.21.07.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 07:21:04 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     airlied@redhat.com, kraxel@redhat.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/qxl: remove qxl_log_level global
Date:   Thu, 21 Apr 2022 10:20:54 -0400
Message-Id: <20220421142054.3751507-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
qxl_kms.c:36:5: warning: symbol 'qxl_log_level' was not declared. Should it be static?

qxl_log_level is defined qxl_kms.c but unused, so remove.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/qxl/qxl_kms.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/qxl/qxl_kms.c b/drivers/gpu/drm/qxl/qxl_kms.c
index a054e4a00fe8..9bf6d4cc98d4 100644
--- a/drivers/gpu/drm/qxl/qxl_kms.c
+++ b/drivers/gpu/drm/qxl/qxl_kms.c
@@ -33,8 +33,6 @@
 #include "qxl_drv.h"
 #include "qxl_object.h"
 
-int qxl_log_level;
-
 static bool qxl_check_device(struct qxl_device *qdev)
 {
 	struct qxl_rom *rom = qdev->rom;
-- 
2.27.0

