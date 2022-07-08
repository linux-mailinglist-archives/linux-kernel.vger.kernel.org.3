Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4C656B5A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbiGHJfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbiGHJe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 072FD2A717
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657272895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sMFHzJKRiYj62gdYRhno9WSMM22FrLKbwCUpBPEktWM=;
        b=JPUVn0pCI9pffK3jHOsWkSh/CvnQm3eYpisgmRMlZQS6Po+TdBmDaJT7xhK37Op5KtKLhu
        AWs/DPwk8IDmfSqhslob3bnLc5CVLHhGldocjyM2Mr8+G7tZueUUhnvAw7nhztuOsJsciD
        Z56aba3IrzyMZ5VpZbicfbKly6IOahM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-xbaF3wnUPSyvHNhf9CW2dQ-1; Fri, 08 Jul 2022 05:34:54 -0400
X-MC-Unique: xbaF3wnUPSyvHNhf9CW2dQ-1
Received: by mail-ej1-f71.google.com with SMTP id l2-20020a170906078200b006fed42bfeacso5524372ejc.16
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 02:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMFHzJKRiYj62gdYRhno9WSMM22FrLKbwCUpBPEktWM=;
        b=UjS3EI/sRxYsu6bXgSM6kgfV3FzYKJOdab0p5cGJRY03CS3Lk5aKOwEix/pYS2QXY4
         VpSpPfMjIZ/Rw9orU+vCLVq26J5IfbsbbCt7gekcBfn5BqvM+xH0aaMAmggzTmo6ZxW2
         Q7X+GiGzIkdZrbhBZuXkxec+Zixn2WWDBEyuHCPTZ5Vtu/UKYx3DPIA6BbRgnl+9hmmI
         kBHUc1m57dwMjdgfqthXIGJJvZi5HPrFAq9C9jOczJ6eiDa+vdNPPfH1EZR7yTynsyrS
         IerKN/aAR4gFu9Q1K/m76sHqkfVWZw55gAN+dNO9OzJblCOnuEkBkrcudmIWHaKftcQk
         UXNQ==
X-Gm-Message-State: AJIora8D+j7+uvXC8dDIHzr9ML/ByGFtF93WATxgVY9tMzKWbdzl6W7l
        SYOVXUqQWI99aFVOrJZlUiVHgbeQ6i6/BkcARcHCXjAkA0St/eeYoRRUtCRqbZm4DjABou9hCrp
        n5KMwNWSYP+cjIkKrq65heV2p
X-Received: by 2002:a17:907:2895:b0:72a:f3bd:6e5f with SMTP id em21-20020a170907289500b0072af3bd6e5fmr2545867ejc.767.1657272893404;
        Fri, 08 Jul 2022 02:34:53 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vqzsj8D95ygzAuhY0cpDJI7xEx8WuoI4Z9hfBmeRv2uPXFteeEPUMGrkSiqA1aqHu8V5VEjQ==
X-Received: by 2002:a17:907:2895:b0:72a:f3bd:6e5f with SMTP id em21-20020a170907289500b0072af3bd6e5fmr2545851ejc.767.1657272893155;
        Fri, 08 Jul 2022 02:34:53 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j24-20020aa7de98000000b00435726bd375sm29359084edv.57.2022.07.08.02.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 02:34:52 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Robert O'Callahan <roc@ocallahan.org>
Subject: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
Date:   Fri,  8 Jul 2022 11:34:51 +0200
Message-Id: <20220708093451.472870-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since userfaultfd doesn't implement a write operation, it is more
appropriate to open it read-only.

When userfaultfds are opened read-write like it is now, and such fd is
passed from one process to another, SELinux will check both read and
write permissions for the target process, even though it can't actually
do any write operation on the fd later.

Inspired by the following bug report, which has hit the SELinux scenario
described above:
https://bugzilla.redhat.com/show_bug.cgi?id=1974559

Reported-by: Robert O'Callahan <roc@ocallahan.org>
Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---

Resending as the last submission was ignored for over a year...

https://lore.kernel.org/lkml/20210624152515.1844133-1-omosnace@redhat.com/T/

I marked this as RFC, because I'm not sure if this has any unwanted side
effects. I only ran this patch through selinux-testsuite, which has a
simple userfaultfd subtest, and a reproducer from the Bugzilla report.

Please tell me whether this makes sense and/or if it passes any
userfaultfd tests you guys might have.

 fs/userfaultfd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e943370107d0..8ccf00be63e1 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -989,7 +989,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
 	int fd;
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
-			O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
+			O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
 	if (fd < 0)
 		return fd;
 
@@ -2090,7 +2090,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
 	mmgrab(ctx->mm);
 
 	fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
-			O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
+			O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
 	if (fd < 0) {
 		mmdrop(ctx->mm);
 		kmem_cache_free(userfaultfd_ctx_cachep, ctx);
-- 
2.36.1

