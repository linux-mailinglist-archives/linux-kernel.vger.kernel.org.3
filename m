Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4515E4FC1F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348502AbiDKQMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348504AbiDKQK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:10:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9436369FD;
        Mon, 11 Apr 2022 09:08:35 -0700 (PDT)
Date:   Mon, 11 Apr 2022 16:08:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649693314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEumtrNgPRij67RkSd7q5ZbJwNeqqSyIxE9/jivKOtg=;
        b=a2QAq3kJvaC0ugNY7Bjl5ycWYgdpQ55X3NHTGmVDTBH9ySY5uC1KCP6EE28R2N3+07oOxz
        MXANzDLEBfWsk3K/UKVAro9IJsGqlZH/FWYppLNFANXHgQD1tZ+YtUd+27grdEhKc3h7uA
        udpReu0urIYWZVzoRljut6xO/AixCZh8Raybc54uRSm5gniKrvBv1UrEOvPUboQJtAYVgX
        mSuvRTbS+IIPPYpnUlpyOnAzj33aajxJS2Z5ocJK4Hz1mWild6lBXEdLKO8JWFXBT79GRm
        msltUje8zD+GoVg8lTgUoa50LBAvq4o7q/UhcQS0I+MRfLwm3kysR+2MDhMiag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649693314;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fEumtrNgPRij67RkSd7q5ZbJwNeqqSyIxE9/jivKOtg=;
        b=FHqAIyofGIoPVgokmmXYKudclcorsQmWyPD69oWZklqSJYzsWkvtpb5U44ovUt9Mlbp/KA
        8pXfGViOTX5CS7Cw==
From:   "tip-bot2 for Yang Yingliang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sevguest: Fix return value check in alloc_shared_pages()
Cc:     Hulk Robot <hulkci@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220411111213.1477853-1-yangyingliang@huawei.com>
References: <20220411111213.1477853-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Message-ID: <164969331258.4207.11880527888370272207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     e50abbf788c239d529f9ab81e325f8e8f8432c9d
Gitweb:        https://git.kernel.org/tip/e50abbf788c239d529f9ab81e325f8e8f8432c9d
Author:        Yang Yingliang <yangyingliang@huawei.com>
AuthorDate:    Mon, 11 Apr 2022 19:12:13 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Apr 2022 17:58:52 +02:00

virt: sevguest: Fix return value check in alloc_shared_pages()

If alloc_pages() fails, it returns a NULL pointer. Replace the wrong
IS_ERR() check with the proper NULL pointer check.

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Brijesh Singh <brijesh.singh@amd.com>
Link: https://lore.kernel.org/r/20220411111213.1477853-1-yangyingliang@huawei.com
---
 drivers/virt/coco/sevguest/sevguest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index 15afb6c..aaa6134 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -581,7 +581,7 @@ static void *alloc_shared_pages(size_t sz)
 	int ret;
 
 	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(sz));
-	if (IS_ERR(page))
+	if (!page)
 		return NULL;
 
 	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
