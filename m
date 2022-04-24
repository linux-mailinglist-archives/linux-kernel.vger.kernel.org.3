Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5808050D00E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbiDXGaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 02:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiDXGaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 02:30:10 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6428B15834
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:27:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id f14so8396628qtq.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 23:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMH61CDrzHjVCAmffJ1E5ukdJqDirmydINDBSwLoEeM=;
        b=ePFqeKOPBVP1IgwKDcs8a5gG/WXvSei4WF0uhoJYObIPAGgpJxMaMHfXupx5x6sl3s
         ul3o5PsOnMH/s8GH3UWU9VzRNJ0JYi+m0I1Tkj+X8v29o0g+L+UZEez6UrzyrPfinJvu
         EQ3KUDwB/H6pBGbtvsSjkqX/MKwYlbk/Sm8C042aGwIoURianr10qmPxXV3SkU/ZbwVF
         K1qgwlvCb+Bam4Mumi8B8vToX6gcFDTk2cX91363ZMKEMUZUY+Pw8PEq/Xi0AgMzSFQ/
         3jTctM4Dsj2qX/YaWUvp0YOArdQpkh9SGCBYooN352vFpjAZSU/f8lnIRvFk0v5B5+CS
         Alww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nMH61CDrzHjVCAmffJ1E5ukdJqDirmydINDBSwLoEeM=;
        b=LCpJFPszhHjuhussh1ZyHksjbsP47EDNGXDLH2jNqcJd7Y2gwpKplDoOlKXusZkIdQ
         OIuPREA8BtnpRXegOw/AfGcZ32kt0SyG2Pn6JjV9puKTllHxjmAou1sfU+zVDSQ7cOft
         lgZKtnwlk18GtdIuaTTeQwSEQhp9RNGU1+/BYbo/7MzFf53ABakBkkdOfREpQ4V6LK5x
         PiT9QQN0n5haRI7xmwBw3HEg30su3vJd1dj7NXCLurZx4Jgz7wphsCKvbURzj2nfv6Ey
         fbxk5vAmuyj9I9P6mJzl2sZ2PUh0aAF++mFh6qFH1nXTTy/n9haeMiVDBIPTAa53qAu2
         2OMQ==
X-Gm-Message-State: AOAM533svbLI3Np2z3SJf6le9YVVkZOoKdKzSKIjT044Ew7Y8kt9qmkB
        +wCCQZgI85LesGY9KG0hBdtn4tuO81I=
X-Google-Smtp-Source: ABdhPJzj7qkYuWbc8UK3DttS34N77zsB4aKhmCUyFz6bdHwvpD5pcHKo5QDWeRd81trfAwY3xxDrRw==
X-Received: by 2002:ac8:5a47:0:b0:2ed:13d6:bd60 with SMTP id o7-20020ac85a47000000b002ed13d6bd60mr8011675qta.371.1650781629633;
        Sat, 23 Apr 2022 23:27:09 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q9-20020a05622a04c900b002f357a420dfsm4107432qtx.16.2022.04.23.23.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 23:27:08 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     dan.j.williams@intel.com
Cc:     vishal.l.verma@intel.com, dave.jiang@intel.com,
        ira.weiny@intel.com, ran.jianping@zte.com.cn, jane.chu@oracle.com,
        rafael.j.wysocki@intel.com, nvdimm@lists.linux.dev,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tools/testing/nvdimm: remove unneeded flush_workqueue
Date:   Sun, 24 Apr 2022 06:26:55 +0000
Message-Id: <20220424062655.3221152-1-ran.jianping@zte.com.cn>
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

From: ran jianping <ran.jianping@zte.com.cn>

All work currently pending will be done first by calling destroy_workqueue,
so there is no need to flush it explicitly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 tools/testing/nvdimm/test/nfit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 1da76ccde448..e7e1a640e482 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -3375,7 +3375,6 @@ static __exit void nfit_test_exit(void)
 {
 	int i;
 
-	flush_workqueue(nfit_wq);
 	destroy_workqueue(nfit_wq);
 	for (i = 0; i < NUM_NFITS; i++)
 		platform_device_unregister(&instances[i]->pdev);
-- 
2.25.1

