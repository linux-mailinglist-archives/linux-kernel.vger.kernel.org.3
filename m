Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB684C5EDC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 21:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiB0U5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 15:57:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiB0U5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 15:57:00 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99F9E2FFE7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 12:56:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F5121063;
        Sun, 27 Feb 2022 12:56:22 -0800 (PST)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0F233F66F;
        Sun, 27 Feb 2022 12:56:20 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, souvik.chakravarty@arm.com,
        peter.hilber@opensynergy.com, cristian.marussi@arm.com
Subject: [RFC PATCH 00/16] Introduce SCMI test driver and related Kselftest
Date:   Sun, 27 Feb 2022 20:55:52 +0000
Message-Id: <20220227205608.30812-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this RFC series is meant to introduce and gather some initial feedback on
a new possible SCMI test infrastructure.

The aim is to be able to test the core SCMI Kernel stack in isolation
exercising directly the SCMI protocol interface defined in scmi_protocol.h
without relying on the normal SCMI driver users already present in the
Kernel (like clk-scmi or cpufreq-scmi).

The reason for this approach is twofold, on one side the SCMI protocol
operations interface in scmi_protocol.h is not necessarily used to its full
exent by the existenting SCMI drivers users, on the other side we don't
want to be constrained in our testing by possible internal constraints
imposed by such subsystems on a production system (for good resasons) or by
the usage patterns enforced by their related API.
As an example the CLK subsystem enforces refcounts on enable/disable ops
and the limited debugfs that is made available for testing does not cover
all the possible SCMI operations and it is hardly configurable at compile
time since such flexibility in setting clk rates is deemed dangerous on a
production system. (for good reasons in fact)

In order to do so, a new SCMI test driver is introduced which is in all
regards a regular SCMI driver (like cpufreq-scmi or clk-scmi) that, first
of all, at probe time, registers as a user for each and every SCMI protocol
(if supported by the underlying SCMI platform server and by this testing
driver) and then takes care to expose on a dedicated SCMI debugfs each
and every SCMI protocol operation and some informational data.

The only fundamental differences with a regular SCMI production driver
(like clk-scmi or cpufreq-scmi) are that it:

 - registers itself for ALL the available and supported SCMI protocols
   (not just one)
 - excludes from the SCMI stack any other production SCMI driver
   (unless cohexistence is allowed by an explicit Kconfig in patch 16/16)

The idea is, on one side, to avoid any possible interference during testing
from concurrently running production drivers possibly accessing the same
SCMI protocol stack and, on the other side, avoid the possibility of
deploying by mistake a system in production which exposes also all the
SCMI interface in debugfs via the SCMI testing driver.

Once the SCMI protocols interface is exposed in debugfs as such we can
happily script our testcases in terms of kselftest as esemplified in patch
15/16. (only reported here as an example ... the KSelftests are RFC^2 and
to be fully re-written)

The resulting SCMI debugfs is roughly structured as detailed down below.

