Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C60538974
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 03:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243305AbiEaBMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 21:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243070AbiEaBMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 21:12:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA1AD9399C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653959525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ftsvv1kgyZ07pkGYMo31JDRVN0rVbQcS4X4QP8a2k4=;
        b=OH1/Gb9JfpyiMei5A4RVXXqXDb84/O+7BoSnRSK+ybtemePxSyOHZRkGgsYK3xekxHvKWw
        8DE7W55no9QDWd0oF/on+VwsRqyl+rzM8B//RpEgvJgdXraWjt/1APigQYe9FbPxG6DgPF
        ZysjG4WOBGgvRXDgHGA0NcksEf3v7uU=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-i1SQqUxNPgCw5HwIReE20Q-1; Mon, 30 May 2022 21:12:04 -0400
X-MC-Unique: i1SQqUxNPgCw5HwIReE20Q-1
Received: by mail-il1-f199.google.com with SMTP id b13-20020a92670d000000b002d1a5d6b795so9259129ilc.16
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 18:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ftsvv1kgyZ07pkGYMo31JDRVN0rVbQcS4X4QP8a2k4=;
        b=mmbav1YJmni9FDhDeWrX5L+SYBm8Ef/AZsFLq/Cfqh3zCIVKNUi+j0CxC7FBmcHkpx
         EC77/tosYzDsIWStYT3mGLlRp1n+Wdlel1hyptaZYA/76vleyrJSlPoxcdsTjoH0ZXdv
         oW0nNwULA45SUefinzc13khAtwz7Fc6nAJHhgXZsKkNuzVo9TDssn2z8WYNw7O+2JH2a
         plwdubkm14omHY03sotmk2BSMp2CKoMgjHgX6FLGe9baOLNorljwcPkgEPrLK9Fi+8g8
         uA8C0CPdcQBiHda8aoV8V98D/qO9hQuUcS4G1EAiBOjdFg8dOwS9WeerRgkugdD19sjT
         nHPw==
X-Gm-Message-State: AOAM533WL7o2r/LwdsxJTq9Ej/BslZZiPc9oSj3I4USOlZDFJRt9Xa3k
        H5Uva9Yn1tfBzCFih2hzynsHV/tIUgr3UyOCSJ8CwoJGY6uI1rQgrTV+VePebL9uT47LO7NWFq0
        6bv2t8JG5vIP//C4+TApfrBMlNszfmj9NCJ+fJ6ESI0sX3cJNQ4/kBq9YY5eFqZKBbzCu6sqXUA
        ==
X-Received: by 2002:a5e:d614:0:b0:65e:42c8:c51b with SMTP id w20-20020a5ed614000000b0065e42c8c51bmr25644015iom.78.1653959523786;
        Mon, 30 May 2022 18:12:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMlE0Rt5YEOvPReAT+xVKJwEsp+VIfQPBHnAmvRHpzn4UHcneOh9VgrZzAwMT91V2dYrCgyA==
X-Received: by 2002:a5e:d614:0:b0:65e:42c8:c51b with SMTP id w20-20020a5ed614000000b0065e42c8c51bmr25643999iom.78.1653959523503;
        Mon, 30 May 2022 18:12:03 -0700 (PDT)
Received: from localhost.localdomain (cpec09435e3e0ee-cmc09435e3e0ec.cpe.net.cable.rogers.com. [99.241.198.116])
        by smtp.gmail.com with ESMTPSA id s6-20020a02c7c6000000b0032be3784b9bsm3158234jao.117.2022.05.30.18.12.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 30 May 2022 18:12:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-man@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] userfaultfd.2: Update on write-protection support
Date:   Mon, 30 May 2022 21:11:57 -0400
Message-Id: <20220531011157.46868-3-peterx@redhat.com>
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

The shmem/hugetlbfs memory types are supported for write-protection
messages very lately.  Update the man page to reflect that.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 man2/userfaultfd.2 | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/man2/userfaultfd.2 b/man2/userfaultfd.2
index 0928a76d2..99aae8b50 100644
--- a/man2/userfaultfd.2
+++ b/man2/userfaultfd.2
@@ -273,13 +273,17 @@ Since Linux 4.11,
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
+memory types. It can be detected with the feature bit
+.BR UFFD_FEATURE_WP_HUGETLBFS_SHMEM .
+.PP
 To register with userfaultfd write-protect mode, the user needs to initiate the
 .B UFFDIO_REGISTER
 ioctl with mode
@@ -330,8 +334,6 @@ ioctl, whose
 should have the flag
 .B UFFDIO_WRITEPROTECT_MODE_WP
 cleared upon the faulted page or range.
-.PP
-Write-protect mode supports only private anonymous memory.
 .SS Reading from the userfaultfd structure
 Each
 .BR read (2)
-- 
2.32.0

