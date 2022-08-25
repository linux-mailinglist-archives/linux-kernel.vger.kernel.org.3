Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686625A130C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbiHYOMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 10:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHYOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 10:12:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C0ABF2F00B
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 07:12:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 17CBCD6E;
        Thu, 25 Aug 2022 07:12:15 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AA723F71A;
        Thu, 25 Aug 2022 07:12:08 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, cristian.marussi@arm.com
Subject: [PATCH v2 0/9] Introduce a unified API for SCMI Server testing
Date:   Thu, 25 Aug 2022 15:11:43 +0100
Message-Id: <20220825141152.2334536-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series aims to introduce a new SCMI unified userspace interface meant
to ease testing an SCMI Server implementation for compliance, fuzzing etc.,
from the perspective of the OSPM agent (non-secure world only ...)

It is proposed as a testing/development facility, it is NOT meant to be a
feature to use in production, but only enabled in Kconfig for test
deployments.

Currently an SCMI Compliance Suite like the one at [1] can only work by
injecting SCMI messages at the SCMI transport layer using the mailbox test
driver (CONFIG_MAILBOX_TEST) via its few debugfs entries and looking at
the related replies from the SCMI backend Server.

This approach has a few drawbacks:

- the SCMI Server under test MUST be reachable through a mailbox based
  SCMI transport: any other SCMI Server placement is not possible (like in
  a VM reachable via SCMI Virtio). In order to cover other placements in
  the current scenario we should write some sort of test driver for each
  and every existent SCMI transport and for any future additional transport
  ...this clearly does not scale.

- even in the mailbox case the userspace Compliance suite cannot simply
  send and receive bare SCMI messages BUT it has to properly lay them out
  into the shared memory exposed by the mailbox test driver as expected by
  the transport definitions. In other words such a userspace test
  application has to, not only use a proper transport driver for the system
  at hand, but it also has to have a comprehensive knowledge of the
  internals of the underlying transport in order to operate.

- last but not least, the system under test has to be specifically
  configured and built, in terms of Kconfig and DT, to perform such kind of
  testing, it cannot be used for anything else, which is unfortunate for
  CI/CD deployments.

This series introduces a new SCMI Raw mode support feature that, when
configured and enabled exposes a new interface in debugfs through which:

- a userspace application can inject bare SCMI binary messages into the
  SCMI core stack; such messages will be routed by the SCMI regular kernel
  stack to the backend Server using the currently configured transport
  transparently: in other words you can test the SCMI server, no matter
  where it is placed, as long as it is reachable from the currently
  configured SCMI stack.
  Same goes the other way around on the reading path: any SCMI server reply
  can be read as a bare SCMI binary message from the same debugfs path.

- as a direct consequence of this way of injecting bare messages in the
  middle of the SCMI stack (instead of beneath it at the transport layer)
  the user application has to handle only bare SCMI messages without having
  to worry about the specific underlying transport internals that will be
  taken care of by the SCMI core stack itself using its own machinery,
  without duplicating such logic.

- a system under test, once configured with SCMI Raw support enabled in
  Kconfig, can be booted without any particular DT change.

In V2 the runtime enable/disable switching capability has been removed
(for now) since still not deemed to be stable/reliable enough: as a
consequence when SCMI Raw support is compiled in, the regular SCMI stack
drivers are now inhibited permanently for that Kernel.

A quick and trivial example from the shell...reading from a sensor
injecting a properly crafted packet in raw mode:

	# INJECT THE SENSOR_READING MESSAGE FOR SENSOR ID=1 (binary little endian)
	root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/message

	# READING BACK THE REPLY...
	root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi_raw/message | od --endian=little -t x4
	0000000 00005406 00000000 00000335 00000000
	0000020

while doing that, since Raw mode makes (partial) use of the regular SCMI
stack, you can observe the messages going through the SCMI stack with the
usual traces:

              bash-329     [000] ..... 14183.446808: scmi_msg_dump: pt=15 t=CMND msg_id=06 seq=0000 s=0 pyld=0100000000000000
   irq/35-mhu_db_l-81      [000] ..... 14183.447809: scmi_msg_dump: pt=15 t=RESP msg_id=06 seq=0000 s=0 pyld=3503000000000000


..trying to read in async when the backend server does NOT supports asyncs:

	# AN ASYNC SENSOR READING REQUEST...
	root@deb-buster-arm64:~# echo -e -n \\x06\\x54\\x00\\x00\\x01\\x00\\x00\\x00\\x01\\x00\\x00\\x00 > /sys/kernel/debug/scmi_raw/message_async

              bash-329     [000] ..... 16415.938739: scmi_msg_dump: pt=15 t=CMND msg_id=06 seq=0000 s=0 pyld=0100000001000000
   irq/35-mhu_db_l-81      [000] ..... 16415.944129: scmi_msg_dump: pt=15 t=RESP msg_id=06 seq=0000 s=-1 pyld=

	# RETURNS A STATUS -1 FROM THE SERVER NOT SUPPORTING IT
	root@deb-buster-arm64:~# cat /sys/kernel/debug/scmi_raw/message | od --endian=little -t x4
	0000000 00005406 ffffffff
	0000010

