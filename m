Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517875A1874
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbiHYSMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHYSM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:12:29 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 52CECCE10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:12:28 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 27PI878E022924;
        Thu, 25 Aug 2022 13:08:07 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 27PI86ZE022921;
        Thu, 25 Aug 2022 13:08:06 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Thu, 25 Aug 2022 13:08:06 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Uros Bizjak <ubizjak@gmail.com>,
        x86@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, sv@linux.ibm.com
Subject: Re: [PATCH] compiler-gcc.h: Remove ancient workaround for gcc PR 58670
Message-ID: <20220825180806.GG25951@gate.crashing.org>
References: <20220624141412.72274-1-ubizjak@gmail.com> <1661422971.cqtahfm22j.naveen@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1661422971.cqtahfm22j.naveen@linux.ibm.com>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Aug 25, 2022 at 04:00:52PM +0530, Naveen N. Rao wrote:
> This is causing a build issue on ppc64le with a new patch replacing use 
> of unreachable() with __builtin_unreachable() in __WARN_FLAGS():
> https://lore.kernel.org/linuxppc-dev/20220808114908.240813-2-sv@linux.ibm.com/

What is the compiler version?  If this is a GCC version that is still
supported, could you please open a PR?  <https://gcc.gnu.org/bugs.html>

> during RTL pass: combine
> In file included from /linux/kernel/locking/rtmutex_api.c:9:
> /linux/kernel/locking/rtmutex.c: In function 
> '__rt_mutex_slowlock.constprop':
> /linux/kernel/locking/rtmutex.c:1612:1: internal compiler error: in 
> purge_dead_edges, at cfgrtl.c:3369
> 1612 | }
>      | ^
> 0x142817c internal_error(char const*, ...)
> 	???:0
> 0x5c8a1b fancy_abort(char const*, int, char const*)
> 	???:0
> 0x72017f purge_all_dead_edges()
> 	???:0
> Please submit a full bug report,
> with preprocessed source if appropriate.
> Please include the complete backtrace with any bug report.
> See <file:///usr/share/doc/gcc-11/README.Bugs> for instructions.

(For some reason your compiler does not show compiler source code file
names or line numbers.)

So it is GCC 11...  is it 11.3?  If not, please try with that.

> So, it looks like gcc still has issues with certain uses of asm goto.

Could be.  Please attach preprocessed code (or reduced code that shows
the same problem if you have that / can make that).  Thanks!


Segher
