Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C8A4BF290
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 08:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiBVHW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 02:22:28 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiBVHWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 02:22:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B89D56231;
        Mon, 21 Feb 2022 23:21:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A7B860FA1;
        Tue, 22 Feb 2022 07:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B67C340E8;
        Tue, 22 Feb 2022 07:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645514518;
        bh=rhZoSoXxf+nv0Ds+0tcSreaauczjofMiqiPbF6f9UGA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kl57WGODDC/6V7Ch1oePdG/zAH9uZBffJIAmW0Islc1P6XoNvGoV0UOgPNMPv7a1r
         XnIpFJ+3Bmk6w1J+n8RSytdmSgI1AaW0RQUNMJlh3oG46NL25l1Yz3FARsE/Et67xy
         +oCOssDowHzYWfRChckrxVkvFfbc1yuZ7qegO+hIb0ztwJXEc1yHUbOuKJUTbjsdym
         HVNvWEWbrL1XuXfKjv6mnGZxbxX2oRFqCyNEncys2E7cCe8JeJqFcZeLW3mAMQyHJi
         3c6wajvCMaUpZNiz1Y7c1xGnnxGIDQXn1rkHxr1IzjW+Nks0frxt1BcxBV7liXXRTm
         uK8VOmPqWOfew==
Date:   Tue, 22 Feb 2022 01:29:51 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 3/8][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct user_sgmap
Message-ID: <c4cf0d052662ab411f72f617576e8097520474d7.1645513670.git.gustavoars@kernel.org>
References: <cover.1645513670.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1645513670.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace one-element array with flexible-array member in struct
user_sgmap.

This issue was found with the help of Coccinelle and audited and fixed,
manually.

Link: https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays
Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aacraid.h  | 2 +-
 drivers/scsi/aacraid/commctrl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 320a30865d58..bcf97c1b8c0c 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -511,7 +511,7 @@ struct sgmap {
 
 struct user_sgmap {
 	u32		count;
-	struct user_sgentry	sg[1];
+	struct user_sgentry	sg[];
 };
 
 struct sgmap64 {
diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index 5d6b0d9da0df..3206d9491fca 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -523,7 +523,7 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 		goto cleanup;
 	}
 
-	if ((fibsize < (sizeof(struct user_aac_srb) - sizeof(struct user_sgentry))) ||
+	if ((fibsize < sizeof(*user_srbcmd)) ||
 	    (fibsize > (dev->max_fib_size - sizeof(struct aac_fibhdr)))) {
 		rcode = -EINVAL;
 		goto cleanup;
-- 
2.27.0

