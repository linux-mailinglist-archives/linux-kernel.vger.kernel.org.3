Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168BB51495B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359265AbiD2Mea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 08:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359174AbiD2Me2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 08:34:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F434B647F
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 05:31:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E2DD1063;
        Fri, 29 Apr 2022 05:31:09 -0700 (PDT)
Received: from e127744.arm.com (unknown [10.57.46.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A09FE3F73B;
        Fri, 29 Apr 2022 05:31:06 -0700 (PDT)
From:   German Gomez <german.gomez@arm.com>
To:     coresight@lists.linaro.org, mathieu.poirier@linaro.org,
        suzuki.poulose@arm.com
Cc:     james.clark@arm.com, leo.yan@linaro.org, mike.leach@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        German Gomez <german.gomez@arm.com>
Subject: [PATCH 0/2] coresight: etm4x: Expose default timestamp source in sysfs
Date:   Fri, 29 Apr 2022 13:30:58 +0100
Message-Id: <20220429123100.268059-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm Sending this sysfs addition to the etm4x driver in order to expose
the timestamp source of the trace (given by the TRFCR_ELx.TS register).

As mentioned in [1/2], having this information is useful for assigning
Kernel times to the perf samples.

Thanks,
German

German Gomez (3):
  coresight: etm4x: Expose default timestamp source in sysfs
  coresight: etm4x: docs: Add documentation for 'ts_source' sysfs
    interface
  perf cs_etm: Store ts_source in AUXTRACE_INFO fields

 .../testing/sysfs-bus-coresight-devices-etm4x |  8 +++
 .../coresight/coresight-etm4x-reference.rst   | 14 ++++
 arch/arm64/include/asm/sysreg.h               |  1 +
 .../coresight/coresight-etm4x-sysfs.c         | 34 ++++++++++
 tools/perf/arch/arm/util/cs-etm.c             | 64 +++++++++++++++++--
 tools/perf/util/cs-etm.c                      | 61 +++++++++---------
 tools/perf/util/cs-etm.h                      | 13 +++-
 7 files changed, 159 insertions(+), 36 deletions(-)

-- 
2.25.1

