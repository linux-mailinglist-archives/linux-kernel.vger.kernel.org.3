Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414C0471E77
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 00:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhLLXAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 18:00:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230128AbhLLXAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 18:00:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639350000;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=WYVQFnDIbcgI5d/vqJyK9JfPBSSPc6zKfbYcO57Li1U=;
        b=WmuhVWsO5mi80RT4m+no3isY1iJou4o3YpWQaknax9Wih1bUHUku36xax5VFio+o60zIc7
        1OGTA7llpIy1V9V4ymdA9oRteRF9FpbmNZ5nA42fn0bQH0A++73QEiJu0FpkduZ58GoFj1
        7cL4stQ+xqGrzmI1cpzkRO3SI4HcvFI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-337-j7ldPk8kM0Gu_K5lkCPIDA-1; Sun, 12 Dec 2021 17:59:59 -0500
X-MC-Unique: j7ldPk8kM0Gu_K5lkCPIDA-1
Received: by mail-wm1-f71.google.com with SMTP id o17-20020a05600c511100b00343141e2a16so2741995wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 14:59:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=WYVQFnDIbcgI5d/vqJyK9JfPBSSPc6zKfbYcO57Li1U=;
        b=U44T4xKF3+hZm6XkrfTRpBH65FRisQK7FfmV1M2AIPWaUInPsugkz2eq5vnXeqq8gD
         Up56/6uCFt12UlrpKDzY+lAUnHNvX7TGoN3vbbC9FaJ99F4Bg3gbFjPSWqNXtIWz89Fn
         7eSBNWx3jblMDhEoJUPOEOeoERblJiu63hntt8v1u6Ff4dilsIkipl8ppwcoeCFgOldn
         YGoVrTKGB+qijxoIoZrSLJPr5HOFwzB+Sab6KNqJUj3BUrN5SRO2GmYtdRHq9Lqv13It
         9MkXULsPqXehkKeYfi4OhsiAf1A8fGgcWaNF6i9+2FaB2oZsb42af1ukl1GMF6N6jecR
         ajuQ==
X-Gm-Message-State: AOAM530AxzC9AzOtnc2dU2F8q9vCuJfmV4SITi586TVsqsJ2sWHYjk51
        BhQNcirhVFeaw1LdvjZMz7FBR1P66o9M/3MBywvTf9iIJ5H6GA+gTJId2zCgt0vZLK7KX5uMuiG
        5eHoCjrS53mD1XQaO0OqSKGBv
X-Received: by 2002:a05:600c:1987:: with SMTP id t7mr32456847wmq.24.1639349998383;
        Sun, 12 Dec 2021 14:59:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx2bTppYN2huiK2nylUvg6FCr00HLDzfg04TlPUjrDVfn+bIvC2GBhAeUTenJbfKS0A/G9aQQ==
X-Received: by 2002:a05:600c:1987:: with SMTP id t7mr32456804wmq.24.1639349998099;
        Sun, 12 Dec 2021 14:59:58 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:107e:eefb:294:6ac8:eff6:22df])
        by smtp.gmail.com with ESMTPSA id bd18sm5203284wmb.43.2021.12.12.14.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 14:59:57 -0800 (PST)
Date:   Sun, 12 Dec 2021 17:59:51 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, dan.carpenter@oracle.com, hch@lst.de,
        jasowang@redhat.com, jroedel@suse.de, konrad.wilk@oracle.com,
        lkp@intel.com, maz@kernel.org, mst@redhat.com, parav@nvidia.com,
        qperret@google.com, robin.murphy@arm.com, stable@vger.kernel.org,
        steven.price@arm.com, suzuki.poulose@arm.com, wei.w.wang@intel.com,
        will@kernel.org, xieyongji@bytedance.com
Subject: [GIT PULL] vhost: cleanups and fixes
Message-ID: <20211212175951-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to bb47620be322c5e9e372536cb6b54e17b3a00258:

  vdpa: Consider device id larger than 31 (2021-12-08 15:41:50 -0500)

----------------------------------------------------------------
virtio,vdpa: bugfixes

Misc bugfixes.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Arnd Bergmann (1):
      virtio: always enter drivers/virtio/

Dan Carpenter (3):
      vduse: fix memory corruption in vduse_dev_ioctl()
      vdpa: check that offsets are within bounds
      vduse: check that offset is within bounds in get_config()

Parav Pandit (1):
      vdpa: Consider device id larger than 31

Wei Wang (1):
      virtio/vsock: fix the transport to work with VMADDR_CID_ANY

Will Deacon (1):
      virtio_ring: Fix querying of maximum DMA mapping size for virtio device

 drivers/Makefile                        | 3 +--
 drivers/vdpa/vdpa.c                     | 3 ++-
 drivers/vdpa/vdpa_user/vduse_dev.c      | 6 ++++--
 drivers/vhost/vdpa.c                    | 2 +-
 drivers/virtio/virtio_ring.c            | 2 +-
 net/vmw_vsock/virtio_transport_common.c | 3 ++-
 6 files changed, 11 insertions(+), 8 deletions(-)

