Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF38481984
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 06:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhL3FLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 00:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhL3FLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 00:11:48 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE592C061574;
        Wed, 29 Dec 2021 21:11:47 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id s1so18997990pga.5;
        Wed, 29 Dec 2021 21:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhrZeTRt63Ckznp6xhiN0kr9Pmyo9kvdfAjg/UWzwdU=;
        b=JnEQlcWihH5OGs0e6O2a8720kUMJrdjwhdLHiibbhS0zZpGMUUQE+o0hw80lKVaSen
         Er2FOrNijZooqqPOfcovOgIhO3a0qasVgczN7j5MO2QcFjXdng3b7R2mWAhlD3SoCyiG
         ZKDvEIUt83WQxognfLmcEZSoHrCBial84vveIxB9z5e6PmrKLKgsw2/OEhPRUqqCgcbY
         gSyuhhCW6wc0WzGl3psOpUv8vS91QdARLrgdc7MX6ZHwodIcocoAcjavapCpHETP6igI
         FlYVS9qoFhFhU8PK1a3FUShWP7gay9KslqrbQ38+IL2cU90UlIFFFqEG8TIsOKQFjhoN
         zz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AhrZeTRt63Ckznp6xhiN0kr9Pmyo9kvdfAjg/UWzwdU=;
        b=LlJo5KH/dEgarL8PUmFLk8PoIq60FEKGuY8kgr2wbA5W1aZPxLutfy0Vg9kBDRmyS3
         NOtTJ6HGQRzD0vzT8G6p/gHsb3Mgz00ghKzYlPERwKEffNNZcFKzf36kFtWkWqT8mCme
         aojhP6u3XErF0LGhIk0MkbMO2SJUb33/kDSSiR8ISAB+6R7GzMNzdl8aG3239BIcy0Gl
         /0ZlK9gE924SLnY9KLnTz5z1REdu+GXV0FaavwXQQ+ooYJkxwUIl/Nx/4+RnJmr73Kin
         bZH6xODAC7DON05X70ya3hM+2pJO8Ql7M4J9BChdMvOCBslzh7cEPPqNNhe9faUFtBn5
         UPcw==
X-Gm-Message-State: AOAM532K3Ax9DjHm8t7UKzYSWF8mfQs+MrpeuDPgGvFAyOo63ynERhzA
        aFZjzU1/35+CFkhQn93tB9U=
X-Google-Smtp-Source: ABdhPJxhpCc/4ScsDOyb7y0asG45cIs6JuM7mxPUxfle7J4mdSIluHG4gsOXZwQ/07SsgRy9qD3bjQ==
X-Received: by 2002:a63:784f:: with SMTP id t76mr11484027pgc.156.1640841107509;
        Wed, 29 Dec 2021 21:11:47 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id e21sm10365925pjr.4.2021.12.29.21.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 21:11:47 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        stern@rowland.harvard.edu, jj251510319013@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v3 0/2] usb: gadget: use after free in dev_config
Date:   Thu, 30 Dec 2021 13:11:30 +0800
Message-Id: <20211230051132.21056-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two bugs:
dev->buf does not need to be released if it already exists before
executing dev_config.
dev->config and dev->hs_config and dev->dev need to be cleaned if
dev_config fails to avoid UAF.

v2:
1. break one patch up into two separate patches.
2. use "fail:" to clear all members.

v3:
fix a mistake in [PATCH v3 2/2]

Hangyu Hua (2):
  usb: gadget: don't release an existing dev->buf
  usb: gadget: clear related members when goto fail

 drivers/usb/gadget/legacy/inode.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.25.1

