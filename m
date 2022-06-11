Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA45472B6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 09:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbiFKHtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 03:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFKHs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 03:48:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B485B2937F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 00:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654933736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=qyk9g0ELjVAhO4lsyGp9C9P5YSNZEspWcN+xPCYvwJY=;
        b=bj+MYL2j5TwpOUPlKRSlCp585JtnbDXvqih5LqBen+jEtrZtPIYloCGHrZkZqsGVV63GSC
        +NyCpgBW+2XqBHYZ99vKieluSQn4lPCAjA35l63dIKuYWJNk2qvmqBuU7heifUTJdnnrE9
        FJIy7Q0cPMoxhaIfcGR1/aAHqjPaIFo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-46-g4ZpthJKOzC_y10Pr393zQ-1; Sat, 11 Jun 2022 03:48:54 -0400
X-MC-Unique: g4ZpthJKOzC_y10Pr393zQ-1
Received: by mail-ed1-f69.google.com with SMTP id g8-20020a056402090800b00433940d207eso974915edz.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 00:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qyk9g0ELjVAhO4lsyGp9C9P5YSNZEspWcN+xPCYvwJY=;
        b=ciny1xendt2HKN3qLNdI7OzxVQB/Km12y+Oj7FySMlqZFZaEAaaAKAJOWWmVFUfIqe
         LzlY7QGSil9yLUuIO1oMQ9JMXCAMuXvDkp6OZAWMNjiJqlZcb+8DvQuI+DsBCJPc7prm
         CIniPu4872dEpOufEEs9A5Aa6hwnZdP64a9IasaOBipW27f1aXbub2x99pqMM7o7D+EF
         UlTI5tb+jL8aXWN3z3cdJ8oK89LTArJkhdX5zyM4cS19IT4mGymtsfKbAtQeEqEsW88V
         GaNC6ZiRJeKBJkMmQZF80LtKwPpgJfYMHMUukx1VsEkDoiKa5xTfwmh9wEC6ex0CL9NX
         6Brw==
X-Gm-Message-State: AOAM533xAjvBO/ZdO4IsAhmTsvxMYnIjMGRR6JM1M1w2DzjSEJoWOKWb
        mLJZSKUd1xynfXnx0DiaFhGWo6ZPvi6esBvSzQzK8TQKQ53BeOyWS656U5TKuaggvPA1R7j8Pn8
        zY5cYf1sBk1aGYtMzrrGdjTMC
X-Received: by 2002:a05:6402:2553:b0:431:6e08:56de with SMTP id l19-20020a056402255300b004316e0856demr31201060edb.406.1654933733331;
        Sat, 11 Jun 2022 00:48:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwLx5bFdq30xI5P4i3ZyKGrtOytrp9e+V51+s6ADqB5Q4i9rEt7pLobi3Np6OXDutzcfAAxQ==
X-Received: by 2002:a05:6402:2553:b0:431:6e08:56de with SMTP id l19-20020a056402255300b004316e0856demr31201044edb.406.1654933733098;
        Sat, 11 Jun 2022 00:48:53 -0700 (PDT)
Received: from redhat.com ([212.116.178.142])
        by smtp.gmail.com with ESMTPSA id zj11-20020a170907338b00b006ff0fe78cb7sm664853ejb.133.2022.06.11.00.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jun 2022 00:48:52 -0700 (PDT)
Date:   Sat, 11 Jun 2022 03:48:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com, elic@nvidia.com, fam.zheng@bytedance.com,
        gautam.dawar@xilinx.com, jasowang@redhat.com,
        johannes@sipsolutions.net, liubo03@inspur.com, mst@redhat.com,
        oliver.sang@intel.com, pilgrimtao@gmail.com, si-wei.liu@oracle.com,
        stable@vger.kernel.org,
        syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com,
        vincent.whitchurch@axis.com, wangxiang@cdjrlc.com,
        xieyongji@bytedance.com
Subject: [GIT PULL] virtio,vdpa: fixes
Message-ID: <20220611034848-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to eacea844594ff338db06437806707313210d4865:

  um: virt-pci: set device ready in probe() (2022-06-10 20:38:06 -0400)

----------------------------------------------------------------
virtio,vdpa: fixes

Fixes all over the place, most notably fixes for latent
bugs in drivers that got exposed by suppressing
interrupts before DRIVER_OK, which in turn has been
done by 8b4ec69d7e09 ("virtio: harden vring IRQ").

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Bo Liu (1):
      virtio: Fix all occurences of the "the the" typo

Dan Carpenter (2):
      vdpa/mlx5: fix error code for deleting vlan
      vdpa/mlx5: clean up indenting in handle_ctrl_vlan()

Jason Wang (2):
      virtio-rng: make device ready before making request
      vdpa: make get_vq_group and set_group_asid optional

Vincent Whitchurch (1):
      um: virt-pci: set device ready in probe()

Xiang wangx (1):
      vdpa/mlx5: Fix syntax errors in comments

Xie Yongji (2):
      vringh: Fix loop descriptors check in the indirect cases
      vduse: Fix NULL pointer dereference on sysfs access

chengkaitao (1):
      virtio-mmio: fix missing put_device() when vm_cmdline_parent registration failed

 arch/um/drivers/virt-pci.c             |  7 ++++++-
 drivers/char/hw_random/virtio-rng.c    |  2 ++
 drivers/vdpa/mlx5/net/mlx5_vnet.c      |  9 +++++----
 drivers/vdpa/vdpa_user/vduse_dev.c     |  7 +++----
 drivers/vhost/vdpa.c                   |  2 ++
 drivers/vhost/vringh.c                 | 10 ++++++++--
 drivers/virtio/virtio_mmio.c           |  3 ++-
 drivers/virtio/virtio_pci_modern_dev.c |  2 +-
 include/linux/vdpa.h                   |  5 +++--
 9 files changed, 32 insertions(+), 15 deletions(-)

