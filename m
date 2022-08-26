Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FDD5A2309
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbiHZIb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiHZIb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:31:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABA888DF5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:31:55 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id pm13so973486pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=6OTlaK8jvc2a8Mce9GUIiufxZRP37gVYjvKib4eNVxI=;
        b=hu0xwVA3obcoMaXIdaCXL3WuaK+vHfptE0/XUZCvwHUKyRVqV7uAFx66Ex2YWq23bs
         uqLdkUF2y2y2+oWziYPtajogn/0dqd1hA85HWOfmlXTDxQQk/e87+DOLD6i4mJETQTw5
         feYzdK/81DlaR/VKs3UoveURZLSctj/mLNSi0bzQn+s52zZhGEVYgpY8/lhXYw51sgno
         SsZYHky0FjQ2noG9m6UL+N2Dnz2xE5NtvactqV0NBQ2Hbj0lGYmKzutys3FcU9gZgJhB
         R6dwcPo45zEOlZJe03K9XYXFACwzVHouCqgi44LWUYCe54nYx2LDIeiBXHt+AgVAH03z
         mhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6OTlaK8jvc2a8Mce9GUIiufxZRP37gVYjvKib4eNVxI=;
        b=IyDFNBn1ltpZAsY6pqMQfXhNSXyEUowS6ktHasqwC/PqlLNa59+a+BZP0h/pOOU7vc
         CUGG9ZD2AmOQtFxc3kp96RWLOf2CGEVnehY51cQEBpRdrjbccKxEkkjdKwK1RmW2yC01
         QZN9F8YbUXM0A5fGkeg6tYyvh+IZ89Gbv1lJcgiKZIjq6We9woOT7QNx62GZ09q3uC6r
         fOdAvbQXYghUudvjNTmagGJOo7xHWsy9RTlajGucGQb/Mgpep4mZX830qCtHwWYGdcAy
         ijrbpesnnFoQVFFyrn7Sa5/TJg3dbUiC087trMFhbkpwkUKFd4ubXnBZN4onU/QtLC4r
         abvg==
X-Gm-Message-State: ACgBeo2AsbbFtMOJxJpLnFYoH9GacaUWBh8vpopbhLf5xsvA7ouNk8iH
        31yOWsE2sMUO7f1rVxTS6g==
X-Google-Smtp-Source: AA6agR65uXXkQHQfsSMG2BCqAs3P8T2HjY6ak7TB54hxzr6sZ5XoqToo01tYb1dnKDtQBxDtcUFMGw==
X-Received: by 2002:a17:903:247:b0:16c:5017:9ad4 with SMTP id j7-20020a170903024700b0016c50179ad4mr2788810plh.115.1661502715389;
        Fri, 26 Aug 2022 01:31:55 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902714200b0016f1ef2cd44sm934953plm.154.2022.08.26.01.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Aug 2022 01:31:54 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH 0/2] Simplify the damon regions access check
Date:   Fri, 26 Aug 2022 16:31:16 +0800
Message-Id: <1661502678-19336-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

This patchset simplify the operations when checking the damon
regions accesses.

Kaixu Xia (2):
  mm/damon: simplify the parameter passing for 'check_accesses'
  mm/damon/vaddr: remove comparison between mm and last_mm when checking
    region accesses

 mm/damon/paddr.c |  5 ++---
 mm/damon/vaddr.c | 11 ++++-------
 2 files changed, 6 insertions(+), 10 deletions(-)

-- 
2.27.0

