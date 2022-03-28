Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA24E9322
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbiC1LUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 07:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiC1LUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 07:20:01 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45978A3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:18:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 5so24111701lfp.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 04:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=QtYy8qA9A7f/3Xy7Dur/JEWyQGPt7QBEGPR9HcaH88s=;
        b=RRtLw6JHyCx1Jr++m0P1IgQZJLCqJrgN9gdtZHPXlNZE3av11GDLxXm8Y8vpnZrGDn
         4WEx1FuWE9HUHaLtUun8DlVH2UAztjfTVYxe/uFfW7qHZbPs4uc48lta8PJyttdYkZ/c
         MKvVF9cZTQgc2n7TzpDpmL485ev6weVbdtjXwzLcb+l8pLaMveZB5wStTzQWX37Snx2L
         3vyvgV0u/0cH19gv7fVisIcak+giRCB2okaY7IvGPwwkI/cKme8PfSJw8788HhY1Ve+2
         TSgLq0lWTugEHD9k6CRPQh4qHT8Ia4u7V8c6kJTIfOPZHjweVmWOZ3X5Q+vk2GKPYLQ8
         4AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=QtYy8qA9A7f/3Xy7Dur/JEWyQGPt7QBEGPR9HcaH88s=;
        b=7fbJ4sIOdRqT6opyf+V7NXXxgZObw8yK0df8hu/SMVhjwcc5bNBz3UWtGwl/AWo9Kn
         J90hlEmXpRLdbkXXLWOj9gVEbK9CZpbiZZwuIlbpISCcb1qWbCJP6OHS5RIll/ElzDOz
         qKvAIrKKS0hp+dCQV0xFHf7YQOlX+qhcwEKbhPgUQl98Dyouf5/Xkj3505/17tFPO0tN
         ogbwKUrh66efs6aoEb2iCUhb12TURkxbJcQZyzM4wyzDVt9wC3ZQivZFOxC7zFn5K9sr
         d/h7GE9FaeCQSQvdPtEX8RB/h2Usw2PBh4VspT9oReq8hXDEROngAIetD9Un4PFP+Hbi
         bnBg==
X-Gm-Message-State: AOAM530dcYOGDyEyFwNWpsmyHKbkRRQ2vNt5rkJS+Vm2zsfIB5F3mMcg
        dJN84kN23YLlKlww/72v+CIBTg==
X-Google-Smtp-Source: ABdhPJyG6HakjF8S+cSEVLGRq5jL+P4HH8LNlrkQBxNGFhsYxM9yivaZAvLE+OFDpuX+6LG5nXUfTw==
X-Received: by 2002:a19:6709:0:b0:448:3162:d843 with SMTP id b9-20020a196709000000b004483162d843mr19212735lfc.95.1648466297580;
        Mon, 28 Mar 2022 04:18:17 -0700 (PDT)
Received: from [127.0.1.1] ([2.92.192.17])
        by smtp.gmail.com with ESMTPSA id r20-20020a2e5754000000b002480655267dsm1624572ljd.67.2022.03.28.04.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 04:18:16 -0700 (PDT)
Subject: [PATCH 0/4] dm: Introduce dm-qcow2 driver to attach QCOW2 files as
 block device
From:   Kirill Tkhai <kirill.tkhai@openvz.org>
To:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, linux-kernel@vger.kernel.org,
        khorenko@virtuozzo.com, kirill.tkhai@openvz.org
Date:   Mon, 28 Mar 2022 14:18:16 +0300
Message-ID: <164846619932.251310.3668540533992131988.stgit@pro>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a new driver allowing to attach QCOW2 files
as block devices. Its idea is to implement in kernel only that
features, which affect runtime IO performance (IO requests
processing functionality). The maintenance operations are
synchronously processed in userspace, while device is suspended.

Userspace is allowed to do only that operations, which never
modifies virtual disk's data. It is only allowed to modify
QCOW2 file metadata providing that disk's data. The examples
of allowed operations is snapshot creation and resize.

Userspace part is handled by already existing utils (qemu-img).

For instance, snapshot creation on attached dm-qcow2 device looks like:

# dmsetup suspend $device
# qemu-img snapshot -c <snapshot_name> $device.qcow2
# dmsetup resume $device

1)Suspend flushes all pending IO and related metadata to file,
  leaving the file in consistent QCOW2 format.
  Driver .postsuspend throws out all images's cached metadata.
2)qemu-img creates snapshot: changes/moves metadata inside QCOW2 file.
3)Driver .preresume reads new version of metadata
  from file (1 page is required), and the device is ready
  to continue handling of IO requests.

This example shows the way of device-mapper infrastructure
allows to implement drivers following the idea of
kernel/userspace components demarcation. Thus, the driver
uses advantages of device-mapper instead of implementing
its own suspend/resume engine.

