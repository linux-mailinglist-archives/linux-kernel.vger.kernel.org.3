Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130FC584807
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 00:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiG1WLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 18:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiG1WLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 18:11:36 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82FF678DD5;
        Thu, 28 Jul 2022 15:11:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC431106F;
        Thu, 28 Jul 2022 15:11:35 -0700 (PDT)
Received: from mammon-tx2.austin.arm.com (mammon-tx2.austin.arm.com [10.118.28.62])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id DF4D13F70D;
        Thu, 28 Jul 2022 15:11:34 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, viresh.kumar@linaro.org,
        robert.moore@intel.com, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v2 0/1] Disable FIE on machines with slow counters
Date:   Thu, 28 Jul 2022 17:10:42 -0500
Message-Id: <20220728221043.4161903-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FIE assumes the delivered/relative perf registers are fast to read so
it goes ahead and hits them quite frequently. On a couple Arm
platforms though they end up in PCC regions which require mailbox
handshaking with other parts of the platform.

This results in a lot of overhead in the cppc_fie task. As such lets
runtime disable FIE if we detect it enabled on one of those platforms.
Also allow the user to manually disable it via a module parameter.

v1->v2:
	Apply Rafael's review comments.
	Move the MODULE_PARAM into the ifdef
	Fix compiler warning when ACPI_CPPC_LIB is disabled.
	
Jeremy Linton (1):
  ACPI: CPPC: Disable FIE if registers in PCC regions

 drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
 include/acpi/cppc_acpi.h       |  5 +++++
 3 files changed, 61 insertions(+), 4 deletions(-)

-- 
2.35.3

