Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7445ACE6C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238058AbiIEJA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 05:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbiIEJAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 05:00:48 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB5B832D8F;
        Mon,  5 Sep 2022 02:00:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q15-20020a17090a304f00b002002ac83485so4115911pjl.0;
        Mon, 05 Sep 2022 02:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=O5yNDW8gq4TOGDNM0FxBpVT4WeyabT0T2v8ISLdqFXw=;
        b=W2IdgowNjSwepq3IUD0NLDF7NezaIWTQTxtO4CxoRGOqbZWhrrazd8zmFNjYZnY/fz
         y6W5oFlPGRI0Cv0NbRLkOwK+qJw5EFi6577wTUuqB+NoyxugSfby1qQwvlB/l1gKoQKx
         d3HKEw95T4GhXS4RdMAxIMq2FzDm62XTVvwh5zBKt9giQEQvKbYnk1sQYx3P7R2ogDDc
         LW8JNpga1P91ZbEOQ3/XCToYOfKTM9wPunYFJhyrQNLpzOZRvpWRxaaU9llSLlMBzzWG
         TzdmVWuNVvBUDvHPsvHmr6my5YuraF2+A49/vxuUcfX+YWf2a7lHy0xgcX1MEnWraXgg
         pozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=O5yNDW8gq4TOGDNM0FxBpVT4WeyabT0T2v8ISLdqFXw=;
        b=EOEp2gL71eDJL0d5FIe6t+X0HbU4qV1+TlLXSQZwNuwbEEGFtAgX7k2yKzwrKiqShf
         2iSWSE7ck+rmB/F6rmS4K8dI23hNEVz+ryOuWlOkeNrqBCA9Cpbcz0yQXLnRevDLX1LP
         cdXajgnfVmc/q7DuQxbr92/55duAyd2RDA0s951QxGllTTPSL0e3VgyA9VyhuENH9Iqp
         kWwIb3MJBQporemm0KoicYt+mItwoIaqe8LnUSs3vwgacYJku1cxj9P3GK0iPzfMnGfy
         eb5cfl3WO9lvZPqV7I0dDxJKIqz70Lr4MhZHiWJwumXpzCK1XB4lir4LdTBmyFR6UnGH
         RorA==
X-Gm-Message-State: ACgBeo0IUzxa24x2y7tNDrpjzyXMdjCMlgwHrgVKuKRVF61ewanqCZpL
        bzf02VX2SpHeSriwaMvR65kcVxAzhqQ=
X-Google-Smtp-Source: AA6agR5QtYRSaXdw2jhoG6yx+1Ml+qm6wyiLk2RuE0yXzUMGxGcej90wQ8bIOmW/ffx0Tpld28PnWQ==
X-Received: by 2002:a17:903:11c7:b0:170:cde7:d24a with SMTP id q7-20020a17090311c700b00170cde7d24amr48336085plh.91.1662368442306;
        Mon, 05 Sep 2022 02:00:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id d124-20020a621d82000000b0053dd1bba6a0sm1148192pfd.145.2022.09.05.02.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 02:00:41 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     sathya.prakash@broadcom.com
Cc:     sreekanth.reddy@broadcom.com,
        suganath-prabu.subramani@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scsi: message: Remove the unneeded result variable
Date:   Mon,  5 Sep 2022 09:00:37 +0000
Message-Id: <20220905090037.335055-1-ye.xingchen@zte.com.cn>
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value mptctl_do_mpt_command() directly instead of storing it in
 another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/message/fusion/mptctl.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/message/fusion/mptctl.c b/drivers/message/fusion/mptctl.c
index f9ee957072c3..1e13c41fd58e 100644
--- a/drivers/message/fusion/mptctl.c
+++ b/drivers/message/fusion/mptctl.c
@@ -1702,8 +1702,6 @@ mptctl_mpt_command (MPT_ADAPTER *ioc, unsigned long arg)
 {
 	struct mpt_ioctl_command __user *uarg = (void __user *) arg;
 	struct mpt_ioctl_command  karg;
-	int		rc;
-
 
 	if (copy_from_user(&karg, uarg, sizeof(struct mpt_ioctl_command))) {
 		printk(KERN_ERR MYNAM "%s@%d::mptctl_mpt_command - "
@@ -1712,9 +1710,7 @@ mptctl_mpt_command (MPT_ADAPTER *ioc, unsigned long arg)
 		return -EFAULT;
 	}
 
-	rc = mptctl_do_mpt_command (ioc, karg, &uarg->MF);
-
-	return rc;
+	return mptctl_do_mpt_command(ioc, karg, &uarg->MF);
 }
 
 /*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
-- 
2.25.1
