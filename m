Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D6B587259
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 22:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234390AbiHAUbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiHAUbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 16:31:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8482A423;
        Mon,  1 Aug 2022 13:31:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 789F160FDA;
        Mon,  1 Aug 2022 20:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F11C433C1;
        Mon,  1 Aug 2022 20:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659385892;
        bh=B66H8spKic1Gh5ozNhXzWmq4IeBfOMracgjyxFL3DoM=;
        h=Date:From:To:Cc:Subject:From;
        b=ooXYHh555o/Wx0aZYQ24ocY8wS90+F6phk1WM9A1ZK+VvTua1y2eyHOICkHSH+FLu
         Wqzj8EvmWkoNd0ZyKaA+RWv+wss1ohXQYnI+jWQTdGRsDLO9my3DXDd/213GUHOwnt
         ga6Py/NfRZFVQR49LkyEYkuA1CD0AVR8V+vKQ9kWIRHtKDAyD9em3Asq3/z6VkrGD1
         lZAsurDcFIe0q9+BAsPxg3h+P/ju00SAKJksbNLJt6l7GzzRd+UrZd+uMcY00g6Lwg
         75SUvtAquEOVcdXm7lv5XFqo9N313ai4DK1fEl8Bm7/J2dkHuBTruOCtoduhJ+UvZo
         Kma6VhAwPJ3hQ==