Note that this was on a JUNO, BUT exactly the same steps can be used to
reach an SCMI Server living on a VM reachable via virtio as long as the
system under test if properly configured to work with a virtio transport.

In a nutshell the exposed API is as follows:

/sys/kernel/debug/scmi_raw/
├── errors
├── message
├── message_async
├── notification
├── reset
├── transport_max_msg_size
├── transport_rx_timeout_ms
└── transport_tx_max_msg

where:

 - message*: used to send sync/async commands and read back immediate and
   delayed responses (if any)
 - errors: used to report timeout and unexpected replies
 - reset: used to reset the SCMI Raw stack, flushing all queues from
   received messages still pending to be read out (useful to be sure to
   cleanup between test suite runs...)
 - notification: used to read any notification being spit by the system
   (if previously enabled by the user app)
 - transport*: a bunch of configuration useful to setup the user
   application expectations in terms of timeouts and message
   characteristics.

Each write corresponds to one command request and the replies or delayed
response are read back one message at time (receiving an EOF at each
message boundary).

The user application running the test is in charge of handling timeouts
and properly choosing SCMI sequence numbers for the outgoing requests: note
that the same fixed number can be re-used (...though discouraged...) as
long as the suite does NOT expect to send multiple in-flight commands
concurrently.

Since the SCMI core regular stack is partially used to deliver and collect
the messages, late replies after timeouts and any other sort of unexpected
message sent by the SCMI server platform back can be identified by the SCMI
core as usual and it will be reported under /errors for later analysis.
(a userspace test-app will have anyway properly detected the timeout on
 /message* ...)

All of the above has been roughly tested against a standard JUNO SCP SCMI
Server (mailbox trans) and an emulated SCMI Server living in a VM (virtio
trans) using a custom experimental version of the scmi-tests Compliance
suite patched to support Raw mode and posted at [2]. (still in development
...certainly not up for review as of now...it is just a mean for me to
test the testing API ... O_o)

The series is based on sudeep/for-next/scmi [3] on top of:

commit 40d30cf680cb ("firmware: arm_scmi: Harmonize SCMI tracing message format")

Still todo:

- needs more complete testing, ideally running to completion at least the full
  SCMI compliance suite at [2] to use it as a reference
- more feedback on the API
- possibly more splitting of the series
- review waiting deferred worker implementation ?
- more transport_ config data needed ?

Having said that (in such a concise and brief way :P) ...
	
...any feedback/comments are welcome !

Thanks,
Cristian

---
v1 --> v2
- added comments and debugfs docs
- added dedicated transport devices for channels initialization
- better channels handling in Raw mode
- removed runtime enable, moved to static compile time exclusion
  of SCMI regular stack

[1]: https://gitlab.arm.com/tests/scmi-tests
[2]: https://gitlab.arm.com/linux-arm/scmi-tests-cm/-/commits/raw_mode_support_V2/
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi

Cristian Marussi (9):
  firmware: arm_scmi: Refactor xfer in-flight registration routines
  firmware: arm_scmi: Simplify chan_available transport operation
  firmware: arm_scmi: Use dedicated devices to initialize channels
  firmware: arm_scmi: Add xfer raw helpers
  firmware: arm_scmi: Move errors defs and code to common.h
  firmware: arm_scmi: Add raw transmission support
  firmware: arm_scmi: Add debugfs ABI documentation for Raw mode
  firmware: arm_scmi: Reject SCMI drivers while in Raw mode
  firmware: arm_scmi: Call Raw mode hooks from the core stack

 Documentation/ABI/testing/debugfs-scmi-raw |   88 ++
 drivers/firmware/arm_scmi/Kconfig          |   13 +
 drivers/firmware/arm_scmi/Makefile         |    1 +
 drivers/firmware/arm_scmi/common.h         |   51 +-
 drivers/firmware/arm_scmi/driver.c         |  375 ++++--
 drivers/firmware/arm_scmi/mailbox.c        |    4 +-
 drivers/firmware/arm_scmi/optee.c          |    4 +-
 drivers/firmware/arm_scmi/raw_mode.c       | 1283 ++++++++++++++++++++
 drivers/firmware/arm_scmi/raw_mode.h       |   29 +
 drivers/firmware/arm_scmi/smc.c            |    4 +-
 drivers/firmware/arm_scmi/virtio.c         |    2 +-
 11 files changed, 1748 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-scmi-raw
 create mode 100644 drivers/firmware/arm_scmi/raw_mode.c
 create mode 100644 drivers/firmware/arm_scmi/raw_mode.h

-- 
2.32.0

