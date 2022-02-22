Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EC34BF7A6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 13:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiBVMCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 07:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiBVMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 07:02:18 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBAE22BCA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:01:33 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 29so9427713ljv.10
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FzYNR2sKDetapYfGLWWudbc7yc1Ktg/KaORx1hjvCVQ=;
        b=4aO75Z6ibjpnvJtJm9vFf+C1Cs8xY5swKEEbD5ADFmeDBZ6zj+gi1xD8nhzvxm78x1
         pBsZIM5BgIRrjJtXenkK9q7vGokX7yfmdFjB6DQlzNpsiRZLTWVYw+sWJQ6wO3xKEDvH
         ILje7SS0I5xpWYbhZDKr6dlzbhdgWZSQIRmcZ1geG/Z8CCwAfSq+4mJLZrZfLzFxF7+K
         64yt+nUdpOhBEbCUu593jPu5Ryx0kfmZn011uvrNgu5THWhISG/bBtMYISGLc4DPZwSh
         sNf5GSI+4f0HuEN/4rAgBxLwls+SxGt1Ypj9VuI+ZNb9/Kd7VP2agqayJ/jLUsPIjg88
         oQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FzYNR2sKDetapYfGLWWudbc7yc1Ktg/KaORx1hjvCVQ=;
        b=19P7TBoLqfMOloLPkJxvWa2xsFxUgydkEFC/mYGXbP2NZrWz8NHkR9pu3II6LE9g8N
         viM851sqGaJxaIHnvd6+hnCnoYlynBZuwKMNPaaN8V/RwP7DImf9TmU9hYmqnjDgqYv+
         5Gf+/3FKhG/efEMY6+RbjFh35Lcte2ZDC9YAzQRUZybooKEUeUj83VguRwTvWiGPSx0J
         LJKoBwM+48FivKrodJiHWyboZDznXJPxgXkziDOWJZugsF1v9Xdt0QIVW330J2XZMkyI
         UxCncFhKYE00Y7w5NexQzA//iuWpKYLPkEqXZbVFowHZrEB/LbAfoMtNNLeyEZO5wyhW
         yzcg==
X-Gm-Message-State: AOAM530fiUivSbql41+9D1Mtslz3ZbKEpifVJPJh9mtpYeNF7v75vvuW
        +PxTsvlHnmfgpySHUb5Mpcc4mQ==
X-Google-Smtp-Source: ABdhPJwGQOfNgPwytiF1r2dQWgVgu6SzGM3zrIl9c3Z1NfSqcUk5K2eYcvGZE8RkVljl2SCy4STEKQ==
X-Received: by 2002:a2e:978f:0:b0:246:360:6cff with SMTP id y15-20020a2e978f000000b0024603606cffmr17319826lji.106.1645531291571;
        Tue, 22 Feb 2022 04:01:31 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
        by smtp.gmail.com with ESMTPSA id v29sm1664024ljv.72.2022.02.22.04.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 04:01:31 -0800 (PST)
From:   Andrew Melnychenko <andrew@daynix.com>
To:     netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        jasowang@redhat.com, mst@redhat.com
Cc:     yan@daynix.com, yuri.benditovich@daynix.com
Subject: [PATCH v4 0/4] RSS support for VirtioNet.
Date:   Tue, 22 Feb 2022 14:00:50 +0200
Message-Id: <20220222120054.400208-1-andrew@daynix.com>
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

Changes since v3:
* Moved hunks a bit.
* Added indirection table zero size check
  for hash report only feature.
* Added virtio_skb_set_hash() helper instead of in-place routine.

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

 drivers/net/virtio_net.c | 389 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 376 insertions(+), 13 deletions(-)

-- 
2.34.1