Date:   Mon, 1 Aug 2022 15:31:28 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] flexible-array transformations in UAPI for 6.0-rc1
Message-ID: <Yug4IJHugXBzPWFH@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b13baccc3850ca8b8cccbf8ed9912dbaa0fdf7f3:

  Linux 5.19-rc2 (2022-06-12 16:11:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flexible-array-transformations-UAPI-6.0-rc1

for you to fetch changes up to 94dfc73e7cf4a31da66b8843f0b9283ddd6b8381:

  treewide: uapi: Replace zero-length arrays with flexible-array members (2022-06-28 21:26:05 +0200)

----------------------------------------------------------------
flexible-array transformations in UAPI for 6.0-rc1

Hi Linus,

Please, pull the following treewide patch that replaces zero-length arrays
with flexible-array members in UAPI. This patch has been baking in
linux-next for 5 weeks now.

-fstrict-flex-arrays=3 is coming and we need to land these changes
to prevent issues like these in the short future:

../fs/minix/dir.c:337:3: warning: 'strcpy' will always overflow; destination buffer has size 0,
but the source string has length 2 (including NUL byte) [-Wfortify-source]
		strcpy(de3->name, ".");
		^

Since these are all [0] to [] changes, the risk to UAPI is nearly zero. If
this breaks anything, we can use a union with a new member name.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836

Thanks
--
Gustavo

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      treewide: uapi: Replace zero-length arrays with flexible-array members

 arch/m68k/include/uapi/asm/bootinfo.h           |  4 +-
 arch/mips/include/uapi/asm/ucontext.h           |  2 +-
 arch/s390/include/uapi/asm/hwctrset.h           |  6 +--
 arch/x86/include/uapi/asm/bootparam.h           |  2 +-
 arch/x86/include/uapi/asm/kvm.h                 | 12 ++---
 include/uapi/drm/i915_drm.h                     |  6 +--
 include/uapi/linux/blkzoned.h                   |  2 +-
 include/uapi/linux/bpf.h                        |  2 +-
 include/uapi/linux/btrfs.h                      | 10 ++--
 include/uapi/linux/btrfs_tree.h                 |  2 +-
 include/uapi/linux/can/bcm.h                    |  2 +-
 include/uapi/linux/connector.h                  |  2 +-
 include/uapi/linux/cycx_cfm.h                   |  2 +-
 include/uapi/linux/dm-ioctl.h                   |  8 +--
 include/uapi/linux/dm-log-userspace.h           |  2 +-
 include/uapi/linux/ethtool.h                    | 28 +++++-----
 include/uapi/linux/fanotify.h                   |  2 +-
 include/uapi/linux/fiemap.h                     |  2 +-
 include/uapi/linux/firewire-cdev.h              | 12 ++---
 include/uapi/linux/fs.h                         |  2 +-
 include/uapi/linux/if_alg.h                     |  2 +-
 include/uapi/linux/if_arcnet.h                  |  6 +--
 include/uapi/linux/if_pppox.h                   |  4 +-
 include/uapi/linux/if_tun.h                     |  2 +-
 include/uapi/linux/igmp.h                       |  6 +--
 include/uapi/linux/inet_diag.h                  |  2 +-
 include/uapi/linux/inotify.h                    |  2 +-
 include/uapi/linux/ip.h                         |  4 +-
 include/uapi/linux/ip_vs.h                      |  4 +-
 include/uapi/linux/iso_fs.h                     |  4 +-
 include/uapi/linux/jffs2.h                      |  8 +--
 include/uapi/linux/kcov.h                       |  2 +-
 include/uapi/linux/kvm.h                        |  8 +--
 include/uapi/linux/minix_fs.h                   |  4 +-
 include/uapi/linux/mmc/ioctl.h                  |  2 +-
 include/uapi/linux/ndctl.h                      | 10 ++--
 include/uapi/linux/net_dropmon.h                |  4 +-
 include/uapi/linux/netfilter/x_tables.h         |  4 +-
 include/uapi/linux/netfilter_arp/arp_tables.h   |  6 +--
 include/uapi/linux/netfilter_bridge/ebt_among.h |  2 +-
 include/uapi/linux/netfilter_ipv4/ip_tables.h   |  6 +--
 include/uapi/linux/netfilter_ipv6/ip6_tables.h  |  4 +-
 include/uapi/linux/perf_event.h                 |  2 +-
 include/uapi/linux/pkt_cls.h                    |  4 +-
 include/uapi/linux/raid/md_p.h                  |  2 +-
 include/uapi/linux/random.h                     |  2 +-
 include/uapi/linux/romfs_fs.h                   |  4 +-
 include/uapi/linux/rtnetlink.h                  |  2 +-
 include/uapi/linux/sctp.h                       | 10 ++--
 include/uapi/linux/seg6.h                       |  2 +-
 include/uapi/linux/seg6_iptunnel.h              |  2 +-
 include/uapi/linux/stm.h                        |  2 +-
 include/uapi/linux/target_core_user.h           |  2 +-
 include/uapi/linux/usb/audio.h                  |  2 +-
 include/uapi/linux/usb/cdc.h                    |  6 +--
 include/uapi/linux/usb/ch9.h                    |  2 +-
 include/uapi/linux/usb/raw_gadget.h             |  4 +-
 include/uapi/linux/usbdevice_fs.h               |  4 +-
 include/uapi/linux/vhost_types.h                |  4 +-
 include/uapi/linux/virtio_9p.h                  |  2 +-
 include/uapi/linux/xfrm.h                       | 10 ++--
 include/uapi/rdma/hfi/hfi1_user.h               |  2 +-
 include/uapi/rdma/ib_user_verbs.h               | 72 ++++++++++++-------------
 include/uapi/rdma/rdma_user_cm.h                |  2 +-
 include/uapi/rdma/rdma_user_ioctl_cmds.h        |  2 +-
 include/uapi/scsi/fc/fc_els.h                   | 18 +++----
 include/uapi/scsi/scsi_bsg_fc.h                 |  2 +-
 include/uapi/sound/asound.h                     |  2 +-
 include/uapi/sound/firewire.h                   |  6 +--
 include/uapi/sound/skl-tplg-interface.h         |  2 +-
 include/uapi/sound/sof/header.h                 |  2 +-
 include/uapi/sound/usb_stream.h                 |  2 +-
 tools/arch/x86/include/uapi/asm/kvm.h           | 12 ++---
 tools/include/uapi/drm/i915_drm.h               |  6 +--
 tools/include/uapi/linux/fs.h                   |  2 +-
 tools/include/uapi/linux/if_tun.h               |  2 +-
 tools/include/uapi/linux/kvm.h                  |  8 +--
 tools/include/uapi/linux/perf_event.h           |  2 +-
 tools/include/uapi/linux/pkt_cls.h              |  4 +-
 tools/include/uapi/linux/seg6.h                 |  4 +-
 tools/include/uapi/linux/usbdevice_fs.h         |  4 +-
 tools/include/uapi/sound/asound.h               |  2 +-
 82 files changed, 216 insertions(+), 216 deletions(-)
