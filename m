Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4474CCD04
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbiCDFVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238205AbiCDFVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:21:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32BE3186B81
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TsbV9aZwys4B5ATDrVcah3NNWPIloXpy6hGN6YFlyJ0=;
        b=aPEArK2oXQA8kC9M9f7b4TPpmYhgATepuaN4sO7wqDGRNLeQxNx+LbMX61sTLNvV3mn+0Y
        WWgzOxCE54MhRNl+Mk/LbhxHWKFdliN1lg1ImDwtYrBIC6BO548Lp+q1c1XP2kClwfr7Z4
        58YarW/K/rmUzqx7UuABDOVYnDf6eEQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-580-ur6LRQ8wPhi5cqmKyWRF3g-1; Fri, 04 Mar 2022 00:20:20 -0500
X-MC-Unique: ur6LRQ8wPhi5cqmKyWRF3g-1
Received: by mail-pg1-f198.google.com with SMTP id v32-20020a634660000000b0037c3f654c50so3272570pgk.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsbV9aZwys4B5ATDrVcah3NNWPIloXpy6hGN6YFlyJ0=;
        b=1SjgoDbHSXy6RH/MqiRiQQxNttbqQx6oHn1obuiuFDfy+nqxrOFn4hYaDsBRRloA19
         5ZRN7tjS8xLLe+86WHYFfBFnJfxok0TxrOYuqnnqFsau/w7BrL58JYasMsYBWXlgp8eW
         IecyvmpB1STkftJ+5GpLCnO3jZJQZ9BhGP3ByVkNPoEvgiIo1+O91LdaZcO7qu5Ofy1D
         7x3UNT6AO1taB2VgH2goTg9zpgEzr4KhVGINJfIZtIa93UnU4D9j2wdb8DsTIM8llpSR
         JvH+gcbGOU5+V7NPtiFLo7Benrj7AowN0DxN62ti8d+4ugyPrFGilnrgMYBN5cmze9zJ
         9SgA==
X-Gm-Message-State: AOAM532HPEMeTShUH7eGIQfeiHBGuQlqRZKv8bgIvtMfZwEdi44YkuXQ
        EsK2AI7Vf5oDZOEio0UxCGKA5sRf3t5vq8KRCNtM8BOSWO9fq0PH/RFdVKBVGjGyK1BEvQAx5jV
        PjgFtEn0EaGnAVZCDS+yni5IT
X-Received: by 2002:a63:8648:0:b0:37c:8fc8:ae4 with SMTP id x69-20020a638648000000b0037c8fc80ae4mr2426557pgd.482.1646371219106;
        Thu, 03 Mar 2022 21:20:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxRWTNjzqF9FDUsgNw/iTSctk6JZiPnQ2cg8VqL5h80ojfUPsMdu0+kgc5kk3/QOyRztfI6Hg==
X-Received: by 2002:a63:8648:0:b0:37c:8fc8:ae4 with SMTP id x69-20020a638648000000b0037c8fc80ae4mr2426547pgd.482.1646371218872;
        Thu, 03 Mar 2022 21:20:18 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.20.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:20:18 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH v7 22/23] mm: Enable PTE markers by default
Date:   Fri,  4 Mar 2022 13:17:07 +0800
Message-Id: <20220304051708.86193-23-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304051708.86193-1-peterx@redhat.com>
References: <20220304051708.86193-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable PTE markers by default.  On x86_64 it means it'll auto-enable
PTE_MARKER_UFFD_WP as well.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index a80ea8721885..93e90efc4ab7 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -901,7 +901,7 @@ config ANON_VMA_NAME
 	  difference in their name.
 
 config PTE_MARKER
-	def_bool n
+	def_bool y
 	bool "Marker PTEs support"
 
 	help
-- 
2.32.0

