Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0333C4F2175
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiDECpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 22:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiDECou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 22:44:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0DC0CEA34A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 18:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649123384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9fEneeyQr1XaNwKhMDQcOUUZbbgPBUxsqyNto4zx3Io=;
        b=OUAQt8iiqhobVHP3MutT95TFGpHYoDkfAsY8qnl8O19zSTOF2FDN7ZJ/8M/19N9ZzhtioN
        bgIUyf+wZd9tU6e8/v95kOHfuPASH/0VYSgDnClBt2AQwUsIsCwj1fbB23tgnr0rkAQuc2
        0goKrvWIjhpfIOymQwLgWDXIzQsWz9w=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-451-Myq_7ErbMCuYDx5nwF2OcQ-1; Mon, 04 Apr 2022 21:49:35 -0400
X-MC-Unique: Myq_7ErbMCuYDx5nwF2OcQ-1
Received: by mail-il1-f200.google.com with SMTP id y8-20020a056e020f4800b002ca498c9655so2147608ilj.20
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 18:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fEneeyQr1XaNwKhMDQcOUUZbbgPBUxsqyNto4zx3Io=;
        b=0isT15sTqSNARIl3w4jOtB7JD0qlyglNcpWucfOAJeKKKBiidrX/5t/Ocp+uJYmkN+
         usmIVrWdaAtkvmUjPD2FonnYvur1uR+DSxYlKMoI6K+yae5RmO7l+mrRWN/eAU17Ifku
         XA4S0gh6uS0cBVrp26+MetuZHbLM3+Y4xNHJYMHxcDpTKXZN+iXYVSP6DnpkUip5fBTJ
         TfLhRrVlrCaArL4T22OHlZaN29HKqQyNGfVFeMIrJEIYFZ0qLKBbiNEuZg3SE0ActzPG
         YdH/BPK7VroFW9wS0MNrYGunv76D0HwxMELX+/2veFKowThKgIrRQ2sqsVHOpaKHZSqR
         2brA==
X-Gm-Message-State: AOAM530CTDpx8p57WFGjfVxBTK5uYkPXYJRkoHMP3wKMPOiKojGoORe4
        pMgD2vEZ1zW2KRDH7xhJ62tZAh7safeZPCfJJFLZNF8WG24HqzmZ6dclOvXyj1MyZ3eJFanKK//
        7GF60crhDiR5hOM18q9j6m56qgUkOeEsxiN0WaLSyH9y9mt64agIrdaYB77NsY3GMvwj6ww/WUA
        ==
X-Received: by 2002:a92:2e01:0:b0:2ca:1f0d:fe5d with SMTP id v1-20020a922e01000000b002ca1f0dfe5dmr531926ile.201.1649123374803;
        Mon, 04 Apr 2022 18:49:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6gsEsxVDLt+Q8uilC+AQSvDlTB1lbfOZtS3HSLlBkhdkp9NXI433lqCZ74NP5YsBF3yosQw==
X-Received: by 2002:a92:2e01:0:b0:2ca:1f0d:fe5d with SMTP id v1-20020a922e01000000b002ca1f0dfe5dmr531898ile.201.1649123374449;
        Mon, 04 Apr 2022 18:49:34 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id s10-20020a6b740a000000b006413d13477dsm7272806iog.33.2022.04.04.18.49.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Apr 2022 18:49:34 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Alistair Popple <apopple@nvidia.com>, peterx@redhat.com
Subject: [PATCH v8 23/23] selftests/uffd: Enable uffd-wp for shmem/hugetlbfs
Date:   Mon,  4 Apr 2022 21:49:32 -0400
Message-Id: <20220405014932.15212-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405014646.13522-1-peterx@redhat.com>
References: <20220405014646.13522-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
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
index 92a4516f8f0d..bbc4a6d8cf7b 100644
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
 
@@ -1594,8 +1594,6 @@ static void set_test_type(const char *type)
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

