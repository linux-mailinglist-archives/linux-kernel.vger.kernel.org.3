Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49D5571BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiGLN6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGLN6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:58:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9804487F57;
        Tue, 12 Jul 2022 06:58:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C77D91596;
        Tue, 12 Jul 2022 06:58:14 -0700 (PDT)
Received: from e126387.arm.com (unknown [10.57.72.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3704B3F73D;
        Tue, 12 Jul 2022 06:58:13 -0700 (PDT)
From:   carsten.haitzler@foss.arm.com
To:     linux-kernel@vger.kernel.org
Cc:     coresight@lists.linaro.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: A patch series improving data quality of perf test for CoreSight
Date:   Tue, 12 Jul 2022 14:57:36 +0100
Message-Id: <20220712135750.2212005-1-carsten.haitzler@foss.arm.com>
X-Mailer: git-send-email 2.25.1
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

This is a prelude to adding more tests to shell tests and in order to
support putting those tests into subdirectories, I need to change the
test code that scans/finds and runs them.

To support subdirs I have to recurse so it's time to refactor the code to
allow this and centralize the shell script finding into one location and
only one single scan that builds a list of all the found tests in memory
instead of it being duplicated in 3 places.

This code also optimizes things like knowing the max width of desciption
strings (as we can do that while we scan instead of a whole new pass
of opening files). It also more cleanly filters scripts to see only
*.sh files thus skipping random other files in directories like *~
backup files, other random junk/data files that may appear and the
scripts must be executable to make the cut (this ensures the script
lib dir is not seen as scripts to run). This avoids perf test running
previous older versions of test scripts that are editor backup files
as well as skipping perf.data files that may appear and so on.

Signed-off-by: Carsten Haitzler <carsten.haitzler@arm.com>


