Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7695554E0D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358634AbiFVO6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 10:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358227AbiFVO6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 10:58:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FBED38AC;
        Wed, 22 Jun 2022 07:58:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F33213D5;
        Wed, 22 Jun 2022 07:58:11 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.38.162])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6B7AC3F792;
        Wed, 22 Jun 2022 07:58:08 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        lukasz.luba@arm.com, viresh.kumar@linaro.org, rafael@kernel.org,
        dietmar.eggemann@arm.com, nm@ti.com, sboyd@kernel.org,
        sudeep.holla@arm.com, cristian.marussi@arm.com,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/4] Energy Model power in micro-Watts and SCMI v3.1 alignment
Date:   Wed, 22 Jun 2022 15:57:58 +0100
Message-Id: <20220622145802.13032-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a patch set which changes Energy Model power values scale to
micro-Watts. It also upgrades the SCMI performance layer + scmi-cpufreq
driver to leverage the SCMI v3.1 spec and process micro-Watts power values
coming from FW. The higher precision in EM power field solves an issue
of a rounding error, which then can be misinterpreted as 'inefficient OPP'.
An example rounding issue calculation is present in patch 1/4 description.

Regards,
Lukasz Luba

Lukasz Luba (4):
  PM: EM: convert power field to micro-Watts precision and align drivers
  Documentation: EM: Switch to micro-Watts scale
  firmware: arm_scmi: Get detailed power scale from perf
  cpufreq: scmi: Support the power scale in micro-Watts in SCMI v3.1

 Documentation/power/energy-model.rst  | 14 +++---
 drivers/cpufreq/mediatek-cpufreq-hw.c |  7 +--
 drivers/cpufreq/scmi-cpufreq.c        | 15 ++++++-
 drivers/firmware/arm_scmi/perf.c      | 18 +++++---
 drivers/opp/of.c                      | 15 ++++---
 drivers/powercap/dtpm_cpu.c           |  5 +--
 drivers/thermal/cpufreq_cooling.c     | 13 +++++-
 drivers/thermal/devfreq_cooling.c     | 19 ++++++--
 include/linux/energy_model.h          | 63 ++++++++++++++++++++-------
 include/linux/scmi_protocol.h         |  8 +++-
 kernel/power/energy_model.c           | 31 ++++++++-----
 11 files changed, 146 insertions(+), 62 deletions(-)

-- 
2.17.1

