Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9068B501E82
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347110AbiDNWoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbiDNWoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:44:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D0E2A8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:41:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id a16-20020a056902057000b00641c83f82f5so5415494ybt.22
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 15:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rAQUyFFCAm9hAIpMthk09aJ6bzB1j1wIgJVRYFh3f58=;
        b=E3GbblU9eh7nB1JiPymsjFnwzoT6TbQMf8ldul6KS4xO2fQSx1uK7JVhfC4can/CSz
         7V3LtWsBoV+qeu9UUPZaLqIeOXV5EyYsNzOkhQTey1XvrEyokJJ9QU5U+uLqMhdgZtbp
         p9yBKq2F+QtfzHyUFMsCjoo6rUMGGkcTpV3of2gXzgwOnyDUXdpqlzV03XFTgetPnHte
         hPHGZIlI+HqWxTTk19bBAEzEPP6x9R92M6n5jSuGU3sHRHY69QwA0MTCGQKiMFRPpuG2
         Y8ARNaB2Czz6794TSC/U4ORN2ewJpmEP0d03K7ypNDwXgC455icI9HQupJDXoB9fThr6
         9v7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rAQUyFFCAm9hAIpMthk09aJ6bzB1j1wIgJVRYFh3f58=;
        b=WPKV/OAKlixGcC32gPI9zZeRo9n0eRIX1W2umntx8GawnnV6tIJwl6Sun2hp+Bq9K1
         /mbmBbGTVpxmfwaPg7OnFAi3uF47JZangBh3gW3rI9/H2Fm7o+LdT9xMxr3zXBDvk991
         8nllbGM8E7lKymMOXSGRq9RvOOI3AppR8FbSZBPIuH9KjEsFE7F5fvq7FstTm4AVwjg4
         fy/zUHDvyhUooupTWktLHJsmDj+Fbiw7ddKTnDQQgzAqicX1BAPsEc07UsrlS8A5+KRe
         y4TBMlLftBYunTEogQ99vMYgkAPYuQOZbX8v7OZyjGeGZc3i99UoX3NOxlMVI1NuC6MC
         5NPA==
X-Gm-Message-State: AOAM5328yIPbu9uIbpzCKm4MwCFPb3re+A3uIvkAjc4xZucXZXMBs05k
        1z3FtQwEkXM/41GQb9+MMS2YNNW4kkQ=
X-Google-Smtp-Source: ABdhPJyPRB6aS2hvABaRs4E8OHt+HsAC7x01q5HuMRBlfWdcx4tIhTOoY3h76+73rpRKld3Mv/x1LMEEXx8=
X-Received: from khazhy-linux.svl.corp.google.com ([2620:15c:2cd:202:a4e5:c402:edee:ce9e])
 (user=khazhy job=sendgmr) by 2002:a81:9ca:0:b0:2eb:f567:217f with SMTP id
 193-20020a8109ca000000b002ebf567217fmr3782016ywj.322.1649976099028; Thu, 14
 Apr 2022 15:41:39 -0700 (PDT)
Date:   Thu, 14 Apr 2022 15:40:56 -0700
In-Reply-To: <20220408234707.2562835-1-khazhy@google.com>
Message-Id: <20220414224056.2875681-1-khazhy@google.com>
Mime-Version: 1.0
References: <20220408234707.2562835-1-khazhy@google.com>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [PATCH v2] block/compat_ioctl: fix range check in BLKGETSIZE
From:   Khazhismel Kumykov <khazhy@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Khazhismel Kumykov <khazhy@google.com>,
        Bart Van Assche <bvanassche@acm.org>
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

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Khazhismel Kumykov <khazhy@google.com>
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

v2: addressed bart's comment

diff --git a/block/ioctl.c b/block/ioctl.c
index 4a86340133e4..f8703db99c73 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -629,7 +629,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return compat_put_long(argp,
 			(bdev->bd_disk->bdi->ra_pages * PAGE_SIZE) / 512);
 	case BLKGETSIZE:
-		if (bdev_nr_sectors(bdev) > ~0UL)
+		if (bdev_nr_sectors(bdev) > ~(compat_ulong_t)0)
 			return -EFBIG;
 		return compat_put_ulong(argp, bdev_nr_sectors(bdev));
 
-- 
2.36.0.rc0.470.gd361397f0d-goog

