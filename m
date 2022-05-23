Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A4B531C36
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiEWTuk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 15:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiEWTub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 15:50:31 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADAE3B54E
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 12:50:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2506D21A7C;
        Mon, 23 May 2022 19:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653335428; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pnIBuBX0Q/ceZjwBsf9Fzv0LPU9t392+Myha87y/3q0=;
        b=zQJ/X2VafUd8f4m1WbvOPKvonU0pIgfv8NDpzWkJZm28g1CEKZnWZ3hDrbWHhID8kpBq6K
        8WURbv8DzH+KsQaIoIuZUznzEWi2XeXsIUmiqx231chIiVXVJZshLYtDjG4F8NUsMbAc35
        1BAn5Bbq4y57hL2DZxm9uMOToS/AB38=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653335428;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=pnIBuBX0Q/ceZjwBsf9Fzv0LPU9t392+Myha87y/3q0=;
        b=MoTImwPfuOIttQ64U3VB/SR30kHYdzjzLUvUkwUMJ6mGZCNvxXvSJDYEAxqAdQrtCimNQW
        ZIEMiiEHsTMUpODw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 187B713AA5;
        Mon, 23 May 2022 19:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kV/xBYTli2LPewAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 23 May 2022 19:50:28 +0000
Date:   Mon, 23 May 2022 21:50:07 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/splitlock for 5.19
Message-ID: <Yovlb9y/umFHY42Y@zn.tnic>
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

please pull the latest lineup of misaligned locks changes for 5.19.

Thx.

---

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_splitlock_for_v5.19_rc1

for you to fetch changes up to 0180a1e823d7c41d9a1c19f38e6069b38fe60c87:

  x86/split_lock: Enable the split lock feature on Raptor Lake (2022-05-04 12:11:25 +0200)

----------------------------------------------------------------
- Add Raptor Lake to the set of CPU models which support splitlock

- Make life miserable for apps using split locks by slowing them down
considerably while the rest of the system remains responsive. The hope
is it will hurt more and people will really fix their misaligned locks
apps. As a result, free a TIF bit.

----------------------------------------------------------------
Tony Luck (3):
      x86/split_lock: Make life miserable for split lockers
      x86/split-lock: Remove unused TIF_SLD bit
      x86/split_lock: Enable the split lock feature on Raptor Lake

 arch/x86/include/asm/cpu.h         |  2 -
 arch/x86/include/asm/thread_info.h |  4 +-
 arch/x86/kernel/cpu/intel.c        | 76 +++++++++++++++++++++++++++-----------
 arch/x86/kernel/process.c          |  3 --
 include/linux/sched.h              |  3 ++
 kernel/fork.c                      |  5 +++
 6 files changed, 63 insertions(+), 30 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
