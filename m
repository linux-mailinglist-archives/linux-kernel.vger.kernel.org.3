Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8374F4BA0CC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:14:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbiBQNNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:13:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240715AbiBQNNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:13:21 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDA6911A2E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:13:06 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD6D812FC;
        Thu, 17 Feb 2022 05:12:51 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CC0A3F66F;
        Thu, 17 Feb 2022 05:12:49 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH v5 0/8] Add SCMI Virtio & Clock atomic support
Date:   Thu, 17 Feb 2022 13:12:26 +0000
Message-Id: <20220217131234.50328-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small series is the tail-subset of the previous V8 series about atomic
support in SCMI [1], whose 8-patches head-subset has now been queued on
[2]; as such, it is based on [2] on top of tag scmi-updates-5.17:

commit 94d0cd1da14a ("firmware: arm_scmi: Add new parameter to
		     mark_txdone")

Patch [1/8] substitute virtio-scmi ready flag and lock with a reference
counter to keep track of vio channels lifetime while removing the need of
a wide spinlocked section (that would cause issues with introduction of
virtio polling support)

Patch [2/8] adds a few helpers to handle the TX free_list and a dedicated
spinlock to reduce the reliance on the main one.

Patch [3/8] adds polling mode to SCMI VirtIO transport in order to support
atomic operations on such transport.

Patches [4,5/8] introduce a new optional SCMI binding, atomic-threshold-us,
to configure a platform specific time threshold used in the following
patches to select with a finer grain which SCMI resources should be
eligible for atomic operations when requested.

Patch [6/8] exposes new SCMI Clock protocol operations to allow an SCMI
user to request atomic mode on clock enable commands.

Patch [7/8] adds support to SCMI Clock protocol for a new clock attributes
field which advertises typical enable latency for a specific resource.

Finally patch [8/8] add support for atomic operations to the SCMI clock
driver; the underlying logic here is that we register with the Clock
framework atomic-capable clock resources if and only if the backing SCMI
transport is capable of atomic operations AND the specific clock resource
has been advertised by the SCMI platform as having:

	clock_enable_latency <= atomic-threshold-us

The idea is to avoid costly atomic busy-waiting for resources that have
been advertised as 'slow' to operate upon. (i.e. a PLL vs a gating clock)

To ease testing the whole series can be find at [3].

Any feedback/testing welcome as usual.

Thanks,
Cristian

[1]: https://lore.kernel.org/linux-arm-kernel/20211220195646.44498-1-cristian.marussi@arm.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=scmi-updates-5.17
[3]: https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_atomic_clk_virtio_V5/

---
v4 --> v5
- dt_bindings: fixed example and removed dtschema warnings/errors
- dt_bindings: added 'default: 0' clause
- introduced vio_msg refcounts and helpers to avoid premature reuse of
  freed messages when both poling and IRQ path are active on a buffer
- better handling of timed out polled messages on late replies using
  new VIO_MSG_POLL_TIMEOUT state
- fixed comments on locks
- removed unneeded virtqueue re-enable when fail to acquire channel in
  complete_cb

V3 --> V4
- renamed optional DT property to atomic-threshold-us

V2 --> V3
 - split out virtio_ring RFC patch into a distinct series
 - calling virtqueue_broke_device when cleaning up channel
 - removed RFC tags from CLK related patches

V1 --> V2
 - added vio channel refcount support patch
 - reviewed free_list support and usage
 - added virtio_ring RFC patch
 - shrinked spinlocked section within virtio_poll_done to exclude
   virtqueue_poll call
 - removed poll_lock
 - use vio channel refcount acquire/release logic when polling
 - using new free_list accessors
 - added new dedicated pending_lock to access pending_cmds_list
 - fixed a few comments

Cristian Marussi (8):
  firmware: arm_scmi: Add a virtio channel refcount
  firmware: arm_scmi: Review virtio free_list handling
  firmware: arm_scmi: Add atomic mode support to virtio transport
  dt-bindings: firmware: arm,scmi: Add atomic-threshold-us optional
    property
  firmware: arm_scmi: Support optional system wide atomic-threshold-us
  firmware: arm_scmi: Add atomic support to clock protocol
  firmware: arm_scmi: Add support for clock_enable_latency
  clk: scmi: Support atomic clock enable/disable API

 .../bindings/firmware/arm,scmi.yaml           |  10 +
 drivers/clk/clk-scmi.c                        |  71 ++-
 drivers/firmware/arm_scmi/Kconfig             |  15 +
 drivers/firmware/arm_scmi/clock.c             |  34 +-
 drivers/firmware/arm_scmi/driver.c            |  33 +-
 drivers/firmware/arm_scmi/virtio.c            | 591 +++++++++++++++---
 include/linux/scmi_protocol.h                 |   9 +-
 7 files changed, 655 insertions(+), 108 deletions(-)

-- 
2.17.1

