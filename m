Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF65537355
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 03:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbiE3Bkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 21:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiE3Bkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 21:40:37 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57393EA91
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 18:40:36 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id j21so8851423pga.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WE4ZVE8mQoLaImrVIMYbwRDn6NJ35hOANqsO3uh5lM=;
        b=NWwIBWvB0YV3Tnf2sRXxtscP+89AFxcEvDESpqQY3z7LIrszbTvIzkBkoy6z/ZIwD4
         hkMrGWl2PMC31bN/Hjeoy+7raLOCb8bzc8fCSHS3LQ00dXdBEpYYnTc1YrLZrJk4P55V
         J+uCFVfiX4tlbE3WfjTZFNlyaBlQBvdnB/Wgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1WE4ZVE8mQoLaImrVIMYbwRDn6NJ35hOANqsO3uh5lM=;
        b=LuARB5pyvpfw3k2JWg7sOeoIQsOUmrS967pxBza1adrYRwBwf9NLvTfovaZr2fIOO5
         u6MTtpOl86iBFo5SYrWhSVJk98MLCoX4ezKp5uVymvbSKc1Rahjk+MTG74pDIdxB/bcc
         SP9xzpOVXGTzcgpy3RM96lS11kpJ+fIlBsPE6YIak56TgRmlLEg6oyQRZnrEL5N48wMz
         dEEyFXDS6cebSyTmragj5OE/9dqqd6LMVKzJNtXO7m5ZLQztmjXl6MwbkSdeW+SAOJpI
         UrwolImS6bbJ14j09Z9ecW+GcU9yX+3ePYQVOpC9GGg5OnQcGEMC5VDW7f/WTobJsXbr
         PIiw==
X-Gm-Message-State: AOAM531jiznL0OUb9tL96z3G11Ebw4I7+g+ggpbbGO2WPSPn0t+63l/6
        78UhDfw737rPG4GI+bMUO+tN1w==
X-Google-Smtp-Source: ABdhPJzwNYgqSSjgjbdvBXwBXi4dLXkHz/WOdmca+LitgrV4YirR7v1uuVugMX+kWqjBks1yBjKMzw==
X-Received: by 2002:a05:6a02:117:b0:3fa:de2:357a with SMTP id bg23-20020a056a02011700b003fa0de2357amr34734443pgb.169.1653874836237;
        Sun, 29 May 2022 18:40:36 -0700 (PDT)
Received: from dlunevwfh.roam.corp.google.com (n122-107-196-14.sbr2.nsw.optusnet.com.au. [122.107.196.14])
        by smtp.gmail.com with ESMTPSA id l9-20020a170902eb0900b0015f2d549b46sm662285plb.237.2022.05.29.18.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 May 2022 18:40:35 -0700 (PDT)
From:   Daniil Lunev <dlunev@chromium.org>
To:     linux-fsdevel@vger.kernel.org, miklos@szeredi.hu,
        viro@zeniv.linux.org.uk, hch@infradead.org, tytso@mit.edu
Cc:     fuse-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Daniil Lunev <dlunev@chromium.org>
Subject: [PATCH v3 0/2] Prevent re-use of FUSE superblock after force unmount
Date:   Mon, 30 May 2022 11:39:56 +1000
Message-Id: <20220530013958.577941-1-dlunev@chromium.org>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v3:
- Back to state tracking from v1
- Use s_iflag to mark superblocked ignored
- Only unregister private bdi in retire, without freeing

Changes in v2:
- Remove super from list of superblocks instead of using a flag

Daniil Lunev (2):
  fs/super: function to prevent super re-use
  FUSE: Retire superblock on force unmount

 fs/fuse/inode.c    |  7 +++++--
 fs/super.c         | 32 ++++++++++++++++++++++++++++----
 include/linux/fs.h |  2 ++
 3 files changed, 35 insertions(+), 6 deletions(-)

-- 
2.31.0

