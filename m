Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B553CE2A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239546AbiFCRhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbiFCRhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:37:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FF2450B11
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654277863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0aUCBdDLRZgXZUTdZmjGfl1wafgZ6gf3pWlYAS6s0rQ=;
        b=FIuKj2qsB99FY6HenwnZHX6SZQNpZgNhiM7rconN7fNcIjkPISQ01bFFQG2If7xbT2dah6
        dXF33OcNh+luz+z7saY59xZjFfZ3xLWQrEfwWjNwjqiD8urAXNeko7i4qpcVYf087dGc8H
        6/B1PA5hfrJ9qs2i3iJV1tq1rpUKfp0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-I2qUrBrkMMGjlJJFsoNiiw-1; Fri, 03 Jun 2022 13:37:42 -0400
X-MC-Unique: I2qUrBrkMMGjlJJFsoNiiw-1
Received: by mail-il1-f199.google.com with SMTP id r9-20020a92cd89000000b002d16798b3cfso6659909ilb.22
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 10:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0aUCBdDLRZgXZUTdZmjGfl1wafgZ6gf3pWlYAS6s0rQ=;
        b=mPuirnpch4WhD7HvFBmk9h0Sw4GiepdJeFFwnfIriR10VMFgTEArGbcz/Oplx7M9up
         A5q36r8O2LJxL/uetg7ZX0B3LdTr10zIHbspGfryS8YGVF0UpEB+2CI6DjpThu1SlfUk
         U5k4Nfh0/8GYA1UEepInhaE4/PggYNYOzvyDG65NZ68hJbKvV2qwAt9je8wls2VUh9og
         dmF+H9k+W2Pu9kW8vfEOFRRo3MlgauxF0coABzstV+F3djQ3G3iEQrmH2VpDt2odw9BM
         ILFXz4r4M+Em4V013vhqoc27VBwdDk1MsKTt1YhTzq9aKo/wNh9AxhS6dfWtbvkMTIQW
         pDGg==
X-Gm-Message-State: AOAM531KccRcH8tWkLUXppoTZ11n/X0cEnQCNleQ09TKSbZ8rL5/Iggp
        sdsnDbcT8+YeQJWfMPPpaFWxZxjmdA2ueb8je1vCrxUCmNXkLR9AcVcUYDosBUtbZ5lhmyHvLAt
        Pv4V1HHhI7eKa/2G4JFvGcSTD5MWllrTTCE1yGb8PYP5ecWajcWIvwCVQJA4TzqoJJ6OkP1EPXg
        ==
X-Received: by 2002:a02:ce8b:0:b0:331:6050:6171 with SMTP id y11-20020a02ce8b000000b0033160506171mr6014972jaq.319.1654277861443;
        Fri, 03 Jun 2022 10:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxT5yNyOJqrMirvzChd6Jq1GY7aquh0xWawRy0pwsachq+SjLrMtUXFuDfeFTAii6nzxub+Mw==
X-Received: by 2002:a02:ce8b:0:b0:331:6050:6171 with SMTP id y11-20020a02ce8b000000b0033160506171mr6014940jaq.319.1654277860823;
        Fri, 03 Jun 2022 10:37:40 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id g23-20020a02bb97000000b0032e1e0ac289sm2791117jan.8.2022.06.03.10.37.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jun 2022 10:37:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com
Subject: [PATCH v2 1/2] userfaultfd.2: Add section for UFFD_USER_MODE_ONLY
Date:   Fri,  3 Jun 2022 13:37:35 -0400
Message-Id: <20220603173736.62581-2-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220603173736.62581-1-peterx@redhat.com>
References: <20220603173736.62581-1-peterx@redhat.com>
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
index 93dca009f..6b9412aaf 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -12,8 +12,9 @@ Standard C library
 .RI ( libc ", " \-lc )
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
@@ -59,6 +60,15 @@ See the description of the
 .B O_NONBLOCK
 flag in
 .BR open (2).
+.TP
+.B UFFD_USER_MODE_ONLY
+This is an userfaultfd specific flag that was introduced since Linux 5.11.
+When set, the userfaultfd object will only be able to handle page faults
+originated from the userspace on the registered regions.
+When a kernel originated fault was triggered on the registered range with
+this userfaultfd, a
+.B SIGBUS
+signal will be delivered.
 .PP
 When the last file descriptor referring to a userfaultfd object is closed,
 all memory ranges that were registered with the object are unregistered
-- 
2.32.0

