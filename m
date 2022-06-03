Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AB53CE2D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344550AbiFCRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344523AbiFCRhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:37:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0420B50B11
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 10:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654277865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bvNdDteJSKV8nPr70UjTL9Ga0ysM0wiU173XEAoRmEg=;
        b=KVN5llUSTKGfOYwgLQOT/k3UPuUs0mFWw5O0GBLZ2DY4thENsp57vN2Y4wjPwFufZFqp0v
        /EV/aIygvIyLSn2HYNbp2ygbjeccnFbBihznmwxj5DWmPyZYDpr6wBTteSfM2OH5yEVBkl
        tImYFuAqUusD9FXE0s3PbI3W95XmN88=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-odD---04Op-DaA8-FLzXhg-1; Fri, 03 Jun 2022 13:37:44 -0400
X-MC-Unique: odD---04Op-DaA8-FLzXhg-1
Received: by mail-il1-f199.google.com with SMTP id a3-20020a924443000000b002d1bc79da14so6672744ilm.15
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 10:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bvNdDteJSKV8nPr70UjTL9Ga0ysM0wiU173XEAoRmEg=;
        b=0iGWt7ohEcK/DUylY1UJtp+K2lu4QQSYvACIa8gpq6pD06xy1jvTyJNQ6y9wiDjwM8
         cPesifqZhduousxBivqAnW0oFKD7VwZyqxRI1BLmiomoEDqGli9joY9IgEQyQdM8iocQ
         MYLhml8JsZrwZqKtZ7syjAsI91JOMelsKuwp9OO312UF3CRCyhgBTtQl+bxgIpOptgqa
         DMOy5iA6cAgTJmjXTYjgEIJdTwUUOUunqhGcR5p/WOeJ6S79GJJXjZW8uQXy+KMWyqsq
         8ZigxamjHufCWx2D08faZs3IIi4L8KJFj7D2lqk9spLQraTuzyMXF1nVVcGD1ExJQ+Qc
         h6Ig==
X-Gm-Message-State: AOAM532cb7IRXYRDlKyQt8+LDATpTTjQMva4td1h/ME2JaBI59lUXcfv
        n/qm3YhrKX535ALvDIu8wZJ6oXoDEEihP384eQhsqQWZWxeZZvr4/NlpqNz5DJ/sYcozHGuh4CF
        lzBet9Ec1vNQMbHRb9Twbx1JYN/dSVCVjZmlob9T41uwsC4zkUfwPe1smZCqaoPn4zfHTpViLlQ
        ==
X-Received: by 2002:a05:6e02:1c42:b0:2d1:aaac:ecc2 with SMTP id d2-20020a056e021c4200b002d1aaacecc2mr6160215ilg.128.1654277862994;
        Fri, 03 Jun 2022 10:37:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD6QpwDL7Wd5u30b73amnDkQf+0XrVGTTVTW2Zv3Vw4x28t8LPwaKvFl/gRzlApcqbp9Utcw==
X-Received: by 2002:a05:6e02:1c42:b0:2d1:aaac:ecc2 with SMTP id d2-20020a056e021c4200b002d1aaacecc2mr6160200ilg.128.1654277862717;
        Fri, 03 Jun 2022 10:37:42 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id g23-20020a02bb97000000b0032e1e0ac289sm2791117jan.8.2022.06.03.10.37.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 03 Jun 2022 10:37:42 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Michael Kerrisk <mtk.manpages@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com
Subject: [PATCH v2 2/2] userfaultfd.2: Update on write-protection support
Date:   Fri,  3 Jun 2022 13:37:36 -0400
Message-Id: <20220603173736.62581-3-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220603173736.62581-1-peterx@redhat.com>
References: <20220603173736.62581-1-peterx@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The shmem/hugetlbfs memory types are supported for write-protection
messages very lately.  Update the man page to reflect that.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/userfaultfd.2 | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index 6b9412aaf..9b5ec0358 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -270,13 +270,18 @@ Since Linux 4.11,
 userfaultfd can be also used with hugetlbfs and shared memory mappings.
 .\"
 .SS Userfaultfd write-protect mode (since 5.7)
-Since Linux 5.7, userfaultfd supports write-protect mode.
+Since Linux 5.7, userfaultfd supports write-protect mode for anonymous memory.
 The user needs to first check availability of this feature using
 .B UFFDIO_API
 ioctl against the feature bit
 .B UFFD_FEATURE_PAGEFAULT_FLAG_WP
 before using this feature.
 .PP
+Since Linux 5.19, the write-protection mode was also supported on shmem and hugetlbfs
+memory types.
+It can be detected with the feature bit
+.BR UFFD_FEATURE_WP_HUGETLBFS_SHMEM .
+.PP
 To register with userfaultfd write-protect mode, the user needs to initiate the
 .B UFFDIO_REGISTER
 ioctl with mode
@@ -327,8 +332,6 @@ ioctl, whose
 should have the flag
 .B UFFDIO_WRITEPROTECT_MODE_WP
 cleared upon the faulted page or range.
-.PP
-Write-protect mode supports only private anonymous memory.
 .\"
 .SS Userfaultfd minor fault mode (since 5.13)
 Since Linux 5.13,
-- 
2.32.0

