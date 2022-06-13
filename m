Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0798654A174
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352426AbiFMVba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353125AbiFMV3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:29:18 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D8C30F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:25:28 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id p2-20020a170902e74200b00164081f682cso3635236plf.16
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=85TvZ48xblqSeyK1ObCYU4jDiPNtGo9XwK9ZI/euUPA=;
        b=GlrUwH24qHzeQ9AganD4s3/3Ga/Btx+c2gJklWdAJr4qQa86y8XRjlNfiHKg3Ey5n5
         RtEHIfspjhcsZzz3CEFeagPWopLPu3VvHGppUiV/T5E+AUl9RqnSqFUb7xD9aUSVm0TR
         uyQOknyKeIrN3StVJeJy7ZRZ8kAeNTnZS6/iESqszFSN7xQlQYRxCxDKvDBohMFsEkso
         b/77rfvP+me+dvvuxBgEdWsL+zWFDmYZ2ebe4x4yuYHFu8aoMo+xEpJc+2nIey5+N2Bv
         LSDQDD5xFhA3jatkW8ngSfgUGX5wrRy4CWwyLlhSyYFry+DNyd8MJorgfK1mJDG9dpk2
         gbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=85TvZ48xblqSeyK1ObCYU4jDiPNtGo9XwK9ZI/euUPA=;
        b=HO+lfpF1jOsPfetMurjZtk1I60x7zCV+vBcZ+gV0Svw+0/ezOq+pY5GRScikVYUZ0a
         5FuYYo09hG8YLWU2yPmrUVjCJfDVfUn9+P/kz0fQIMBZ4OiOfYyBAiIm7znrOIJUvply
         DupBEfFhUgzuHO1vKlFHhUnsAr8W1OE0LVu368O3BWfcNtZdnWv2/htAmdyShpuimlED
         qvrTfBCbBwvO3f83mMfGbiTsl/XfMxKUzNJn2iCgo4O8THdz+Lw50+QfOENp1pCX1cFL
         yQRyHce1AHD62jASu6XsjhUETPIiBPQsGpCU+SrhGKv2DtnNTni5+IdWZsL527KcwxKz
         RDAg==
X-Gm-Message-State: AOAM5335CETZeI4RDhgT+VweGLsX0rbBm7rkvyQBEOrQQ9onRXJ5eZsB
        vxpLhGo/dUSGYn3PcD99xrfJWMqPiuMS
X-Google-Smtp-Source: AGRyM1teZsQrTvOprp3xqHfR3ZP6vv0nwWhoMDiS4OVcjajPvm6qIOyxiRJQjnLWDjIo5LP2ad3IKe9CknIJ
X-Received: from sweer.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:e45])
 (user=bgardon job=sendgmr) by 2002:a62:820a:0:b0:51b:d1f9:b45f with SMTP id
 w10-20020a62820a000000b0051bd1f9b45fmr1253849pfd.63.1655155527858; Mon, 13
 Jun 2022 14:25:27 -0700 (PDT)
Date:   Mon, 13 Jun 2022 21:25:14 +0000
In-Reply-To: <20220613212523.3436117-1-bgardon@google.com>
Message-Id: <20220613212523.3436117-2-bgardon@google.com>
Mime-Version: 1.0
References: <20220613212523.3436117-1-bgardon@google.com>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [PATCH v9 01/10] KVM: selftests: Remove dynamic memory allocation for
 stats header
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to allocate dynamic memory for the stats header since
its size is known at compile time.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/kvm_binary_stats_test.c     | 58 +++++++++----------
 1 file changed, 27 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
index 1baabf955d63..ae48d4153f85 100644
--- a/tools/testing/selftests/kvm/kvm_binary_stats_test.c
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -26,56 +26,53 @@ static void stats_test(int stats_fd)
 	int i;
 	size_t size_desc;
 	size_t size_data = 0;
-	struct kvm_stats_header *header;
+	struct kvm_stats_header header;
 	char *id;
 	struct kvm_stats_desc *stats_desc;
 	u64 *stats_data;
 	struct kvm_stats_desc *pdesc;
 
 	/* Read kvm stats header */
-	header = malloc(sizeof(*header));
-	TEST_ASSERT(header, "Allocate memory for stats header");
-
-	ret = read(stats_fd, header, sizeof(*header));
-	TEST_ASSERT(ret == sizeof(*header), "Read stats header");
-	size_desc = sizeof(*stats_desc) + header->name_size;
+	ret = read(stats_fd, &header, sizeof(header));
+	TEST_ASSERT(ret == sizeof(header), "Read stats header");
+	size_desc = sizeof(*stats_desc) + header.name_size;
 
 	/* Read kvm stats id string */
-	id = malloc(header->name_size);
+	id = malloc(header.name_size);
 	TEST_ASSERT(id, "Allocate memory for id string");
-	ret = read(stats_fd, id, header->name_size);
-	TEST_ASSERT(ret == header->name_size, "Read id string");
+	ret = read(stats_fd, id, header.name_size);
+	TEST_ASSERT(ret == header.name_size, "Read id string");
 
 	/* Check id string, that should start with "kvm" */
