Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C47E508E83
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381208AbiDTRid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381163AbiDTRiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:38:17 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8B01EACA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:35:26 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id r12-20020a17090a690c00b001cb9bce2284so1319828pjj.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2gtKOU35OdURDLf2vQT2shOzxYpqDt8gAksR5jX1bwc=;
        b=UerDsJvqa+wjYvw3RmbKSKCag/gLiIUrxMEtyPzWi98n6Txmyb9L0p4f6C/xpvujt/
         4n0UBt++725LBe3gMgr4uUovUw6nE+Hw4QtwonboW1shQ8kUTq9NM4THEMu9xupN5p8Q
         h0lMY8GOcEfBG9Jd+VD9WSBbh0m9vcagXxpQdSBwD/m2oW9zQML5rioZE1fRrGuNI7XP
         cfJcUOM8YKcJziaSlz14VdViSGv0Y0EFdCG+8GofENoqBBvwl4TG8oFplLlEGBZymozj
         FRLdJM6kQZibiIFtYct8U5D6CVmUycMqjiu5J4ansFXN4VivyCqxQ8gYvzCZNqQtp2Vl
         xDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2gtKOU35OdURDLf2vQT2shOzxYpqDt8gAksR5jX1bwc=;
        b=eK1e1o7B/NB5y3GPs2XfbzJ++RCBMX2f2/r4bBgI3J8vmVGdStXco2IakRb2mclokY
         W37ku+r5IvxtJ2JYzwXmQ5tDeIJZ5aYg/1PAPog+XE5tCfwqhStSUDBOMZzfXtpbpl7T
         lGzDmiPrJo58WQZTsTOP10T7Fe5tcZuUxGQTDCdJ26Jj4m3Yv55+Kb7zhZGUOQVDyYIt
         GTGERbyZKV10JoZ0SRu1N9avzebmOM3dRxHrJBSsThnGQZstYeYQnEHdBGkbTcEhGBtW
         0IISPyvWsVmcJkyKIIb0W1fSQwMXMl44BTeHUE95JZee+73e6p4qr51cGsQFnG8ELVI8
         X+6Q==
X-Gm-Message-State: AOAM531Z2JvIi35YVjfaUEVbUoBEI9yCkyf3Da81Iw5jW/MqgksOxtRT
        cTYGXeSEQpDLlDCp/4yZzNm8Alf/xqHPnf1hurhXIbzgGAns5gYUF2Ut+R8UDWdzjeA9U/0BUNI
        feJEhumG93joSq6M3LEErJslyPKineHoJ8huTZXMLiYxCaCbnlgB/mm7LlEfosyg7rDgyJaHO
X-Google-Smtp-Source: ABdhPJymfloTy7XRp3ZJVIqCgiFCZHKjPQQqzUk2UH9hwRmzj7Aft1fc3NOFXJsNrgjFBZge2vJSLIJb+4Hv
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:6ea6:489a:aad6:761c])
 (user=bgardon job=sendgmr) by 2002:aa7:9019:0:b0:4fa:7532:9551 with SMTP id
 m25-20020aa79019000000b004fa75329551mr24877253pfo.26.1650476126053; Wed, 20
 Apr 2022 10:35:26 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:35:08 -0700
In-Reply-To: <20220420173513.1217360-1-bgardon@google.com>
Message-Id: <20220420173513.1217360-6-bgardon@google.com>
Mime-Version: 1.0
References: <20220420173513.1217360-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v6 05/10] KVM: selftests: Read binary stat data in lib
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code to read the binary stats data to the KVM selftests
library. It will be re-used by other tests to check KVM behavior.

No functional change intended.

Reviewed-by: David Matlack <dmatlack@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  3 ++
 .../selftests/kvm/kvm_binary_stats_test.c     |  7 ++--
 tools/testing/selftests/kvm/lib/kvm_util.c    | 36 +++++++++++++++++++
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index fabe46ddc1b2..2a3a4d9ed8e3 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -403,6 +403,9 @@ int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
 void read_stats_header(int stats_fd, struct kvm_stats_header *header);
 struct kvm_stats_desc *read_stats_desc(int stats_fd,
 				       struct kvm_stats_header *header);
+int read_stat_data(int stats_fd, struct kvm_stats_header *header,
+		   struct kvm_stats_desc *desc, uint64_t *data,
+		   ssize_t max_elements);
 
 uint32_t guest_get_vcpuid(void);
 
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 8b31f8fc7e08..59677fae26e5 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -160,11 +160,8 @@ static void stats_test(int stats_fd)
 	size_data = 0;
 	for (i = 0; i < header.num_desc; ++i) {
 		pdesc = (void *)stats_desc + i * size_desc;
-		ret = pread(stats_fd, stats_data,
-				pdesc->size * sizeof(*stats_data),
-				header.data_offset + size_data);
-		TEST_ASSERT(ret == pdesc->size * sizeof(*stats_data),
-				"Read data of KVM stats: %s", pdesc->name);
+		read_stat_data(stats_fd, &header, pdesc, stats_data,
+			       pdesc->size);
 		size_data += pdesc->size * sizeof(*stats_data);
 	}
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 12fa8cc88043..ea4ab64e5997 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2615,3 +2615,39 @@ struct kvm_stats_desc *read_stats_desc(int stats_fd,
 
 	return stats_desc;
 }
+
+/*
+ * Read stat data for a particular stat
+ *
+ * Input Args:
+ *   stats_fd - the file descriptor for the binary stats file from which to read
+ *   header - the binary stats metadata header corresponding to the given FD
+ *   desc - the binary stat metadata for the particular stat to be read
+ *   max_elements - the maximum number of 8-byte values to read into data
+ *
+ * Output Args:
+ *   data - the buffer into which stat data should be read
+ *
+ * Return:
+ *   The number of data elements read into data or -ERRNO on error.
+ *
+ * Read the data values of a specified stat from the binary stats interface.
+ */
+int read_stat_data(int stats_fd, struct kvm_stats_header *header,
+		   struct kvm_stats_desc *desc, uint64_t *data,
+		   ssize_t max_elements)
+{
+	ssize_t size = min_t(ssize_t, desc->size, max_elements);
+	ssize_t ret;
+
+	ret = pread(stats_fd, data, size * sizeof(*data),
+		    header->data_offset + desc->offset);
+
+	/* ret from pread is in bytes. */
+	ret = ret / sizeof(*data);
+
+	TEST_ASSERT(ret == size,
+		    "Read data of KVM stats: %s", desc->name);
+
+	return ret;
+}
-- 
2.36.0.rc0.470.gd361397f0d-goog

