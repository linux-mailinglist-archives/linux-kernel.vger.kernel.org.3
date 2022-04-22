Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB39950B429
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 11:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446038AbiDVJgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 05:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiDVJgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:36:03 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFEE0527EE;
        Fri, 22 Apr 2022 02:33:10 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id fu34so5101453qtb.8;
        Fri, 22 Apr 2022 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKj1Iz2wotd6Q1HzBlseJejXHAA7DldFTnIUidB/naE=;
        b=fBRzG++pkAOAkeHm31OL6ch90PY3P50rDwTw/LF+TXaBnzI8S9fbDRn7XSMQldgy+o
         k5xniFtK0KmCxZ+jUO8bsiXoILkAy616ISG7I8rhl9ImR4skYy3c7ifQ6A6eJMRNWQYY
         oeL0jM5ottwXYQm27duvejCuzfq+8wMdlps3quFOdlBtYflBH8wfxsqPb49rkisLS8iG
         Wz1kaXsDPsk9KIcEJJTRcGAA2pRUfU/9t2uK6CjuGm4E3GxZpAJHaRoRwzpDuALDPrOX
         EzNos2OuAZZb0PCXOJClR18lQGuiuAsmMwqXlgV5dUwJlqSg4pJaMz+gHyTdBsMJ5hcE
         zNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TKj1Iz2wotd6Q1HzBlseJejXHAA7DldFTnIUidB/naE=;
        b=P3OBcaodU10o50Pv18hPg9JdWDstYHKZaPWL+gjuf6nBJKXpKNnfwIvYWJ88B3Fz+3
         NkP/9YAJGmsXVf0DWvzyX/RqkbMiXvje5bviafR/lrPhm6I7TtFTuAYTfH+tlHYcc4RD
         0DBfCiLoefiD8pL5+0aMFbUUOnI9W+Gu9z7BlGzd1reC82iVII1ND+GrM/nSBDZVZ2KK
         4JDdx6aurX5dIuqqkQ/jbPC9YewDjvptZqPRKSFsCZSxQdDmQfmBVA6Zs43RhexUsTOV
         b5llwvtGBrIJZnGuOFuI8cmtsc81RCr8LAYuGGczRBDCpTd70/e3JfWLyyEBfbRuh9Y4
         H/Ew==
X-Gm-Message-State: AOAM532ZI2WegT2eOEURu5RfbGkrXIYlUMxYljHF9ql23cer65K1AGCo
        z/ufU8uvZSymcqUhitjkGLnVkmZ+gZM=
X-Google-Smtp-Source: ABdhPJxDYG+8EBdG5c+n+zAobzQzk5zYMbOfooK1UIPd25EIvwQW0hamlgTQw4Q47Y2l8ceC320wIA==
X-Received: by 2002:a05:622a:1194:b0:2f2:35b:28df with SMTP id m20-20020a05622a119400b002f2035b28dfmr2445799qtk.30.1650619990125;
        Fri, 22 Apr 2022 02:33:10 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i68-20020a375447000000b006809e0adfffsm694635qkb.25.2022.04.22.02.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 02:33:09 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ran.jianping@zte.com.cn
To:     dmitry.torokhov@gmail.com
Cc:     ran.jianping@zte.com.cn, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] Input: synaptics-rmi4: remove unnecessary flush_workqueue()
Date:   Fri, 22 Apr 2022 09:33:04 +0000
Message-Id: <20220422093304.2781183-1-ran.jianping@zte.com.cn>
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
so there is unnecessary to flush it explicitly.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ran jianping <ran.jianping@zte.com.cn>
---
 drivers/input/rmi4/rmi_f54.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 93b328c796c6..c5ce907535ef 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -733,7 +733,6 @@ static int rmi_f54_probe(struct rmi_function *fn)
 	v4l2_device_unregister(&f54->v4l2);
 remove_wq:
 	cancel_delayed_work_sync(&f54->work);
-	flush_workqueue(f54->workqueue);
 	destroy_workqueue(f54->workqueue);
 	return ret;
 }
-- 
2.25.1

