Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DD6545D03
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243281AbiFJHQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346548AbiFJHQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:16:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0238D289A24;
        Fri, 10 Jun 2022 00:16:42 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r71so24036632pgr.0;
        Fri, 10 Jun 2022 00:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lgzEz9lRcUr2RYERuVGP5XDTC+Uf7I5b+LB1N9h1spE=;
        b=q2PMJkfm1ETHt4f049NuUaYxAAuOMKlnAVBt+XRRdNfk/4+OAnk71WQ3bvywJqQvad
         Kg0DkoqI41YFdFZH8kpEwBCiFajiRFgIYWhFxPfh94XSGwjjsNvXQitBK4wboCOkIO/U
         zzMmc69MkBl6D5tv3bINw4tmr9CqYlknjrg/2fof8zwX4HKczpSipnVynBWknk0fE+3x
         yFVNFEVC7sXYmS2XmYyu/Qj8JfDGwrTuYCqF7/MT/P9C9tx+Q04Fc9m62T4zU6e9xcwk
         HHGXoETK9ka/0spK+Qv5Kq/kwV6jeZswaa3mDJrLjcO7X293zkVZMXYdq+3H/p3C6Uwk
         ujGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lgzEz9lRcUr2RYERuVGP5XDTC+Uf7I5b+LB1N9h1spE=;
        b=pJ6uJXiy0musQjbzgeSzT73k+79eH49ykOBF+U1h7NzHG5egsmYYTv7jlBxfEpuILw
         wmbt6r2EEKMEN+JLUmgab4kppk7EXSbsRSa+fPcAyUv01TMB2m1lF+6HuMHZDmcOASf8
         nXPcrSeW2Z/7hoSYG79dNKMviPBWYMNyIlNBXtE8RNlwp8qZfHD3jVsNsoxpS2E9V+z8
         TTuU5Oe8aKsXm2NeJ4qL8MIGOubYIr/L8t6jsE+Xh5hXP7frf6xorLV1wGT+AWc2UIAr
         cLGLgRFAcSgmhmaKTJ12+T9xGatAqHrqCQEi6FbIdkb8tVHvWbk4j8lAdh+iTSmQa5RG
         io7A==
X-Gm-Message-State: AOAM530jC013Y14dc9b5kA9eXBjWf4d0FxogL9c9BCf8ogMAiFDswq+/
        7ARfMEjQYsDHoJxIe5SoL9Dete6S95Ga+EVliEM=
X-Google-Smtp-Source: ABdhPJxbbscPEi1voRkLIcYVArvuegPD6owbBYbVKro6UuSK89jyGZ8rENgl+xpfcs7m9W+BumF+/w==
X-Received: by 2002:a05:6a00:2cc:b0:51b:f1d3:e5f with SMTP id b12-20020a056a0002cc00b0051bf1d30e5fmr33514357pft.52.1654845401504;
        Fri, 10 Jun 2022 00:16:41 -0700 (PDT)
Received: from localhost.localdomain ([139.198.0.165])
        by smtp.gmail.com with ESMTPSA id t4-20020a628104000000b0051829b1595dsm479937pfd.130.2022.06.10.00.16.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2022 00:16:40 -0700 (PDT)
From:   Sun Feng <loyou85@gmail.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     loyou85@gmail.com
Subject: [PATCH] block: fix attribute_group lost if set before add_disk
Date:   Fri, 10 Jun 2022 15:16:29 +0800
Message-Id: <1654845389-21741-1-git-send-email-loyou85@gmail.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

after commit 52b85909f85d("block: fold register_disk into device_add_disk")
when set attribute_group with following code:

  disk_to_dev(disk)->groups = attr_groups;
  err = add_disk(disk);

disk_to_dev(disk)->groups will set to NULL in device_add_disk,

  static inline int __must_check add_disk(struct gendisk *disk)
  {
       	return device_add_disk(NULL, disk, NULL);
  }
  int __must_check device_add_disk(struct device *parent, ...
                                 const struct attribute_group **groups)
  {
	…
	ddev->groups = groups

and it will lose attribute group set.

Signed-off-by: Sun Feng <loyou85@gmail.com>
---
 block/genhd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 27205ae..6b76f67 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -459,7 +459,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	dev_set_uevent_suppress(ddev, 1);
 
 	ddev->parent = parent;
-	ddev->groups = groups;
+	if (groups) {
+		WARN_ON(ddev->groups);
+		ddev->groups = groups;
+	}
 	dev_set_name(ddev, "%s", disk->disk_name);
 	if (!(disk->flags & GENHD_FL_HIDDEN))
 		ddev->devt = MKDEV(disk->major, disk->first_minor);
-- 
2.7.4

