Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFE557B6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbiGTM4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGTM4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:56:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 668AC252;
        Wed, 20 Jul 2022 05:56:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BA311576;
        Wed, 20 Jul 2022 05:56:01 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E830F3F70D;
        Wed, 20 Jul 2022 05:55:58 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Guenter Roeck <linux@roeck-us.net>, linux-acpi@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ionela Voinescu <ionela.voinescu@arm.com>
Subject: [PATCH v3 0/3] arch_topology/cacheinfo: Fixes for v5.20
Date:   Wed, 20 Jul 2022 13:55:37 +0100
Message-Id: <20220720-arch_topo_fixes-v3-0-43d696288e84@arm.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are fixes for the cacheinfo/arch_topology updates containing [0]
queued currently in the -next via [3].

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

---
Changes in v3 from v2[2]:
	- Dropped mapping and unmapping of PPTT at runtime using
	  acpi_{get,put}_table() to avoid "BUG: sleeping function
	  called from invalid context"
	- Added tested-by from Geert

Changes in v2[2] from v1[1]:
        - Changed the cacheinfo per-cpu allocation to be atomic
	  to fix possible "BUG: sleeping function called from invalid context"
        - Added all the received tags

[0] https://lore.kernel.org/all/20220704101605.1318280-1-sudeep.holla@arm.com
[1] https://lore.kernel.org/all/20220713133344.1201247-1-sudeep.holla@arm.com
[2] https://lore.kernel.org/all/20220715102609.2160689-1-sudeep.holla@arm.com
[3] https://lore.kernel.org/all/20220706124644.2276077-1-sudeep.holla@arm.com

---
Sudeep Holla (3):
      cacheinfo: Use atomic allocation for percpu cache attributes
      ACPI: PPTT: Leave the table mapped for the runtime usage
      arch_topology: Fix cache attributes detection in the CPU hotplug path

 drivers/acpi/pptt.c          | 102 ++++++++++++++++++++-----------------------
 drivers/base/arch_topology.c |  16 +++----
 drivers/base/cacheinfo.c     |   2 +-
 3 files changed, 54 insertions(+), 66 deletions(-)
---
base-commit: 7128af87c7f1c30cd6cebe0b012cc25872c689e2
change-id: 20220720-arch_topo_fixes-d91d43827aeb

Best regards,
-- 
Regards,
Sudeep

