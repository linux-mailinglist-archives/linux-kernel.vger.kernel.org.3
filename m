Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0130B4DE46B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 00:09:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241416AbiCRXKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 19:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232891AbiCRXKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 19:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBD5F47EA
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 16:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA32A61642
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 23:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93020C340E8;
        Fri, 18 Mar 2022 23:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647644935;
        bh=A3Y689zBKJu2EqrYev8FF9G6KLLrbNU5CtFhDlAKkoo=;
        h=From:To:Cc:Subject:Date:From;
        b=K4qsOy4oKGHU5z7hHaHsd6/bgIdYpZCLAFxzaTTDq/Z09ALl0lZ9uuxdgJ0hEErOt
         K2mR/g4LceflzCDAQrtTYTVpUBPfO/3qZ2DZk/JTFDDXRR/cqc4TNvRc2iYi94J/GJ
         ScAmwIlveiilEFuFeRfGVyC3OL3s9Hg4/cAtaqIcDjD6Sm2+V03qsLGJPr2u3iqoFe
         xSugWArJvQ6PZFXSXPrYgU4OoM5uzeWeIqyYetfMgYZWnHh+NCfuTq8nLvGPkTIezK
         NumgA30BPJiK0dtKhO/h4Xbuk/97wgzJ9Rl9qHNbRwYf/nzmW6w4FgD17DAb6DkgFj
         zQGK8w9fZM5vQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] Fix CONFIG_X86_KERNEL_IBT for clang and ld.lld < 14.0.0
Date:   Fri, 18 Mar 2022 16:07:45 -0700
Message-Id: <20220318230747.3900772-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While testing -tip after the IBT bits were merged, our continuous
integration noticed a crash with clang-11:

https://builds.tuxbuild.com/26ZRIuAPHx1L802ExiYCuLuvMhK/build.log

This crash is a separate issue from the one that is already being
checked for with '-fcf-protection=branch -mfentry -pg'. This new crash
was fixed in clang-12:

https://github.com/llvm/llvm-project/commit/e0b89df2e0f0130881bf6c39bf31d7f6aac00e0f

Unfortunately, I have not been able to tease out a simplified reproducer
for this crash that always triggers. The reproducer in that commit
message and the reproducer commented in the LLVM test do not trigger all
the time (at least with the clang-11 that is in Debian/Ubuntu,
assertions might make the crash always happen but we cannot count on
that); even the full preprocessed files straight from the kernel source
do not always trigger a crash.

As a result, this series proposes just having a hard version check for
clang 14.0.0 and newer, which will cover this new clang-11 crash and the
'-fcf-protection=branch -mfentry -pg' crash.

Adding a check for a version of clang that has not been released yet is
a little riskier than dynamically testing the clang binary for an issue,
as it is possible that someone is using/testing a version of clang from
before a particular issue was fixed, while still having the same version
number. However, our policy for version checks in the kernel has always
been to use the final version of clang that will have the issue fixed,
as people should be upgrading their compilers often if they are using
prereleased versions.

In this particular instance, the '-fcf-protection=branch -mfentry -pg'
crash has been fixed for over three months, which is plenty of time to
upgrade:

https://github.com/llvm/llvm-project/commit/dfcf69770bc522b9e411c66454934a37c1f35332

At the moment, I only know of one version of clang that is fairly widely
used that will show this crash, which is Android's clang 14.0.2. We are
in the process of getting a newer version (14.0.3) deployed to minimize
the impact this change will have on various testing groups:

https://android-review.googlesource.com/c/kernel/common/+/2032664
https://android-review.googlesource.com/c/kernel/common/+/2032665
https://android-review.googlesource.com/c/kernel/common/+/2032666
https://gitlab.com/Linaro/tuxmake/-/merge_requests/244

If for some reason there are any reports of issues after this change,
feel free to direct them to this cover letter and tell them to upgrade
their compiler :)

The second patch just codifies the result of this discussion and issue:

https://lore.kernel.org/r/202202241627.EEF3D5D2@keescook/
https://github.com/ClangBuiltLinux/linux/issues/1606

This is based on -tip x86/core and it has survived an allmodconfig build
with clang-11 through clang-15 (CC=clang and LLVM=1).

Nathan Chancellor (2):
  x86/Kconfig: Only enable CONFIG_CC_HAS_IBT for clang >= 14.0.0
  x86/Kconfig: Only allow CONFIG_X86_KERNEL_IBT with ld.lld >= 14.0.0

 arch/x86/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)


base-commit: 2f35e67f621fffc636cb802a4f93fd168cf38274
-- 
2.35.1

