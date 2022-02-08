Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE164AE080
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353278AbiBHSPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384720AbiBHSPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:15:45 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150ABC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:15:44 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z19so34849661lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 10:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubojHHrasWsqhS6qr/dbMNAqWg0S4l0W2lxdG9od6YA=;
        b=7UmIQ9z5CVY4nqjy1zfqHmy+itjDZKx6BB61jiQKXprE09I4TN+opuJCV0itXXHB6E
         4q4L7vf1nz8jfx3Zw2r0+PaePFmZFUnhdn8aAobd4I3TnJZa7rm88wwbanBWNjPqiY0b
         gy1tLj1MKefoY88SmyTtwXJwsKSHGhA+t1JDChEd6+LTE7F0LyVVFhzGVIxBB2BWBjND
         435WBDpWdFtnwyRORG+wXCj4Gxkqfz35P7VKT0e/lLWY5D1+nguQThqh1Y9oflq6pcT8
         gmaZlYkg+SLGBG3soegU/pCCO0fQ69Vq4hmDuUFCsy3CGmJGrB0dcwdI/C/IuI7U2A8P
         Wfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ubojHHrasWsqhS6qr/dbMNAqWg0S4l0W2lxdG9od6YA=;
        b=IO7JX2hwxAF25DsHUPhZprNP4JTKHYMF90Ap9ETCfuBFS753ZuVGb50RGmw0rULydx
         ahBz9VTFObN+OHUuwRr1+mniVFgEZYyrLi3knJsQuqztfxC6Ju03JpF6U++nVYH4M/mI
         gkivn2XHJzbpuWM/uvtqNVQBDxGz+b/a6QTHckek/GNq8e6OJpw1rnrGySdRL5Trin+W
         9rOsWtClf1PLS3/WQlxQN55Si+Yl8oHR0PPOjd55c2PeOsAlGcabusvYcGPHUd+chLcv
         yyfXePxDd00WLOI64AZJvxgwZTcgPDd6JeHvFJ2PfsucmLEGNRANBsYdPQM5M9YYiYX7
         iLAA==
X-Gm-Message-State: AOAM530hyAcshmpJwdHR9V8EmalGbLaYV4KjTpuDlYSz3WNjYwxfhCyP
        JjWvMk7RxrOPDbujAoSpRGqLNA==
X-Google-Smtp-Source: ABdhPJwzqbI+mN9KcrTVXPsPB3UD7i65WJfgtYokQzM0tLnA7+rYbrnDMW8UVrsv6pAndRL6TU+ZaA==
X-Received: by 2002:a05:6512:2821:: with SMTP id cf33mr3740205lfb.37.1644344142449;
        Tue, 08 Feb 2022 10:15:42 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id p16sm2125082ljc.86.2022.02.08.10.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 10:15:41 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v3 0/4] RSS support for VirtioNet.
Date:   Tue,  8 Feb 2022 20:15:06 +0200
Message-Id: <20220208181510.787069-1-andrew@daynix.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes since v2:
* Fixed issue with calculating padded header length.
  During review/tests, there was found an issue that
  will crash the kernel if VIRTIO_NET_F_MRG_RXBUF
  was not set. (thx to Jason Wang <jasowang@redhat.com>)
* Refactored the code according to review.

Changes since v1:
* Refactored virtnet_set_hashflow.
* Refactored virtio_net_ctrl_rss.
* Moved hunks between patches a bit.

Changes since rfc:
* Code refactored.
* Patches reformatted.
* Added feature validation.

Andrew Melnychenko (4):
  drivers/net/virtio_net: Fixed padded vheader to use v1 with hash.
  drivers/net/virtio_net: Added basic RSS support.
  drivers/net/virtio_net: Added RSS hash report.
  drivers/net/virtio_net: Added RSS hash report control.

 drivers/net/virtio_net.c | 382 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 369 insertions(+), 13 deletions(-)

-- 
2.34.1

