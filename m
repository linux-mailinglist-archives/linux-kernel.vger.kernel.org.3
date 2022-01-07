Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E344487F22
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:58:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbiAGW6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:58:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35330 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiAGW6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:58:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D4362015
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 22:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D436CC36AED;
        Fri,  7 Jan 2022 22:58:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1n5yBz-001gya-Ou;
        Fri, 07 Jan 2022 17:58:39 -0500
Message-ID: <20220107225655.647376947@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 07 Jan 2022 17:56:55 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 0/2] tracing: Fix filtering on string pointers
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If filtering on an event's string pointer that happens to point into
user space, then the pointer could cause a page fault and crash the
kernel.

Also, have system call events use the temp buffer when filtering.


Steven Rostedt (2):
      tracing: Have syscall trace events use trace_event_buffer_lock_reserve()
      tracing: Add test for user space strings when filtering on string pointers

----
 kernel/trace/trace_events_filter.c | 79 +++++++++++++++++++++++++++++++++++++-
 kernel/trace/trace_syscalls.c      |  6 +--
 2 files changed, 79 insertions(+), 6 deletions(-)
