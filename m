Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F3E348E318
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 04:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239052AbiANDuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 22:50:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37424 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiANDux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 22:50:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC2260DD4;
        Fri, 14 Jan 2022 03:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85A7C36AE9;
        Fri, 14 Jan 2022 03:50:50 +0000 (UTC)
Date:   Thu, 13 Jan 2022 22:50:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
Message-ID: <20220113225048.17d4d9b7@rorschach.local.home>
In-Reply-To: <20220114143418.06035a75@canb.auug.org.au>
References: <20220112113103.7e03448f@canb.auug.org.au>
        <20220114120240.4b592480@canb.auug.org.au>
        <20220113211633.4f9bea57@gandalf.local.home>
        <20220114135808.391398d0@canb.auug.org.au>
        <20220114140258.2fe2f076@canb.auug.org.au>
        <20220113222539.30202e01@rorschach.local.home>
        <20220114143418.06035a75@canb.auug.org.au>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Jan 2022 14:34:18 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> > Does it fail on anything else?  
> 
> This is the first build I do after merging each tree, so I don't know
> about others.  I may be able to do some testing later today (after
> linux-next is released).

Could you see if this fixes it? This is a revert of part of the patch.
Yinan, was there a reason you moved this code?

-- Steve

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index dd9955f45774..5cdd9bc5c385 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -400,9 +400,6 @@ if [ -n "${CONFIG_DEBUG_INFO_BTF}" -a -n "${CONFIG_BPF}" ]; then
 	${RESOLVE_BTFIDS} vmlinux
 fi
 
-info SYSMAP System.map
-mksysmap vmlinux System.map
-
 if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
 	info SORTTAB vmlinux
 	if ! sorttable vmlinux; then
@@ -411,6 +408,9 @@ if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
 	fi
 fi
 
+info SYSMAP System.map
+mksysmap vmlinux System.map
+
 # step a (see comment above)
 if [ -n "${CONFIG_KALLSYMS}" ]; then
 	mksysmap ${kallsyms_vmlinux} .tmp_System.map
