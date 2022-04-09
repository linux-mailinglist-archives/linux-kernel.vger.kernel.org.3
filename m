Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0624FA5CC
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiDIIP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234210AbiDIIPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:15:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116942DD58;
        Sat,  9 Apr 2022 01:13:20 -0700 (PDT)
From:   Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649491997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pFzCSKR7Mj3eFHDV5uYg79nOA2mgZ7Z8ghkTdFnmA2M=;
        b=M6gInquBuYlHQLj4q/VchocaySCfZdv/kJ++HxEh2gqjIKrL1GL9VX0hUP7anUDktyrTRN
        Su7MP338oGS0Hav7B3qQxsX7BvS9D56YLklP3YNLr+nSfz4k6NmBlzmeZqoYeSn4eXlk45
        EjLK3CZqtMIgExl9O+92KKzECbdR3UjV4ERGZHy+sHLs+42vtGTnwxCp0zd9zaFL8a/BUA
        66UrMytVHwsBr536/qNLDeNcODcrwSc6ezAHg6IaBVeqtsjYWEQ7SV/bcefk2htSeDiPso
        LaiQmsE5fB7SLEuUDRqAV7b8t8cyvQ/J8fcEnmenvglh+HrD/CJqbd2Oz9ei4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649491997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pFzCSKR7Mj3eFHDV5uYg79nOA2mgZ7Z8ghkTdFnmA2M=;
        b=9bkcjq9J6pVEfSsRoRfO9VCadpyN+lDsN0thArHJd4KgI5+1f23CRhhsDckGTg+Xcsg8iP
        ekf4JvL/6a70VFCA==
To:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 0/3] tracing: Introduce trace clock tai
Date:   Sat,  9 Apr 2022 10:12:57 +0200
Message-Id: <20220409081300.4762-1-kurt@linutronix.de>
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

Thanks,
Kurt

Kurt Kanzenbach (3):
  timekeeping: Introduce fast accessor to clock tai
  tracing: Introduce trace clock tai
  tracing: Add documentation for trace clock tai

 Documentation/trace/ftrace.rst | 12 ++++++++++++
 include/linux/timekeeping.h    |  1 +
 kernel/time/timekeeping.c      | 17 +++++++++++++++++
 kernel/trace/trace.c           |  1 +
 4 files changed, 31 insertions(+)

-- 
2.30.2

