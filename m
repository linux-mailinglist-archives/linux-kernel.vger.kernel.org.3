Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B39B953C374
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 05:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiFCDyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 23:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237059AbiFCDyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 23:54:33 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5FC31926
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 20:54:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u18so6027641plb.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 20:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NjAQ9U1RyZ6v//Z9T1/sKRQ+oNLTOeoBnmYJ+dO7aSk=;
        b=IHyysdxE8wrk06+yrVq66k2wvBC4vdESSMS30QlzhI3DHGQKAUXIl7V74dMRlNxQ+9
         sTB/p5AMjwxBD4LIvGbBCKV/UxEGlFmPGt0PaYWmW3MJMP432ZhjnyrhSLGK7xfz7fLT
         W49Mm3467QKIKBD0UBGFN7qc0bvPjze0VzKhBHMfFM/L9Kj/wk4wLCV3+g6hhzSK1q/g
         powdBclaqBH32B5e4WVQTygGb8QKt6Cwxy9n5UCSVUObNtZGYTFmDT1y4oX+wLyRq99w
         Onj9IihcmOzyz04nOIZWBykW5oHPFG5gRjJ2rtZEWYRYlMrPDWMUJnAZMz7tF3c3q3x4
         wgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NjAQ9U1RyZ6v//Z9T1/sKRQ+oNLTOeoBnmYJ+dO7aSk=;
        b=heW8hy3o1YC3KENVWMMJ3HcrSBH+2rNEp2Rh/D1GoFV9HlDO+jZAYnhICLmdO+CmAX
         fCKrShPvyVBU2x6Dim16iEguwJo/jP7WGJ1b2IVyYF4qJOEQggwH0tacR59H73hSTuxl
         85Jg2VCHVOo3/v1hqwSVdtPQdlwtVTySoCV4bTtlYvRWkSv6l6D4S+eICJjGMKMGglj9
         TWWeK+VniX92ESCMJ0MsqKCkhS6l7PAfAW+yQkR6WxE0BBoSPWKas3s76M8I2x+jxC3H
         BbTkxN0vorSL5WeodlDolnK1yK9/5sec+7EwUvv+k0xhtqp/UdU/PqPl0GcF1pcdY3tJ
         t1yA==
X-Gm-Message-State: AOAM53250dLxVD6HsOFx49kpQ3uiPKkqM46P14BdnMyaj3IMFzfRuBJv
        uooAKQQ3Qg7rPfYQpyNFSgg=
X-Google-Smtp-Source: ABdhPJyRoBzhzCK/ZrLQd0WQrH4EgBt6sszDp+oB0AthomXCVEQasTnQQh8J0A+5To1VrAXOfLSVMA==
X-Received: by 2002:a17:902:b18e:b0:15f:b2c:6ca with SMTP id s14-20020a170902b18e00b0015f0b2c06camr8275857plr.84.1654228472011;
        Thu, 02 Jun 2022 20:54:32 -0700 (PDT)
Received: from localhost ([101.86.206.159])
        by smtp.gmail.com with ESMTPSA id d124-20020a636882000000b003fac21dc6edsm4166400pgc.21.2022.06.02.20.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 20:54:31 -0700 (PDT)
From:   Patrick Wang <patrick.wang.shcn@gmail.com>
To:     catalin.marinas@arm.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yee.lee@mediatek.com, patrick.wang.shcn@gmail.com
Subject: [PATCH v2 3/4] mm: kmemleak: handle address stored in object based on its type
Date:   Fri,  3 Jun 2022 11:54:14 +0800
Message-Id: <20220603035415.1243913-4-patrick.wang.shcn@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
References: <20220603035415.1243913-1-patrick.wang.shcn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Treat the address stored in object in different way according
to its type:

