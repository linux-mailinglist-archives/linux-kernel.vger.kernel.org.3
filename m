Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B85573F05
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237514AbiGMVcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiGMVca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:32:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B8A237E5;
        Wed, 13 Jul 2022 14:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0149061ECC;
        Wed, 13 Jul 2022 21:32:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E44C34114;
        Wed, 13 Jul 2022 21:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657747948;
        bh=3YioYuPMqpg2csfGAVK/4KkwATW+oUo1OvACL7TZtHM=;
        h=From:To:Cc:Subject:Date:From;
        b=ENPS3cSoTCCw0TDxNiiEkxkGlW0Aor3vRoV5nje0wNP0yPBmRVcvcdz9m1DfTw38L
         /dbAtdoXgInHrcTF4dWqP+t1oLUnf2T+ywOhIRhg8SurzCJsLl2qlXCDKwXXMafVHb
         kc9dYdi0lSN42NOOmzx4cBko8xRe7oGTO6qm13F2/GiOE0ivu9tCseteWsgmhgI6x3
         XY3nDkYjOLCQ0VeGQ10lqeEYw7TbLuHi2jO0PCN3rbow3MNVUVzIIKeA1m/MJ51oLb
         vFz819A1pFeo+mnoHWjwg7kpmfZgO3tgEe9Ze2gMhJan02bIfY/X4QDtk1bgxry1JH
         j0NlkqvjPGscQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH V2] rtla: Fix Makefile when called from -C tools/
Date:   Wed, 13 Jul 2022 23:32:19 +0200
Message-Id: <870c02d4d97a921f02a31fa3b229fc549af61a20.1657747763.git.bristot@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Cc: Steven Rostedt <rostedt@goodmis.org>
Fixes: 8619e32825fd ("rtla: Follow kernel version")
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.32.0

