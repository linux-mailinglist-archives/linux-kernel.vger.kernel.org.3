Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89DD4D0519
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 18:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbiCGRUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 12:20:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbiCGRUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 12:20:19 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8753259A45;
        Mon,  7 Mar 2022 09:19:24 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53CDF153B;
        Mon,  7 Mar 2022 09:19:24 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.41.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 855B63FA45;
        Mon,  7 Mar 2022 09:19:22 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        anshuman.khandual@arm.com
Cc:     german.gomez@arm.com, leo.yan@linaro.com,
        James Clark <james.clark@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Branch stack improvements 
Date:   Mon,  7 Mar 2022 17:19:13 +0000
Message-Id: <20220307171917.2555829-1-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
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

I came across a few generic non-Arm issues when reviewing Anshuman's new
support for branch record buffers on Arm [1].

The first one is a fix to an error message which is misleading if the
feature is unavailable and the remaining ones make the branch type field
visible in perf report and perf script so that it can be debugged or used
by other tools.

Applies to perf/core (56dce86819)

Thanks
James

[1] https://lore.kernel.org/lkml/1642998653-21377-1-git-send-email-anshuman.khandual@arm.com/

James Clark (4):
  perf: Add error message for unsupported branch stack cases
  perf: Print branch stack entry type in --dump-raw-trace
  perf: Refactor perf script branch stack printing
  perf script: Output branch sample type

 tools/perf/builtin-script.c | 28 +++++++++++++---------------
 tools/perf/util/evsel.c     |  4 ++++
 tools/perf/util/session.c   |  5 +++--
 3 files changed, 20 insertions(+), 17 deletions(-)

-- 
2.28.0

