Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA964908F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbiAQMpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:45:24 -0500
Received: from foss.arm.com ([217.140.110.172]:57822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231622AbiAQMpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:45:23 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2984A6D;
        Mon, 17 Jan 2022 04:45:23 -0800 (PST)
Received: from e127744.arm.com (unknown [10.57.36.133])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D5ABA3F73D;
        Mon, 17 Jan 2022 04:45:21 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com, james.clark@arm.com,
        leo.yan@linaro.org
Cc:     German Gomez <german.gomez@arm.com>
Subject: [RFC PATCH 0/2] perf: arm_spe: Fix consistency of CONTEXT packets in SPE driver
Date:   Mon, 17 Jan 2022 12:44:30 +0000
Message-Id: <20220117124432.3119132-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applies a couple of small changes to the arm_spe_pmu driver.

We are seeing context packets in an inconsistent number of SPE records
even  when the perf-tool runs without the needed capabilities. This is
fixed in [1/2].

We're also allowing CONTEXT packets to be collected in per-cpu events in
[2/2].

I'm sending as an RFC because it's the first time I change driver code.
Also I'm not 100% sure of the approach in [2/2] (from a security and/or
implementation standpoint).

Thanks,
German

- [PATCH 1/2] Fixes the consistency issue with the context packets.
- [PATCH 2/2] Enables context packets in per-cpu events.

German Gomez (2):
  perf: arm_spe: Fix consistency of PMSCR register bit CX
  perf: arm_spe: Enable CONTEXT packets in SPE traces if the profiler
    runs in CPU mode.

 drivers/perf/arm_spe_pmu.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.25.1

