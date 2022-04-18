Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B16505B27
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:34:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245593AbiDRPhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345379AbiDRPgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 74CEC583B2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 07:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650293812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7lZX+S4magYauDVmNSYsgT0vN1ofTMVqqC/tGiJW/RM=;
        b=FAC0rSVXyzsPaajnI2T6EdrwLKvMxYfZ7zZLMRjMgz5YqyFC09DZkhA8ymMv7IlmH+9bzK
        NFuttvA6lJ431u4kot9PIP2Yes7iVEaRXai+yEzKCfrjluY5gSGudK5oVDCd9khd4DXVBU
        0KMid9E7JCAyhQy+Hc2u+685DKP/2KY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-412-ClJwkAGEPOq92FhgC0R87g-1; Mon, 18 Apr 2022 10:56:41 -0400
X-MC-Unique: ClJwkAGEPOq92FhgC0R87g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 77A1F811E7A;
        Mon, 18 Apr 2022 14:56:41 +0000 (UTC)
Received: from llong.com (dhcp-17-215.bos.redhat.com [10.18.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A70EC27E94;
        Mon, 18 Apr 2022 14:56:41 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Barry Marson <bmarson@redhat.com>,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [RFC PATCH] mm/mmap: Map MAP_STACK to VM_STACK
Date:   Mon, 18 Apr 2022 10:56:20 -0400
Message-Id: <20220418145620.788664-1-longman@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One of the flags of mmap(2) is MAP_STACK to request a memory segment
suitable for a process or thread stack. The kernel currently ignores
this flags. Glibc uses MAP_STACK when mmapping a thread stack. However,
selinux has an execstack check in selinux_file_mprotect() which disallows
a stack VMA to be made executable.

Since MAP_STACK is a noop, it is possible for a stack VMA to be merged
with an adjacent anonymous VMA. With that merging, using mprotect(2)
to change a part of the merged anonymous VMA to make it executable may
fail. This can lead to sporadic failure of applications that need to
make those changes.

One possible fix is to make sure that a stack VMA will not be merged with
a non-stack anonymous VMA. That requires a vm flag that can be used to
distinguish a stack VMA from a regular anonymous VMA. One can add a new
dummy vm flag for that purpose. However, there is only 1 bit left in the
lower 32 bits of vm_flags. Another alternative is to use an existing vm
flag. VM_STACK (= VM_GROWSDOWN for most arches) can certainly be used for
this purpose. The downside is that it is a change in existing behavior.

Making a stack VMA growable by default certainly fits the need of a
process or thread stack. This patch now maps MAP_STACK to VM_STACK to
prevent unwanted merging with adjacent non-stack VMAs and make the VMA
more suitable for being used as a stack.

Reported-by: Joe Mario <jmario@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mman.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mman.h b/include/linux/mman.h
index b66e91b8176c..6e2b29040e48 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -156,6 +156,7 @@ calc_vm_flag_bits(unsigned long flags)
 	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
 	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
 	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
+	       _calc_vm_trans(flags, MAP_STACK,	     VM_STACK     ) |
 	       arch_calc_vm_flag_bits(flags);
 }
 
-- 
2.27.0

