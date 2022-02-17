Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6774BAA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 21:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245642AbiBQUDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 15:03:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242479AbiBQUDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 15:03:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13DF46672;
        Thu, 17 Feb 2022 12:03:27 -0800 (PST)
Date:   Thu, 17 Feb 2022 20:03:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645128205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOeAq8Wz1215EOu7MIijxGemH7CRVJkP1nxWITYpvJw=;
        b=b+shO7ApXEu04h/YwnVFsAMe1Ga1dztA6BnX9GPWOuLKYg9jQY0t3iSjM6SCvX3w+GBHFd
        52PHFa4ScXJ6wN2+GeUesFy/Gbg+tL1Vx5gDS137P2CzOtNEEwpejcbG5YY3TxLjZDisci
        SrLXmebVlx5GBsDwUe9ZB7C/QFs10IsvDkyK9qlJ9wnpAi1+CgXhfMvkMEO937NpMfz3ix
        WAwERgOZItayvXOu2az8+iYwVBbl8BE4Ks/5Ux3CbIj18c3klAPw9ebh+Wrgi9sZqJ/TjW
        HqnszPqi3cDOcxlrOR2r9d5wzcAROHTVNK6gitimYrD+hunwn6I759Vw4P72bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645128205;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VOeAq8Wz1215EOu7MIijxGemH7CRVJkP1nxWITYpvJw=;
        b=IlCsC1PgVPeM2aYUKVuwGcLqGyrOo4fCttKj7HLAAgMOPtYgJgYmyZDMpwyMuULukDd4rV
        8TITMsu203ErUCBw==
From:   "tip-bot2 for Muhammad Usama Anjum" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Treat CC as one argument
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220214184109.3739179-3-usama.anjum@collabora.com>
References: <20220214184109.3739179-3-usama.anjum@collabora.com>
MIME-Version: 1.0
Message-ID: <164512820380.16921.322060840370939582.tip-bot2@tip-bot2>
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

Commit-ID:     6170abb21e2380477080b25145da9747ad467d3d
Gitweb:        https://git.kernel.org/tip/6170abb21e2380477080b25145da9747ad467d3d
Author:        Muhammad Usama Anjum <usama.anjum@collabora.com>
AuthorDate:    Mon, 14 Feb 2022 23:41:09 +05:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Feb 2022 11:55:17 -08:00

selftests/sgx: Treat CC as one argument

CC can have multiple sub-strings like "ccache gcc". For check_cc.sh,
CC needs to be treated like one argument. Put double quotes around it to
make CC one string and hence one argument.

Fixes: 2adcba79e69d ("selftests/x86: Add a selftest for SGX")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220214184109.3739179-3-usama.anjum@collabora.com
---
 tools/testing/selftests/sgx/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 2956584..75af864 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -4,7 +4,7 @@ include ../lib.mk
 
 .PHONY: all clean
 
-CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh $(CC) \
+CAN_BUILD_X86_64 := $(shell ../x86/check_cc.sh "$(CC)" \
 			    ../x86/trivial_64bit_program.c)
 
 ifndef OBJCOPY