The below fio test was used to measure performance:

# fio --name=test --ioengine=libaio --direct=1 --bs=$bs --filename=$dev
      --readwrite=$rw --runtime=60 --numjobs=2 --iodepth=8

The collected results consists of the both: fio measurement
and system load taken from /proc/loadavg. Since loadavg min
period is 60 seconds, fio's runtime is 60 too.
Here is average results of 5 runs (IO/loadavg is also average
of IO/loadavg of 5 runs):

-------------------------------------------+---------------------------------+--------------------------+
                  qemu-nbd (native aio)    |             dm-qcow2            |          diff, %         |
----+--------------------------------------+---------------------------------+--------------------------+
bs  |  RW   | IO,MiB/s  loadavg  IO/loadavg|  IO,MiB/s   loadavg   IO/loadavg|IO     loadavg  IO/loadavg|
------------|------------------------------+---------------------------------+--------------------------+
4K  | READ  |  279       1.986     147     |  512        2.088     248       |+83.7    +5.1     +68.4   |
4K  | WRITE |  242       2.31      105     |  770        2.172     357       |+217.9   -5.9     +239.7  |
----+-------|------------------------------+---------------------------------+--------------------------+
64K | READ  |  1199      1.794     691     |  1218       1.118     1217      |+1.6     -37.7    +76     |
64K | WRITE |  946       1.084     877     |  1003       0.466     2144      |+6.1     -57      +144.5  |
------------|------------------------------+---------------------------------+--------------------------+
512K| READ  |  1741      1.142     1526    |  2196       0.546     4197      |+26.1    -52.2    +175.1  |
512K| WRITE |  1016      1.084     941     |  993        0.306     3267      |-2.2     -71.7    +246.9  |
----|-------|------------------------------+---------------------------------+--------------------------+
1M  | READ  |  1793      1.174     1542    |  2373       0.566     4384      |+32.4    -51.8    +184.2  |
1M  | WRITE |  1037      0.894     1165    |  1068       0.892     1196      |+2.9     -0.2     +2.7    |
----|-------+------------------------------+---------------------------------+--------------------------+
2M  | READ  |  1784      1.084     1654    |  2431       0.788     3090      |+36.3    -27.3    +86.8   |
2M  | WRITE |  1027      0.878     1172    |  1063       0.878     1212      |+3.6     0        +3.4    |
----+-------+------------------------------+---------------------------------+--------------------------+
(NBD attaching string: qemu-nbd -c $dev --aio=native --nocache file.qcow2)

As in diff column, dm-qcow2 driver has the best throughput
(the only exception is 512K WRITE), and the smallest
loadavg (the only exception is 4K READ). The density
of dm-qcow2 is significantly better.

(Note, that tests are made on preallocated images, when
 all L2 table is allocated, since QEMU has lazy L2 allocation
 feature, which is not implemented in dm-qcow2 yet).

So, one of the reasons of implementing the driver is providing
better performance and density than it's done in qemu-nbd.
The second reason is a possibility to unify virtual disks format
for VMs and containers, so a disk image can be used to start
both of them.

This patchset consists of 4 patches. Patches [1-2] make small
changes in dm code: [1] exports a function, while [2] makes
.io_hints be called for drivers not having .iterate_devices.
Patch [3] adds dm-qcow2, while patch [4] adds a userspace
wrapper for attaching such the devices.

---

Kirill Tkhai (4):
      dm: Export dm_complete_request()
      dm: Process .io_hints for drivers not having underlying devices
      dm-qcow2: Introduce driver to create block devices over QCOW2 files
      dm-qcow2: Add helper for working with dm-qcow2 devices


 drivers/md/Kconfig           |   17 +
 drivers/md/Makefile          |    2 +
 drivers/md/dm-qcow2-cmd.c    |  383 +++
 drivers/md/dm-qcow2-map.c    | 4256 ++++++++++++++++++++++++++++++++++
 drivers/md/dm-qcow2-target.c | 1026 ++++++++
 drivers/md/dm-qcow2.h        |  368 +++
 drivers/md/dm-rq.c           |    3 +-
 drivers/md/dm-rq.h           |    2 +
 drivers/md/dm-table.c        |    5 +-
 scripts/qcow2-dm.sh          |  249 ++
 10 files changed, 6309 insertions(+), 2 deletions(-)
 create mode 100644 drivers/md/dm-qcow2-cmd.c
 create mode 100644 drivers/md/dm-qcow2-map.c
 create mode 100644 drivers/md/dm-qcow2-target.c
 create mode 100644 drivers/md/dm-qcow2.h
 create mode 100755 scripts/qcow2-dm.sh

--
Signed-off-by: Kirill Tkhai <kirill.tkhai@openvz.org>

