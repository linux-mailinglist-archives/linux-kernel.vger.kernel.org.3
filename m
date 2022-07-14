Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80149574621
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 09:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiGNHtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 03:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbiGNHtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 03:49:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59D53D5AF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:47:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r10so1421087wrv.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ENpXGCfOojvm5HzOOGlSlXEcDNquLj89EnJRW1uV9Q=;
        b=nUIszvOV1SKjyeh8V1EgkwL9bn2jp22IcQ3+c3ojYV+nzi0p+mLCG7Ue02wZTN7AY5
         W+LvGiQNM9HDeXQjrbMjtPYecghemrptI57XVUikoryzIr5j9TJQk71ozidRZiRhGDSi
         9WE9+xlpI/uRMDXMpQ8C97hNrdNJfK2o1r30GkimCfZd0mCHSmr8R8duA1eKDyPlp/dX
         afRBwh9WVSPxUeslnWkaQY61cF6gc7mwhKSe2IoTMQ1fTEdyhiDC2mFz+dpljHYxBzu7
         4nSoyxyyQirGp7LWyeh17EV1tnKC4/01bPTk/33UQWQ3OC9QqpJLgArO6h/BDHbnM42o
         fnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ENpXGCfOojvm5HzOOGlSlXEcDNquLj89EnJRW1uV9Q=;
        b=NOR3pWxbW2TutuxVO69qQAATAEPhdUp8LDrOooOXujKZ0jaE6ChBAOpefw10WJpoT0
         5TAc/bVROsFUBp43xfa91x/OnaImsS+5VtuPC8feL5JCfBU8yabghJahCmwjXT2QT/Cd
         SDI+uQza8wqYhdIh2GHeC4P3Th6klCibPyhjHbwTTrB4Tha0xgeMhq5Hh/vTo7eJTQ+L
         SX8GC1i+a6URHsQ8zKHlG/dwgh6Onm4t2DT+WSAn5A0xMDL21cUO9FCJOUMEVaLxXJlX
         uHZ/Z+MtljBxPHZlrzDC9QFoCCreGlDsxBt1nLIfkF1O0I9+Y+E2gEATgkkUebLDPR4e
         jwyQ==
X-Gm-Message-State: AJIora+mhFu3uIscdfzrWnOnnPVaWWjm5jCJOiWWgmGr/YZpWZkO2nlz
        zXfMZAP/TVBhWHVPCSp8C/fdsyFOAS9bz4iN
X-Google-Smtp-Source: AGRyM1uDdySWT3c/cpFu8Pnqq0wuG6SVeWWLxZrIqlrgJPrAUJHwG0dFVm3ZUMPnYVJ6yFIYRxKDiA==
X-Received: by 2002:adf:f006:0:b0:21d:7bf3:1f2e with SMTP id j6-20020adff006000000b0021d7bf31f2emr7384440wro.593.1657784866861;
        Thu, 14 Jul 2022 00:47:46 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c359300b003a300452f7fsm1161638wmq.32.2022.07.14.00.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 00:47:46 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] kernel/hung_task: fix address space of proc_dohung_task_timeout_secs
Date:   Thu, 14 Jul 2022 08:47:44 +0100
Message-Id: <20220714074744.189017-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proc_dohung_task_timeout_secs() function is incorrectly marked
as having a __user buffer as argument 3. However this is not the
case and it is casing multiple sparse warnings. Fix the following
warnings by removing __user from the argument:

kernel/hung_task.c:237:52: warning: incorrect type in argument 3 (different address spaces)
kernel/hung_task.c:237:52:    expected void *
kernel/hung_task.c:237:52:    got void [noderef] __user *buffer
kernel/hung_task.c:287:35: warning: incorrect type in initializer (incompatible argument 3 (different address spaces))
kernel/hung_task.c:287:35:    expected int ( [usertype] *proc_handler )( ... )
kernel/hung_task.c:287:35:    got int ( * )( ... )
kernel/hung_task.c:295:35: warning: incorrect type in initializer (incompatible argument 3 (different address spaces))
kernel/hung_task.c:295:35:    expected int ( [usertype] *proc_handler )( ... )
kernel/hung_task.c:295:35:    got int ( * )( ... )

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 kernel/hung_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index cff3ae8c818f..bb2354f73ded 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -229,7 +229,7 @@ static long hung_timeout_jiffies(unsigned long last_checked,
  * Process updating of timeout sysctl
  */
 static int proc_dohung_task_timeout_secs(struct ctl_table *table, int write,
-				  void __user *buffer,
+				  void *buffer,
 				  size_t *lenp, loff_t *ppos)
 {
 	int ret;
-- 
2.35.1

