Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DDF47FCCD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236765AbhL0MxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhL0MxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:53:22 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B241C06173E;
        Mon, 27 Dec 2021 04:53:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k66-20020a1ca145000000b00345fa984108so2656878wme.2;
        Mon, 27 Dec 2021 04:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=P/au97/FpQGpCIWXJLd40PtZYg+NpWsNt/T09/0nn+g=;
        b=i4owH1aagy9ydAw3s1oaf8UoLtfw4gyeld2AiMpsi8EadR9S2YleL5Lv79Jsr1gSLL
         wJuFUuiw5nyMjo+mj7KmEwImjQGIB9T0Jt4XMcv281+wEmKm3yCGu1YieObGFBrgi+4S
         7iwgzJdEZ+HwEf1AFaRfc6g8UvNAudzEppHQ1rtxrF/QiSIPJ0ATyAxrNbGvOJkRsj3L
         XNwVLspZMcZMZTy406rQSX/mHSMHfesO5yN/ueGdH8L/mhdrp2eQINWaUE49A5s4dhbK
         7VlK9ZsKhejOzCfUNpZBL/8hLfJZ4U+sR2r1AWFiDdUI1G6Wec+yw734WXv6AFs6C0rE
         YZ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P/au97/FpQGpCIWXJLd40PtZYg+NpWsNt/T09/0nn+g=;
        b=CnI1Jn6ZaxkLEUm39YVJOwDIWIWG4jm7Bo31N4GgQbFbPM5i+liroj9xllm9N5WeCM
         DX5u/2HJ1/jWvB/pwI5i8CtDf6lBnykidDU1p8n9kZFU0TgFPA17B9kDg+tM2QaKS4zq
         ubwKdnrNmCXmEVcQgIwYZWGzXTPqS6N5GrEAUeFUbZQomN1c06i9eCnpl4ixHVY4eso8
         4GVrG7dxhk7dUpMqAOb/xnxZziYxf3sbLvOGv9bxjaiKQAdXg2Xvh5LX3JPJMzQtiTxo
         mmtUamM1SCKfbti6vwPNy4nqotDh8+EPVTnDAdGOyWe/IAnhxjewAzDdV92XrFP7UmuV
         DKQQ==
X-Gm-Message-State: AOAM532kQ8i5s9Acnb+41671OBSbJXo+3Dj/VNxUoWWpSs6nfLXKnQGc
        Fx50ZGxxY2FOEtGoa5r2KFc=
X-Google-Smtp-Source: ABdhPJytIe560EhN2h0QMk8mA3ZbjMwKjx9t9jLhWaRh41LdpywGHWtJKnt4PB1nBkNmaDeAtbZdcQ==
X-Received: by 2002:a05:600c:35cf:: with SMTP id r15mr13190147wmq.106.1640609600481;
        Mon, 27 Dec 2021 04:53:20 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:26c4:7200:610f:609b:d46a:2a08])
        by smtp.gmail.com with ESMTPSA id y8sm16666635wrd.10.2021.12.27.04.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 04:53:19 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] trace: remove unneeded initialization in __trace_uprobe_create()
Date:   Mon, 27 Dec 2021 13:53:08 +0100
Message-Id: <20211227125308.25787-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no need to initialize ret with 0, as all the early error branches
simply return constant values, and the default path always reaches
ret = kern_path(filename, LOOKUP_FOLLOW, &path), which will reset ret
before the initial value was ever used.

Remove this unneeded initialization and keep the code succinct.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 kernel/trace/trace_uprobe.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 5921951a0d5c..9da10c5efdce 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -548,7 +548,6 @@ static int __trace_uprobe_create(int argc, const char **argv)
 	bool is_return = false;
 	int i, ret;
 
-	ret = 0;
 	ref_ctr_offset = 0;
 
 	switch (argv[0][0]) {
-- 
2.17.1

