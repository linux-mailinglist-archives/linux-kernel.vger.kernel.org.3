Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A46D59B8DD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 07:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiHVFxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 01:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiHVFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 01:53:26 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3539CB7DA
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:53:25 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r22so8498447pgm.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 22:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=LcNHrnEhxuFZm+K7EEF8OzzvN2HFfZimKpmmavzN8HM=;
        b=HyZrFAGr4rovcGDB38Cq87BHaAK7i7EozVlYc5ZSe3WVF5SbSmB1UYNP7m2/jM6gix
         t+iE76zr1Dwg2h6qNamSJF0tpBmfRxxOm/Sj2wni4lkqIb5itP90/AQ7NsWFeS3AcEWY
         Z9dogkwIzc2GpGe5O+Lr3mOyyfpQy908LVsX00DDjoFLnAkpdVNSZvsVAfXwdLs1GHn3
         4w9i4ZZwElg1yGt0wDZMWjMbHHNGigb97W6N31eoIk4IatVqytejMOULcJo9du91D+Mb
         YcXjMy4jZ8dAaPBDmx700c+amt/cHT+tnJaJxYOOFF/VGb6up8CytAU2QDdUkAuPoHZk
         dm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=LcNHrnEhxuFZm+K7EEF8OzzvN2HFfZimKpmmavzN8HM=;
        b=kstnhI/iDnwwM1RyImwG5d3LbYgZ5Ix6uN9KhTyLDVTBauhiF5DfiIsvQ52ARWSxV+
         Xl2og1ymaI+mXhOE4zl0/HVEwuXGRDo1WP/oRPy+Jea3+ozoC7h5vHe6Zr+Gkchq6itx
         8MKPonbV2Se3bX5Y/O7pXaKzEpVU1lIVv1areZUwXJoUhUhLRn0u3L9aiXWlTQT00aYz
         LQnzcTFW/fMrVOYv5FeWvltAnZbpxQ9TFs0IZmH6vfks9Aq5qiGMfaAtcIDqIwQCYxpa
         ErhxKYJg4pyfAcUWAtAPcE4OQ5tkIqt+EOAs4FcCtEef2FxfAhvbqVVkp+I8RGlenbNs
         aIMA==
X-Gm-Message-State: ACgBeo08FnKAcmkeQf2mdpwmI1V7gq9yOXoMDN4yHN8Aj4kdRLU7O7PR
        EmvFJ/3jNbhqEXGgcrWW7xOMsUxiGY4=
X-Google-Smtp-Source: AA6agR6T1osXtaulkEyVdRKlQkXIF4y6BvJbde+f0ksLsYhTQiAJw4/8wisjY4GIrZ8y7O9LxqE+jg==
X-Received: by 2002:a63:6e81:0:b0:419:f7b1:4b12 with SMTP id j123-20020a636e81000000b00419f7b14b12mr15579172pgc.406.1661147604728;
        Sun, 21 Aug 2022 22:53:24 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cu14-20020a17090afa8e00b001f23db09351sm7078817pjb.46.2022.08.21.22.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 22:53:24 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>
Subject: [RFC PATCH 0/2] erofs: support compressed fragments data
Date:   Mon, 22 Aug 2022 13:52:59 +0800
Message-Id: <cover.1661146058.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

This feature can merge tail of per-file or the whole files into a
special inode to achieve greater compression ratio.

mkfs v4: https://lore.kernel.org/all/cover.1661087840.git.huyue2@coolpad.com/

Yue Hu (2):
  erofs: support on-disk offset for shifted decompression
  erofs: add on-disk compressed fragments support

 fs/erofs/decompressor.c | 15 +++++++----
 fs/erofs/erofs_fs.h     | 26 ++++++++++++++-----
 fs/erofs/internal.h     | 16 +++++++++---
 fs/erofs/super.c        |  6 +++++
 fs/erofs/sysfs.c        |  2 ++
 fs/erofs/zdata.c        | 55 ++++++++++++++++++++++++++++++++++++++++-
 fs/erofs/zmap.c         | 40 +++++++++++++++++++++++++++---
 7 files changed, 141 insertions(+), 19 deletions(-)

-- 
2.17.1