-	TEST_ASSERT(!strncmp(id, "kvm", 3) && strlen(id) < header->name_size,
+	TEST_ASSERT(!strncmp(id, "kvm", 3) && strlen(id) < header.name_size,
 				"Invalid KVM stats type, id: %s", id);
 
 	/* Sanity check for other fields in header */
-	if (header->num_desc == 0) {
+	if (header.num_desc == 0) {
 		printf("No KVM stats defined!");
 		return;
 	}
 	/* Check overlap */
-	TEST_ASSERT(header->desc_offset > 0 && header->data_offset > 0
-			&& header->desc_offset >= sizeof(*header)
-			&& header->data_offset >= sizeof(*header),
+	TEST_ASSERT(header.desc_offset > 0 && header.data_offset > 0
+			&& header.desc_offset >= sizeof(header)
+			&& header.data_offset >= sizeof(header),
 			"Invalid offset fields in header");
-	TEST_ASSERT(header->desc_offset > header->data_offset ||
-			(header->desc_offset + size_desc * header->num_desc <=
-							header->data_offset),
+	TEST_ASSERT(header.desc_offset > header.data_offset ||
+			(header.desc_offset + size_desc * header.num_desc <=
+							header.data_offset),
 			"Descriptor block is overlapped with data block");
 
 	/* Allocate memory for stats descriptors */
-	stats_desc = calloc(header->num_desc, size_desc);
+	stats_desc = calloc(header.num_desc, size_desc);
 	TEST_ASSERT(stats_desc, "Allocate memory for stats descriptors");
 	/* Read kvm stats descriptors */
 	ret = pread(stats_fd, stats_desc,
-			size_desc * header->num_desc, header->desc_offset);
-	TEST_ASSERT(ret == size_desc * header->num_desc,
+			size_desc * header.num_desc, header.desc_offset);
+	TEST_ASSERT(ret == size_desc * header.num_desc,
 			"Read KVM stats descriptors");
 
 	/* Sanity check for fields in descriptors */
-	for (i = 0; i < header->num_desc; ++i) {
+	for (i = 0; i < header.num_desc; ++i) {
 		pdesc = (void *)stats_desc + i * size_desc;
 		/* Check type,unit,base boundaries */
 		TEST_ASSERT((pdesc->flags & KVM_STATS_TYPE_MASK)
@@ -104,7 +101,7 @@ static void stats_test(int stats_fd)
 			break;
 		}
 		/* Check name string */
-		TEST_ASSERT(strlen(pdesc->name) < header->name_size,
+		TEST_ASSERT(strlen(pdesc->name) < header.name_size,
 				"KVM stats name(%s) too long", pdesc->name);
 		/* Check size field, which should not be zero */
 		TEST_ASSERT(pdesc->size, "KVM descriptor(%s) with size of 0",
@@ -124,14 +121,14 @@ static void stats_test(int stats_fd)
 		size_data += pdesc->size * sizeof(*stats_data);
 	}
 	/* Check overlap */
-	TEST_ASSERT(header->data_offset >= header->desc_offset
-		|| header->data_offset + size_data <= header->desc_offset,
+	TEST_ASSERT(header.data_offset >= header.desc_offset
+		|| header.data_offset + size_data <= header.desc_offset,
 		"Data block is overlapped with Descriptor block");
 	/* Check validity of all stats data size */
-	TEST_ASSERT(size_data >= header->num_desc * sizeof(*stats_data),
+	TEST_ASSERT(size_data >= header.num_desc * sizeof(*stats_data),
 			"Data size is not correct");
 	/* Check stats offset */
-	for (i = 0; i < header->num_desc; ++i) {
+	for (i = 0; i < header.num_desc; ++i) {
 		pdesc = (void *)stats_desc + i * size_desc;
 		TEST_ASSERT(pdesc->offset < size_data,
 			"Invalid offset (%u) for stats: %s",
@@ -142,15 +139,15 @@ static void stats_test(int stats_fd)
 	stats_data = malloc(size_data);
 	TEST_ASSERT(stats_data, "Allocate memory for stats data");
 	/* Read kvm stats data as a bulk */
-	ret = pread(stats_fd, stats_data, size_data, header->data_offset);
+	ret = pread(stats_fd, stats_data, size_data, header.data_offset);
 	TEST_ASSERT(ret == size_data, "Read KVM stats data");
 	/* Read kvm stats data one by one */
 	size_data = 0;
-	for (i = 0; i < header->num_desc; ++i) {
+	for (i = 0; i < header.num_desc; ++i) {
 		pdesc = (void *)stats_desc + i * size_desc;
 		ret = pread(stats_fd, stats_data,
 				pdesc->size * sizeof(*stats_data),
-				header->data_offset + size_data);
+				header.data_offset + size_data);
 		TEST_ASSERT(ret == pdesc->size * sizeof(*stats_data),
 				"Read data of KVM stats: %s", pdesc->name);
 		size_data += pdesc->size * sizeof(*stats_data);
@@ -159,7 +156,6 @@ static void stats_test(int stats_fd)
 	free(stats_data);
 	free(stats_desc);
 	free(id);
-	free(header);
 }
 
 
-- 
2.36.1.476.g0c4daa206d-goog

