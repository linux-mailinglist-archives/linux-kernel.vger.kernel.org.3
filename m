Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A5D4FA03E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 01:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240071AbiDHXtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 19:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiDHXtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 19:49:15 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C5E17A8D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 16:47:11 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x132-20020a25ce8a000000b00640812b1ebaso2608851ybe.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Sr/qRaqa5z0r+uAXDRErpJZ7x7X8TiNzZy9nkvxB+Zo=;
        b=j093d4HglnRuHm30WYjo+4bJfNhh8R69tSuGD8sG2vVCGmZLtmPNULApd085mM1rRp
         PtrfZIA0w/UrHLyEHZI8p6RExsXeXpJ2ertTmmlbxqdPfVA6CKOlNWQbO/VR8Deuex6i
         IlzuXGJqwlKqLIW+SJcxEvFb7MMgZnD86nwsNYN+BetBxTlMAoalaykCtrxCSLUeUggx
         3kiLXg5Bdzf2/jshqvd6p+aHtKglXlrfIu0aD9BU6vP0uAZxtHeuI/Cn56ZlrX9DKOB8
         CKVwq4mU9ItDow5/lGb5h+igr1uhcI/c5eDd01UyPylqJ5MugYxRTm3Ns0RnTDCfo4kG
         wM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Sr/qRaqa5z0r+uAXDRErpJZ7x7X8TiNzZy9nkvxB+Zo=;
        b=lR1F6JsaLQsh3jonNANo49dYtZa7G8UVYwJbBNHBVKcw12VuZZSjlx0TuvKSi95J9D
         tINl9nyFOOcG+rLQm8NrERluVYEH5VuY7xXIaAHqUayqqxhguxHwQ4bTRQTnfPSsX483
         mM95NMT3c4BER/557s9GghEJTc2Wybha1TZRaVqm6sQ7SodVNapDehE8/LOxPL9nTEBp
         hliu8XGZpsMbha5R74b68ggiPTwsVwtkD0K3nXkrUeeRiSQaBeOe5JZE1XTLygPzmOMN
         jIlFNUa2DLtgnR1nhfopUxhL5E7qi6qVgko5xdGOCh4VSfchzb20kgmIz2FR8N5Gh23l
         zaTw==
X-Gm-Message-State: AOAM5318CwAT237eV+pQ9PKCmmHvn6Sw46CfY/OdZTqyxKF4rGcnLkS2
        Qem7nM8PYx5UMhCewhfYUDf8cID+stQ=
X-Google-Smtp-Source: ABdhPJwHsnREaTd9LqMnQLGsxcwdglz8LsVSd8sjRZeQ7YvvH6hrJ73som0gxiDhjaauIi1oCS+8yi9KIqA=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:102:a6b5:8282:fe01])
 (user=khazhy job=sendgmr) by 2002:a81:7357:0:b0:2e5:f8d1:eb92 with SMTP id
 o84-20020a817357000000b002e5f8d1eb92mr17753632ywc.461.1649461630297; Fri, 08
 Apr 2022 16:47:10 -0700 (PDT)
Date:   Fri,  8 Apr 2022 16:47:07 -0700
Message-Id: <20220408234707.2562835-1-khazhy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH] block/compat_ioctl: fix range check in BLKGETSIZE
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel ulong and compat_ulong_t may not be same width. Use type directly
to eliminate mismatches.

This would result in truncation rather than EFBIG for 32bit mode for
large disks.

Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Noticed this one was sitting in my "not landed yet" pile, third time's
the charm? :)

diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e4..959e93a90b29 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -629,7 +629,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return compat_put_long(argp,
 			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
 	case BLKGETSIZE:
-		if (bdev_nr_sectors(bdev) > ~0UL)
+		if (bdev_nr_sectors(bdev) > ~((compat_ulong_t)0UL))
 			return -EFBIG;
 		return compat_put_ulong(argp, bdev_nr_sectors(bdev));
 
-- 
2.35.1.1178.g4f1659d476-goog

