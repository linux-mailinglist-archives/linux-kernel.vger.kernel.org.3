Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0074A4914
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 15:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379288AbiAaOMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 09:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379295AbiAaOMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 09:12:21 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF848C06173B;
        Mon, 31 Jan 2022 06:12:20 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id i65so12947723pfc.9;
        Mon, 31 Jan 2022 06:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/I6TXSAhpwpx43zy+1D3LjupIF/S0HrCdtr/QJiuKck=;
        b=RCRWOyCmmNz2Ji7dxlsRcIJXL6LRRLXTf71zMxpCuThhJun4nnbgxUIcDLzZzw4gps
         m/MhttSa7rSau6iOdYCMRS/NLssIlUxNThsjBADigz3gccESpLWobZlC08I/NeU2JteX
         QbJu90hoJfiKVzDwxMl6lzFe6/zuSmc2DITe/jtpy8JJV+KnxTxrlSECLTp52yIJHIiI
         DdkCvaWK0WYkxGbKutZUEnsMydcLZEskLFSvXTgx1972MNQ/Y5eINKLjcMB152dah0jT
         fHzQ793HagYg+foOSOw1dJU8taj7emJVgpSx+b09/VBu/zaewLLCJNQ2UHDX9Q96VQbB
         ZNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/I6TXSAhpwpx43zy+1D3LjupIF/S0HrCdtr/QJiuKck=;
        b=4soTBiERBTaG/da6cYcE9j0LXz5TvPqQWYm1yABYmEGLVzkl7s4PdVBlgLugGqYgQW
         gDqcd5jVhK0Ul+kOwwOJvftqci3UWMFTXnlCxEx23Wui2SY5LBx6GDoQ+A3UzcO9BsTu
         uvo4FrRfNPxRZni03s3/YS8r1Fn2hblaFKBwVs+8IdoXEww1E0B2ND7Gbx2QX339YL5t
         Q03apbkzGyElukBU58jZGGUINpsSwlNQOK4aYGw0Pnis+L9C/Vi9xfdm2J/tCnQ6iYu+
         sLVbMDAZl3ArfHRMpJnAhFvgYvE9leNSSUWSusQMg58hTFpRc5kJ9k7c9aZofN7Ek7dO
         lYdg==
X-Gm-Message-State: AOAM531DVWydryEvjG0kxgherLgmvmr0i6VqrnIBFX3HgP4A4/fB/CVF
        f1015WcpT0faKAqmdyP2LocryinYHfI=
X-Google-Smtp-Source: ABdhPJz/9wehUZbBF9sdwQK6keejXwwNI0VcP2LlRgwce8kl5j5sEMrXfKNy6Biri+HmsjM625wnsQ==
X-Received: by 2002:a05:6a00:24d6:: with SMTP id d22mr20079569pfv.36.1643638340321;
        Mon, 31 Jan 2022 06:12:20 -0800 (PST)
Received: from localhost.localdomain ([124.253.246.115])
        by smtp.googlemail.com with ESMTPSA id g12sm18101682pfm.119.2022.01.31.06.12.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Jan 2022 06:12:19 -0800 (PST)
From:   Puranjay Mohan <puranjay12@gmail.com>
X-Google-Original-From: Puranjay Mohan <p-mohan@ti.com>
To:     kishon@ti.com, vigneshr@ti.com, s-anna@ti.com,
        bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Puranjay Mohan <p-mohan@ti.com>
Subject: [PATCH 2/2] remoteproc: wkup_m3: Set deny_sysfs_ops flag
Date:   Mon, 31 Jan 2022 19:41:52 +0530
Message-Id: <1643638312-3912-3-git-send-email-p-mohan@ti.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
References: <1643638312-3912-1-git-send-email-p-mohan@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

The Wakeup M3 remote processor is controlled by the wkup_m3_ipc
client driver, so set the newly introduced 'deny_sysfs_ops' flag
to not allow any overriding of the remoteproc firmware or state
from userspace.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Puranjay Mohan <p-mohan@ti.com>
---
 drivers/remoteproc/wkup_m3_rproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/wkup_m3_rproc.c b/drivers/remoteproc/wkup_m3_rproc.c
index 484f7605823e..bbb84bb28af8 100644
--- a/drivers/remoteproc/wkup_m3_rproc.c
+++ b/drivers/remoteproc/wkup_m3_rproc.c
@@ -163,6 +163,7 @@ static int wkup_m3_rproc_probe(struct platform_device *pdev)
 	}
 
 	rproc->auto_boot = false;
+	rproc->deny_sysfs_ops = true;
 
 	wkupm3 = rproc->priv;
 	wkupm3->rproc = rproc;
-- 
2.24.3

