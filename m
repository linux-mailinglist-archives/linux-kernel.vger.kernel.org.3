Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 983E954D9C2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 07:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358509AbiFPFhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 01:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242913AbiFPFhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 01:37:34 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3F855B1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 22:37:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EEB6221BC3;
        Thu, 16 Jun 2022 05:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655357842; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dts+yl7uUGQYgHpGD+VRq8p1wRFkW3OYpt27WoT5mBw=;
        b=Wx6s/9DMRIBUq5O2Ke+thHwBX/osV+aWHUpiZvIt+G+IFpLzMjvbRDuj/MJ050pNFTctl4
        8dE8pXdY3hRNQ0SbDIBUrxQXzeDaHSrwPiWsXhR6K0w0nwLIfI2c4YaTL8lAgab2z9P8Ij
        zoMmc13vZ8d1+vQZkTY/g1lOkI6qGa8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B8DAE139C4;
        Thu, 16 Jun 2022 05:37:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PojHK5LBqmKVRwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 16 Jun 2022 05:37:22 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     viresh.kumar@linaro.org, hch@infradead.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: [PATCH v2] xen: don't require virtio with grants for non-PV guests
Date:   Thu, 16 Jun 2022 07:37:15 +0200
Message-Id: <20220616053715.3166-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
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

Commit fa1f57421e0b ("xen/virtio: Enable restricted memory access using
Xen grant mappings") introduced a new requirement for using virtio
devices: the backend now needs to support the VIRTIO_F_ACCESS_PLATFORM
feature.

This is an undue requirement for non-PV guests, as those can be operated
with existing backends without any problem, as long as those backends
are running in dom0.

Per default allow virtio devices without grant support for non-PV
guests.

Add a new config item to always force use of grants for virtio.

Fixes: fa1f57421e0b ("xen/virtio: Enable restricted memory access using Xen grant mappings")
Reported-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- remove command line parameter (Christoph Hellwig)
---
 drivers/xen/Kconfig | 9 +++++++++
 include/xen/xen.h   | 2 +-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index bfd5f4f706bc..a65bd92121a5 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -355,4 +355,13 @@ config XEN_VIRTIO
 
 	  If in doubt, say n.
 
+config XEN_VIRTIO_FORCE_GRANT
+	bool "Require Xen virtio support to use grants"
+	depends on XEN_VIRTIO
+	help
+	  Require virtio for Xen guests to use grant mappings.
+	  This will avoid the need to give the backend the right to map all
+	  of the guest memory. This will need support on the backend side
+	  (e.g. qemu or kernel, depending on the virtio device types used).
+
 endmenu
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 0780a81e140d..4d4188f20337 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -56,7 +56,7 @@ extern u64 xen_saved_max_mem_size;
 
 static inline void xen_set_restricted_virtio_memory_access(void)
 {
-	if (IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain())
+	if (IS_ENABLED(CONFIG_XEN_VIRTIO_FORCE_GRANT) || xen_pv_domain())
 		platform_set(PLATFORM_VIRTIO_RESTRICTED_MEM_ACCESS);
 }
 
-- 
2.35.3

