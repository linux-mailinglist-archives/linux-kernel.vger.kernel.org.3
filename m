Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18D2519BFD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347391AbiEDJkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 05:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiEDJkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 05:40:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C00C1ADBD
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 02:36:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C4BFED1;
        Wed,  4 May 2022 02:36:40 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF68A3FA50;
        Wed,  4 May 2022 02:36:38 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        vincent.guittot@linaro.org, daniel.lezcano@linaro.org,
        tarek.el-sherbiny@arm.com, adrian.slatineanu@arm.com,
        souvik.chakravarty@arm.com,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/7] SCMIv3.1 Powercap protocol and driver
Date:   Wed,  4 May 2022 10:36:02 +0100
Message-Id: <20220504093609.3077646-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
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

this short series introduces the last missing bit of SCMIv3.1, Powercap
protocol. Along the series, there is a small refactoring around the SCMI
FastChannels handling routines so as to reuse as much as possible the
pre-existent (and tested) FastChannel code from the Perf protocol.

As a last step in the series an ARM SCMI based powercap driver is added,
which takes care to expose via the Powercap framework all the SCMI Powercap
zones that have been discovered asking the SCMI platform firmware.

Basic testing has been performed against an emulated SCMI platform
supporting SCMIv3.1 Powercap protocol, with the exclusion of the FCs
bits whose generalization has been only tested for regression on a
JUNO platform sporting a regular SCP/SCMI v2.10 fw.

The series is based on sudeep/for-next/scmi [1] on top of:

commit c7f8852d4216 ("firmware: arm_scmi: Fix late checks on pointer dereference")

Thanks,
Cristian

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
 drivers/firmware/arm_scmi/powercap.c          | 809 ++++++++++++++++++
 drivers/firmware/arm_scmi/protocols.h         |  23 +
 drivers/powercap/Kconfig                      |  13 +
 drivers/powercap/Makefile                     |   1 +
 drivers/powercap/arm_scmi_powercap.c          | 537 ++++++++++++
 include/linux/scmi_protocol.h                 | 124 +++
 12 files changed, 1757 insertions(+), 175 deletions(-)
 create mode 100644 drivers/firmware/arm_scmi/powercap.c
 create mode 100644 drivers/powercap/arm_scmi_powercap.c

-- 
2.32.0

