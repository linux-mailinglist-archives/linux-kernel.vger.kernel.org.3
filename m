Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB804E1DBE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 21:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236833AbiCTUgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 16:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCTUgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 16:36:04 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D57A527C2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 13:34:40 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id u30-20020a4a6c5e000000b00320d8dc2438so16941643oof.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 13:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ecrgKv+b8Qeggg1m7l22EYC1uE+osTsOg8aZ/gQrc3c=;
        b=L2OdXyzopGapOhtxUiD1olNWsog6SVvxO2+TwdCHkd9/zNE86IjCpFFZpsp8BN2GEI
         5DFp3S03qv2z5qQ4TrUwzXlLelaoFATL9AXezdFEbkTFQiEsj+NmvxgFiENaIPoJrAW+
         gz+DFDN3FRz5Jrs+lnwUBm27BayUgsTDVm/Eo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ecrgKv+b8Qeggg1m7l22EYC1uE+osTsOg8aZ/gQrc3c=;
        b=rlIdMQrGSWb4cyHx6vmhRcnJZ3QB4n0Zw0cddQsQOLB3nD5HysVnNgB6sa/fYNi/Ba
         bz97pJ22PpubYZ/cXOhMac1ba6o64ZNfAmmNpjAxRhrUT2WqAePPpATAEt1m2DZ2K4dl
         XUrePFQos91oe/zUpU4p81IeW9eCKsTW0nswQfUzky5SGeUHWYUQUgUTIvopwCMxTQrz
         sRdlWrPs4QmJi1NZkz/DNLN0g95ehBHUktXjJxwqDvZ7TFBKC0iVyWOc0jdvdmzKrt8X
         cQra2iGKW4swtUdLhJ+KZftI7WmWPcgyk/4u2BnSa2uX2Cokr4rcGG4EpB9Uct+CeYvJ
         sRzw==
X-Gm-Message-State: AOAM530eEV7msWK1b5CtoPcDoeKItjVAKnFwLjaVc8oE7neUBmP0Rp4Y
        9kSxq3iR9HL9yZoTg39+wD5TSaFpBvkGQz1a
X-Google-Smtp-Source: ABdhPJxgfMgmJ+9i6NRWWCmg8QrOEvSBzV+HMqriiacBhX+UTzbI8FLq0ySeegivnN9/9clcdxmVhA==
X-Received: by 2002:a4a:d78b:0:b0:324:10fd:ef59 with SMTP id c11-20020a4ad78b000000b0032410fdef59mr5754659oou.49.1647808479262;
        Sun, 20 Mar 2022 13:34:39 -0700 (PDT)
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com. [209.85.161.47])
        by smtp.gmail.com with ESMTPSA id d66-20020aca3645000000b002eccb84aa7dsm6500424oia.19.2022.03.20.13.34.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Mar 2022 13:34:38 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id w3-20020a4ac183000000b0031d806bbd7eso16901441oop.13
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 13:34:38 -0700 (PDT)
X-Received: by 2002:a05:6870:b487:b0:dd:c79d:18ab with SMTP id
 y7-20020a056870b48700b000ddc79d18abmr5649870oap.205.1647808477753; Sun, 20
 Mar 2022 13:34:37 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Mar 2022 13:34:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4fFjx2pgbGNBM4wJs3=eReZ05EQyprzgT2Jv8qJ2vJg@mail.gmail.com>
Message-ID: <CAHk-=wj4fFjx2pgbGNBM4wJs3=eReZ05EQyprzgT2Jv8qJ2vJg@mail.gmail.com>
Subject: Linux 5.17
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we had an extra week of at the end of this release cycle, and I'm
happy to report that it was very calm indeed.  We could probably have
skipped it with not a lot of downside, but we did get a few
last-minute reverts and fixes in and avoid some brown-paper bugs that
would otherwise have been stable fodder, so it's all good.

And that calm last week can very much be seen from the appended
shortlog - there really aren't a lot of commits in here, and it's all
pretty small. Most of it is in drivers (net, usb, drm), with some core
networking, and some tooling updates too.

It really is small enough that you can just scroll through the details
below, and the one-liner summaries will give a good flavor of what
happened last week.

Of course, this means that the merge window for 5.18 will be open
starting tomorrow, and I already have about a dozen pull requests
waiting in my inbox. I appreciate the early pull requests: it gives me
that warm and fuzzy feeling of "this was all ready in plenty of time".
Judging by the statistics in linux-next, it looks like 5.18 will be a
bit bigger than 5.17 was, but hopefully without some of the drama.

So go test this, and we'll get 5.18 started tomorrow.

                   Linus

---

Alan Stern (2):
      usb: usbtmc: Fix bug in pipe direction for control transfers
      usb: gadget: Fix use-after-free bug by not setting udc->dev.driver

Arnd Bergmann (2):
      arm64: fix clang warning about TRAMP_VALIAS
      arm64: errata: avoid duplicate field initializer

Bartosz Golaszewski (1):
      Revert "gpio: Revert regression in sysfs-gpio (gpiolib.c)"

