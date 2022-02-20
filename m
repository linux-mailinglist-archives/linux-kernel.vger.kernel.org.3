Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8E94BCE60
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 13:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243527AbiBTMKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 07:10:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBTMKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 07:10:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC9F427CE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 04:09:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E4AC721101;
        Sun, 20 Feb 2022 12:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645358987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NhA2M5ouZJ/t7Vji2jIOKU+buKReKVfDxNRZF0w43TA=;
        b=gZnLYGT18zReCxmbt1Sm1+gw9Oiql0JpPvOOQxebb0tbU+tlquri5XYXvxqNg4BmjOR+cz
        lYvNgb0DzVD8fB1dcOs7lQrSMT4Q0W6ihaudNQa0i5EaUA1G/J/fqGzxc1DnYV5Tx9hIWd
        Ha83OcZd/DPRHJibZvTYHQzAEze10rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645358987;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NhA2M5ouZJ/t7Vji2jIOKU+buKReKVfDxNRZF0w43TA=;
        b=pkW5CZkp+ZiyWS/ixsHMfN0PIPAziasxobvOBLUb5gQwCCgmlgkfX+FT4gBZV8xun9ZaA2
        jVGxCSAniVPv+4DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B23CE1331E;
        Sun, 20 Feb 2022 12:09:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wMwTKYsvEmKsIwAAMHmgww
        (envelope-from <bp@suse.de>); Sun, 20 Feb 2022 12:09:47 +0000
Date:   Sun, 20 Feb 2022 13:09:44 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] sched/urgent for 5.17
Message-ID: <YhIviC2M5OwHYcUY@zn.tnic>
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

following the discussion from last week, here's hopefully a better fix
for the task exposure race.

Pls pull,
thx.

---

The following changes since commit 754e0b0e35608ed5206d6a67a791563c631cec07:

  Linux 5.17-rc4 (2022-02-13 12:13:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/sched_urgent_for_v5.17_rc5

for you to fetch changes up to b1e8206582f9d680cff7d04828708c8b6ab32957:

  sched: Fix yet more sched_fork() races (2022-02-19 11:11:05 +0100)

----------------------------------------------------------------
- Fix task exposure order when forking tasks

----------------------------------------------------------------
Peter Zijlstra (1):
      sched: Fix yet more sched_fork() races

 include/linux/sched/task.h |  4 ++--
 kernel/fork.c              | 13 ++++++++++++-
 kernel/sched/core.c        | 34 +++++++++++++++++++++-------------
 3 files changed, 35 insertions(+), 16 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Ivo Totev, HRB 36809, AG Nürnberg
