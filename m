Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45A4DB72E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 18:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355945AbiCPRdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239152AbiCPRdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 13:33:50 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9675B3E2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 10:32:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [88.235.220.59])
        by gnuweeb.org (Postfix) with ESMTPSA id 42F877E2EA;
        Wed, 16 Mar 2022 17:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1647451954;
        bh=jZr9li0mpvtx2O5cZVJBJWHmGZZCMOh/qEKForCKN60=;
        h=From:To:Cc:Subject:Date:From;
        b=M8fqXZXMgSzI5Ea5Pg8zhmawPPo6EoWrnZF/g00vKMDOqcNLaIyQbEej3roTTuGq/
         A/vib4VRHmRFLmbksfBEMyW4AkzSt2d6XJ4zfmi/tgEIbb6lFFXqBlo68OW5Xc4d/d
         xmqza1s5sYKrXHXIwlCdaXWbqsXN/4fRfj9+wf5UdBkVH8+A4uXSx6ADOu60RKKmC6
         7qFczwDOApTkxdeg9qVsWANJbbxIXSqOTKgPBfzr/8Cic9+qRCTHNLRAMlQQHVnmFr
         XmOwr0uh79dB6k25vPMkq0IGCwvf0IeezwjlmSd1TDeUI3j8dC/5zI5Jmarls1WPZB
         DyRMOYvU+6niA==
From:   Beru Shinsetsu <windowz414@gnuweeb.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        Beru Shinsetsu <windowz414@gnuweeb.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Subject: [PATCH] boot install: Partially refactor the logic for detecting bootloader
Date:   Wed, 16 Mar 2022 20:32:21 +0300
Message-Id: <20220316173221.5937-1-windowz414@gnuweeb.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While running `make install` after building the kernel and installing
modules on several distros like EndeavourOS, there would be a pretty
little output (To be exact, "Cannot find LILO") due to lack of LILO
bootloader, which is really uncommon for a user to have it while
GRUB is there. So, if LILO doesn't exist, instead of skipping other
bootloaders, check for `grub-mkconfig` using exit status of `which
grub-mkconfig` to see if we have it present in PATH and run it. All
GRUB installs must have it in PATH for other external scripts and
GRUB itself to handle it fine as well.

I have no idea why did the maintainer not consider this, even after
several posts done on several forums without an actual patch. See
appended link for more details on why is this required without
requiring user to run it themselves.

Link: https://serverfault.com/questions/383286/compiling-linux-kernel-make-install-asks-for-lilo-now-what

Also, put the `sync` command to the end of all commands, make sure
all copied files are properly written to disk for all cases, not only
when LILO is not found.

Suggested-by: Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Signed-off-by: Beru Shinsetsu <windowz414@gnuweeb.org>
---

  v2 -> v3
  - Properly make use of GRUB config check and execute `echo` for
    when LILO and GRUB are not found only when *both* are missing.
  - Make the exit status check compatible with POSIX shell as
    well.
  - Upon Alviro's suggestion, put `sync` command to the very end,
    to make sure all copied files are properly written to disk
    unconditionally.

  (Link v2: https://t.me/GNUWeeb/552772)
  v1 -> v2
  - Remove use of absolute path for grub-mkconfig check and use
    `which` instead and check its exit status.
  - Change commit message accordingly.
---
 arch/x86/boot/install.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/install.sh b/arch/x86/boot/install.sh
index d13ec1c38640..2007c06dbbdd 100644
--- a/arch/x86/boot/install.sh
+++ b/arch/x86/boot/install.sh
@@ -54,6 +54,11 @@ if [ -x /sbin/lilo ]; then
 elif [ -x /etc/lilo/install ]; then
        /etc/lilo/install
 else
-       sync
-       echo "Cannot find LILO."
+       which grub-mkconfig > /dev/null 2>&1
+       if [ "$?" -eq "0" ]; then
+              grub-mkconfig -o /etc/grub/grub.cfg
+       else
+              echo "Cannot find LILO or GRUB."
+       fi
 fi
+sync
-- 
2.35.1

