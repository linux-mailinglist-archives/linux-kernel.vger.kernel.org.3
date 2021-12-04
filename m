Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755FE468557
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355095AbhLDO1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 09:27:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233795AbhLDO1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 09:27:06 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638627820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5b2uriykKgPHTmlAG2P2NYmE9drKwdyejG/Ik80gAI=;
        b=VqEkpk2BgU6O+Y29MaX161OU2b9yWfNAz2iUaQOubA4FiYI7+iPJIKB3dD8MJ7Fe6QNgEp
        5tYeFFc2azHcNvMAseXMzTGvxCkAobZBxeMlf2usJ3wpBFiuOxbgy+KmYSrnvbeWQzy7V4
        YPtSZYoAbm+JGhBexbQnPh90Cd1q8Bfed7Isi8siUwjujmPCzgKjImp7UQw8UONUz4FGDC
        UeExIEKucbZ6rfPnEN4no3d3Jk/WwdQVUdY0VhveaYiwBdI2XdoTSrVPObCtq3rR8L6xtH
        V21tMU4govDAsN5oT/Jxnmufigw6H7u9kROUfLXpun3a2Bb4VKxqCa9n3eE+gg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638627820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+5b2uriykKgPHTmlAG2P2NYmE9drKwdyejG/Ik80gAI=;
        b=0mYQi0hLjkh5+1Gk0y47xn63zi1Sl239lQwP8uAeKzqHB/VVTlmmg+ceXlmtv8eFGxrht/
        W8VMLZUqE0hMtLDw==
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v12 2/5] perf: Add a counter for number of user access
 events in context
In-Reply-To: <CAL_JsqJ9kkch_SB6LT_fwxk9QS36zbwsj5wu+dtY7yWe6SEMug@mail.gmail.com>
References: <20211027201641.2076427-1-robh@kernel.org>
 <20211027201641.2076427-3-robh@kernel.org> <87zgpl9rqq.ffs@tglx>
 <CAL_JsqJ9kkch_SB6LT_fwxk9QS36zbwsj5wu+dtY7yWe6SEMug@mail.gmail.com>
Date:   Sat, 04 Dec 2021 15:23:39 +0100
Message-ID: <87sfv84ff8.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03 2021 at 09:58, Rob Herring wrote:
> On Tue, Nov 30, 2021 at 4:57 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> I've rewritten it like this:
>
> On arm64, user space counter access will be controlled differently
> compared to x86. On x86, access in the strictest mode is enabled for all
> tasks in an MM when any event is mmap'ed. For arm64, access is
> explicitly requested for an event and only enabled when the event's
> context is active. This avoids hooks into the arch context switch code
> and gives better control of when access is enabled.
>
> In order to configure user space access when the PMU is enabled, it is
> necessary to know if any event (currently active or not) in the current
> context has user space accessed enabled. Add a counter similar to other
> counters in the context to avoid walking the event list every time.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
