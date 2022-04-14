Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF44500CB5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbiDNMEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiDNMET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:04:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7C97668;
        Thu, 14 Apr 2022 05:01:55 -0700 (PDT)
Date:   Thu, 14 Apr 2022 12:01:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649937713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irNbvxyJiOJgaVPVNK2gMVgCR2ECZ8V5k+AvUnmmvHA=;
        b=Oie8G6ousjkqfvc7YbWJtVHE0at7lxDl+bCYiXMpbAv3izBEhPjZkJ+NTzXGg1PReri4tG
        zDAysPr1rlDVbURS+xLDUUern0xVKXwM6iB/YVncTpge2ahb7O7XqtVYX1b3htQ/A3yR0C
        OA21yxtGXwuF+frX74ogPAhg9l8w6uyMw4i/jZ+XkHM38dM127KNQ4ckBo6InrW0qJVsMA
        K9vi4/ePd6MEinYAV+1ktY2MjsJr1joD5heLI0beW/RIEpys7VGdL7CrKMSUGqdz8W1Gkg
        PzCkzWmDBTCp5f2pCgkbEbMmnekVzQ4LQCQWv7oz1tqqfUJQ40zJGqREh1YbkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649937713;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irNbvxyJiOJgaVPVNK2gMVgCR2ECZ8V5k+AvUnmmvHA=;
        b=1mG37d/0qY5EQW4Sj/TytzS1r/szavrXvAsgpfc8qjpTppp4AH5ASnxVD8ye4Zwt3IEP01
        Vutvkw+V0uaLVdAg==
From:   "tip-bot2 for Haowen Bai" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sevguest: Fix bool function returning negative value
Cc:     Haowen Bai <baihaowen@meizu.com>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1649930657-10837-1-git-send-email-baihaowen@meizu.com>
References: <1649930657-10837-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Message-ID: <164993771183.4207.3486210875608345661.tip-bot2@tip-bot2>
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

Commit-ID:     101826e02ac6c829bf4e768295e79ae9c37b4b2a
Gitweb:        https://git.kernel.org/tip/101826e02ac6c829bf4e768295e79ae9c37b4b2a
Author:        Haowen Bai <baihaowen@meizu.com>
AuthorDate:    Thu, 14 Apr 2022 18:04:17 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Apr 2022 13:53:35 +02:00

virt: sevguest: Fix bool function returning negative value

The function enc_payload() is wrongly declared bool but returns an
integer value. Correct it.

  [ bp: Massage commit message. ]

Fixes: fce96cf04430 ("virt: Add SEV-SNP guest driver")
Signed-off-by: Haowen Bai <baihaowen@meizu.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/1649930657-10837-1-git-send-email-baihaowen@meizu.com
---
 drivers/virt/coco/sevguest/sevguest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
index aaa6134..15f069e 100644
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ b/drivers/virt/coco/sevguest/sevguest.c
@@ -276,7 +276,7 @@ static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, 
 	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
 }
 
-static bool enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
+static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
 			void *payload, size_t sz)
 {
 	struct snp_guest_msg *req = snp_dev->request;
