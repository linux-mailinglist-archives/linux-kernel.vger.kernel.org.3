Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF84A4B3001
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 23:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353882AbiBKWA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 17:00:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245258AbiBKWAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 17:00:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD16C74;
        Fri, 11 Feb 2022 14:00:17 -0800 (PST)
Date:   Fri, 11 Feb 2022 22:00:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644616815;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWFu/sLaMqy4EBO4xh38pYAaJOx0SMnJHEATCu4s7k0=;
        b=cQjQERsloCphD/91gnp3sg3MGT1LUoPwul/uZvGdxWmfF/15WJTKBLoowmfNLUktS/fq71
        1M9BlHRUaX+bLt8K1OU8U72FyxII1/YCZ4UCvXxQ1XYkWgkIn1n9D6z18A8fZu/32Jq9r1
        pPFiLjZ2l+QlLu27OuwfzaOhSai5fGISx/cSclc8+OhEUu40Hfhpl9szaJuy+lKhtMafDx
        idQCmjlC4n9EGJ7lY4XYEH0UErzDzg4+zmoGeyJZpjO0Av5YDLSVvzbLsjuOaMgklf7Fcy
        YC70ATZIz/eorY98ZkPmkU+dozLeoOZJvfk6E5Vq4fd6E0kTU4IaCWholCBVfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644616815;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWFu/sLaMqy4EBO4xh38pYAaJOx0SMnJHEATCu4s7k0=;
        b=IvQHViznau46bqG7btNnvLi8PwoPefeCpmvCpefP8fV6bFzipqlc2I29O8PnE1bi5cW+KZ
        JbmsOth/TrYlq4Dg==
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Do not attempt enclave build without
 valid enclave
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ce3778c77f95e6dca348c732b12f155051d2899b4=2E16443?=
 =?utf-8?q?55600=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Ce3778c77f95e6dca348c732b12f155051d2899b4=2E164435?=
 =?utf-8?q?5600=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <164461681421.16921.5423219410361337915.tip-bot2@tip-bot2>
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

Commit-ID:     fff36bcbfde1126f6b81cb8ee12a58aada17ca29
Gitweb:        https://git.kernel.org/tip/fff36bcbfde1126f6b81cb8ee12a58aada17ca29
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 08 Feb 2022 13:48:40 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 11 Feb 2022 13:52:47 -08:00

selftests/sgx: Do not attempt enclave build without valid enclave

It is not possible to build an enclave if it was not possible to load
the binary from which it should be constructed. Do not attempt
to make further progress but instead return with failure. A
"return false" from setup_test_encl() is expected to trip an
ASSERT_TRUE() and abort the rest of the test.

Fixes: 1b35eb719549 ("selftests/sgx: Encpsulate the test enclave creation")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lkml.kernel.org/r/e3778c77f95e6dca348c732b12f155051d2899b4.1644355600.git.reinette.chatre@intel.com
---
 tools/testing/selftests/sgx/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 370c499..a7cd2c3 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -147,6 +147,7 @@ static bool setup_test_encl(unsigned long heap_size, struct encl *encl,
 	if (!encl_load("test_encl.elf", encl, heap_size)) {
 		encl_delete(encl);
 		TH_LOG("Failed to load the test enclave.\n");
+		return false;
 	}
 
 	if (!encl_measure(encl))
