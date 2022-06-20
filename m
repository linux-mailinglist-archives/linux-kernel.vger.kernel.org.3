Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63A87551F5C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbiFTOtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240838AbiFTOsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:48:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4383A1B6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 07:08:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91AF5B811C2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 14:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D10C341CB;
        Mon, 20 Jun 2022 14:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655734085;
        bh=Z/oJEsaKj+L+FGhbF0pNjut3FueP7Z/IV1nVOkNcn0Y=;
        h=From:To:Cc:Subject:Date:From;
        b=vRarTaatcWNz+voPqUJMYscS68LZ1V477ksWEK9vwO6iV0nA/rf98ijJsgcHxdofI
         8X6AEd4luZ8WEtvGupUAu6Dl3jRpi70w+JdzR5lDcBmY53P4PiU4wAVSo0bTgtow5p
         dcG2hOFryndE0fh8ZbqXWGh/SHYpov/j0AClwWMKB/1PY8CyClX2XHYe1Vun9dE0eW
         oD7AZLQxzWwQyB9BLR2AtgM1oScItE9V033yioqeoNwn/2JFyFxPF3M9vfMy3vItQz
         4q8OsyPCmd+hgq8JW+nYEyN5kEQIiZ+yiph0T6rdZE2tN1m7ZCx0EfrR/pIXkUNKYU
         9HaAV3Cepn3iw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3I4P-0002Yi-U4; Mon, 20 Jun 2022 16:08:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH RESEND] x86/pmem: fix platform-device leak in error path
Date:   Mon, 20 Jun 2022 16:07:23 +0200
Message-Id: <20220620140723.9810-1-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure to free the platform device in the unlikely event that
registration fails.

Fixes: 7a67832c7e44 ("libnvdimm, e820: make CONFIG_X86_PMEM_LEGACY a tristate option")
Signed-off-by: Johan Hovold <johan@kernel.org>
---

It's been almost four months so resending.

Obviously not an important fix in itself, but this allows for getting
rid of the last two users of platform_device_add() that failed to
release the platform device on errors (and may help prevent new ones
from being added).

Johan


 arch/x86/kernel/pmem.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/pmem.c b/arch/x86/kernel/pmem.c
index 6b07faaa1579..23154d24b117 100644
--- a/arch/x86/kernel/pmem.c
+++ b/arch/x86/kernel/pmem.c
@@ -27,6 +27,11 @@ static __init int register_e820_pmem(void)
 	 * simply here to trigger the module to load on demand.
 	 */
 	pdev = platform_device_alloc("e820_pmem", -1);
-	return platform_device_add(pdev);
+
+	rc = platform_device_add(pdev);
+	if (rc)
+		platform_device_put(pdev);
+
+	return rc;
 }
 device_initcall(register_e820_pmem);
-- 
2.35.1

