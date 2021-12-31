Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C85F48255D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 18:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhLaRVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 12:21:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbhLaRVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 12:21:53 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7D3C061574;
        Fri, 31 Dec 2021 09:21:53 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id iy13so23802560pjb.5;
        Fri, 31 Dec 2021 09:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4w4iQeDLKc5AnuL3Apr/w/wwYMsHQ5AOILOZbFCrro=;
        b=SLJvd7LufoVwaX5BLu48VrkV3zBDix9v7Fqh479Lkdq9Gq4wthDdTrHbQkC6qP4zB2
         zAXbGHUDIYrNL4LApfiHxBbK6B7SrDPOcpl3vUC2W+p6iU8gPRyVdfK7kSjBrLVkomW+
         02ad6tlbRB4wlxheS8Fj9N+Qa/6GnKR5LiV4W2vic4ba1isjY2gu0lAT5KEILOdpuBJ/
         NUy9275rURg/l1NpQT/LiYsaxw2ZZYIScPtv8PD+d/fU/NbfWwRl91im2DN03jz2GT0o
         BhzFUNn0QDjwBPbdFfh6D/G1nVLOvkQyNV5LGAgv5SWDPI7TfLUomBsBAw1FAlHuFa7A
         gwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4w4iQeDLKc5AnuL3Apr/w/wwYMsHQ5AOILOZbFCrro=;
        b=ljlVl+e9BY3ytQZBxunMawatyq/lK2LFFsI/ZRiD6psAwUrXhcDvPF4eYLPiexCBtO
         Vw7pPZSi3yETX8VTxxwXazQ2f/IUCOiY3cRyhMnrf/sitC8zI07y5WMGVZDoIuxxMBFJ
         he6i08ybZyYo1M2MiPz9wWIrttnW21DhtccNBk8C2C4lbMyLYwzOAu4qVPdDiAeWokEQ
         bd6d11Utkot0zCds2JUE1ieePP93ovy9nD6qjuTL7Y8oPIs+J39Q9FHT1iqVcu4iuo+H
         yC6SRhGHsTc+WbGGwdHT4sS/a1ipkovZ8Q5gzxHRGyeCDyF33SmgGlN88QK512862uAN
         N+JA==
X-Gm-Message-State: AOAM532xDP3IYOuQY2BpiYlmNPcETAv3/0A/t8TFV0CdZVrnivoBZsim
        QuGIpv0oIetLpgZXm4R1zFQ=
X-Google-Smtp-Source: ABdhPJz2is0ABT1M3ftinqAFmT+pKqn2Qe2Kc3PipzvUcnNWEyWVF0nUCNyfOQ0cUqhAu4xnbRAITw==
X-Received: by 2002:a17:902:aa8b:b0:148:ee33:70fe with SMTP id d11-20020a170902aa8b00b00148ee3370femr36174951plr.38.1640971312940;
        Fri, 31 Dec 2021 09:21:52 -0800 (PST)
Received: from localhost.localdomain ([125.118.132.4])
        by smtp.gmail.com with ESMTPSA id k141sm30145834pfd.144.2021.12.31.09.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 09:21:52 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org, axboe@kernel.dk,
        dan.carpenter@oracle.com, jj251510319013@gmail.com,
        stern@rowland.harvard.edu
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v4 0/2] usb: gadget: use after free in dev_config
Date:   Sat,  1 Jan 2022 01:21:36 +0800
Message-Id: <20211231172138.7993-1-hbh25y@gmail.com>
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

v4:
avoid multiple unnecessary statement labels in [PATCH v4 2/2]

Hangyu Hua (2):
  usb: gadget: don't release an existing dev->buf
  usb: gadget: clear related members when goto fail

 drivers/usb/gadget/legacy/inode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

-- 
2.25.1

