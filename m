Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8349D488C70
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 22:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbiAIVHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 16:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiAIVHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 16:07:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2305C06173F
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 13:07:16 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id g11so37522678lfu.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jan 2022 13:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esg4bn7G0jMIkn6seqDEuQvZNEfKaqIXGyIwMWcVDh0=;
        b=B1de/dpBwPvfubE+v3OaTkKnDg55HGFm13nmRzKKZ4yE9ozwtfZOAkNGm4dzpB5j9c
         1DCpFubLzTK+G20mk26Z2odim8dMS2HWjpzQ6pmPUV5mGeuwgYPhIC+jN7YCykPe36UF
         qIJNSMdz7AhP8MVNWPr0qK6JvWnA7kWUROWTwl5SHoBHabURvVNETBRTXTiBgwKki1cV
         LqBsjPMxkFHhySkGCw6nvq48vLOnqkJLxThjAW1EtNbp5za3Hwh9t3LZFE3lSuxzzHjZ
         7z1wNYfglyK3+bsSgHVPtTHHkTNliWt60z3dXX1S+8AFLUlpjfRJOqU5v9kS21Cqmwxn
         peTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=esg4bn7G0jMIkn6seqDEuQvZNEfKaqIXGyIwMWcVDh0=;
        b=fVzJMG8n5DwPgkY0uGXlXyMRaFtvqjZHKIumqKlXlVyDRUfOh+mAQRU81x49CgI7sQ
         IQfeBE3mrlRYet8CAUz1BoNUzBN7xfOyyUnrkmjwN3W6ZKZ/zFxmNBNxFPdh8PVeoskp
         k8xDf+n/njXJXopq0YcYkv/Bs5zRVCLbNBP43LZtRdbJL5i0pdMXydIR0LKFJGf3kcfi
         BeIWDLMrghdQYjdxlQosAzSKAPlN9728x6snjlkrEsgsJzfD/WITKUBGxaCA2i46PsMD
         FQTAROXP2dzalo+9e3Lm03DG0eJ+P30Zd36TZV9d8bLi0fOeS4yopYaqDxwY8esv5BXP
         hdHA==
X-Gm-Message-State: AOAM532tRGEetr0Ft7+bkbbAdDglVmmH/oKrZqVkWC0/FUpluYkVeTXY
        6RLAn5FgfdtRaB5YLxjKtx/E/A==
X-Google-Smtp-Source: ABdhPJxH3Js0nW5RBZ54Ll58iBo6WDg8zPSOgnp1ipujtGCBK7qTeTiBQQjXzcujKxks1yxE5fCT/w==
X-Received: by 2002:a2e:b907:: with SMTP id b7mr46119133ljb.167.1641762435212;
        Sun, 09 Jan 2022 13:07:15 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id p17sm766129lfu.233.2022.01.09.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jan 2022 13:07:14 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH 0/4] RSS support for VirtioNet.
Date:   Sun,  9 Jan 2022 23:06:55 +0200
Message-Id: <20220109210659.2866740-1-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio-net supports "hardware" RSS with toeplitz key.
Also, it allows receiving calculated hash in vheader
that may be used with RPS.
Added ethtools callbacks to manipulate RSS.

Technically hash calculation may be set only for
SRC+DST and SRC+DST+PORTSRC+PORTDST hashflows.
The completely disabling hash calculation for TCP or UDP
would disable hash calculation for IP.

RSS/RXHASH is disabled by default.

Changes since rfc:
* code refactored
* patches reformatted
* added feature validation

Andrew Melnychenko (4):
  drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report.
  drivers/net/virtio_net: Added RSS hash report control.

 drivers/net/virtio_net.c | 404 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 390 insertions(+), 14 deletions(-)

-- 
2.34.1

