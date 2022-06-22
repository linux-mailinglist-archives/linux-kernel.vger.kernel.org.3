Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663EF5550EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359403AbiFVQLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359244AbiFVQKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:10:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D36C3EF03
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:10:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 0D4FE1F8E1;
        Wed, 22 Jun 2022 16:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655914252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3utwreIcXrsHaZ2aPHJW+ToYT/lkMci89t36LS1rRtk=;
        b=rX2V6UHCEbDokFsQZRoynOuusc4yhrQefn8Slx89yncv7CUS9rWToPJogg9VgkkRvxO5zF
        N7BA+/1Vos8rc9Z+chjfuoz3ATNTNR2xeetaKfYJXvrv6KH3E/uFe1jwy76fiUCBiELIRh
        sXBNDkiFiCrv7gLrbWjiPv+yKlln+t4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C084013AC7;
        Wed, 22 Jun 2022 16:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +DmlLQs/s2JzCwAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 22 Jun 2022 16:10:51 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/2] x86: fix setup of brk area
Date:   Wed, 22 Jun 2022 18:10:48 +0200
Message-Id: <20220622161048.4483-3-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220622161048.4483-1-jgross@suse.com>
References: <20220622161048.4483-1-jgross@suse.com>
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

Commit e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for older binutils")
put the brk area into the .bss segment, causing it not to be cleared
initially. As the brk area is used to allocate early page tables, these
might contain garbage in not explicitly written entries.

This is especially a problem for Xen PV guests, as the hypervisor will
validate page tables (check for writable page tables and hypervisor
private bits) before accepting them to be used. There have been reports
of early crashes of PV guests due to illegal page table contents.

Fix that by letting clear_bss() clear the brk area, too.

Fixes: e32683c6f7d2 ("x86/mm: Fix RESERVE_BRK() for older binutils")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/head64.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index e7e233209a8c..6a3cfaf6b72a 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -430,6 +430,8 @@ void __init clear_bss(void)
 {
 	memset(__bss_start, 0,
 	       (unsigned long) __bss_stop - (unsigned long) __bss_start);
+	memset(__brk_base, 0,
+	       (unsigned long) __brk_limit - (unsigned long) __brk_base);
 }
 
 static unsigned long get_cmd_line_ptr(void)
-- 
2.35.3