At the top layer, there are two main informational directories (info/ and
transport/ holding some general data related to SCMI stack versioning and
current transport configuration and then there is one directory for each
SCMI protocol that has been found available on the system (as advertised
by the backend SCMI server) and that this driver currently supports.

/sys/kernel/debug/scmi/
├── info
├── protocol_0x14
├── protocol_0x15
└── transport

Looking inside the protocol directory we found:

/sys/kernel/debug/scmi/protocol_0x14/
├── 000
│   ├── enable
│   ├── enable_atomic_irqs_off
│   ├── enable_atomic_irqs_on
│   ├── info
│   │   ├── enable_latency
│   │   ├── name
│   │   ├── num_rates
│   │   ├── rate_discrete
│   │   └── rates
│   └── rate_get_set
├── 001
│   ├── enable
│   ├── enable_atomic_irqs_off
│   ├── enable_atomic_irqs_on
│   ├── info
│   │   ├── enable_latency
│   │   ├── name
│   │   ├── num_rates
│   │   ├── rate_discrete
│   │   └── rates
│   └── rate_get_set
├── 002
│   ├── enable
│   ├── enable_atomic_irqs_off
│   ├── enable_atomic_irqs_on
│   ├── info
│   │   ├── enable_latency
│   │   ├── max_rate
│   │   ├── min_rate
│   │   ├── name
│   │   ├── rate_discrete
│   │   └── step_size
│   └── rate_get_set
└── version

- one toplevel 'version' entry to state SCMI Clock protocol version
  supported by the platform

- one subdirectory for each resource (clocks in this case) that has been
  found on the system and named by its ID: inside these resource subdir we
  found a resource specific info/ subdir describing the resource and the
  SCMI protocol operations available as exposed by the SCMI protocol.
  (mostly reflecting operations defined in scmi_protocol.h)

Note that, the operations exposed here could be some variations of the
basic SCMI operations (like the above enable/disable with IRQs on/off).

The KSelftest are basically structured in the same way, a bunch of tests
scripts organized by protocol directories mimicking this layout.

The fundamental issue with all of this is that, the above level of freedom
in testing the SCMI stack pose a serious risk of shooting ourselves in the
foot:

 - what if some clock test just kills the machine disablling something
   fundamental at runtime ?

 - what if instead our clock rate test is so good that spots an issue
   with the SCMI backend server (inadvertenly) and we fry the board ?

All of the above depends really on what SCMI backend we use for testing:
we should stick to more conservative tests on real HW, while we could
engage in more radical and invasive testcases at the presence of some more
virtualized backend where, ideally, nothing is real and everything is
mocked.

For this reasons the SCMI debugfs exposes some detailed information about
the running backend SCMI stack like 

/sys/kernel/debug/scmi/info/
├── impl_ver
├── major_ver
├── minor_ver
├── num_agents
├── num_protocols
├── sub_vendor_id
└── vendor_id

so that the examples tests in the Kselftest patch have been structured to
check for the running SCMI incarnation and eventually skip the most
invasive testcases (like clk rate set) if not in presence of a mocked
virtualized backend.

In other words this driver and the KSelftest try to stay agnostic and be
as general as possible so that can be used, with different extents, on a
number of different backend SCMI server implementations.

All the current SCMI debugfs entries are mre extensively documented in
Documentation/ABI/testing,

Remaining TODO:

- implement test driver support for all the other std protocols
- more tests (restructuring these armm64/scmi KSelftests)
- expose stats/timeouts/errors
- expose Base protocol ?
  (note that for its nature the SCMI Test driver loads only after the
   SCMI core stack has been loaded and the Base operations have been
   issued already to gather basic info from the platform)

This series is based on top of sudeep/for-next/scmi/updates [1]

commit 38a0e5b735d6 ("clk: scmi: Support atomic clock enable/disable API")

Thanks,
Cristian

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi/updates

Cristian Marussi (16):
  firmware: arm_scmi: Simplify scmi_devm_notifier_unregister
  firmware: arm_scmi: Make protocols init fail on basic errors
  firmware: arm_scmi: Add multiple protocols registration support
  firmware: arm_scmi: Add .version_get protocol operation
  firmware: arm_scmi: Expose information on configured transport
  firmware: arm_scmi: Define a common SCMI_MAX_PROTOCOLS value
  debugfs: Add signed versions of debugfs_create_u32/64 helpers
  firmware: arm_scmi: Add SCMI Testing driver
  firmware: arm_scmi: testing: Add Clock protocol full support
  firmware: arm_scmi: testing: Add Sensor protocol basic support
  firmware: arm_scmi: Add test driver generic notification helpers
  firmware: arm_scmi: Add Sensor notifications testing support
  firmware: arm_scmi: Add testing Power protocol support
  firmware: arm_scmi: Add testing Voltage protocol support
  selftests: arm64: Add initial SCMI testcases
  [DEBUG]: firmware: arm_scmi: Add Kconfig to allow SCMI Testing driver
    coexistence

 Documentation/ABI/testing/debugfs-scmi        | 269 ++++++++
 drivers/firmware/arm_scmi/Kconfig             |  18 +
 drivers/firmware/arm_scmi/Makefile            |   2 +
 drivers/firmware/arm_scmi/base.c              |   5 +-
 drivers/firmware/arm_scmi/bus.c               |   4 +-
 drivers/firmware/arm_scmi/clock.c             |   9 +-
 drivers/firmware/arm_scmi/common.h            |  24 +-
 drivers/firmware/arm_scmi/driver.c            |  46 +-
 drivers/firmware/arm_scmi/notify.c            |  34 +-
 drivers/firmware/arm_scmi/perf.c              |  11 +-
 drivers/firmware/arm_scmi/power.c             |  11 +-
 drivers/firmware/arm_scmi/reset.c             |  11 +-
 .../arm_scmi/scmi_test_driver/Makefile        |   5 +
 .../arm_scmi/scmi_test_driver/scmi_test.c     | 160 +++++
 .../arm_scmi/scmi_test_driver/test_clocks.c   | 287 ++++++++
 .../arm_scmi/scmi_test_driver/test_common.c   | 285 ++++++++
 .../arm_scmi/scmi_test_driver/test_common.h   | 108 +++
 .../arm_scmi/scmi_test_driver/test_powers.c   | 105 +++
 .../arm_scmi/scmi_test_driver/test_sensors.c  | 627 ++++++++++++++++++
 .../arm_scmi/scmi_test_driver/test_voltages.c |  51 ++
 drivers/firmware/arm_scmi/sensors.c           |   5 +-
 drivers/firmware/arm_scmi/system.c            |  11 +-
 drivers/firmware/arm_scmi/voltage.c           |   1 +
 fs/debugfs/file.c                             |  74 +++
 fs/libfs.c                                    |  12 +-
 include/linux/debugfs.h                       |   4 +
 include/linux/scmi_protocol.h                 |  47 +-
 tools/testing/selftests/arm64/Makefile        |   2 +-
 tools/testing/selftests/arm64/scmi/Makefile   |   6 +
 tools/testing/selftests/arm64/scmi/config     |   1 +
 .../arm64/scmi/kselftest_scmi_lib.sh          | 118 ++++
 .../selftests/arm64/scmi/run_scmi_tests.sh    |  69 ++
 .../testcases/protocol_0x14/clock_enable.sh   |  33 +
 .../protocol_0x14/clock_rate_read.sh          |  18 +
 .../protocol_0x14/clock_rate_write.sh         |  29 +
 .../testcases/protocol_0x15/sensor_reading.sh |  17 +
 36 files changed, 2463 insertions(+), 56 deletions(-)
 create mode 100644 Documentation/ABI/testing/debugfs-scmi
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/Makefile
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/scmi_test.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_clocks.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_common.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_common.h
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_powers.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_sensors.c
 create mode 100644 drivers/firmware/arm_scmi/scmi_test_driver/test_voltages.c
 create mode 100644 tools/testing/selftests/arm64/scmi/Makefile
 create mode 100644 tools/testing/selftests/arm64/scmi/config
 create mode 100644 tools/testing/selftests/arm64/scmi/kselftest_scmi_lib.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/run_scmi_tests.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_enable.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_read.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/testcases/protocol_0x14/clock_rate_write.sh
 create mode 100755 tools/testing/selftests/arm64/scmi/testcases/protocol_0x15/sensor_reading.sh

-- 
2.17.1

