Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC86B4A0169
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 21:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351098AbiA1UId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 15:08:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40502 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiA1UIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 15:08:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7E3C61DBF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 20:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4558C340E7;
        Fri, 28 Jan 2022 20:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643400511;
        bh=XR312gwwkivjOFnJoiBOcc/U2tYDpRKzm7K0DpQ3Z0A=;
        h=From:To:Cc:Subject:Date:From;
        b=BCTQcKWigd8Rxzn5KOYKibnWXQLFBytmNn/CuqbEq4wN3u8yEf/lOsc4su1x2uyl5
         QXkIbD2+6eIjcLUBL/upExq7+4zBxiQmLsV0RITBRj716wkDW4ptUi0J5MXHkrYF7r
         ZaSJMUfrLJeErDWRN+DUaO1kzv3u45jFL//ogfhXjnM23Ots2DWekXq3ypYGpPNkc5
         flNuDz+lX7lCEPjd58L4hBNkX8i+Y+0SxnGJPiXvBDcIGGc8M0EnieXgAFo6TKFKuS
         kocC67YVeAa1KadNDZ7hTOHZzp81MhjY3gmOPcCfHDjgVCXX5r5JEv30hsBW/MFink
         NrJsaPygOwwnQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH v2 0/2] tracing: Misc bugfixes
Date:   Fri, 28 Jan 2022 14:08:25 -0600
Message-Id: <cover.1643399022.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were 2 patches in v1 that were flagged by the 0day robot for
strncpy off-by-1 warnings:

  tracing: Remove size restriction on hist trigger cmd error logging
  tracing: Remove size restriction on synthetic event cmd error logging

  warning: 'strncpy' output truncated before terminating nul copying
  as many bytes from a string as its length [-Wstringop-truncation]

This v2 patchset consists of just those two patches with the fix for
those warnings.

Tom

v1 text below


Hi Steve,

This is an assorted bunch of bugfixes addressing a bugzilla bug,
smatch warnings, and related things I found while fixing those.  In
particular, when looking at the bugzilla bug,
https://bugzilla.kernel.org/show_bug.cgi?id=215513, I noticed that the
err_log output looked truncated and looking further into it found that
it was, because the hist trigger command was very long, exceeding the
256 character limit.

Obviously that's too short, and the final 3 patches remove that
limitation.

Tom

The following changes since commit ca965f23256b350ebd94b3dc1a319f28e8267f5f:

  tracing: Remove size restriction on tracing_log_err cmd strings (2022-01-27 15:38:28 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/zanussi/linux-trace.git ftrace/misc-bugfixes-v2

Tom Zanussi (2):
  tracing: Remove size restriction on hist trigger cmd error logging
  tracing: Remove size restriction on synthetic event cmd error logging

 kernel/trace/trace_events_hist.c  | 30 +++++++++++++++++++++++-------
 kernel/trace/trace_events_synth.c | 17 ++++++++++++++---
 2 files changed, 37 insertions(+), 10 deletions(-)

-- 
2.17.1

