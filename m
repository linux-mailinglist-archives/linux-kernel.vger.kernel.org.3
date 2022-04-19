Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5D507AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 22:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352632AbiDSU2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 16:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiDSU2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 16:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C68C8344FC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650399936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ax1hiIZ0I02ZmnVoS1FQGYcdelIwXVMzf8EDN4fi9ww=;
        b=MX1mpwCD52cQqxz8sOif9zOvldjgm9D006UbUprR12cmZEfz4mGvw6Jiq97AJ2DK3luDTl
        iI40ge4fivcrPQpuAzsKawnwRUwx5bq5yK2F0N6nY52lSzezTXDTIMmcINfT+AHr638mRV
        mCFqPtWnF5OLS1cXDzKypJimWGBGgz4=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-194-Cfy7skdqOmi5XAYVMQnx5A-1; Tue, 19 Apr 2022 16:25:35 -0400
X-MC-Unique: Cfy7skdqOmi5XAYVMQnx5A-1
Received: by mail-io1-f69.google.com with SMTP id s12-20020a056602168c00b00654ae9e6963so3450977iow.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 13:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ax1hiIZ0I02ZmnVoS1FQGYcdelIwXVMzf8EDN4fi9ww=;
        b=asBZS5LQvyZFK6DRiZV1NXOl7XYk97cDI4RsHbVLGOzeQCXJT3GPu5Hr8fo4FM7p2d
         ELcA4bJBmrh8V3buJZbwcIZ8m+Tw5Sw+jkMZT0PzSO8forRhMDME7qsjfAQ6fOxQOOmj
         I/kbhfkOS38AQYfRFmcVaXgxqKLf9Mtsx9zsSkE+Ax98M8bZjIi9wR0/qIvntcF4Sf+M
         Ck+xIsG/aO/W37xnL1k3lbF0iSNfp5l6lQVt5HflKFMiYc9N50Iv4FAGi3wdeQ/pbgjo
         pSmnfi44nNlHAlB22AX3cR69Uj49r2vnYyLcWotOxz+MJimbBWIBlatuvA3E6xHX3Jxx
         em4Q==
X-Gm-Message-State: AOAM531fiXF9KiKmu4iJqfqRu5fZox7dHMAR/If3yNU3HzbkzkYmMze9
        z65yc8dHYKbtlDJpwrkNrTPSQDGtvSLoc2DUqkKWRcd/yxQPNgio4WScdUA9ncUvbAYJSNNO92N
        ptTW+dUDddaWVc6mbCDrUh4hS
X-Received: by 2002:a92:508:0:b0:2cb:ebd8:a76b with SMTP id q8-20020a920508000000b002cbebd8a76bmr7979245ile.156.1650399934583;
        Tue, 19 Apr 2022 13:25:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHYRlcO9x0OUHBCz2/TrnKyl0H5zUpCoJ20gT+VTXDMr9UebvFOOiY+EiFAxleSo0TP00xXg==
X-Received: by 2002:a92:508:0:b0:2cb:ebd8:a76b with SMTP id q8-20020a920508000000b002cbebd8a76bmr7979232ile.156.1650399934379;
        Tue, 19 Apr 2022 13:25:34 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id i11-20020a92540b000000b002c9a82e8dacsm9403836ilb.32.2022.04.19.13.25.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Apr 2022 13:25:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/uffd: Hide PTE_MARKER option
Date:   Tue, 19 Apr 2022 16:25:31 -0400
Message-Id: <20220419202531.27415-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PTE_MARKER option should not need to be exposed to the kernel builder,
keep it internal and remove the prompt so it won't be seen.

Instead, make the PTE_MARKER_UFFD_WP option to explicitly choose PTE_MARKER
when necessary.

While PTE_MARKER_UFFD_WP will still prompt to user, change the wording so
that it'll not mention PTE_MARKER at all but renaming it to "Userfaultfd
write protection support for shmem/hugetlbfs".

Reported-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---

NOTE: IMHO this patch can either be standalone if easier, or be squashed
into patch "mm: Enable PTE markers by default" in -mm.

Please review, thanks.
---
 mm/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 3eca34c864c5..d740e1ff3b2f 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -910,16 +910,16 @@ config ANON_VMA_NAME
 	  difference in their name.
 
 config PTE_MARKER
-	bool "Marker PTEs support"
-	default y
+	bool
 
 	help
 	  Allows to create marker PTEs for file-backed memory.
 
 config PTE_MARKER_UFFD_WP
-	bool "Marker PTEs support for userfaultfd write protection"
+	bool "Userfaultfd write protection support for shmem/hugetlbfs"
 	default y
-	depends on PTE_MARKER && HAVE_ARCH_USERFAULTFD_WP
+	depends on HAVE_ARCH_USERFAULTFD_WP
+	select PTE_MARKER
 
 	help
 	  Allows to create marker PTEs for userfaultfd write protection
-- 
2.32.0

