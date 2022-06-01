Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0389F53AFC0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 00:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiFAVbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 17:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiFAVbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 17:31:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86EE419EC12
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 14:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654119092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o5bHj6wRHQJMVaUw4bU2o6OC+GlCc7ot9HM5HjXoiho=;
        b=fsPFf85mDJDpE2QB0rm/9Ca6ma6/uMKUd1120FY/rZG6XAQH4IuFSWX2HHACV6aF3dYlfY
        L/TL6tZBHomXUtHpdncQM+O3wmVMIjgqyvsCOgvCKRq3gKXW1hhntNsfn8dHB9DxSUo6mw
        q+d2GMYyEAz+omXNgrVebx+HKMYJHRE=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-4AXxrMBBO4OltI5UWEw-SQ-1; Wed, 01 Jun 2022 17:31:31 -0400
X-MC-Unique: 4AXxrMBBO4OltI5UWEw-SQ-1
Received: by mail-il1-f198.google.com with SMTP id y18-20020a927d12000000b002d3dd2a5d53so1329305ilc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 14:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=o5bHj6wRHQJMVaUw4bU2o6OC+GlCc7ot9HM5HjXoiho=;
        b=LYoXTlhA+rMJjfnQrRd4GPgbegkW6wb5Rtq5fbktKJyh+YJNaBJM3ZxzyPq6ozyd+4
         D3Wv7SEiX5M6QGpy8+bjgU4xrEq+ObaUCPIB2yvp7nf5xPVzLUvwtMUO22t6eZb84nCi
         sIQ6c95SJv7uI4UiIe729g+KFv5q7IBOQPv9M6NAQHXUSZzrYOkkpEaM7po4uvMuP5p+
         i6R7sh3QDugWuojRMBhOr9vDWUcG6bgtoE6HnfHvRpIrHXWPSU7xkdM846Qv/3K2gXQn
         dA/JP+HCIDd0bJsmkAd7S9ertamwkCJVvZhyCYwzK0hEtdt0vXTAfeFXwJtQ+q3bQe7N
         uk8A==
X-Gm-Message-State: AOAM5303fCknK6lamS2CJIs7fEW+YRGJJr41jyuCt6+zeqtV/+/nUA1A
        iaIDBhJwjCsJW3Wx2p4OkWm/Fl5WTyNp+cYwR/43kyR3qbqb5r4ZuTeeIjT5bGcX9V8skIwUJ3Z
        aQQQ51pjzBvWpfrRc8wKZ+NHR
X-Received: by 2002:a92:de51:0:b0:2d3:9fd9:f86a with SMTP id e17-20020a92de51000000b002d39fd9f86amr1327201ilr.33.1654119090516;
        Wed, 01 Jun 2022 14:31:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrrMUkUP8u+fo9yM49u0vjRdpRZGsFm95jBt1IcCuJsuVX5RRlbN0yaJ4ktSsf9skx7c8CZw==
X-Received: by 2002:a92:de51:0:b0:2d3:9fd9:f86a with SMTP id e17-20020a92de51000000b002d39fd9f86amr1327189ilr.33.1654119090263;
        Wed, 01 Jun 2022 14:31:30 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i13-20020a056e020d8d00b002d1a5afa79bsm107765ilj.86.2022.06.01.14.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 14:31:29 -0700 (PDT)
Date:   Wed, 1 Jun 2022 15:31:29 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [GIT PULL] VFIO updates for v5.19-rc1
Message-ID: <20220601153129.09281cf3.alex.williamson@redhat.com>
In-Reply-To: <CAHk-=wi9QJsTw-Ob5z8-ioaHqzOXQd3qqUfOd3Meyq-eXM5kMg@mail.gmail.com>
References: <20220601111128.7bf85da0.alex.williamson@redhat.com>
        <CAHk-=wi9QJsTw-Ob5z8-ioaHqzOXQd3qqUfOd3Meyq-eXM5kMg@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jun 2022 13:57:52 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Wed, Jun 1, 2022 at 10:11 AM Alex Williamson
> <alex.williamson@redhat.com> wrote:
> >
> > I'm not sure where git pull-request is getting the diffstat below, the
> > diff of the actual merge of this against mainline looks far less scary.
> > If I've botched something, please let me know.  
> 
> It's all normal, and due to you having merges in your tree and
> multiple merge bases.
> 
> See
> 
>     Documentation/maintainer/messy-diffstat.rst
> 
> for details (yay, Jonathan scrounged together docs so that I don't end
> up having to write a long email explanation any more, and there are
> links to some of my previous explanations on lore).
> 
> That also has a suggested remedy, ie just do a temporary merge and use
> the diffstat from that one instead.

Ok, so I should have gone the one step further than I did and replaced
the diffstat from pull-request with the one from my local test merge,
which would have looked like this:

 Documentation/driver-api/vfio-mediated-device.rst |   4 +-
 drivers/gpu/drm/i915/gvt/gtt.c                    |   4 +-
 drivers/gpu/drm/i915/gvt/gvt.h                    |   8 +-
 drivers/gpu/drm/i915/gvt/kvmgt.c                  | 115 +---
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c   |  65 +-
 drivers/s390/cio/vfio_ccw_cp.c                    |  47 +-
 drivers/s390/cio/vfio_ccw_cp.h                    |   4 +-
 drivers/s390/cio/vfio_ccw_fsm.c                   |   3 +-
 drivers/s390/cio/vfio_ccw_ops.c                   |   7 +-
 drivers/s390/crypto/vfio_ap_ops.c                 |  50 +-
 drivers/s390/crypto/vfio_ap_private.h             |   3 -
 drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c    |  16 +-
 drivers/vfio/pci/mlx5/cmd.c                       | 236 +++++--
 drivers/vfio/pci/mlx5/cmd.h                       |  52 +-
 drivers/vfio/pci/mlx5/main.c                      | 136 ++--
 drivers/vfio/pci/vfio_pci.c                       |   6 +-
 drivers/vfio/pci/vfio_pci_config.c                |  56 +-
 drivers/vfio/pci/vfio_pci_core.c                  | 254 ++++---
 drivers/vfio/vfio.c                               | 781 ++++++++--------------
 include/linux/mlx5/driver.h                       |  12 +
 include/linux/vfio.h                              |  44 +-
 include/linux/vfio_pci_core.h                     |   3 +-
 include/uapi/linux/vfio.h                         |   4 +-
 virt/kvm/vfio.c                                   | 329 ++++-----
 24 files changed, 1095 insertions(+), 1144 deletions(-)

> But I can also re-create that messy diffstat (and thus verify that
> what you sent me matches what I got) here locally too.
> 
> So while the diffstat is messy and not very useful for a "this is what
> changed" angle (because it has a lot of other changes mixed in), even
> that messy diffstat is actually useful for my secondary reason, namely
> as a verification that yes, I got what you were trying to send and
> just didn't document very clearly because of those multiple merge
> bases.
> 
> I can (and do) also check the shortlog, since the actual log doesn't
> have any issues with merges, it's only "diff" that needs a single
> well-defined <start,end> tuple.

Thanks, Linus.  Replacing the pull-request diffstat didn't feel quite
right, but I'll do that next time I get a crazy listing.  Thanks,

Alex

