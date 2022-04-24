Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C427050CFFC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 08:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238341AbiDXGV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 02:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231567AbiDXGVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 02:21:54 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC1715E843;
        Sat, 23 Apr 2022 23:18:55 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d14so8386274qtw.5;
        Sat, 23 Apr 2022 23:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yby90S4qeqTNTQCQTqXyyQ6ZkOIT/Nf47vs830JnxMk=;
        b=VeR4tPYU8LPkCDcI5NL5K7ivslj8+hgD3D79PsoQm5Twy4E1+XDwSJgqbAjD1qCBZq
         rVY+gvFcnLau0m9u7vzRe+adGhWmiaqhkXO1oTMzLR/5G0WPkeDjtb5GWkp28y3CIfJA
         hITqWhh0SkpLWJutDnwrukDuq6lsTwqvuXjHrunf3tJEcv6PGtyTcGYR6BFMxHyDu95r
         cjo3cBpxuJm2eeYNXPHMuJ0JXss+PnOnCIS7WYOMuEFdKiT/5yEYFdCneyzWcGEFcfnP
         kagGPgd/bicpNsViC/fPKqfo1JjXWwdcY55thaR4Yae9OXCNaWeuSROnZc58aDnQZaiK
         OugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yby90S4qeqTNTQCQTqXyyQ6ZkOIT/Nf47vs830JnxMk=;
        b=gXujtXxUdlB57JfM239qeL0zk+y++OCnccaV3uP3QdVNiqOprQrS+f7HLNQvL1ZQjb
         qKUJPueRNwetIzdONrk+WzIUZ9kUpoUa3EI3jJG/fblDwxeH2Nb6eMwrD4p0mO9q4QB1
         7yChFPLqafQIpT4yEHprufG8ONabPLSy/4STUug0lx0Jy6T3QMijyE59R08p+G34ZCvQ
         rlQLQE0tYTIt8DfLozVFuYvN/8B7wdTg4wF+E4mUtDpet8pbhDdVrwpM2t+ebvTBYOjO
         qiqYM8QcyIRwlTJdewWeptPaXLoTFCUkJRSbkJjsbtL9Vj0lPHCnZYTQKOkD9IIBs+z5
         GBkg==
X-Gm-Message-State: AOAM533paGnQg2Sve6z4ZFRL1Rr6ZOIS6gQ7X82XBlWk7xrg4D+rQr/+
        +Rd2RfuKzgiVXI7Hf6plXaA=
X-Google-Smtp-Source: ABdhPJwK1v96DPTQMFreQtZ9eS9KfM4LtTDRxtiHSTWJVAaGVYKJB316Iqr8jKQ0yfmOPElfpSFzeQ==
X-Received: by 2002:a05:622a:58c:b0:2f1:f8cf:16bf with SMTP id c12-20020a05622a058c00b002f1f8cf16bfmr8329127qtb.71.1650781134784;
        Sat, 23 Apr 2022 23:18:54 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s18-20020a05622a1a9200b002f36470c4f1sm1012500qtc.56.2022.04.23.23.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 23:18:54 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     anil.gurumurthy@qlogic.com
Cc:     sudarsana.kalluru@qlogic.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ran jianping <ran.jianping@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: bfa: remove unneeded flush_workqueue
Date:   Sun, 24 Apr 2022 06:18:45 +0000
Message-Id: <20220424061845.3218774-1-ran.jianping@zte.com.cn>
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
 drivers/scsi/bfa/bfad_im.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/scsi/bfa/bfad_im.c b/drivers/scsi/bfa/bfad_im.c
index 8419a1a89485..c335f7a188d2 100644
--- a/drivers/scsi/bfa/bfad_im.c
+++ b/drivers/scsi/bfa/bfad_im.c
@@ -755,7 +755,6 @@ void
 bfad_destroy_workq(struct bfad_im_s *im)
 {
 	if (im && im->drv_workq) {
-		flush_workqueue(im->drv_workq);
 		destroy_workqueue(im->drv_workq);
 		im->drv_workq = NULL;
 	}
-- 
2.25.1

