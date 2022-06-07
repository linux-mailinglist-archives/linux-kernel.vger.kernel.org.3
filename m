Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D811542396
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391697AbiFHB51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1588470AbiFGXyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 19:54:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D14E96FF;
        Tue,  7 Jun 2022 16:09:55 -0700 (PDT)
Date:   Tue, 07 Jun 2022 23:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654643394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPtbavvWbpS7D7tQA2mHOL1BkRlP5Uv7lAoc3YHVg04=;
        b=nxJI3qMF2EzpyqqTD8K6BZxPqOoAptV7F3Jrbt+1JxEWQYfZQfrrJGBN3M4z5Lwge7Mdam
        UF0oCKTcFl8nJ9duQNV8D+s0ggs4YH8O5TBqBlTtNoMa0i4Nx9pNhVKgbHM2ikTt5R7SzB
        pEpL1o2INu7OaCRPBILjvIqOpJZmsMGmhsJYQnIF4Fg537RZabMMwq9OcAuTOXUCDoIIc9
        MizjeurkocdCLuxQJnphtZJvyow9TNfuhc0hxeZIfPD3nr00asR/4fpEDMnFiJFKviTlkf
        fkWHkhQJoIspFzzKQNQqbir6vWFd4bEKcqdIZzGMDKjdOGlknRp0xMe5GhcJtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654643394;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dPtbavvWbpS7D7tQA2mHOL1BkRlP5Uv7lAoc3YHVg04=;
        b=Wo3Sp00UT3ZpFCyVn+uwJxxrggurJSA46NHn9T9gIG2lDUpnh1T+0+4IBmiGzy2+ASyyHZ
        BpL2qfI4DRSULbAA==
From:   "tip-bot2 for Ira Weiny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/pkeys: Clarify PKRU_AD_KEY macro
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220419170649.1022246-3-ira.weiny@intel.com>
References: <20220419170649.1022246-3-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID: <165464339203.4207.2085449999144025922.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     54ee1844047c1df015ab2679a4f55564a3aa1fa1
Gitweb:        https://git.kernel.org/tip/54ee1844047c1df015ab2679a4f55564a3aa1fa1
Author:        Ira Weiny <ira.weiny@intel.com>
AuthorDate:    Tue, 19 Apr 2022 10:06:07 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 07 Jun 2022 16:06:33 -07:00

x86/pkeys: Clarify PKRU_AD_KEY macro

When changing the PKRU_AD_KEY macro to be used for PKS the name came
into question.[1]

The intent of PKRU_AD_KEY is to set an initial value for the PKRU
register but that is just a mask value.

Clarify this by changing the name to PKRU_AD_MASK().

NOTE the checkpatch errors are ignored for the init_pkru_value to align
the values in the code.

[1] https://lore.kernel.org/lkml/eff862e2-bfaa-9e12-42b5-a12467d72a22@intel.com/

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lkml.kernel.org/r/20220419170649.1022246-3-ira.weiny@intel.com
---
 arch/x86/mm/pkeys.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index e44e938..7418c36 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -110,7 +110,7 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
 	return vma_pkey(vma);
 }
 
-#define PKRU_AD_KEY(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
+#define PKRU_AD_MASK(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
 
 /*
  * Make the default PKRU value (at execve() time) as restrictive
@@ -118,11 +118,14 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
  * in the process's lifetime will not accidentally get access
  * to data which is pkey-protected later on.
  */
-u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
-		      PKRU_AD_KEY( 4) | PKRU_AD_KEY( 5) | PKRU_AD_KEY( 6) |
-		      PKRU_AD_KEY( 7) | PKRU_AD_KEY( 8) | PKRU_AD_KEY( 9) |
-		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
-		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
+u32 init_pkru_value = PKRU_AD_MASK( 1) | PKRU_AD_MASK( 2) |
+		      PKRU_AD_MASK( 3) | PKRU_AD_MASK( 4) |
+		      PKRU_AD_MASK( 5) | PKRU_AD_MASK( 6) |
+		      PKRU_AD_MASK( 7) | PKRU_AD_MASK( 8) |
+		      PKRU_AD_MASK( 9) | PKRU_AD_MASK(10) |
+		      PKRU_AD_MASK(11) | PKRU_AD_MASK(12) |
+		      PKRU_AD_MASK(13) | PKRU_AD_MASK(14) |
+		      PKRU_AD_MASK(15);
 
 static ssize_t init_pkru_read_file(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
