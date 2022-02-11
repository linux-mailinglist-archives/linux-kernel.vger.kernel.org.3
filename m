Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 255864B2FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353824AbiBKWAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:00:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbiBKWAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:00:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B453C70;
        Fri, 11 Feb 2022 14:00:16 -0800 (PST)
Date:   Fri, 11 Feb 2022 22:00:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644616814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVdsDY+AVwaZHBoO1999lTMOc3mt/8B0JIo/q+wOGnc=;
        b=sP6cHmS7y2V4DXtk0TTrChMPNhxNJCKv8q66e6DvxEZ1HF4HPtNdGf4Kqias4iqjnUWTNX
        snjDCjGP3kUdcDYST5sPnB7D7jSJRxkY9/1LVIz/b/8md8n7MmagZVuT5bRnc824ojRo+F
        hrQYdcFHaxPVT8vKQjYZSo3yOJS0+EMtE2QSjtiyBgOafJV0gEL7QzmA3vUcmV5pYZylqC
        b61qkpjrnNQ9BtCIogUcvhl5QAr2Iepnbv8V3ZXvUzjl0fSS3n4JEeL/b6VxORDPAhR3Ni
        mu02vJHw6Ffw8LbcYMZg0aYJKamuK2LuCiOtR2QPCwBZj5xB5tCW/wxZKPR3Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644616814;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NVdsDY+AVwaZHBoO1999lTMOc3mt/8B0JIo/q+wOGnc=;
        b=VZD6S+1TWISmZDQzR01PP+QhPZXwSB7AErh/52h+C9nLMdf2vlSz0WejWRsUtZlmWs/SG9
        waHG2rZGAt0Hj7DA==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Ensure enclave data available during
 debug print
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdab672f771e9b99e50c17ae2a75dc0b020cb0ce9=2E16443?=
 =?utf-8?q?55600=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cdab672f771e9b99e50c17ae2a75dc0b020cb0ce9=2E164435?=
 =?utf-8?q?5600=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <164461681339.16921.1879698421998762534.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     2db703fc3b15e7ef68c82eca613a3c00d43d70af
Gitweb:        https://git.kernel.org/tip/2db703fc3b15e7ef68c82eca613a3c00d43d70af
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 08 Feb 2022 13:48:41 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Feb 2022 13:52:47 -08:00

selftests/sgx: Ensure enclave data available during debug print

In support of debugging the SGX tests print details from
the enclave and its memory mappings if any failure is encountered
during enclave loading.

When a failure is encountered no data is printed because the
printing of the data is preceded by cleanup of the data.

Move the data cleanup after the data print.

Fixes: 147172148909 ("selftests/sgx: Dump segments and /proc/self/maps only on failure")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lkml.kernel.org/r/dab672f771e9b99e50c17ae2a75dc0b020cb0ce9.1644355600.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index a7cd2c3..b0bd95a 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -186,8 +186,6 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	return true;
 
 err:
-	encl_delete(encl);
-
 	for (i = 0; i < encl->nr_segments; i++) {
 		seg = &encl->segment_tbl[i];
 
@@ -208,6 +206,8 @@ err:
 
 	TH_LOG("Failed to initialize the test enclave.\n");
 
+	encl_delete(encl);
+
 	return false;
 }
 
