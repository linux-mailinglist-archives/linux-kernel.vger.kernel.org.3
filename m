Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0754CCCFC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 06:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbiCDFVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 00:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238214AbiCDFV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 00:21:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F200187BB7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646371229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/LhV/Ezx1y/irXCjQ5LcN5y8nixtLOeiBAqYVpW0dWs=;
        b=TlxyA7LUg59805Uegl8WcuUbJLCiH/Or1fM9D8NAJoKlQuo+kzGAfmq/DsNElmFFPLfXjS
        M1K519NGNd5uKFQDia0E8G+luDhCd/9ucXP6pvozLqL4VtH3jSj5MnQnsgoowXn8fr3lzJ
        01kY4zfT3hFnyz/5mTBrvmZrzmtp6/A=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-G0i2FlNdNj672f5lREGhaw-1; Fri, 04 Mar 2022 00:20:27 -0500
X-MC-Unique: G0i2FlNdNj672f5lREGhaw-1
Received: by mail-pg1-f199.google.com with SMTP id j29-20020a634a5d000000b00376a7b5602dso3922084pgl.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 21:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LhV/Ezx1y/irXCjQ5LcN5y8nixtLOeiBAqYVpW0dWs=;
        b=khjS2lmqvlccCvSK6VNPW4hk5Y8noPFO8sl+gbWLy6LkfpACq9O9HJNZTt8t9T796q
         BoB+LGwvxVq+Uk/zTKVVHqX0BO2lzNP9S7v7TLpqyobSFggofJma525Zu1QGY3I/kMM+
         m2K13Vp7o+TG78KelehdfJ5jfCci2NVoFwMn1gTkRc9U3Gpx03eFhtJOO+s7YKKzvlxE
         gQvFXeXDKbYNGrKyVX+JTUC5UyLFl/p0Yko42dvMc5Pg8by3c7JAoOPV01CdsZwd1WjG
         vQCfEFZew5Yy/FG1uPRJZ6cyjMwIYBKwmq+rPzhF9AXgaJc7ghvbOdkl+jbphpNx9/gp
         Tp3A==
X-Gm-Message-State: AOAM532B1rHI5x2sIIS9OTrTOxc0/JfjAUXeznQLAeR54Vm2FNIiUvUg
        dixvoMSh+PMHJqPdHO01gMkwQd1LjFwLr/0l3lzWTKFx2Ht5A26qYsuFgwNyUjkc4ISHhieiHBx
        PfKmnwblNiopbGcVzh9Zs04lE
X-Received: by 2002:a17:90b:17cb:b0:1bf:138d:e0f8 with SMTP id me11-20020a17090b17cb00b001bf138de0f8mr5251910pjb.157.1646371226899;
        Thu, 03 Mar 2022 21:20:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw1mSRuLkPo2ioYs6r74omrthJGnPJt2ZsaElav8kmbyVq3KwqPqDcyzWlHKXdEjHb9j9zBKw==
X-Received: by 2002:a17:90b:17cb:b0:1bf:138d:e0f8 with SMTP id me11-20020a17090b17cb00b001bf138de0f8mr5251896pjb.157.1646371226610;
        Thu, 03 Mar 2022 21:20:26 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.59])
        by smtp.gmail.com with ESMTPSA id p16-20020a056a000b5000b004f669806cd9sm4323865pfo.87.2022.03.03.21.20.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Mar 2022 21:20:26 -0800 (PST)
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
Subject: [PATCH v7 23/23] selftests/uffd: Enable uffd-wp for shmem/hugetlbfs
Date:   Fri,  4 Mar 2022 13:17:08 +0800
Message-Id: <20220304051708.86193-24-peterx@redhat.com>
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

After we added support for shmem and hugetlbfs, we can turn uffd-wp test on
always now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index fe404398c65a..d91668df8135 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -82,7 +82,7 @@ static int test_type;
 static volatile bool test_uffdio_copy_eexist = true;
 static volatile bool test_uffdio_zeropage_eexist = true;
 /* Whether to test uffd write-protection */
-static bool test_uffdio_wp = false;
+static bool test_uffdio_wp = true;
 /* Whether to test uffd minor faults */
 static bool test_uffdio_minor = false;
 
@@ -1597,8 +1597,6 @@ static void set_test_type(const char *type)
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
-		/* Only enable write-protect test for anonymous test */
-		test_uffdio_wp = true;
 	} else if (!strcmp(type, "hugetlb")) {
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-- 
2.32.0

