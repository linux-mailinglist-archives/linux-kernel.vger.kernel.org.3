Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42485A4CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiH2M4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiH2M4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E74C58B7B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661777281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Vq6S9k41K0ozfm3HjX6Hm9UzfxhgAZTgGJlWKH5WN+U=;
        b=F0BxZqnqo3OTVd22nLJZAIM0z7sMtLFJux0bNpkyftO0u1K3XI200jsMBGBRyYzojvLCKU
        KSXyWJA2WuQaGFoH8YDflGGvgxpoK/BKeso8EI9VMy3Jw+J8XXF+vcNtujFUofSJBHW58J
        XvsrFGCTvYdL0oDMD7+Olag7WnC4kGM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-DhFrdFW-PfKXWzBEp3mNsA-1; Mon, 29 Aug 2022 08:48:00 -0400
X-MC-Unique: DhFrdFW-PfKXWzBEp3mNsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCF091C1BD28;
        Mon, 29 Aug 2022 12:47:58 +0000 (UTC)
Received: from vbendel-laptop-2020.redhat.com (unknown [10.40.195.0])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DC2E1415117;
        Mon, 29 Aug 2022 12:47:56 +0000 (UTC)
From:   vbendel@redhat.com
To:     linux-doc@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Mike Rapoport <rppt@kernel.org>,
        Vratislav Bendel <vbendel@redhat.com>,
        Jozef Bacik <jobacik@redhat.com>
Subject: [PATCH] docs: mm: fix vm overcommit documentation for OVERCOMMIT_GUESS
Date:   Mon, 29 Aug 2022 14:46:38 +0200
Message-Id: <20220829124638.63748-1-vbendel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vratislav Bendel <vbendel@redhat.com>

Commit 8c7829b04c52 "mm: fix false-positive OVERCOMMIT_GUESS failures"
changed the behavior of the default OVERCOMMIT_GUESS setting.
Reflect the change also in the Documentation, namely files:
    Documentation/admin-guide/sysctl/vm.rst
    Documentation/mm/overcommit-accounting.rst

Reported-by: Jozef Bacik <jobacik@redhat.com>
Signed-off-by: Vratislav Bendel <vbendel@redhat.com>
---
 Documentation/admin-guide/sysctl/vm.rst    | 4 ++--
 Documentation/mm/overcommit-accounting.rst | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index 9b833e439f09..351443427360 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -742,8 +742,8 @@ overcommit_memory
 
 This value contains a flag that enables memory overcommitment.
 
-When this flag is 0, the kernel attempts to estimate the amount
-of free memory left when userspace requests more memory.
+When this flag is 0, the kernel compares the userspace memory request
+size against total memory plus swap and rejects obvious overcommits.
 
 When this flag is 1, the kernel pretends there is always enough
 memory until it actually runs out.
diff --git a/Documentation/mm/overcommit-accounting.rst b/Documentation/mm/overcommit-accounting.rst
index a4895d6fc1c2..e2263477f6d5 100644
--- a/Documentation/mm/overcommit-accounting.rst
+++ b/Documentation/mm/overcommit-accounting.rst
@@ -8,8 +8,7 @@ The Linux kernel supports the following overcommit handling modes
 	Heuristic overcommit handling. Obvious overcommits of address
 	space are refused. Used for a typical system. It ensures a
 	seriously wild allocation fails while allowing overcommit to
-	reduce swap usage.  root is allowed to allocate slightly more
-	memory in this mode. This is the default.
+	reduce swap usage. This is the default.
 
 1
 	Always overcommit. Appropriate for some scientific
-- 
2.26.3

