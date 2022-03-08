Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C954D1089
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343636AbiCHG5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbiCHG5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:57:09 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3F83D1C1;
        Mon,  7 Mar 2022 22:56:13 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id e15so14968477pfv.11;
        Mon, 07 Mar 2022 22:56:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKWLtU4zz1/zFVHhrDZHE3rjhXGyfrW7xNSyA4kl7Rc=;
        b=EAC94q4eGyN3xC+1r+cts3HFagw0H+M6JLKx+cyOYKUUo6h1mskAeYIB2Zpl/7g7lV
         zaWJ9eB8cw8BRp8srEuKd+hP0RKDh3DnpkmIMFBXU/8mLMRUUpErwPSGnvk+kx3s5+ek
         9rIIYuz0Whgr0z2yt001UTszg/8k8H6p61ULaY1A4mIRBxU9em5V8J2JLXUZQEhGA2GG
         A1C7FnxetOJjQT+XUzJj0XmBJbNn7zbpIlAMijj0orpw4FnXCeh+JhgNioZe8uX5Qez5
         dHisvq13qwpP4FdHNQ0jJREeBCbS5C3oUWEcg0aluCar3ymNU62ohZPNVWWW0+OS5Tun
         JsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EKWLtU4zz1/zFVHhrDZHE3rjhXGyfrW7xNSyA4kl7Rc=;
        b=UwgKOcdzEb7h9HlkUqtIJ0Us7jPV+N8wUEdzNUf4Y206O8cry9026Gr0tGxTLfdlKN
         xiLcp6fO/zJshbIjHhrSI3M7jdIVHiV7fhEnwxRK160Cy1jyo7Epm0vjpQBH1+rLDvzV
         Lx+57HVCXpRubT3l8tKBtriuPgy6ATJWfLdwn9ArzFHRoFw24aRSBr8DnovQIaqc6uFS
         4Xhmh28+S1Jtuva9q/KaS+93s23Mz3UmzFg4Oqc8Q9YmlUPc782T8gDioVakDwmX1zTl
         LtQEgvXphYDTuEBa48uDk0y126jX3YSdL09UkAwkT2mioeyAqFBHRQNJK4px9EWkwHXJ
         TlpQ==
X-Gm-Message-State: AOAM532NxB1gYHGOkSGwLD+U9aVVB1b/i4G8+iY9xSv2Ovn9DjJUAArN
        B1e9Na9FNjTbcVBic2iz+44=
X-Google-Smtp-Source: ABdhPJyy4Dpzn9emP4W1/XAN7GRoL0KMEDtuFqM6nXa5Lc9V97SUHIT4y15UYiHy6ML+u6GIgdPVHg==
X-Received: by 2002:a62:bd0e:0:b0:4f6:e07f:d4ee with SMTP id a14-20020a62bd0e000000b004f6e07fd4eemr14429505pff.46.1646722572865;
        Mon, 07 Mar 2022 22:56:12 -0800 (PST)
Received: from ubuntu.. ([115.27.208.93])
        by smtp.gmail.com with ESMTPSA id j17-20020a634a51000000b00378f9c90e66sm13706588pgl.39.2022.03.07.22.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 22:56:12 -0800 (PST)
From:   Yeqi Fu <fufuyqqqqqq@gmail.com>
To:     Hannes Reinecke <hare@suse.de>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lyz_cs@pku.edu.cn, Yeqi Fu <fuyq@stu.pku.edu.cn>
Subject: [PATCH 1/2] scsi: fcoe: fix memory leak
Date:   Mon,  7 Mar 2022 22:55:26 -0800
Message-Id: <20220308065527.90341-1-fufuyqqqqqq@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yeqi Fu <fuyq@stu.pku.edu.cn>

Resource release is needed on the error handling branch
to prevent memory leak. Fix this by adding kfree to the
error handling branch.

Signed-off-by: Yeqi Fu <fuyq@stu.pku.edu.cn>
---
 drivers/scsi/fcoe/fcoe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index 44ca6110213c..dbc202f2f05a 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -829,6 +829,7 @@ static void fcoe_fdmi_info(struct fc_lport *lport, struct net_device *netdev)
 		if (rc) {
 			printk(KERN_INFO "fcoe: Failed to retrieve FDMI "
 					"information from netdev.\n");
+			kfree(fdmi);
 			return;
 		}
 
-- 
2.30.2

