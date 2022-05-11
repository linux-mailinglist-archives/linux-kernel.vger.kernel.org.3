Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089F45228FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiEKBbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234894AbiEKBbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:31:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC5A3A5DA
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:31:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id a19so260877pgw.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 18:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ro2giJkuvuJdzvxf68e3H2xmYter4QpHE79FuLxIAc=;
        b=Au1CU6jRpreJ8t+x3gPMPRVQje08IpwwfwVdGeqOXNoom/8XyrcCbThW+IE0O/XP4x
         X4gXGv2PvlgWuWnxUrl98Db7XwYlWhhuYU7PyejopoAQp/tlb0ci+Yq6YnMZtCIRisUH
         7d8UJRehsjc4Tk8M8B9tiB2d400n/3ALaL23U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7Ro2giJkuvuJdzvxf68e3H2xmYter4QpHE79FuLxIAc=;
        b=MvC0L8ZElQGNwy5k7+KJLePA1hmpUoBoThEnkyp6epQZvFgztwjNsr7sVQRadTe+83
         8W8ywtmKSm25syvzQXdyhtYbfSUm08Yt37htUlTpFHFGND04b8bpX5zt/9yOuj5NRhWU
         u5LWewR99PMteLMA1uwayo0Yf+cLlrl1BBPDNuxjULfwpwovAOPxaakZpTVhHvUbMboc
         rRFTHxqWC7OWEdGoOdgHOvSGRQsYjbM5eY/GK5rZihstl6hg2MmynfUi2zdPEN56IQq0
         ymMUy3gYPytnIyrom7afBB+0vdLWEG+4/mYGthx2gQ+HbSAYs6QOyxsRS9CmCmJpM1nS
         k+Cg==
X-Gm-Message-State: AOAM531mkfCYmyHZ1FWDZzjlkvd0ridFWcoqqS8GqAKkQF9riqw5W/3K
        GG9uWIFapv3Y9iS9tsfETtI7wEldtVb81Q==
X-Google-Smtp-Source: ABdhPJxjUzX9FxHTIomOWYpQjNpMKe2au4mvF33dt4V+qZYFdN1t+q4jmXd9hobBS6rMTpFYDYXtpg==
X-Received: by 2002:a63:5c58:0:b0:3c2:f183:cbd7 with SMTP id n24-20020a635c58000000b003c2f183cbd7mr18502090pgm.33.1652232672791;
        Tue, 10 May 2022 18:31:12 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090aa50400b001cd4989feecsm2494749pjq.56.2022.05.10.18.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 18:31:12 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: [PATCH 0/2] Prevent re-use of FUSE superblock after force unmount
Date:   Wed, 11 May 2022 11:30:55 +1000
Message-Id: <20220511013057.245827-1-dlunev@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Force unmount of fuse severes the connection between FUSE driver and its
userspace counterpart. However, open file handles will prevent the
superblock from being reclaimed. An attempt to remount the filesystem at
the same endpoint will try re-using the superblock, if still present.
Since the superblock re-use path doesn't go through the fs-specific
superblock setup code, its state in FUSE case is already disfunctional,
and that will prevent the mount from succeeding.
The patchset adds a possibility to mark the superblock  "defunc", which
will prevent its re-use by the subsequent mounts, and uses the
functionality in FUSE driver.


Daniil Lunev (2):
  fs/super: Add a flag to mark super block defunc
  FUSE: Mark super block defunc on force unmount

 fs/fuse/inode.c    | 11 +++++++++--
 fs/super.c         |  4 ++--
 include/linux/fs.h |  1 +
 3 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.31.0

