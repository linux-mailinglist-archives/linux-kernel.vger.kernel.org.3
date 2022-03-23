Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72BB4E5783
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343605AbiCWRbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237522AbiCWRbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:31:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4202AB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:29:45 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C15F210F2;
        Wed, 23 Mar 2022 17:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648056584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GmNzccqZ+smFgm4jdUVrhkkpvSEU/fHLlvEESaa6UQc=;
        b=Gxz56Q/SHNygTpEAg5PcALx8Q7U15AS/3GPRZCyJrNU7YyQ73L5fGTgVrxcXmzjSEK0kre
        usLkyE+2GJEH7ltG4EmycoU4WRxYj9HFF23I2FbSCxqxosY9X6VOyeKG1KWFdr0mzTZP76
        PN7Cp+8E1BuzFvlBk7u0VXsrccprEyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648056584;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GmNzccqZ+smFgm4jdUVrhkkpvSEU/fHLlvEESaa6UQc=;
        b=8ItH11o1cybsbN2GrfuQArDZjhyjP+2QoSaoGDqumd2sgu5fcNSRKKZ9dQl2xHkhRsqjg5
        dqP0RwOSWleoQpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 101AE12FC5;
        Wed, 23 Mar 2022 17:29:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 4u3oAwhZO2I8IwAAMHmgww
        (envelope-from <bp@suse.de>); Wed, 23 Mar 2022 17:29:44 +0000
Date:   Wed, 23 Mar 2022 18:29:38 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] RAS updates for 5.18
Message-ID: <YjtZAvQnshp1pZIh@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the RAS side of things for 5.18.

But before you do, a git question if I may:

So the branch I'm sending you is tip/ras/core and I fast-forwarded it to
v5.17-rc4 before adding new stuff ontop.

However, I needed to have prerequisite work from another tip branch:
tip/locking/core which was fast-forwarded to v5.17-rc1 before it got
that prerequisite work added ontop.

So I merged tip/locking/core into tip/ras/core - see merge commit below
- and added the RAS stuff ontop.

However, when creating the diffstat for the pull request, it would
add additional files to it from tip/locking/core even if all the
tip/locking/core changes are already in your master branch:

$ git log master..tip/locking/core
$

After poking at it a bit more, I found a hint as to what it might be
complaining about:

$ git diff --stat master...ras_core_for_v5.18_rc1
warning: master...ras_core_for_v5.18_rc1: multiple merge bases, using 754e0b0e35608ed5206d6a67a791563c631cec07

and:

$ git merge-base -a master ras_core_for_v5.18_rc1
754e0b0e35608ed5206d6a67a791563c631cec07 - that's rc4
b008893b08dcc8c30d756db05c229a1491bcb992 - that's the top-commit of tip/locking/core at the time the merge commit was created.

So it looks like the diffstat for the pull request is created by using
the -rc4 as the merge base:

$ git diff --stat v5.17-rc4..ras_core_for_v5.18_rc1
...

while the correct diffstat should be from the merge-commit onwards:

$ git diff --stat c0f6799de2a0..ras_core_for_v5.18_rc1
...

So, long story short, what am I doing wrong?

Thx a lot!

---

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v5.18_rc1

for you to fetch changes up to 7f1b8e0d6360178e3527d4f14e6921c254a86035:

  x86/mce: Remove the tolerance level control (2022-02-23 11:09:25 +0100)

----------------------------------------------------------------
- More noinstr fixes

- Add an erratum workaround for Intel CPUs which, in certain
circumstances, end up consuming an unrelated uncorrectable memory error
when using fast string copy insns

- Remove the MCE tolerance level control as it is not really needed or
used anymore

----------------------------------------------------------------
Borislav Petkov (3):
      Merge tip:locking/core into tip:ras/core
      x86/mce: Use arch atomic and bit helpers
      x86/mce: Remove the tolerance level control

Jue Wang (1):
      x86/mce: Work around an erratum on fast string copy instructions

Auto-merging MAINTAINERS
Auto-merging arch/x86/kernel/cpu/mce/core.c
Merge made by the 'ort' strategy.
 Documentation/ABI/removed/sysfs-mce       |  37 ++++++++++++++++
 Documentation/ABI/testing/sysfs-mce       |  32 --------------
 Documentation/vm/hwpoison.rst             |   2 -
 Documentation/x86/x86_64/boot-options.rst |   9 +---
 arch/x86/kernel/cpu/mce/core.c            | 175 ++++++++++++++++++++++++++++++++++++++++++++-------------------------------
 arch/x86/kernel/cpu/mce/internal.h        |  31 +++++++++++---
 arch/x86/kernel/cpu/mce/severity.c        |  23 +++++-----
 7 files changed, 177 insertions(+), 132 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-mce

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
