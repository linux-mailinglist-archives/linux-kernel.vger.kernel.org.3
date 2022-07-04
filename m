Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9215C565CAA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 19:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiGDRRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 13:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGDRRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 13:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7A602267D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656955027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dJl8ux0EZ7Jia3kKagn8kSTy589GQC3E4FjhJXlWoqY=;
        b=EkjryOXoEdBIlQ6EeCeQDnmOHdsqcnIuthHxAV+YxpPKkvrlgT9Vrux2E4gv4QUKWwtsgj
        8QD8EowdYWX6QVL2v3+2J6+upJyO1sTbQDtZPaJSmgnlhePUX+B6KT0TmC3dQqTYvx0iV3
        AbVWrppD4JRS/pgI97nfPwCZzimmPns=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-FlrNwSWQMfW30YQBZmyMsA-1; Mon, 04 Jul 2022 13:17:06 -0400
X-MC-Unique: FlrNwSWQMfW30YQBZmyMsA-1
Received: by mail-qt1-f197.google.com with SMTP id d4-20020ac86144000000b00319586f86fcso7285248qtm.16
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 10:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dJl8ux0EZ7Jia3kKagn8kSTy589GQC3E4FjhJXlWoqY=;
        b=wPnki8k+bAOHWZM7bdhxfzMcWn+tCb7HT+4OqmnzktRAVRrJ2MOmvv3m5+2Chmorih
         quqAkWzdrz+WtG6LpWUAZjGOJWmNjMkw9iOdKXIMffZDoXe6HVjGD96kRz8+XGwOjlgn
         9jc0jLUyt5J39lgxERpM26xhXv0AZRGIh/ng2rp5M5fAu5pLsxbVtAV8tNtl2n6YGhHc
         1OAcig/2Nxu8PB2h4SP9JIl/TJq4w01XwWpohDJkgAZbMuSnTxUoTjBmAPkyzlm/iwDr
         yXXREl83V0CXYcTxyrZEaR+wXJr94yMPvCCKdvnwulsDb/vRT326ujdeB5iD4/iEFbPe
         UIJg==
X-Gm-Message-State: AJIora8ciCJ95R0B/cgJwgJYfI42Fm9owepJZKriwJuePjlYdE8IdFBg
        SgdgVo2Z2FrKZxa6FRY4oo5oMlGCtkv83Qi3nGf0WBhDJUEOS4ERibIyglzWdpF4gVPaMBMEwEr
        jvhG2H6GZwzeJqb8oOYliIr5Q
X-Received: by 2002:a05:622a:1387:b0:31d:40ca:e0d3 with SMTP id o7-20020a05622a138700b0031d40cae0d3mr9228541qtk.121.1656955025824;
        Mon, 04 Jul 2022 10:17:05 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tdqvbbkgywL0gMPuv2TluFvxiJijTYr7j5CCBab+M/VZT3kqBA0aJume41Clg+XZJh/b2cbQ==
X-Received: by 2002:a05:622a:1387:b0:31d:40ca:e0d3 with SMTP id o7-20020a05622a138700b0031d40cae0d3mr9228526qtk.121.1656955025578;
        Mon, 04 Jul 2022 10:17:05 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-206.retail.telecomitalia.it. [79.46.200.206])
        by smtp.gmail.com with ESMTPSA id o16-20020a05620a2a1000b006a68fdc2d18sm21656078qkp.130.2022.07.04.10.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 10:17:04 -0700 (PDT)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
Date:   Mon,  4 Jul 2022 19:16:55 +0200
Message-Id: <20220704171701.127665-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 3 patches fix various problems I have encountered with
virtio_test (they may go without this series, but I included to allow you
to test the series).

Patch 4 is in preparation of patch 5, moving the feature negotiation when
we initialize the device.

Patch 5 add the support of vhost-vdpa in virtio_test

Patch 6 add vdpa_test.ko based on vdpa_sim_test.c, so we can reuse most of
the code coming from the vdpa_sim framework.

I tested in this way:

  $ modprobe vdpa_sim
  $ modprobe vhost-vdpa

  # load the vdpasim_test device
  $ insmod vdpa_test.ko

  # create a new vdpasim_test device
  $ vdpa dev add mgmtdev vdpasim_test name dev0

  # run the test using the /dev/vhost-vdpa-0 device
  $ ./virtio_test --vdpa /dev/vhost-vdpa-0
  spurious wakeups: 0x0 started=0x100000 completed=0x100000

Comments and suggestions are welcome :-)

Thanks,
Stefano

Stefano Garzarella (6):
  tools/virtio: fix build
  vhost_test: add $(srctree) on the included path
  virtio_test: call __virtio_unbreak_device
  tools/virtio: move feature negotiation in vdev_info_init()
  virtio_test: support vhost-vdpa device
  vdpasim: add vdpa_sim_test module

 tools/virtio/linux/kernel.h           |   2 +-
 tools/virtio/linux/virtio.h           |   2 +
 tools/virtio/linux/vringh.h           |   1 +
 drivers/vdpa/vdpa_sim/vdpa_sim_test.c | 203 ++++++++++++++++++++++++++
 tools/virtio/vdpa_test/vdpa_test.c    |   1 +
 tools/virtio/virtio_test.c            | 131 ++++++++++++++---
 tools/virtio/Makefile                 |  32 +++-
 tools/virtio/vdpa_test/Makefile       |   3 +
 tools/virtio/vhost_test/Makefile      |   2 +-
 9 files changed, 350 insertions(+), 27 deletions(-)
 create mode 100644 drivers/vdpa/vdpa_sim/vdpa_sim_test.c
 create mode 100644 tools/virtio/vdpa_test/vdpa_test.c
 create mode 100644 tools/virtio/vdpa_test/Makefile

-- 
2.36.1

