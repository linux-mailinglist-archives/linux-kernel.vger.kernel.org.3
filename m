Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCE0461FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345278AbhK2TRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:17:49 -0500
Received: from foss.arm.com ([217.140.110.172]:45424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231430AbhK2TPr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:15:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A69E21063;
        Mon, 29 Nov 2021 11:12:29 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA2013F5A1;
        Mon, 29 Nov 2021 11:12:27 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: [PATCH v7 00/16] Introduce atomic support for SCMI transports
Date:   Mon, 29 Nov 2021 19:11:40 +0000
Message-Id: <20211129191156.29322-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series mainly aims to introduce atomic support for SCMI transports
that can support it.

After a bit of refactoring in the first 5 patches of the series, in
[06/16], as a closely related addition, it is introduced a common way for a
transport to signal to the SCMI core that it does not offer completion
interrupts, so that the usual polling behaviour will be required: this can
be done enabling statically a global polling behaviour for the whole
transport with flag scmi_desc.force_polling OR dynamically enabling at
runtime such polling behaviour on a per-channel basis using the flag
scmi_chan_info.no_completion_irq, typically during .chan_setup().
The usual per-command polling selection behaviour based on
hdr.poll_completion is preserved as before.

Patch [07/16], ports SMC transport to use the common core completions when
completion interrupt is available or otherwise revert to use common core
polling mechanism above introduced: this avoids the improper call of
scmi_rx_callback directly in smc_send_message.

With [08/16] I introduce a flag to allow a transport to signal to the core
that upon return of a .send_message() the requested command execution can
be assumed by the core to have been fully completed by the platform, so
that the response payload (if any) can be immediately fetched without the
need to effectively poll the channel.

In [09/16] and [10/16] I enable such flag for SMC amd OPTEE transports.

With [11/16] a transport that supports atomic operations on its TX
path can now declare itself as .atomic_enabled and, if the platform has
been also configured to use such atomic operation mode via Kconfig, the
SCMI core will refrain itself too from sleeping on the RX path and instead
rely on polling on the correspondent when such atomic behaviour is
requested from the upper layers. (like the Clock framework)

Then in [12/16] SMC is converted to be .atomic_enabled by substituting
the mutexes with busy-waiting to keep the channel 'locked' ONLY IF the
SMC transport is configured to operate in atomic mode.
(CONFIG_ARM_SCMI_TRANSPORT_SMC_ATOMIC_ENABLE=y)

In [13/16] a new parameter is added to mark_txdone transport operation;
this will be needed to support polling/atomic support in SCMI virtio.

[14/16] adds polling and configurable atomic mode support to SCMI virtio.
(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO_ATOMIC_ENABLE=y)

Finally [15/16] adds support for atomic clock enable/disable requests to
the SCMI Clock protocol layer, while in [16/16] the SCMI Clock driver is
modified to gain optional support for atomic operations when operating on
an atomically capable and configured SCMI transport.

Atomic support has been tested against the virtio transport in regards to
the above mentioned Clock enable/disable operations.
(echo 1 > /sys/kernel/debug/clk/myclock/clk_prepare_enable)
Pure polling has been tested on mailbox transport.

The series is based on sudeep/for-next/scmi [1] on top of:

commit 61bc76be367e ("firmware: arm_scmi: optee: Fix missing mutex_init()")

Any feedback welcome.

Thanks,

Cristian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi 

---
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


Cristian Marussi (16):
  firmware: arm_scmi: Perform earlier cinfo lookup call in do_xfer
  firmware: arm_scmi: Set polling timeout to max_rx_timeout_ms
  firmware: arm_scmi: Refactor message response path
  include: trace: Add new scmi_xfer_response_wait event
  firmware: arm_scmi: Use new trace event scmi_xfer_response_wait
  firmware: arm_scmi: Add configurable polling mode for transports
  firmware: arm_scmi: Make smc transport use common completions
  firmware: arm_scmi: Add sync_cmds_atomic_replies transport flag
  firmware: arm_scmi: Make smc support atomic sync commands replies
  firmware: arm_scmi: Make optee support atomic sync commands replies
  firmware: arm_scmi: Add support for atomic transports
  firmware: arm_scmi: Add atomic mode support to smc transport
  firmware: arm_scmi: Add new parameter to mark_txdone
  firmware: arm_scmi: Add atomic mode support to virtio transport
  firmware: arm_scmi: Add atomic support to clock protocol
  clk: scmi: Support atomic clock enable/disable API

 drivers/clk/clk-scmi.c              |  56 +++++--
 drivers/firmware/arm_scmi/Kconfig   |  29 ++++
 drivers/firmware/arm_scmi/clock.c   |  22 ++-
 drivers/firmware/arm_scmi/common.h  |  26 ++-
 drivers/firmware/arm_scmi/driver.c  | 196 +++++++++++++++++-----
 drivers/firmware/arm_scmi/mailbox.c |   3 +-
 drivers/firmware/arm_scmi/optee.c   |  18 ++-
 drivers/firmware/arm_scmi/smc.c     | 108 ++++++++++---
 drivers/firmware/arm_scmi/virtio.c  | 241 ++++++++++++++++++++++++++--
 include/linux/scmi_protocol.h       |  11 ++
 include/trace/events/scmi.h         |  28 ++++
 11 files changed, 636 insertions(+), 102 deletions(-)

-- 
2.17.1

