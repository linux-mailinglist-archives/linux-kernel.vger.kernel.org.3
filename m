Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2B9586188
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 23:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbiGaVJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 17:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiGaVJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 17:09:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C6DF85
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 14:09:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD1FEB80DCD
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 21:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDDCC433D7;
        Sun, 31 Jul 2022 21:09:40 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oIGBv-007Giq-1o;
        Sun, 31 Jul 2022 17:09:39 -0400
Message-ID: <20220731210939.401925191@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 31 Jul 2022 17:09:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [for-next][PATCH 2/4] rtla: Fix Makefile when called from -C tools/
References: <20220731210918.097591536@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Sedat Dilek reported an error on rtla Makefile when running:

    $ make -C tools/ clean
    [...]
    make[2]: Entering directory
    '/home/dileks/src/linux-kernel/git/tools/tracing/rtla'
    [...]
    '/home/dileks/src/linux-kernel/git/Documentation/tools/rtla'
    /bin/sh: 1: test: rtla-make[2]:: unexpected operator    <------ The problem
    rm: cannot remove '/home/dileks/src/linux-kernel/git': Is a directory
    make[2]: *** [Makefile:120: clean] Error 1
    make[2]: Leaving directory

This occurred because the rtla calls kernel's Makefile to get the
version in silence mode, e.g.,

    $ make -sC ../../.. kernelversion
    5.19.0-rc4

But the -s is being ignored when rtla's makefile is called indirectly,
so the output looks like this:

    $ make -C ../../.. kernelversion
    make: Entering directory '/root/linux'
    5.19.0-rc4
    make: Leaving directory '/root/linux'

Using 'grep -v make' avoids this problem, e.g.,

    $ make -C ../../.. kernelversion | grep -v make
    5.19.0-rc4

Thus, add | grep -v make.

Link: https://lkml.kernel.org/r/870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org

Fixes: 8619e32825fd ("rtla: Follow kernel version")
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/Makefile b/tools/tracing/rtla/Makefile
index 3822f4ea5f49..1bea2d16d4c1 100644
--- a/tools/tracing/rtla/Makefile
+++ b/tools/tracing/rtla/Makefile
@@ -1,6 +1,6 @@
 NAME	:=	rtla
 # Follow the kernel version
-VERSION :=	$(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion)
+VERSION :=	$(shell cat VERSION 2> /dev/null || make -sC ../../.. kernelversion | grep -v make)
 
 # From libtracefs:
 # Makefiles suck: This macro sets a default value of $(2) for the
-- 
2.35.1
