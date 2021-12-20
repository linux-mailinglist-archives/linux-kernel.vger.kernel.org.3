Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD7547B40B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbhLTT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:57:26 -0500
Received: from foss.arm.com ([217.140.110.172]:34530 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231911AbhLTT5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:57:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7EE81FB;
        Mon, 20 Dec 2021 11:57:22 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A1E83F718;
        Mon, 20 Dec 2021 11:57:21 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v8 00/11] Introduce atomic support for SCMI transports
Date:   Mon, 20 Dec 2021 19:56:35 +0000
Message-Id: <20211220195646.44498-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series mainly aims to introduce atomic support for SCMI transports
that can support it.

In [01/11], as a closely related addition, it is introduced a common way
for a transport to signal to the SCMI core that it does not offer
completion interrupts, so that the usual polling behaviour will be
required: this can be done enabling statically a global polling behaviour
for the whole transport with flag scmi_desc.force_polling OR dynamically
enabling at runtime such polling behaviour on a per-channel basis using
the flag scmi_chan_info.no_completion_irq, typically during .chan_setup().
The usual per-command polling selection behaviour based on
hdr.poll_completion is preserved as before.

Patch [02/11], ports SMC transport to use the common core completions when
completion interrupt is available or otherwise revert to use common core
polling mechanism above introduced: this avoids the improper call of
scmi_rx_callback directly in smc_send_message.

With [03/11] I introduce a flag to allow a transport to signal to the core
that upon return of a .send_message() the requested command execution can
be assumed by the core to have been fully completed by the platform, so
that the response payload (if any) can be immediately fetched without the
need to effectively poll the channel.

In [04/11] and [05/11] I enable such flag for SMC amd OPTEE transports.

With [06/11] a transport that supports atomic operations on its TX
path can now declare itself as .atomic_enabled and, if the platform has
been also configured to use such atomic operation mode via Kconfig, the
SCMI core will refrain itself too from sleeping on the RX path and instead
rely on polling on the correspondent when such atomic behaviour is
requested from the upper layers. (like the Clock framework)

Then in [07/11] SMC is converted to be .atomic_enabled by substituting
the mutexes with busy-waiting to keep the channel 'locked' ONLY IF the
SMC transport is configured to operate in atomic mode.
(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE=y)

In [08/11] a new parameter is added to mark_txdone transport operation;
this will be needed to support polling/atomic support in SCMI virtio.

[09/11] adds polling and configurable atomic mode support to SCMI virtio.
(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE=y)

Finally [10/11] adds support for atomic clock enable/disable requests to
the SCMI Clock protocol layer, while in [11/11] the SCMI Clock driver is
modified to gain optional support for atomic operations when operating on
an atomically capable and configured SCMI transport.

NOTE THAT once atomic mode is available and configured on the underlying
SCMI transport, selected SCMI operations can be performed in atomic mode:
in this series this is done only for Clock enable operations; moreover
ALL the known clock devices are currently moved to atomic operations if
supported by transport: later a more fine grained control to avoid atomic
operations on 'slow' clock domains will be introduced, but this latter
solution requires an SCMI Spec change which is still underway.

Atomic support has been tested against the virtio transport in regards to
the above mentioned Clock enable/disable operations.
(echo 1 > /sys/kernel/debug/clk/myclock/clk_prepare_enable)
Pure polling has been tested on mailbox transport.

The series is based on sudeep/for-next/scmi [1] on top of:

commit f872af09094c ("firmware: arm_scmi: Use new trace event
		     scmi_xfer_response_wait")

Any feedback welcome.

Thanks,

Cristian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi 

---
V7 --> V8
- rebased on top sudeep/for-next/scmi
- removed clock prepare/unprepare for atomic transports
- removed ifdeffery in SCMI virtio atomic/polling support
- added SCMI virtio polling deferred worker
- simplified SCMI virtio spinlocking around free list
- removed ifdeffery in SMC atomic support
- removed polling_capable/polling_enabled internal flags, using macros
- renaming to sync_cmds_completed_on_ret

V6 --> V7
- rebased on lates sudeep/for-next/scmi
- fixed missing list_del() in vio_complete while processing pre-fetched buffers
- added proper spilocking while accessing pending_cmds_list
- reduced unneeded spinlocked region in virtio_poll_done
- using __unused macro in optional mark_txdone param

V5 --> V6
- changed default polling timeout
- refactored SCMI RX path
- added timeout_ms to traces in RX-path
- added OPTEE support for sync_cmds_atomic_replies
- reworked the whole atomic support in SCMI core removing any reliance
  on IRQs. (using pure polling)
- added new parameter to mark_txdone
- added new SCMI VirtIO polling/atomic support
- reviewed Clock SCMI Driver atomic support: now supporting both
  clk_prepare and clk_enable when atomic transport is detected
- added CCs

V4 --> V5
- removed RFCs tags
- added scmi_desc.atomic_enabled flags and a few Kconfig options to set
  atomic mode for SMC and VirtIO transports. Default disabled.
- added Kconfig option to enable forced polling as a whole on the Mailbox
  transport
- removed .poll_done callback from SMC transport since no real polling is
  needed once sync_cmds_atomic_replies is set
- made atomic_capable changes on SMC transport dependent on Kconfig
  CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE: so no change and no busy waiting
  if atomic mode is NOT enabled in Kconfig.
- made const: force_polling/atomic_capable/atomic_enabled/sync_cmds_atomic_replies

V3 --> V4
- rebased on linux-next/master next-20210824
- renamed .needs_polling to .no_completion_irq
- added .sync_cmds_atomic_replies
- make SMC use .sync_cmd_atomic_replies

V2 --> v3
- rebased on SCMI VirtIO V6 which in turn is based on v5.14-rc1

Cristian Marussi (11):
  firmware: arm_scmi: Add configurable polling mode for transports
  firmware: arm_scmi: Make smc transport use common completions
  firmware: arm_scmi: Add sync_cmds_completed_on_ret transport flag
  firmware: arm_scmi: Make smc support sync_cmds_completed_on_ret
  firmware: arm_scmi: Make optee support sync_cmds_completed_on_ret
  firmware: arm_scmi: Add support for atomic transports
  firmware: arm_scmi: Add atomic mode support to smc transport
  firmware: arm_scmi: Add new parameter to mark_txdone
  firmware: arm_scmi: Add atomic mode support to virtio transport
  firmware: arm_scmi: Add atomic support to clock protocol
  clk: scmi: Support atomic clock enable/disable API

 drivers/clk/clk-scmi.c              |  54 +++++-
 drivers/firmware/arm_scmi/Kconfig   |  29 +++
 drivers/firmware/arm_scmi/clock.c   |  22 ++-
 drivers/firmware/arm_scmi/common.h  |  23 ++-
 drivers/firmware/arm_scmi/driver.c  | 123 ++++++++++--
 drivers/firmware/arm_scmi/mailbox.c |   3 +-
 drivers/firmware/arm_scmi/optee.c   |  18 +-
 drivers/firmware/arm_scmi/smc.c     |  98 +++++++---
 drivers/firmware/arm_scmi/virtio.c  | 291 +++++++++++++++++++++++++---
 include/linux/scmi_protocol.h       |  11 ++
 10 files changed, 586 insertions(+), 86 deletions(-)

-- 
2.17.1

