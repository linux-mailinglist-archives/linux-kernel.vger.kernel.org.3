Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1CEC468AA3
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 12:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbhLELqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 06:46:08 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:33094 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhLELqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 06:46:07 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2077B2190C;
        Sun,  5 Dec 2021 11:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1638704560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hVsLVWGXHAQTvnRwXkCVHEpx5vTh8lfF2drCROrZzvI=;
        b=KMyDPGur4GUqOddl1CbsQh/RFX6gAxxSijy8yE7NmajvoCinkH2Th6BCoc3m9kO+VPFqYZ
        eClXhOBCDhEOlljkGGAhq4dSz2hLkWbVlWsC/kSfBLbAtjE1CL8bQSrCiXCq4NfDdjBMc+
        wT5LJg4s9S5CEaAV5mf/zDxpPv4C1wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1638704560;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hVsLVWGXHAQTvnRwXkCVHEpx5vTh8lfF2drCROrZzvI=;
        b=B3ho2VZdZdPgofPbmRDpkCfSUh6NTDf2GVod70gSUZ+ctwrmbnIz7uaRioDdA77IYmXgq4
        HnCXZjagGNAGO1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0343D13451;
        Sun,  5 Dec 2021 11:42:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QQ5mALClrGGTXwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 05 Dec 2021 11:42:39 +0000
Date:   Sun, 5 Dec 2021 12:42:42 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for v5.16-rc4
Message-ID: <YaylsgmYwXBK6qXf@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a couple of urgent scheduler fixes for 5.16.

Thx.

---

The following changes since commit d58071a8a76d779eedab38033ae4c821c30295a5:

  Linux 5.16-rc3 (2021-11-28 14:09:19 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.16_rc4

for you to fetch changes up to 315c4f884800c45cb6bd8c90422fad554a8b9588:

  sched/uclamp: Fix rq->uclamp_max not set on first enqueue (2021-12-04 10:56:18 +0100)

----------------------------------------------------------------
- Properly init uclamp_flags of a runqueue, on first enqueuing

- Fix preempt= callback return values

- Correct utime/stime resource usage reporting on nohz_full to return
the proper times instead of shorter ones

----------------------------------------------------------------
Andrew Halaney (1):
      preempt/dynamic: Fix setup_preempt_mode() return value

Frederic Weisbecker (1):
      sched/cputime: Fix getrusage(RUSAGE_THREAD) with nohz_full

Qais Yousef (1):
      sched/uclamp: Fix rq->uclamp_max not set on first enqueue

 include/linux/sched/cputime.h |  5 +++--
 kernel/sched/core.c           |  6 +++---
 kernel/sched/cputime.c        | 12 +++++++++---
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
