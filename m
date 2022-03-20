Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0814E1BE9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 14:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbiCTNvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 09:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiCTNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:51:49 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FE216F6CE;
        Sun, 20 Mar 2022 06:50:26 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id g19so13386869pfc.9;
        Sun, 20 Mar 2022 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=3gEfZ5eoe+zbYqKcw6UvYGVoZnHKD5O1CTE0CBSi2mE=;
        b=nsghIvdv68eBtZZ0SDUbUPSL5nju06yT5n/GjGTKOfgqJb8EWucdgLSR2hXoNVrZvJ
         UBPJMiTChOHP8fwFwAEsM/dEgurTQBf6AsRNJSSDwBImjhQiKBX2XWRhDFLvFkZ3/EaR
         id9Re3UivtKF0oUzrRbr2lwyTGJvyjieVnvSzXT//V1i/S0EImyu0YiHa0qJohmuSATE
         IgyGsIgsh6wZ38NKqRVykWvayq8J9XVzS825FxS6tDa/DYb0FhENjLwK7aw0L7/xo/rY
         LVcApfnbn2vxR9wQuqwmSNBDeMoHCGYXDxt95jNUC6aoXf0nKxDBEeZ/oJVo7kl6Ux5s
         WZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3gEfZ5eoe+zbYqKcw6UvYGVoZnHKD5O1CTE0CBSi2mE=;
        b=j2HCD6HyiPDqCy+72Ju3eOT0+b6FxqKn3yRWq3JRfHkI9iKEJlhE6mXT2ryLGESphi
         isnsBXwF5oKsaNZmRyZSTAec9NJHL2del6lZK8jXspxL3ryh+5/WgkMD94XrQjjrp17q
         x6egTL4wDocCpqSNfvGU0WHjFSSoEaOowE2iV9i+i52ria76AFlmT2KidO1G8Zyevly8
         SFQm1fbU3DWu8daYd0+4yXzJfTsNZABVp6QurJDf6jbm5x3QTM6FIJcSKc/gldagqMFo
         V5DBILyL9gaTJeXOISzZTSPopTxqo573nHSsRcgrvfRbHRug2abMJJTxsxZUgzJuUNa8
         dRpQ==
X-Gm-Message-State: AOAM533yzf3sQ7Uk2xMnoVj3hqPvwR0v0oDmqiXmfD3J3Myo8bQZbSAH
        fP85+6ePO4bl1uPLWErvam8=
X-Google-Smtp-Source: ABdhPJyFFt6taN93Z87S4wW6DOaTHETcem7tz2A/oFRRe32+e0RtBWKz5INAo2FXZZuipwvlLzKUug==
X-Received: by 2002:a05:6a00:8cc:b0:4bc:3def:b616 with SMTP id s12-20020a056a0008cc00b004bc3defb616mr19519125pfu.18.1647784225783;
        Sun, 20 Mar 2022 06:50:25 -0700 (PDT)
Received: from localhost.localdomain ([36.24.165.243])
        by smtp.googlemail.com with ESMTPSA id q17-20020aa79831000000b004f769d0c323sm16473559pfl.100.2022.03.20.06.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 06:50:25 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     sfrench@samba.org
Cc:     sprasad@microsoft.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        jakobkoschel@gmail.com, Xiaomeng Tong <xiam0nd.tong@gmail.com>
Subject: [PATCH] cifs: fix incorrect use of list iterator after the loop
Date:   Sun, 20 Mar 2022 21:50:15 +0800
Message-Id: <20220320135015.19794-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bug is here:
if (!tcon) {
	resched = true;
	list_del_init(&ses->rlist);
	cifs_put_smb_ses(ses);

Because the list_for_each_entry() never exits early (without any
break/goto/return inside the loop), the iterator 'ses' after the
loop will always be an pointer to a invalid struct containing the
HEAD (&pserver->smb_ses_list). As a result, the uses of 'ses' above
will lead to a invalid memory access.

The original intention should have been to walk each entry 'ses' in
'&tmp_ses_list', delete '&ses->rlist' and put 'ses'. So fix it with
a list_for_each_entry_safe().

Fixes: 3663c9045f51a ("cifs: check reconnects for channels of active tcons too")
Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
---
 fs/cifs/smb2pdu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 7e7909b1ae11..f82d6fcb5c64 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3858,8 +3858,10 @@ void smb2_reconnect_server(struct work_struct *work)
 	tcon = kzalloc(sizeof(struct cifs_tcon), GFP_KERNEL);
 	if (!tcon) {
 		resched = true;
-		list_del_init(&ses->rlist);
-		cifs_put_smb_ses(ses);
+		list_for_each_entry_safe(ses, ses2, &tmp_ses_list, rlist) {
+			list_del_init(&ses->rlist);
+			cifs_put_smb_ses(ses);
+		}
 		goto done;
 	}
 

base-commit: 14702b3b2438e2f2d07ae93b5d695c166e5c83d1
-- 
2.17.1

