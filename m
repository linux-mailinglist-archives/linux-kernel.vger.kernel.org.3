Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048D7518556
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236072AbiECNZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiECNZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:25:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C460336B7C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:22:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 60A7521871;
        Tue,  3 May 2022 13:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651584130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CsELYWB9g735n4psOgGA9RLVHOTzorxnOT84eRzNkC4=;
        b=bTPrVtI98WQI22j4IYJLmfiH/e8o2FSFZ7FrB5SFsp33Oi13Cy18uQCxYfHrJpShK6M1t4
        K9qPTJ0SxyLjKyMS0KuYdCJGf2bVdcqC2KyIgsR1uPLFEPrejQ1cJVWYyEMo+F3ATAxyEM
        DnCZsYFDCVgN2tCW6uOkWMgAo9KNMnI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0838913AE0;
        Tue,  3 May 2022 13:22:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4IeDAIIscWIASAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 03 May 2022 13:22:10 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jbeulich@suse.com, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/2] x86/pat: fix x86_has_pat_wp()
Date:   Tue,  3 May 2022 15:22:06 +0200
Message-Id: <20220503132207.17234-2-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220503132207.17234-1-jgross@suse.com>
References: <20220503132207.17234-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86_has_pat_wp() is using a wrong test, as it relies on the normal
PAT configuration used by the kernel. In case the PAT MSR has been
setup by another entity (e.g. BIOS or Xen hypervisor) it might return
false even if the PAT configuration is allowing WP mappings.

Fixes: 1f6f655e01ad ("x86/mm: Add a x86_has_pat_wp() helper")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/mm/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d8cfce221275..71e182ebced3 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -80,7 +80,8 @@ static uint8_t __pte2cachemode_tbl[8] = {
 /* Check that the write-protect PAT entry is set for write-protect */
 bool x86_has_pat_wp(void)
 {
-	return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] == _PAGE_CACHE_MODE_WP;
+	return __pte2cachemode_tbl[__cachemode2pte_tbl[_PAGE_CACHE_MODE_WP]] ==
+	       _PAGE_CACHE_MODE_WP;
 }
 
 enum page_cache_mode pgprot2cachemode(pgprot_t pgprot)
-- 
2.35.3

