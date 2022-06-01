Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C9153AEE3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiFAVLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiFAVKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:10:10 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2D33A5CC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:10:08 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-30c9a01d1c5so25648027b3.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 14:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pVaTSPAQEVy2CNYXgyGERflUa1UnpxtWsRCm1+DHM0I=;
        b=qXULVoO6+EalsRQww91BZdH4F1FPzamFzdCuD9JMQ4oNnbzdCmSxgZc20iLjfaIyu9
         035Kh0CdYGlLPiJ25ddJxscd3BxxTLLcfX0jtZdREgFMIqn1rkbSKgkARzioTC/A8tas
         3NuYB6L1HD4gTO/aNzJLnSQ1WaggmOx0/438qBX2iBbhumXV/RhZOiPpIoLlmk0RUXOc
         5t/PUzmGxbJzrDGV0mbbU7bvEqDmcNEq1Djll7wqS+zFaKHHjXzOSGDGaNE/ywAEkvwF
         T/6K/glEUQhT8dMeNTcbQNapsDUmm9zjIn4Q0zu18LpjqZK/MsywWWDJdVtwA61+vhmX
         MMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pVaTSPAQEVy2CNYXgyGERflUa1UnpxtWsRCm1+DHM0I=;
        b=kJ4UwpFzsFu7ixskgDfayYJCokXxEDevgVIYAxBKD6TjDuzEl0SRIM5lcHEBqY/0DG
         +9qvdSPSHf+lCkV6GDkDvNHggM8ALvvtffMZsX/9TCuEsFVCAD/cf6Z/sDEkFqfAuT+p
         r47SWGX2zGMyxfuRbBYvoDujEKESTaw/HTMVvxMqAvYRebyrJhKA29atIrY+H4kKm6FT
         MsQPmttR3D5FZrwvrTnItjA1WW+0zjy31KKT0cidz6Ut+XxeV2PGSHDwgpxjKX5TFihh
         Q4G+OvjFBAHJDVT6gLT1hDR7W+8jRbd9XUYBgxf+Y4uuYWXugIp0+PGdm2hYa1+ZAkO0
         sI8Q==
X-Gm-Message-State: AOAM5305q9nR6DaJUWg61a/zK/Cl4dt2iOjKVBGMONE8eoF2uTEMdSL6
        ylzUTzit+L18n8KYzql7hiO2X48nrl4TLkPTuDEs
X-Google-Smtp-Source: ABdhPJwG95aafNsEufWgrETrVkwWcP9feuuT5hALzrFwcXkK1hca+6s5+HAso23kqRPbpApWAa16vBUbLGVvfdFw/mck
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:aaec:e358:9f0e:2b26])
 (user=axelrasmussen job=sendgmr) by 2002:a81:6c56:0:b0:30f:a8ef:950d with
 SMTP id h83-20020a816c56000000b0030fa8ef950dmr1726046ywc.322.1654117808101;
 Wed, 01 Jun 2022 14:10:08 -0700 (PDT)
Date:   Wed,  1 Jun 2022 14:09:51 -0700
In-Reply-To: <20220601210951.3916598-1-axelrasmussen@google.com>
Message-Id: <20220601210951.3916598-7-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220601210951.3916598-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH v3 6/6] selftests: vm: add /dev/userfaultfd test cases to run_vmtests.sh
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This new mode was recently added to the userfaultfd selftest. We want to
exercise both userfaultfd(2) as well as /dev/userfaultfd, so add both
test cases to the script.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/run_vmtests.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 7e102246dd9f..930c54eb5b4b 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -121,12 +121,17 @@ run_test ./gup_test -a
 run_test ./gup_test -ct -F 0x1 0 19 0x1000
 
 run_test ./userfaultfd anon 20 16
+run_test ./userfaultfd anon:dev 20 16
 # Hugetlb tests require source and destination huge pages. Pass in half the
 # size ($half_ufd_size_MB), which is used for *each*.
 run_test ./userfaultfd hugetlb "$half_ufd_size_MB" 32
+run_test ./userfaultfd hugetlb:dev "$half_ufd_size_MB" 32
 run_test ./userfaultfd hugetlb_shared "$half_ufd_size_MB" 32 "$mnt"/uffd-test
 rm -f "$mnt"/uffd-test
+run_test ./userfaultfd hugetlb_shared:dev "$half_ufd_size_MB" 32 "$mnt"/uffd-test
+rm -f "$mnt"/uffd-test
 run_test ./userfaultfd shmem 20 16
+run_test ./userfaultfd shmem:dev 20 16
 
 #cleanup
 umount "$mnt"
-- 
2.36.1.255.ge46751e96f-goog