- Only use kasan_reset_tag for virtual address
- Only update min_addr and max_addr for virtual address
- Convert physical address to virtual address in scan_object

Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Patrick Wang <patrick.wang.shcn@gmail.com>
---
 mm/kmemleak.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 218144392446..246a70b7218f 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -297,7 +297,9 @@ static void hex_dump_object(struct seq_file *seq,
 	warn_or_seq_printf(seq, "  hex dump (first %zu bytes):\n", len);
 	kasan_disable_current();
 	warn_or_seq_hex_dump(seq, DUMP_PREFIX_NONE, HEX_ROW_SIZE,
-			     HEX_GROUP_SIZE, kasan_reset_tag((void *)ptr), len, HEX_ASCII);
+			     HEX_GROUP_SIZE, object->flags & OBJECT_PHYS ? ptr :
+			     kasan_reset_tag((void *)ptr),
+			     len, HEX_ASCII);
 	kasan_enable_current();
 }
 
@@ -389,14 +391,15 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias,
 {
 	struct rb_node *rb = is_phys ? object_phys_tree_root.rb_node :
 			     object_tree_root.rb_node;
-	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
+	unsigned long untagged_ptr = is_phys ? ptr : (unsigned long)kasan_reset_tag((void *)ptr);
 
 	while (rb) {
 		struct kmemleak_object *object;
 		unsigned long untagged_objp;
 
 		object = rb_entry(rb, struct kmemleak_object, rb_node);
-		untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
+		untagged_objp = is_phys ? object->pointer :
+				(unsigned long)kasan_reset_tag((void *)object->pointer);
 
 		if (untagged_ptr < untagged_objp)
 			rb = object->rb_node.rb_left;
@@ -643,16 +646,19 @@ static struct kmemleak_object *create_object(unsigned long ptr, size_t size,
 
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 
-	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
-	min_addr = min(min_addr, untagged_ptr);
-	max_addr = max(max_addr, untagged_ptr + size);
+	untagged_ptr = is_phys ? ptr : (unsigned long)kasan_reset_tag((void *)ptr);
+	if (!is_phys) {
+		min_addr = min(min_addr, untagged_ptr);
+		max_addr = max(max_addr, untagged_ptr + size);
+	}
 	link = is_phys ? &object_phys_tree_root.rb_node :
 		&object_tree_root.rb_node;
 	rb_parent = NULL;
 	while (*link) {
 		rb_parent = *link;
 		parent = rb_entry(rb_parent, struct kmemleak_object, rb_node);
-		untagged_objp = (unsigned long)kasan_reset_tag((void *)parent->pointer);
+		untagged_objp = is_phys ? parent->pointer :
+				(unsigned long)kasan_reset_tag((void *)parent->pointer);
 		if (untagged_ptr + size <= untagged_objp)
 			link = &parent->rb_node.rb_left;
 		else if (untagged_objp + parent->size <= untagged_ptr)
@@ -1202,7 +1208,9 @@ static bool update_checksum(struct kmemleak_object *object)
 
 	kasan_disable_current();
 	kcsan_disable_current();
-	object->checksum = crc32(0, kasan_reset_tag((void *)object->pointer), object->size);
+	object->checksum = crc32(0, object->flags & OBJECT_PHYS ? (void *)object->pointer :
+				    kasan_reset_tag((void *)object->pointer),
+				    object->size);
 	kasan_enable_current();
 	kcsan_enable_current();
 
@@ -1353,6 +1361,7 @@ static void scan_object(struct kmemleak_object *object)
 {
 	struct kmemleak_scan_area *area;
 	unsigned long flags;
+	void *obj_ptr;
 
 	/*
 	 * Once the object->lock is acquired, the corresponding memory block
@@ -1364,10 +1373,15 @@ static void scan_object(struct kmemleak_object *object)
 	if (!(object->flags & OBJECT_ALLOCATED))
 		/* already freed object */
 		goto out;
+
+	obj_ptr = object->flags & OBJECT_PHYS ?
+		  __va((void *)object->pointer) :
+		  (void *)object->pointer;
+
 	if (hlist_empty(&object->area_list) ||
 	    object->flags & OBJECT_FULL_SCAN) {
-		void *start = (void *)object->pointer;
-		void *end = (void *)(object->pointer + object->size);
+		void *start = obj_ptr;
+		void *end = obj_ptr + object->size;
 		void *next;
 
 		do {
-- 
2.25.1

