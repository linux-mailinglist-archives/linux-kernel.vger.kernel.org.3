Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33F85080E9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359482AbiDTGTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350332AbiDTGTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:19:05 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D45B393ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:16:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id p8so1018820pfh.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 23:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIvmKGLNVqcazkFOBIdFvPkLcGgM6DHpc1ty+OLQ4Tg=;
        b=a1oG0yz7qnNvNKPdPDC9751ZAu1bkGG88T4eGTerzzIf7l1WfaPd976wD8Kvta8NDc
         GkR+Azj7Vy/U5uD2OgZY54MZkBv1cipBZa9j6K8PY9LcbYdjfDbUBxdUK1H6gQ3QPjEI
         lUKWh9CY+ywJtvqXKideXA4aHj1c4f6EAXL+byWRyFeM71KnNFXwPDKtEqfhS656HNCv
         xltRELuhVVK7QM1ndEpc2faMhF+c2N4TZSeHhzaAXdhIm6Hv5gQsbJ9uqe9gvI4t1zXc
         DiLmXZcdUVkpUbx+witTn3tXnz2Ddp9vCRt+FUE39aVqhEPUL1pVCf/VlkGvB6XHv0nV
         75lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oIvmKGLNVqcazkFOBIdFvPkLcGgM6DHpc1ty+OLQ4Tg=;
        b=KJai9Udw1G0+YU66wVwToYzkwVnGGSZS8qdTGxB5p2xFNtW42nG92KmmZngctcYtHT
         Sl2ZP94VGEjBx2Kqo5mqWqHWkB5fUjiTrc2rmPI6j0AfDAsUIyuISF+oLPYPHID1FN3z
         PKUlOltEBl55S3FV17MHNyuCZLEvKq70fXXdOpaH2De3rBbHRAAjRDBpQ5EBb6rKf3gG
         hqR+eFYl+7pXUSgybhqO+JTv4/shlaajntHEv6JqXDJchC06tqEAZB/dLGbfMmTpea+w
         cGKufKgrGhCuEDBcg4esUtRQ9JkdADYVUWK8FarM2UmZcvDY7sKKw6Upge9A+r0DIuet
         nFHw==
X-Gm-Message-State: AOAM531z4wMVTTxgR1+Onebxcd8PWjz9l2VTW+ZlxcC0U237dBqIt0Dq
        UI2SmHjBdSerEsDqfsTXPY0=
X-Google-Smtp-Source: ABdhPJx71sZKQGk+/eDpcpJu3i6VS9r5ubfhNlctyGQtGJg/WdxwKKD438afKIwvGkYVABgXz1gviw==
X-Received: by 2002:a05:6a00:1254:b0:50a:55c5:5ff7 with SMTP id u20-20020a056a00125400b0050a55c55ff7mr19642891pfi.85.1650435379909;
        Tue, 19 Apr 2022 23:16:19 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:daec:60d:88f6:798a])
        by smtp.gmail.com with ESMTPSA id k22-20020aa790d6000000b0050a765d5d48sm9798778pfk.160.2022.04.19.23.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 23:16:19 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PULL 0/3] xtensa fixes for 5.18
Date:   Tue, 19 Apr 2022 23:16:08 -0700
Message-Id: <20220420061611.4103443-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following fixes for the Xtensa architecture.

The following changes since commit ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e:

  Linux 5.18-rc2 (2022-04-10 14:21:36 -1000)

are available in the Git repository at:

  https://github.com/jcmvbkbc/linux-xtensa.git tags/xtensa-20220416

for you to fetch changes up to 839769c35477d4acc2369e45000ca7b0b6af39a7:

  xtensa: fix a7 clobbering in coprocessor context load/store (2022-04-15 18:44:02 -0700)

----------------------------------------------------------------
Xtensa fixes for v5.18:

- fix patching CPU selection in patch_text
- fix potential deadlock in ISS platform serial driver
- fix potential register clobbering in coprocessor exception handler

----------------------------------------------------------------
Duoming Zhou (1):
      arch: xtensa: platforms: Fix deadlock in rs_close()

Guo Ren (1):
      xtensa: patch_text: Fixup last cpu should be master

Max Filippov (1):
      xtensa: fix a7 clobbering in coprocessor context load/store

 arch/xtensa/kernel/coprocessor.S    | 4 ++--
 arch/xtensa/kernel/jump_label.c     | 2 +-
 arch/xtensa/platforms/iss/console.c | 8 --------
 3 files changed, 3 insertions(+), 11 deletions(-)

-- 
Thanks.
-- Max
