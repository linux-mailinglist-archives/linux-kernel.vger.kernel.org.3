Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122D348DD3D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:54:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237322AbiAMRym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:54:42 -0500
Received: from foss.arm.com ([217.140.110.172]:49218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230141AbiAMRyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:54:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C00F36D;
        Thu, 13 Jan 2022 09:54:40 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AB7823F766;
        Thu, 13 Jan 2022 09:54:39 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-eng@arm.com
Cc:     james.clark@arm.com, German Gomez <german.gomez@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] perf: arm_spe: make the PMSCR CX bit[3] consistent across the session
Date:   Thu, 13 Jan 2022 17:54:15 +0000
Message-Id: <20220113175417.5523-1-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The value of the CX bit of the PMSCR register is not consistent across
a perf session. There is an example in [1/2] to reproduce the issue.

This cset applies a small correction to fix the consistency issue.

- [PATCH 1/2] Makes the CX bit consistent by caching the value during
  the initialization of the SPE PMU event.
- [PATCH 2/2] Allows CONTEXT packets when profiling in CPU mode.

German Gomez (2):
  perf: arm_spe: make the PMSCR CX bit[3] consistent across the session
  perf: arm_spe: Enable CONTEXT packets if profiling in CPU mode

 drivers/perf/arm_spe_pmu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.25.1

