Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9990E4E4E90
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242908AbiCWIve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242896AbiCWIvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:51:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAFBA73078
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648025402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=C46ALa3Wn3pwhctoVHx8CVmLq4tfYoG9vF9MoJZBSbM=;
        b=Fw+1RxrHlGQ4nlVwD7lCm6Ime8c2e/Bdd9lSAfxlu6qFfh2Gr2+f5zEKpP56/DVihakG/Q
        2VyTlRcpdW55/HAWZ3Pj8eg9xqXseU+oP+D9kQPT+Tdnn7pozapODn5ZCzboHfzNUMrXv4
        dBpdC4OV7hhfnxK04pwnOL8VmtbpDQ8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-365-JD5h84ePPc2_FIbhpO8ocQ-1; Wed, 23 Mar 2022 04:50:00 -0400
X-MC-Unique: JD5h84ePPc2_FIbhpO8ocQ-1
Received: by mail-qv1-f71.google.com with SMTP id cl19-20020a05621404f300b0044103143211so758269qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 01:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=C46ALa3Wn3pwhctoVHx8CVmLq4tfYoG9vF9MoJZBSbM=;
        b=Yna+Drp9rsv9xcCCdQgkgxFSvxEEmYdDlRWNHwaoe5O/Cyz7HW4TJPcqOPuOmhK+3J
         mcZ5vlRvtnMmun+t3X+0t2gibPMGbF33ZzBHh4ZXvcu7uyRHFu7OOsFpNd77TQR5RK6r
         Uq9/SKnr9Ssr7pPn8jlAyh4DX6z0/zPDQY1Qfw+xE4Y3Vb6oQRqEdpg85jwOZxyxmev2
         Z22HRyjtF+3prrQwr9FE2GN69G/LKyiC+yNMYKDsQ2YoO34EN/Kf1QIG4RM4MMxJVakj
         YmeVRVOAJhlUSPnSO9HxpZR+n9xuya6jWUfgz5AzWNyGV/zMKM5Lw/D9V6EkMQi+u9Gk
         VliA==
X-Gm-Message-State: AOAM530XDpNw07Xn64JbBpwxHBpTJKN7PQE4Van069F0cN5eXeFLG0UB
        Wyxi2SI3VP6IoUm+lwNfR5aCgiT2mgKPj0gyBDmkDG0E0/8lGdldiuV3/2DEWeh7V6EteAD2B29
        8jGgcn9OLGfmEBz715qkPx5pT
X-Received: by 2002:a05:622a:107:b0:2e1:d655:cc4c with SMTP id u7-20020a05622a010700b002e1d655cc4cmr23525895qtw.669.1648025400247;
        Wed, 23 Mar 2022 01:50:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzfE8/OMwCCgqFxQqE3tKOs0mFQYucCfXdxmrRXsheQTGYlj3H8WZkZdUr2Tkkn7dzVMymHwA==
X-Received: by 2002:a05:622a:107:b0:2e1:d655:cc4c with SMTP id u7-20020a05622a010700b002e1d655cc4cmr23525876qtw.669.1648025399984;
        Wed, 23 Mar 2022 01:49:59 -0700 (PDT)
Received: from step1.redhat.com (host-87-12-25-114.business.telecomitalia.it. [87.12.25.114])
        by smtp.gmail.com with ESMTPSA id j188-20020a3755c5000000b0067d1c76a09fsm10640609qkb.74.2022.03.23.01.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 01:49:59 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Arseny Krasnov <arseny.krasnov@kaspersky.com>,
        "David S. Miller" <davem@davemloft.net>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Asias He <asias@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 0/3] vsock/virtio: enable VQs early on probe and finish the setup before using them
Date:   Wed, 23 Mar 2022 09:49:51 +0100
Message-Id: <20220323084954.11769-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.35.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch fixes a virtio-spec violation. The other two patches
complete the driver configuration before using the VQs in the probe.

The patch order should simplify backporting in stable branches.

v2:
- patch 1 is not changed from v1
- added 2 patches to complete the driver configuration before using the
  VQs in the probe [MST]

v1: https://lore.kernel.org/netdev/20220322103823.83411-1-sgarzare@redhat.com/

Stefano Garzarella (3):
  vsock/virtio: enable VQs early on probe
  vsock/virtio: initialize vdev->priv before using VQs
  vsock/virtio: read the negotiated features before using VQs

 net/vmw_vsock/virtio_transport.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

-- 
2.35.1

