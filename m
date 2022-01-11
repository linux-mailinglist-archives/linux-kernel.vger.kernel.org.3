Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497C448AA35
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349190AbiAKJLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbiAKJLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:11:53 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2394BC06173F;
        Tue, 11 Jan 2022 01:11:53 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id y17so17844611qtx.9;
        Tue, 11 Jan 2022 01:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K7x+JZF86Katyduo1F3Cq4Z3ms8a5kmTYTKWb9L+M58=;
        b=RVUZANS24rS/qqagyz0hQnIJB7u53VKD4ML1B2bAGrdPo7qbFEHURxHb3bFkmNvBOC
         MP5EiLGm2xmzXogFGG6JJ1LTpFqiea+Rajd3E0Vv3yF4EgTjzSvVMrXR8uwNqs61cTpD
         F44ZolsDsWkU1cODuB7RUSCSYCwkcLZ888pU0Tqcom+r4O2oeqGvijMEKr75GYR9GCOc
         NsMaQz8SD2On03L+oA6+C9inAyR5LbCK1Di+ebgtzWpLIJyN/4nwmVfqRIBmJ+cysQWd
         ghJ4MhAXfYwFYSvEoXnLQk3nctuHceHaupTm2c502vrEzZpP0nEpXr2QFUQcWMFnfb9W
         gnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K7x+JZF86Katyduo1F3Cq4Z3ms8a5kmTYTKWb9L+M58=;
        b=2kupBa8ifca2EE35k0wCNSxepjaUy6eawYGTqsqDgD57v7Kofs06UpVHbLl/YXAwga
         WtPg2ldC4/nBQK2DnfhR1RS6kh0N6LLoh+CqpH9rviUwB5e17a4woD4IxRzn7QFU/Q5N
         3WDrjVBR73vJvpBIttsCvrGfu3jkfEurArSJUMdu3Pe4aGIhnZo8xhp40wMY7POGuVN0
         v+rozWBSGhmDRag4uWqjkG5Z7UJ7tj3ZwHqs9zt1j+PDqce2LN/xPgabXPSpP6GOlW7k
         F268K0zkVf9k7Mhhp56dmXQwQMK/btrIxxzTUdCjHXAfdyX90EozLw8Bb/cjP1EPm3Fm
         dQ7w==
X-Gm-Message-State: AOAM533OPHwgz9inKPtzUldc/VvfAtFNaIk+yK9YTv/wtYwKbr+NO1E8
        gx2aZNwWp4Cbl1MyO2v0fcY=
X-Google-Smtp-Source: ABdhPJyHTQbftU3acBcGr0xNuoIfOAkTkfC7hI/YKg74bfwTfpczR8cnyfgFNqeKAfZHY6yp4L2bAg==
X-Received: by 2002:ac8:5c50:: with SMTP id j16mr2928564qtj.255.1641892312354;
        Tue, 11 Jan 2022 01:11:52 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w19sm6442517qkp.19.2022.01.11.01.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 01:11:51 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: deng.changcheng@zte.com.cn
To:     kashyap.desai@broadcom.com
Cc:     sumit.saxena@broadcom.com, shivasharan.srikanteshwara@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        megaraidlinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] scsi: megaraid: use max() to make code cleaner
Date:   Tue, 11 Jan 2022 09:11:44 +0000
Message-Id: <20220111091144.651526-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Use max() in order to make code cleaner.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 drivers/scsi/megaraid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid.c b/drivers/scsi/megaraid.c
index bf987f3a7f3f..17e8a9aeedc4 100644
--- a/drivers/scsi/megaraid.c
+++ b/drivers/scsi/megaraid.c
@@ -3475,8 +3475,7 @@ mega_m_to_n(void __user *arg, nitioctl_t *uioc)
 		/*
 		 * Choose the xferlen bigger of input and output data
 		 */
-		uioc->xferlen = uioc_mimd.outlen > uioc_mimd.inlen ?
-			uioc_mimd.outlen : uioc_mimd.inlen;
+		uioc->xferlen = max(uioc_mimd.outlen, uioc_mimd.inlen);
 
 		if( uioc_mimd.outlen ) uioc->flags = UIOC_RD;
 		if( uioc_mimd.inlen ) uioc->flags |= UIOC_WR;
-- 
2.25.1

