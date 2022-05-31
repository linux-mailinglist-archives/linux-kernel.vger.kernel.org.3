Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB25538973
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243166AbiEaBMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242242AbiEaBMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A36B93987
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653959524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B1zh0G6TK+W9pGc27qGuRakMVqnavlPCuAI+rVxzeGY=;
        b=ixy7FTS/dQzXK2w81U1xN85hRnPZJo+Q4lNF/QjhQnmwXm5e7itwyabZVqtndLjYWL55x+
        UdUOcmWbuLCinh8eiCWj34INA2JKkyS/YPQE/yVL1XRAhhy0MCrUahKjdnWMfs8qyTJJsf
        MzqrZ7g6d3IWfBa2LnFRUKJfjd9QPJI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-93xGvDeyNRWPipSvz94SFQ-1; Mon, 30 May 2022 21:12:03 -0400
X-MC-Unique: 93xGvDeyNRWPipSvz94SFQ-1
Received: by mail-il1-f199.google.com with SMTP id x3-20020a056e021bc300b002d1b0ccfca6so9269809ilv.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1zh0G6TK+W9pGc27qGuRakMVqnavlPCuAI+rVxzeGY=;
        b=UQnHeW2IGxUsL9GwX+4/mkWImouovHKcYuZFwf6Ec95GhIhf+9RrBwieswZ7C+/59Z
         29mKBUaFsDzCBnSNFcJuK5tPFkN3Y88gFRtCn+TkHMq8lHnZhojpYvXScd0YAMmfgAH6
         ZBF6Rg5MBRhM0ojSmFxbbm2o8qt8B7i16JX7mk+lqrLCHkCHtv7Kjx+B16KsaOfkyfgI
         vbf8YMFKC8dSek8rv7t2FsO+rwzvOhKaPl6OIrRD+j7r9eFn7N++qatYqhYWA6hhX8vp
         W8KFnNm7/o9K0MfGDinnVYtvP64l8x5nGVxx+pXhykm07OAFv4H73rNcnSjv10bciGZl
         6apA==
X-Gm-Message-State: AOAM530OQFhgat8UapzVxAToRzh4uprDiF2EFZDLar6vkAvqSO2ISQcn
        tGcWO6dwTxSCJLnWTXveeViyZw68sPhE30S6HcxIhPOzVxsHevp3TJGbMtjpoi7wA19h4f6Dr7a
        YNeODaBrqAIgl0msvA2VcWyWMwQ+od3nrDjXn49mu5p6+buUwsMCMfJI/sA7zLlFGlfr04/WkXg
        ==
X-Received: by 2002:a05:6638:22c1:b0:331:f39:dc21 with SMTP id j1-20020a05663822c100b003310f39dc21mr6075908jat.75.1653959522125;
        Mon, 30 May 2022 18:12:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8O9HB/EdT6K2oS1Z/LDBvAFHH91nKVvI12INxaRwhBYX3fQMWWp9l9Gk9CQfAnLC9UW9O4A==
X-Received: by 2002:a05:6638:22c1:b0:331:f39:dc21 with SMTP id j1-20020a05663822c100b003310f39dc21mr6075887jat.75.1653959521805;
        Mon, 30 May 2022 18:12:01 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id s6-20020a02c7c6000000b0032be3784b9bsm3158234jao.117.2022.05.30.18.12.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 30 May 2022 18:12:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] userfaultfd.2: Add section for UFFD_USER_MODE_ONLY
Date:   Mon, 30 May 2022 21:11:56 -0400
Message-Id: <20220531011157.46868-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220531011157.46868-1-peterx@redhat.com>
References: <20220531011157.46868-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a paragraph for UFFD_USER_MODE_ONLY flag that was introduced in
Linux 5.11.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/userfaultfd.2 | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index cee7c01d2..0928a76d2 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -29,8 +29,9 @@
 userfaultfd \- create a file descriptor for handling page faults in user space
 .SH SYNOPSIS
 .nf
-.BR "#include <fcntl.h>" "            /* Definition of " O_* " constants */"
-.BR "#include <sys/syscall.h>" "      /* Definition of " SYS_* " constants */"
+.BR "#include <fcntl.h>" "             /* Definition of " O_* " constants */"
+.BR "#include <sys/syscall.h>" "       /* Definition of " SYS_* " constants */"
+.BR "#include <linux/userfaultfd.h>" " /* Definition of " UFFD_* " constants */"
 .B #include <unistd.h>
 .PP
 .BI "int syscall(SYS_userfaultfd, int " flags );
@@ -76,6 +77,15 @@ See the description of the
 .BR O_NONBLOCK
 flag in
 .BR open (2).
+.TP
+.BR UFFD_USER_MODE_ONLY
+This is an userfaultfd specific flag that was introduced since Linux 5.11.
+When set, the userfaultfd object will only be able to handle page faults
+originated from the userspace on the registered regions.
+When a kernel originated fault was triggered on the registered range with
+this userfaultfd, a
+.BR SIGBUS
+signal will be delivered.
 .PP
 When the last file descriptor referring to a userfaultfd object is closed,
 all memory ranges that were registered with the object are unregistered
-- 
2.32.0

