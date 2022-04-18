Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8302D504EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbiDRKVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbiDRKU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:20:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8E419034;
        Mon, 18 Apr 2022 03:18:20 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k29so18060419pgm.12;
        Mon, 18 Apr 2022 03:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FgfhznoEwlI1gZ4RwiNHpMGAMQaG/XKY7H6WtjqDG8M=;
        b=lHoVeiM8H9bA2eBLAqPdQQ0GNfndniP6f54WpBLOiATsNbv3uH/gzQYz+y3A3hTd02
         62azlrYt/zWYfbNvTk/dU7zval1wXAH6IhhY1QCODzCh9g7USBWH7pSJzKwnDKvni5n+
         vSLUZ1cKGVj68Jo+bkjlM4fDt3T0qvz/OE82UwQcASNQ34lfxFh9Q5o8A+XYzBye5iPw
         rBVsiYkEhiMyeertPSU80kW0JKZT1jp6mG0SDyrKAbat3SncZ7S6VGfZDEMUHDWaQrql
         0CF7/IQHCptHRqlk2eYj0xFfXt0Nnt8YRk88GRWweQcMEWvIjdu7S9/qhtb4ihBXIEvD
         3yug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FgfhznoEwlI1gZ4RwiNHpMGAMQaG/XKY7H6WtjqDG8M=;
        b=Z0k+UQo0j1mhzwKpOAf4s3x980BEsKVxiux+kbEqJvZ30KHjQorh3bl8MriQjsC73J
         0iIWGCeIpxnCa/D8t33oqMznEdNEt9JazjuxCE3vW5sRkZc2F4gdZrEHFySOf6gsQiCo
         M8HwlvaMEJOKwzbBtO4zwC8kDmLdsdGkrP5RS+1YLutRpiGjc53eMBuyJi2AXQFrQ5XF
         KW1Pf1pMaRMUVmyYkIoCU6m27P/lnMUsNDBdCtHm519qAgfauHgmdHmSMq1swuUx8tdW
         PxvIKPGikwLZ9UdkRBtnt9Zf1plOF2j5/3W3VTUXM2bZBM6C2NR35Tsm+yELz8zbWARP
         r/Bw==
X-Gm-Message-State: AOAM533HJ8kNykBrF8Ku0nFOk4sf8fNAH0OLjN9NH7LktffCGgcJh+AZ
        7vMgt8Zdz647/sJVFtHlrSQ8XQDwFPV6LZ52
X-Google-Smtp-Source: ABdhPJxtthY78qV0jQEj4SNMVC5cDIobAmelUAJAgQUoM8P9FAHgSpQA46MZ85hWQF/57vQMQ/yHfw==
X-Received: by 2002:a05:6a00:1a91:b0:4fa:b21d:2ce with SMTP id e17-20020a056a001a9100b004fab21d02cemr11519916pfv.75.1650277099931;
        Mon, 18 Apr 2022 03:18:19 -0700 (PDT)
Received: from localhost.localdomain ([103.84.139.165])
        by smtp.gmail.com with ESMTPSA id y6-20020a626406000000b005060889f2cdsm12011331pfb.191.2022.04.18.03.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:18:19 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        arnaud.pouliquen@foss.st.com
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] rpmsg: virtio: fix possible double free in rpmsg_virtio_add_ctrl_dev()
Date:   Mon, 18 Apr 2022 18:17:24 +0800
Message-Id: <20220418101724.42174-1-hbh25y@gmail.com>
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

vch will be free in virtio_rpmsg_release_device() when
rpmsg_ctrldev_register_device() fails. There is no need to call
kfree() again.

Fixes: c486682ae1e2 ("rpmsg: virtio: Register the rpmsg_char device")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 drivers/rpmsg/virtio_rpmsg_bus.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
index 603233f0686e..3b7b47f785cf 100644
--- a/drivers/rpmsg/virtio_rpmsg_bus.c
+++ b/drivers/rpmsg/virtio_rpmsg_bus.c
@@ -851,7 +851,6 @@ static struct rpmsg_device *rpmsg_virtio_add_ctrl_dev(struct virtio_device *vdev
 
 	err = rpmsg_ctrldev_register_device(rpdev_ctrl);
 	if (err) {
-		kfree(vch);
 		return ERR_PTR(err);
 	}
 
-- 
2.25.1

