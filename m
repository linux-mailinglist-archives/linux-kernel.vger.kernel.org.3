Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B685800A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 16:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235492AbiGYOU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 10:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiGYOUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 10:20:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8FBAA120BA
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658758852;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VjhxBnXfdQJxc8cGv/KCPbDaOiUZz+5THvMR1Yb191c=;
        b=LlXMOTMSYqezinWOISth4yH2ztxevx0RTN1hyWVEfZsywEae1lvJ/+GiMQlj3W2iROCKZY
        aesw9Yt3Jnku63Mxk05NNI8+mvitJ1ZSGfJCHqVwfa2syYI901VOn48eSqgFHIzWVu9dU7
        Hs85XibgdK8Usb5GXXV3ecyPlHR5ZyQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-640-SdQUWrpLNmqMh8wQj_vSIw-1; Mon, 25 Jul 2022 10:20:51 -0400
X-MC-Unique: SdQUWrpLNmqMh8wQj_vSIw-1
Received: by mail-qk1-f197.google.com with SMTP id f20-20020a05620a409400b006b5fc740485so9916745qko.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 07:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VjhxBnXfdQJxc8cGv/KCPbDaOiUZz+5THvMR1Yb191c=;
        b=eai3MUIYGcVBRVsluIGUY/AOwdEsI+s8xOvZdb/CywGLDajvDwNSu7y99fLXK+/z9e
         B2Xu6NT/oMpMuD+N2/mkt3bITHgHN8mMOulRk+CO3kHWyZ5+iN4eloekft/9uRCr9P7y
         iujRwwu1zvFGeKMxwaP4dy8jrcbDYbOuYRczQ/aZSzqPwUlQNJk/gI2W37wp3+AnwWK2
         0ytQ2VRILPmQr9HXVgHp9sfHxdrVvrgl1KF5YQy2UTq5rIiGQCazYuUvHLWncjEXtI9q
         NZeH4S1PziJFuSopOV1FiTrfU/XJZETGOaxn1Fzgi/nJkTvP2bnTeYOB9SDJv9KE0Ogx
         xOaQ==
X-Gm-Message-State: AJIora/4OWFhS/m4Lx8NO8o2WpKEJ/GzVJv2KUxXNc9hdS4Q3/EMpjBk
        dsbJ1JaMYh7XuNPBYbm98d2Eid+HNQxXVoMEeKi2NfKj+FgLih8dZt0Lt+GewtxkQJVYS8AB+DJ
        dMULhpNxbsbBXcGJsFJdLmd4g6Rssh5/0GduOuomlqAPQLfqtupWFNO3tN+PJRvK9NLNCfLFExg
        ==
X-Received: by 2002:a37:53c1:0:b0:6b5:513a:c5bc with SMTP id h184-20020a3753c1000000b006b5513ac5bcmr9200707qkb.0.1658758850532;
        Mon, 25 Jul 2022 07:20:50 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vc+ZkWRV13O7tEb5YUXw2eqXLazt18OupxEcZFVdKte1/R5yctu83n1UbltLHwdXwnsonh0w==
X-Received: by 2002:a37:53c1:0:b0:6b5:513a:c5bc with SMTP id h184-20020a3753c1000000b006b5513ac5bcmr9200673qkb.0.1658758850216;
        Mon, 25 Jul 2022 07:20:50 -0700 (PDT)
Received: from localhost.localdomain (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id ey14-20020a05622a4c0e00b0031f0ab4eceasm7626071qtb.7.2022.07.25.07.20.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Jul 2022 07:20:49 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     peterx@redhat.com, Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 0/3] mm/mprotect: Fix soft-dirty checks
Date:   Mon, 25 Jul 2022 10:20:45 -0400
Message-Id: <20220725142048.30450-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- Add r-bs
- Fix spellings and commit messages (on Fixes) [David]
- In the new test case unlink() after open() to not leave temp file even failed

v2: https://lore.kernel.org/lkml/20220720220324.88538-1-peterx@redhat.com
v3: https://lore.kernel.org/lkml/20220721183338.27871-1-peterx@redhat.com

Patch 1 is the previous patch and real fix.  Two more test patches added to
add mprotect test to soft-dirty.c, meanwhile add soft-dirty test into the
vm test loop.

Please review, thanks.

Peter Xu (3):
  mm/mprotect: Fix soft-dirty check in can_change_pte_writable()
  selftests: soft-dirty: Add test for mprotect
  selftests: Add soft-dirty into run_vmtests.sh

 mm/internal.h                             | 18 ++++++
 mm/mmap.c                                 |  2 +-
 mm/mprotect.c                             |  2 +-
 tools/testing/selftests/vm/run_vmtests.sh |  2 +
 tools/testing/selftests/vm/soft-dirty.c   | 67 ++++++++++++++++++++++-
 5 files changed, 88 insertions(+), 3 deletions(-)

-- 
2.32.0

