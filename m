Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759DD50098C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 11:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241622AbiDNJUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 05:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbiDNJUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 05:20:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B1A50B34;
        Thu, 14 Apr 2022 02:18:14 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649927892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VKYOKsNdtO2aGH0r6q2BwEHQC1rQZ88mXZkktgYJ4/M=;
        b=fMEDdqLD67Im0YAB13eH/+DEbam1jQociwxB96JNa3zPzdM6DQqjoG1jroCoSV2nnnwkBH
        fLKur5K2WWkZ2qAOtUUboTc/+1T0Dphvz0hHIYbur9ZNZX/pvnAdYRkiEUxMGDvUFsysee
        siMxqZzxKrO0F4B1YJAGDvM0Vm2GxSEoLNQyOAwiJTjEwUKfu5TmSjAd0y8COHgIUanJ7s
        fERMeFkrqtIEjBaDl2J/UCGf25sLTQ9kHVlCBdIzVBqq2L0MBrJ5OClTD0n41yxOE5UmFS
        4u91nEvC4UadJOZslVkHhy416tn1ZXlPGH+cgwH1ZvWgVQG5QSgHmu/9mUizyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649927892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VKYOKsNdtO2aGH0r6q2BwEHQC1rQZ88mXZkktgYJ4/M=;
        b=sero7Ruh9jP3d3VowrepRmpjg7HgtFyrarLTJ3Ys29MkDnSdA84oPsf2bygzOdsNcBl9de
        euYeBzXWygmu/5BQ==
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH v2 0/3] tracing: Introduce trace clock tai
Date:   Thu, 14 Apr 2022 11:18:02 +0200
Message-Id: <20220414091805.89667-1-kurt@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the Linux kernel tracing infrastructure has support for using different clocks
to generate timestamps for trace events. Especially in TSN networks it's useful
to have TAI as trace clock, because the application scheduling is done in
accordance to the network time, which is based on TAI. With a tai trace_clock in
place, it becomes very convenient to correlate network activity with Linux
kernel application traces.

However, there's no fast accessor for CLOCK_TAI yet. Therefore, patch #1 is
adding one. Patch #2 introduces the clock and the last one adds documentation
for it.

Changes since v1:

 - Add missing data_race() annotation for TAI offset which is accessed without
   any form of locking for KCSAN (Thomas)
 - Add missing documentation entry for ktime_get_tai_fast_ns()
 - Minor changelog tweaks

Previous versions:

 - https://lore.kernel.org/all/20220409081300.4762-1-kurt@linutronix.de/

Thanks,
Kurt

Kurt Kanzenbach (3):
  timekeeping: Introduce fast accessor to clock tai
  tracing: Introduce trace clock tai
  tracing: Add documentation for trace clock tai

 Documentation/core-api/timekeeping.rst |  1 +
 Documentation/trace/ftrace.rst         | 12 ++++++++++++
 include/linux/timekeeping.h            |  1 +
 kernel/time/timekeeping.c              | 17 +++++++++++++++++
 kernel/trace/trace.c                   |  1 +
 5 files changed, 32 insertions(+)

-- 
2.30.2