Borislav Petkov (1):
      kvm/emulate: Fix SETcc emulation function offsets with SLS

Brian Masney (1):
      crypto: qcom-rng - ensure buffer for generate is completely filled

Christoph Niedermaier (1):
      drm/imx: parallel-display: Remove bus flags check in
imx_pd_bridge_atomic_check()

Claudiu Beznea (1):
      net: dsa: microchip: add spi_device_id tables

Dan Carpenter (1):
      usb: gadget: rndis: prevent integer overflow in rndis_set_response()

David Jeffery (1):
      scsi: fnic: Finish scsi_cmnd before dropping the spinlock

Doug Berger (1):
      net: bcmgenet: skip invalid partial checksums

Eric Dumazet (1):
      net/packet: fix slab-out-of-bounds access in packet_recvmsg()

Florian Westphal (2):
      Revert "netfilter: nat: force port remap to prevent shadowing
well-known ports"
      Revert "netfilter: conntrack: tag conntracks picked up in local out h=
ook"

Guo Ziliang (1):
      mm: swap: get rid of livelock in swapin readahead

H. Nikolaus Schaller (1):
      partially Revert "usb: musb: Set the DT node on the child device"

Haimin Zhang (1):
      af_key: add __GFP_ZERO flag for compose_sadb_supported in
function pfkey_register

Hannes Reinecke (1):
      nvmet: revert "nvmet: make discovery NQN configurable"

Ian Rogers (2):
      perf evlist: Avoid iteration for empty evlist.
      perf parse-events: Ignore case in topdown.slots check

Ivan Vecera (1):
      iavf: Fix hang during reboot/shutdown

Jakub Kicinski (1):
      Add Paolo Abeni to networking maintainers

Jason Wang (1):
      vhost: allow batching hint without size

Jiasheng Jiang (2):
      atm: eni: Add check for dma_map_single
      hv_netvsc: Add check for kvmalloc_array

Jiyong Park (1):
      vsock: each transport cycles only on its own sockets

Jocelyn Falempe (1):
      drm/mgag200: Fix PLL setup for g200wb and g200ew

Joseph Qi (1):
      ocfs2: fix crash when initialize filecheck kobj fails

Juerg Haefliger (1):
      net: phy: mscc: Add MODULE_FIRMWARE macros

Kalle Valo (1):
      Revert "ath10k: drop beacon and probe response which leak from
other channel"

Kurt Cancemi (1):
      net: phy: marvell: Fix invalid comparison in the resume and
suspend functions

Linus Torvalds (1):
      Linux 5.17

Linus Walleij (1):
      Input: zinitix - do not report shadow fingers

Maciej Fijalkowski (1):
      ice: fix NULL pointer dereference in ice_update_vsi_tx_ring_stats()

Manish Chopra (1):
      bnx2x: fix built-in kernel driver load failure

Marek Vasut (1):
      drm/panel: simple: Fix Innolux G070Y2-L01 BPP settings

Matt Lupfer (1):
      scsi: mpt3sas: Page fault in reply q processing

Miaoqian Lin (1):
      net: dsa: Add missing of_node_put() in dsa_port_parse_of

Michael Petlan (1):
      perf symbols: Fix symbol size calculation condition

Michael Walle (1):
      net: mdio: mscc-miim: fix duplicate debugfs entry

Ming Lei (1):
      block: release rq qos structures for queue without disk

Nicolas Dichtel (1):
      net: handle ARPHRD_PIMREG in dev_is_mac_header_xmit()

Niels Dossche (1):
      alx: acquire mutex for alx_reinit in alx_change_mtu

Pablo Neira Ayuso (1):
      netfilter: nf_tables: disable register tracking

Pavel Skripkin (1):
      Input: aiptek - properly check endpoint type

Przemyslaw Patynowski (1):
      iavf: Fix double free in iavf_reset_task

Qian Cai (1):
      configs/debug: restore DEBUG_INFO=3Dy for overriding

Rafael J. Wysocki (1):
      Revert "ACPI: scan: Do not add device IDs from _CID if _HID is not va=
lid"

Randy Dunlap (1):
      efi: fix return value of __setup handlers

Sabrina Dubroca (1):
      esp6: fix check on ipv6_skip_exthdr's return value

Steve French (1):
      smb3: fix incorrect session setup check for multiuser mounts

Sudheer Mogilappagari (1):
      ice: destroy flow director filter mutex after releasing VSIs

Tadeusz Struk (1):
      net: ipv6: fix skb_over_panic in __ip6_append_data

Thomas Zimmermann (1):
      drm: Don't make DRM_PANEL_BRIDGE dependent on DRM_KMS_HELPERS

Uwe Kleine-K=C3=B6nig (1):
      counter: Stop using dev_get_drvdata() to get the counter device

Vladimir Oltean (2):
      Revert "arm64: dts: freescale: Fix 'interrupt-map' parent address cel=
ls"
      net: mscc: ocelot: fix backwards compatibility with single-chain
tc-flower offload

Yosry Ahmed (1):
      selftests: vm: fix clang build error multiple output files
