Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1A515352EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348420AbiEZRym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348383AbiEZRyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:54:23 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963A8A8883
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:54:20 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id z21-20020aa79595000000b00518157fadaeso1306425pfj.14
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5vGiJJSdPSy1HuUrdRdW0JjSgOuzkODUzYg68y2Y0IE=;
        b=awTsQInRgNWh6d6fLmKGIfDPoNZ4JDM2kuLlhw7abGgTIdeg2euhrAX2+NgjQ01LeN
         CVegJaCn3C37OaApahQZZF6U+jHJYg3R9YLzcff0AHf8fcOtObXcGOx3QYXHXjn4IFQF
         7zPaztoMyM5ZejafOqecsbkhUIC0MWLUfecOjsETMrxFDi5XEdAQnzYpVaYL3ilyjbz8
         j66SlEXU9kKc05kj3uu2cC1s5sJBNEgGdPpMqkqnwqPknzI/WVjPhp5bYxovnMqykJqO
         e4Pn7IhO0gVdfAPkt6bNvmhABkvsBDImE28fOEEdn4x5+obhzs/8efxaCWq/2y5B6YWU
         TMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5vGiJJSdPSy1HuUrdRdW0JjSgOuzkODUzYg68y2Y0IE=;
        b=x0qFGXDnZPamM7PEAoB3g0iya2oBhhHlHkPp6Tah9P0j0Heob0FAlHeiA+7PRgTMjV
         8Rv6kTBQ2xM5UQudGYR0/FF2cMidlbY5QjT0GyMryJMmJD3OyaxiNlP+0kHg2LLjhKK+
         ANx6Mozs+eRUvqwHsvaoANTTSc40mlRvB+LhgDib+m4msL1G+xWXxdm74SRtiEwt9qoM
         pNONQfcR8oaxC0K+cFhkXbSMwhQwPIesyCB210aQXoqzoZpkrqOa8+Jn7hUdCDUf+yod
         vsAnX5kIK4pElWSg7WgyYRX4Xrt9OFwyunPZewHiT9EEk/uU5+EOO4q6FzOGcql0MUbS
         b3nQ==
X-Gm-Message-State: AOAM531hvCOCZXdgVUQyL/5mcHZIERrXRRNbu9YTCLsvdqym9JNtmLB+
        x4ObylUGpPYz13xaMB0SJFJE1+1Lm5c9
X-Google-Smtp-Source: ABdhPJxzDERCjXuxy/IwSh6i+hQtpcXP2gfe93mhJr6DUTfm2z6EJg4aaaHDrZmVwey6gqWbRy9hbupmzePA
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a17:903:2305:b0:162:1023:b88a with SMTP id
 d5-20020a170903230500b001621023b88amr25435065plh.48.1653587660052; Thu, 26
 May 2022 10:54:20 -0700 (PDT)
Date:   Thu, 26 May 2022 17:54:02 +0000
In-Reply-To: <20220526175408.399718-1-bgardon@google.com>
Message-Id: <20220526175408.399718-6-bgardon@google.com>
Mime-Version: 1.0
References: <20220526175408.399718-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH v8 05/11] KVM: selftests: Read binary stat data in lib
From:   Ben Gardon <bgardon@google.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Peter Xu <peterx@redhat.com>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the code to read the binary stats data to the KVM selftests
library. It will be re-used by other tests to check KVM behavior.

Also opportunistically remove an unnecessary calculation with
"size_data" in stats_test.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  4 +++
 .../selftests/kvm/kvm_binary_stats_test.c     |  9 ++---
 tools/testing/selftests/kvm/lib/kvm_util.c    | 35 +++++++++++++++++++
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index da7bf881f94f..967f6d6cf255 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -426,6 +426,10 @@ static inline struct kvm_stats_desc *get_stats_descriptor(struct kvm_stats_desc
 	return (void *)stats + index * get_stats_descriptor_size(header);
 }
 
+void read_stat_data(int stats_fd, struct kvm_stats_header *header,
+		    struct kvm_stats_desc *desc, uint64_t *data,
+		    size_t max_elements);
+
 uint32_t guest_get_vcpuid(void);
 
 #endif /* SELFTEST_KVM_UTIL_BASE_H */
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 956dc40d9bc7..ee2d6c18d620 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -147,15 +147,10 @@ static void stats_test(int stats_fd)
 	ret = pread(stats_fd, stats_data, size_data, header.data_offset);
 	TEST_ASSERT(ret == size_data, "Read KVM stats data");
 	/* Read kvm stats data one by one */
-	size_data = 0;
 	for (i = 0; i < header.num_desc; ++i) {
 		pdesc = get_stats_descriptor(stats_desc, i, &header);
-		ret = pread(stats_fd, stats_data,
-				pdesc->size * sizeof(*stats_data),
-				header.data_offset + size_data);
-		TEST_ASSERT(ret == pdesc->size * sizeof(*stats_data),
-				"Read data of KVM stats: %s", pdesc->name);
-		size_data += pdesc->size * sizeof(*stats_data);
+		read_stat_data(stats_fd, &header, pdesc, stats_data,
+			       pdesc->size);
 	}
 
 	free(stats_data);
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e5abcb189f1d..5e1ac66faf0f 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2610,3 +2610,38 @@ struct kvm_stats_desc *read_stats_descriptors(int stats_fd,
 
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
+ * Read the data values of a specified stat from the binary stats interface.
+ */
+void read_stat_data(int stats_fd, struct kvm_stats_header *header,
+		    struct kvm_stats_desc *desc, uint64_t *data,
+		    size_t max_elements)
+{
+	size_t nr_elements = min_t(ssize_t, desc->size, max_elements);
+	size_t size = nr_elements * sizeof(*data);
+	ssize_t ret;
+
+	TEST_ASSERT(desc->size, "No elements in stat '%s'", desc->name);
+	TEST_ASSERT(max_elements, "Zero elements requested for stat '%s'", desc->name);
+
+	ret = pread(stats_fd, data, size,
+		    header->data_offset + desc->offset);
+
+	TEST_ASSERT(ret >= 0, "pread() failed on stat '%s', errno: %i (%s)",
+		    desc->name, errno, strerror(errno));
+	TEST_ASSERT(ret == size,
+		    "pread() on stat '%s' read %ld bytes, wanted %lu bytes",
+		    desc->name, size, ret);
+}
-- 
2.36.1.124.g0e6072fb45-goog

