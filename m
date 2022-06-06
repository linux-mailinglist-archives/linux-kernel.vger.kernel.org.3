Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6F753EAB2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiFFKC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 06:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiFFKCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 06:02:53 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9F332E58
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 03:02:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7307F1596;
        Mon,  6 Jun 2022 03:02:51 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7F1C33F66F;
        Mon,  6 Jun 2022 03:02:49 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        daniel.lezcano@linaro.org, tarek.el-sherbiny@arm.com,
        adrian.slatineanu@arm.com, souvik.chakravarty@arm.com,
        wleavitt@marvell.com, wbartczak@marvell.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 0/7] SCMIv3.1 Powercap protocol and driver
Date:   Mon,  6 Jun 2022 11:02:23 +0100
Message-Id: <20220606100230.3465828-1-cristian.marussi@arm.com>
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

As a last step in the series an ARM SCMI based powercap driver is added,
which takes care to expose via the Powercap framework all the SCMI Powercap
zones that have been discovered asking the SCMI platform firmware.

Basic testing has been performed against an emulated SCMI platform
supporting SCMIv3.1 Powercap protocol using powercap-utils, with the
exclusion of the FCs bits whose generalization has been only tested for
regression on a JUNO platform sporting a regular SCP/SCMI v2.10 fw.

The series is based on sudeep/for-next/scmi [1] on top of:

commit ef189d7c6156 ("firmware: arm_scmi: Remove all the unused local variables")

Thanks,
Cristian

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
  firmware: arm_scmi: Make use of FastChannels configurable
  firmware: arm_scmi: Add scmi_driver optional setup/teardown callbacks
  powercap: arm_scmi: Add SCMI Powercap based driver

 .../bindings/firmware/arm,scmi.yaml           |  10 +
 drivers/firmware/arm_scmi/Kconfig             |  13 +
 drivers/firmware/arm_scmi/Makefile            |   2 +-
 drivers/firmware/arm_scmi/bus.c               |  15 +-
 drivers/firmware/arm_scmi/driver.c            | 167 ++++
 drivers/firmware/arm_scmi/perf.c              | 218 +----
 drivers/firmware/arm_scmi/powercap.c          | 857 ++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h         |  23 +
 drivers/powercap/Kconfig                      |  13 +
 drivers/powercap/Makefile                     |   1 +
 drivers/powercap/arm_scmi_powercap.c          | 537 +++++++++++
 include/linux/scmi_protocol.h                 | 129 +++
 12 files changed, 1810 insertions(+), 175 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/powercap.c
 create mode 100644 drivers/powercap/arm_scmi_powercap.c

-- 
2.32.0

