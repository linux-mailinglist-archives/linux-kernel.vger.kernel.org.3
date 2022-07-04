Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D586D565230
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234458AbiGDKYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiGDKXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:23:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 215CD8D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 03:23:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33CF923A;
        Mon,  4 Jul 2022 03:23:03 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00A793F792;
        Mon,  4 Jul 2022 03:23:00 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v4 0/7] SCMIv3.1 Powercap protocol and driver
Date:   Mon,  4 Jul 2022 11:22:34 +0100
Message-Id: <20220704102241.2988447-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this short series introduces the last missing bit of SCMIv3.1, Powercap
protocol. Along the series, there is a small refactoring around the SCMI
FastChannels handling routines so as to reuse as much as possible the
pre-existent (and tested) FastChannel code from the Perf protocol.

New SCMI FC tracing support is added too along the way.

As a last step in the series an ARM SCMI based powercap driver is added,
which takes care to expose via the Powercap framework all the SCMI Powercap
zones that have been discovered asking the SCMI platform firmware.

Basic testing has been performed against an emulated SCMI platform
supporting SCMIv3.1 Powercap protocol using powercap-utils, with the
exclusion of the FCs bits whose generalization has been only tested for
regression on a JUNO platform sporting a regular SCP/SCMI v2.10 fw.

The series is based on sudeep/for-next/scmi [1] on top of:

commit 754f04cac362 ("firmware: arm_scmi: Relax CLOCK_DESCRIBE_RATES out-of-spec checks")

Thanks,
Cristian

v3 --> v4
- fixed GENMASK usage in thresholds state u64 (was broken on 32bit systems)
- dropped SCMI setup/teardown helpers patch in favour of standard module_init/exit
- dropping FCs usage configurability via Kconfig

v2 --> v3:
- added and used some SCMI Fastchannel tracing support
- reverted logic of Kconfig to configure usage of SCMI FC
- using strscpy with new SHORT_NAME_SZ in Powercap protocol
- added devm_protocol_acquire helper

v1 --> v2:
- fixed measurements thresholds updates to trigger notification
  enable update commands
- added a bit more comments
- usig bitfield.h macros
- fixed sparse complaint about missing static on global

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git/log/?h=for-next/scmi
----

Cristian Marussi (7):
  dt-bindings: firmware: arm,scmi: Add powercap protocol
  firmware: arm_scmi: Add SCMIv3.1 Powercap protocol basic support
  firmware: arm_scmi: Generalize FastChannel support
  firmware: arm_scmi: Add SCMIv3.1 Powercap FastChannels support
  include: trace: Add SCMI FastChannel tracing
  firmware: arm_scmi: Use FastChannel tracing
  powercap: arm_scmi: Add SCMI Powercap based driver

 .../bindings/firmware/arm,scmi.yaml           |  10 +
 drivers/firmware/arm_scmi/Makefile            |   2 +-
 drivers/firmware/arm_scmi/driver.c            | 167 ++++
 drivers/firmware/arm_scmi/perf.c              | 225 ++---
 drivers/firmware/arm_scmi/powercap.c          | 866 ++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h         |  23 +
 drivers/powercap/Kconfig                      |  13 +
 drivers/powercap/Makefile                     |   1 +
 drivers/powercap/arm_scmi_powercap.c          | 538 +++++++++++
 include/linux/scmi_protocol.h                 | 127 +++
 include/trace/events/scmi.h                   |  25 +
 11 files changed, 1825 insertions(+), 172 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/powercap.c
 create mode 100644 drivers/powercap/arm_scmi_powercap.c

-- 
2.32.0

