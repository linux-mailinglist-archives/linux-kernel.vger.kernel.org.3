Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56687497CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 11:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236977AbiAXKEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 05:04:11 -0500
Received: from foss.arm.com ([217.140.110.172]:55970 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235062AbiAXKEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 05:04:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A5286D;
        Mon, 24 Jan 2022 02:04:05 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E7533F73B;
        Mon, 24 Jan 2022 02:04:03 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, peter.hilber@opensynergy.com,
        igor.skalkin@opensynergy.com, cristian.marussi@arm.com
Subject: [PATCH 0/6] Add SCMI Virtio & Clock atomic support
Date:   Mon, 24 Jan 2022 10:03:35 +0000
Message-Id: <20220124100341.41191-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This small series is the tail-subset of the previous V8 series about atomic
support in SCMI [1], whose 8-patches head-subset has now been queued on
[2]; as such, it is based on [2] on top of tag scmi-updates-5.17:

commit 94d0cd1da14a ("firmware: arm_scmi: Add new parameter to
		     mark_txdone")

Patch 1/5 adds polling mode to SCMI VirtIO transport in order to support
atomic operations on such transport and it could have been an independent
patch indeed, it is provided here only for ease of testing.

Patch 2,3 introduce a new optional SCMI binding, atomic_threshold, to
configure a platform specific time threshold used in the following patches
to select with a finer grain which SCMI resources should be eligible for
atomic operations when requested.

Patch 4 exposes new SCMI Clock protocol operations to allow an SCMI user
to request atomic mode on clock enable commands.

Patch 5 adds support to SCMI Clock protocol for a new clock attributes
field which advertises typical enable latency for a specific resource.
It is marked as RFC since the SCMI spec including such addition is still
to be finalized.

Finally patch 6 add support for atomic operations to the SCMI clock driver;
the underlying logic here is that we register with the Clock framework
atomic-capable clock resources if and only if the backing SCMI transport is
capable of atomic operations AND the specific clock resource has been
advertised by the SCMI platform as having:

	clock_enable_latency <= atomic_threshold

The idea is to avoid costly atomic busy-waiting for resources that have
been advertised as 'slow' to operate upon. (i.e. a PLL vs a gating clock)
This last patch is marked as RFC too since it is dependent on the previous
one (that is RFC-tagged too)

To ease testing the whole series can be find at [3].

Any feedback/testing welcome as usual.

Thanks,
Cristian

[1]: https://lore.kernel.org/linux-arm-kernel/20211220195646.44498-1-cristian.marussi@arm.com/
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/tag/?h=scmi-updates-5.17
[3]: https://gitlab.arm.com/linux-arm/linux-cm/-/commits/scmi_atomic_clk_virtio_V1/

Cristian Marussi (6):
  firmware: arm_scmi: Add atomic mode support to virtio transport
  dt-bindings: firmware: arm,scmi: Add atomic_threshold optional
    property
  firmware: arm_scmi: Support optional system wide atomic_threshold
  firmware: arm_scmi: Add atomic support to clock protocol
  [RFC] firmware: arm_scmi: Add support for clock_enable_latency
  [RFC] clk: scmi: Support atomic clock enable/disable API

 .../bindings/firmware/arm,scmi.yaml           |  10 +
 drivers/clk/clk-scmi.c                        |  71 +++-
 drivers/firmware/arm_scmi/Kconfig             |  15 +
 drivers/firmware/arm_scmi/clock.c             |  34 +-
 drivers/firmware/arm_scmi/driver.c            |  36 +-
 drivers/firmware/arm_scmi/virtio.c            | 315 ++++++++++++++++--
 include/linux/scmi_protocol.h                 |   9 +-
 7 files changed, 440 insertions(+), 50 deletions(-)

-- 
2.17.1

