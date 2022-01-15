Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F3F48F94F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 21:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbiAOUgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 15:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbiAOUgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 15:36:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B396C061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 12:36:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8D53B80B3D
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 20:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48AEC36AE5;
        Sat, 15 Jan 2022 20:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642278969;
        bh=j81iu10IGA5MM7vZ+4Xflpm3VzuElFYMdZD244D7f5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LKaqP8ny21GJ1HjC2QlE+3d0zehf1jptH+vE+ls2WL1yuH+ubKPqPnkvgRfUS13zT
         Da3189wOonGl3l1jcwzRT2HpFZ0nbhterUBop+eiG/IM3Q6tfwmnK3Cn784s/9FBlH
         6YY1uiMt8KwkYgpOZ7B3YWKc3Ran2ldQIEokF1wUBEr0WxyUbtZG7e80YDr3kqXkqh
         Y3ByVd/CyJZENnrMaFfMddBbZ9wZU7s4RyfrU65exjdfmAgHShs0Hvl0Kl+X5rlrjk
         pBIUf5mUfeLrwimXIFCsUOvgldMGljupoaN5bPB506zOPO7fB6KDrtqq2sYlYBg5KO
         gjhRphO614Zeg==
Date:   Sat, 15 Jan 2022 13:36:04 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Yinan Liu <yinan@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
        llvm@lists.linux.dev
Subject: Re: [for-next][PATCH 10/31] scripts: ftrace - move the
 sort-processing in ftrace_init
Message-ID: <YeMwNEfNaGErFthk@archlinux-ax161>
References: <20220111173030.999527342@goodmis.org>
 <20220111173115.079437896@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220111173115.079437896@goodmis.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven and Yinan,

On Tue, Jan 11, 2022 at 12:30:41PM -0500, Steven Rostedt wrote:
> From: Yinan Liu <yinan@linux.alibaba.com>
> 
> When the kernel starts, the initialization of ftrace takes
> up a portion of the time (approximately 6~8ms) to sort mcount
> addresses. We can save this time by moving mcount-sorting to
> compile time.
> 
> Link: https://lkml.kernel.org/r/20211212113358.34208-2-yinan@linux.alibaba.com
> 
> Signed-off-by: Yinan Liu <yinan@linux.alibaba.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

This change as commit 72b3942a173c ("scripts: ftrace - move the
sort-processing in ftrace_init") in -next causes a bunch of warnings at
the beginning of the build when using clang as the host compiler:

$ make -skj"$(nproc)" LLVM=1 distclean allmodconfig init/main.o
In file included from scripts/sorttable.c:195:
scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:2: note: remove the 'if' if its condition is always false
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:6: note: remove the '||' if its condition is always false
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:6: note: remove the '||' if its condition is always false
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:288:30: note: initialize the variable 'mcount_sort_thread' to silence this warning
        pthread_t mcount_sort_thread;
                                    ^
                                     = 0
In file included from scripts/sorttable.c:197:
scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:2: note: remove the 'if' if its condition is always false
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:6: note: remove the '||' if its condition is always false
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:380:6: note: remove the '||' if its condition is always false
        if (!mstruct.init_data_sec || !_start_mcount_loc || !_stop_mcount_loc) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:370:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        if (pthread_create(&orc_sort_thread, NULL,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:370:2: note: remove the 'if' if its condition is always false
        if (pthread_create(&orc_sort_thread, NULL,
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:360:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        if (orc_ip_size % sizeof(int) != 0 ||
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:360:2: note: remove the 'if' if its condition is always false
        if (orc_ip_size % sizeof(int) != 0 ||
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:360:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
        if (orc_ip_size % sizeof(int) != 0 ||
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:360:6: note: remove the '||' if its condition is always false
        if (orc_ip_size % sizeof(int) != 0 ||
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:360:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
        if (orc_ip_size % sizeof(int) != 0 ||
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:360:6: note: remove the '||' if its condition is always false
        if (orc_ip_size % sizeof(int) != 0 ||
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:353:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        if (!g_orc_ip_table || !g_orc_table) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:353:2: note: remove the 'if' if its condition is always false
        if (!g_orc_ip_table || !g_orc_table) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
scripts/sorttable.h:353:6: warning: variable 'mcount_sort_thread' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
        if (!g_orc_ip_table || !g_orc_table) {
            ^~~~~~~~~~~~~~~
scripts/sorttable.h:479:6: note: uninitialized use occurs here
        if (mcount_sort_thread) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:353:6: note: remove the '||' if its condition is always false
        if (!g_orc_ip_table || !g_orc_table) {
            ^~~~~~~~~~~~~~~~~~
scripts/sorttable.h:288:30: note: initialize the variable 'mcount_sort_thread' to silence this warning
        pthread_t mcount_sort_thread;
                                    ^
                                     = 0
12 warnings generated.

Should mcount_sort_thread be zero initialized or is there something else
going on here? I am currently hunting down a bunch of other regressions
so apologies for just the report rather than a patch to fix it.

Cheers,
Nathan
