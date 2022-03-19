Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA434DE94D
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243632AbiCSQcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 12:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiCSQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 12:32:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5D23F9C1;
        Sat, 19 Mar 2022 09:31:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC26DB801BE;
        Sat, 19 Mar 2022 16:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED249C340EC;
        Sat, 19 Mar 2022 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647707462;
        bh=wRvWM489UeSI+c+0E3Ykx681mCS+MQ5SYG34PY6iOWw=;
        h=From:To:Cc:Subject:Date:From;
        b=b8WXKmfCE0UOKsWUcbi5kt0GCBs6xHX910QkjBJVjRGiUrj0wbDJTdorzAHFrbpye
         bWHTMQiYRUcWH9plbzzQR2f3PSsa/IE7oSZ+Tjn6nrKNRFHotpi76FcUokcoswziF2
         yBJV9im5R+Sr7lr/48oL+h0AKFPDxmN5DP1Rp5dob4H8Mh0yAtqwPS53SpyAbQlpZE
         9jpOPw+sXKgewJiTY4vWxo8n4PiMHswXejZ3dAHAYO9qVUuRDKxCriUtAPPi0DdYXo
         VR0Tft931DZGLf5r+R0dC2qZRyS3BCgLWmjugRX0kHOL47a9ZwEQxZIf3FrAPo3lC5
         rkF9gCAX853KQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Subject: [PATCH] x86/sgx: Allow RW for TCS pages
Date:   Sat, 19 Mar 2022 18:30:10 +0200
Message-Id: <20220319163010.101686-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not allowing to set RW for added TCS pages leads only to a special case
to be handled in the user space run-time. Thus, allow permissions to be
set RW. Originally, it would have probably made more sense to check up
that the permissions are RW.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 arch/x86/kernel/cpu/sgx/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
index 83df20e3e633..f79761ad0400 100644
--- a/arch/x86/kernel/cpu/sgx/ioctl.c
+++ b/arch/x86/kernel/cpu/sgx/ioctl.c
@@ -215,7 +215,7 @@ static int sgx_validate_secinfo(struct sgx_secinfo *secinfo)
 	 * CPU will silently overwrite the permissions as zero, which means
 	 * that we need to validate it ourselves.
 	 */
-	if (pt == SGX_SECINFO_TCS && perm)
+	if (pt == SGX_SECINFO_TCS && (perm != 0 || perm != (PROT_READ | PROT_WRITE)))
 		return -EINVAL;
 
 	if (secinfo->flags & SGX_SECINFO_RESERVED_MASK)
-- 
2.35.1

