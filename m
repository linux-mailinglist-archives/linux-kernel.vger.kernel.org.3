Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640FB481954
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 05:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbhL3Eid (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 23:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhL3Eib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 23:38:31 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A937DC061574;
        Wed, 29 Dec 2021 20:38:31 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id u16so17404389plg.9;
        Wed, 29 Dec 2021 20:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QUa5ba4iNY1YFlFOcz4de6sAHj24nTw9/CXpmKZ8juw=;
        b=R8IZbI7WjbyD1o9J/a14PPlNkeiOsRPjp7xSOvxwGENT297WVc5yLaKLKDlFssfUmi
         aeNsz9j0hhQYAl4KUQszOERwiMCnafsRC9In+VQofxGgKNoXRVox6vf3OlVkv/sKKRC7
         iG7p0eLVdSBjtbQDZQSXVzhVbFJXlR6h71gVxR8YBwZAvP2/OKgfD1TUIXEpNLHwbJDn
         +p9qeOT1vpsfh8Lmo2CD+XaKVeLiDS3wEd8d8kYDimkT57l8wawP6iVjbcXoZtAXjWrH
         iFcqVFOgNRnU01RYtveBW/NMkwDdc5Xf0UkmJJXRJKQFUZV9g6ADix/ku5hQXfLxQuBd
         w/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QUa5ba4iNY1YFlFOcz4de6sAHj24nTw9/CXpmKZ8juw=;
        b=bCcqUw7jELQPrA2hZFli04WudDpFc24GAk6gbUaKfwQmaPJkPbNuHZ6/56yz6Ewhq+
         J6I9BjngyYLFNHSh4TBdubx+flCu+KIiCiYkZ9q0nCtv4XV6xdRHnPpkZAPFvL2kbvFs
         eWJiqfxBCVS0z4PQIZYSxQEdv4u/0AZh8b0TvmU2kNUMt64I+yeDrHAJtsTohFOTzm8O
         ZsoasRa76/X4jpFO+TsRmBBpCwwKhuFFnaG8xdUhyVsNWSNZTugtBC8WdQiTiXTkNdIh
         HVYsOPkj7jbc8P6KA6kfuyxbdvIZ/D5YN8RhVVO6Xn6UhDZGczRK43cY65mcFwfNBuNA
         QgyQ==
X-Gm-Message-State: AOAM532BXOpAHD/0iyOAXXVOMlOA2Kw36WeZDxOWtjViMoZSHLokUYGz
        C5g4gqDXZU5i+tPhDCQ3kUs=
X-Google-Smtp-Source: ABdhPJxZsGwrEAjbJgs3r84+DdhgH+issnXxO2MTK3/5+g+ylh2q/R5VteHBgBVvUl9plSq5OzECYA==
X-Received: by 2002:a17:902:76c1:b0:149:989d:c6e3 with SMTP id j1-20020a17090276c100b00149989dc6e3mr8361967plt.127.1640839111150;
        Wed, 29 Dec 2021 20:38:31 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.53])
        by smtp.gmail.com with ESMTPSA id g16sm22828808pfv.159.2021.12.29.20.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 20:38:30 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        stern@rowland.harvard.edu, jj251510319013@gmail.com,
        dan.carpenter@oracle.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2 0/2] usb: gadget: use after free in dev_config
Date:   Thu, 30 Dec 2021 12:38:13 +0800
Message-Id: <20211230043815.18899-1-hbh25y@gmail.com>
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

Hangyu Hua (2):
  usb: gadget: don't release an existing dev->buf
  usb: gadget: clear related members when goto fail

 drivers/usb/gadget/legacy/inode.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

-- 
2.25.1

