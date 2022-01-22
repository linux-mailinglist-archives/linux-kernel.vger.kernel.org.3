Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 505E1496D24
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 18:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbiAVRsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 12:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiAVRsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 12:48:36 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3970C06173B;
        Sat, 22 Jan 2022 09:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kTOLNIcUI/OpFocR5/mh8LFmWzu6xroLWktyW1LbA4c=; b=pX33jnXRpPi7N+XWJ91t6H6S7m
        Ji6uvc9I15QtNcWtGAqiV3Ept53eczK6Wmv2J8iTHgxkz9qaPchBUzcUEWtuigdAPjS71ag8A7hkP
        od+nChR8VUGt4NIAv6UffFGV8wriqBGvX6vgp/YpSsNckrNk1mY8FWrDROB7uSJYo1i6Bfj5aUDoP
        lRMpersmPuuJf5mKlSlzj+x3Uj4bBqt+ylWejQf5EjZTCNZgUxS1kjdpxTGyFS1ovtYUUAeKn6M/3
        4apVPO4lxDlD2+3trKkAMr/m/oOHWLHz0QwpzTF/Rj4FFBd2Wr48nLzo/aEI+7njZCYmUw8kOWsOI
        N6UsOYug==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nBKV9-00HXLF-G4; Sat, 22 Jan 2022 17:48:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH -next] exit: export make_task_dead()
Date:   Sat, 22 Jan 2022 09:48:34 -0800
Message-Id: <20220122174834.6493-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a config file from "kernel test robot <lkp@intel.com>" for a
different problem, this linker error was exposed when
CONFIG_IA64_MCA_RECOVERY=m.

We could either export make_task_dead() or restrict IA64_MCA_RECOVERY
to a bool Kconfig symbol instead of a tristate symbol, so go with the
EXPORT_SYMBOL() path.

Fixes this build error:

ERROR: modpost: "make_task_dead" [arch/ia64/kernel/mca_recovery.ko] undefined!

Fixes: 0e25498f8cd4 ("exit: Add and use make_task_dead.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-ia64@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>
Cc: kernel test robot <lkp@intel.com>
---
 kernel/exit.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20220121.orig/kernel/exit.c
+++ linux-next-20220121/kernel/exit.c
@@ -896,6 +896,7 @@ void __noreturn make_task_dead(int signr
 
 	do_exit(signr);
 }
+EXPORT_SYMBOL(make_task_dead);
 
 SYSCALL_DEFINE1(exit, int, error_code)
 {
